From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Tue, 5 Jun 2018 16:09:52 +0200
Subject: [PATCH 1/3] Revert "arm64: topology: divorce MC scheduling domain
 from core_siblings"
In-Reply-To: <1528206938-2702-1-git-send-email-sudeep.holla@arm.com>
References: <CAMuHMdWJWj3a0MZgEi7VJTUJRNoeR+X3eoN8A-sW6fwimEr6Fg@mail.gmail.com>
 <1528206938-2702-1-git-send-email-sudeep.holla@arm.com>
Message-ID: <CAMuHMdVPRLt34SUDsbbHvEG2OzvbJoT6id7Rb_2j32=zb1TuKg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Sudeep,

On Tue, Jun 5, 2018 at 3:55 PM, Sudeep Holla <sudeep.holla@arm.com> wrote:
> This reverts commit 37c3ec2d810f87eac73822f76b30391a83bded19.
>
> Currently on ARM64 platforms, we don't update the CPU topology masks
> on each hotplug operation. However, the updates to cpu_coregroup_mask

I would add

    "leading to e.g. a system hang during system suspend."

to avoid people thinking this is purely a small bookkeeping issue without  any
percussions.

> done as part of ACPI PPTT support, in particular the commit being
> reverted makes use of cpumask_of_node which returns the cpu_oneline_mask
> instead of core_sibling as core_sibling masks are not updated for CPU
> hotplug operations and the comparision to find NUMA in package or LLC
> siblings fails.
>
> The original commit is technically correct and since it depends on the
> not yet supported feature, let's revert this for now. We can put it back
> once we have the support for CPU topology masks update on hotplug merged.
>
> Reported-by: Geert Uytterhoeven <geert@linux-m68k.org>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will.deacon@arm.com>
> Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>

Thanks!

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
