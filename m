From: dianders@chromium.org (Doug Anderson)
Date: Tue, 14 Oct 2014 13:24:03 -0700
Subject: [PATCH v4 4/6] ARM: rockchip: add basic smp support for rk3288
In-Reply-To: <1413231122-1770-5-git-send-email-kever.yang@rock-chips.com>
References: <1413231122-1770-1-git-send-email-kever.yang@rock-chips.com>
 <1413231122-1770-5-git-send-email-kever.yang@rock-chips.com>
Message-ID: <CAD=FV=WGnE3fBfzLGN_x8dFqq4RV=OnVAyUgRQheMiyG4U7TkQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Kever,

On Mon, Oct 13, 2014 at 1:12 PM, Kever Yang <kever.yang@rock-chips.com> wrote:
> +       /*
> +        * We need to soft reset the cpu when we turn off the cpu power domain,
> +        * or else the active processors might be stalled when the individual
> +        * processor is powered down.
> +        */
> +       if (read_cpuid_part_number() != ARM_CPU_PART_CORTEX_A9) {

I haven't done a full review of this patch, but it seems unlikely that
your uses of read_cpuid_part_number() and read_cpuid_part() in this
patch are correct.  You use both functions and in both cases compare
the results to ARM_CPU_PART_CORTEX_A9.
