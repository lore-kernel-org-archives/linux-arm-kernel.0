From: santosh.shilimkar@ti.com (Shilimkar, Santosh)
Date: Thu, 17 May 2012 12:40:59 +0530
Subject: [PATCHv2 03/19] ARM: OMAP4: PM: Add device-off support
In-Reply-To: <87obpn92jy.fsf@ti.com>
References: <1336990730-26892-1-git-send-email-t-kristo@ti.com>
 <1336990730-26892-4-git-send-email-t-kristo@ti.com> <87obpn92jy.fsf@ti.com>
Message-ID: <CAMQu2gzwwVNVbNob4k-DXj04Hj4NgW9FuT0JQbvf7wOBkhf9CQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 17, 2012 at 4:06 AM, Kevin Hilman <khilman@ti.com> wrote:
> +Jean for functional power states
>
> Tero Kristo <t-kristo@ti.com> writes:
>
>> This patch adds device off support to OMAP4 device type.
>
> Description is rather thin for a patch that is doing so much.
>
>> OFF mode is disabled by default,
>
> why?
>
>> however, there are two ways to enable OFF mode:
>> a) In the board file, call omap4_pm_off_mode_enable(1)
>> b) Enable OFF mode using the debugfs entry
>> echo "1">/sys/kernel/debug/pm_debug/enable_off_mode
>> (conversely echo '0' will disable it as well).
>
> This part needs to be a separate patch.
>
> But, as stated in the core retention series, I'd like to move away from
> these global flags all together.
>
> The way we manage the disabling of certain states (like off) is already
> clumsy for OMAP3, and it's getting worse with OMAP4. ?Basically, I think
> this feature needs to be supported by using constraints on functional
> power states. ? Having checks all over the place is getting unwieldy and
> not attractive to maintain.
>
> The combination of constraints and functional power states should make
> this much more manageable. ? Until we have that, I'd prefer to keep
> the debugfs enable/disable stuff as separate patches at the end of the
> series used only for testing.
>
>> Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
>> [t-kristo at ti.com: largely re-structured the code]
>
> then the sign-off above from Santosh probably doesn't apply anymore.
> You should change that to a Cc and just mention tht this is based upon
> some original work from Santosh.
>
> First, ?some general comments:
>
> There is a lot going on in this patch, so it is hard to follow what all
> is related, and why. ?Just a quick glance suggests it needs to be broken
> up into at least a few parts:
>
> - low-level PRM support: new APIs for various off-mode features)
> ?(should probably be done on top of functional power states)
> - powerdomain core support or "achievable" states
> ?(should probably be done on top of functional power states)
> - IRQ/GIC context save/restore
> - secure RAM save/restore (this has been tightly coupled to the GIC
> ?but it's not obvious why)
> - PM debug support to enable/disable off-mode
> ?(for testing only, not for merge)
>
Further split sounds good to me.

Regards
santosh
