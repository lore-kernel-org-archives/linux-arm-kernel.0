From: paul@pwsan.com (Paul Walmsley)
Date: Tue, 30 Aug 2011 01:06:30 -0600 (MDT)
Subject: [GIT PULL v2] OMAP: clock/powerdomain/clockdomain/hwmod: fixes
	for 3.1-rc
In-Reply-To: <alpine.DEB.2.00.1108230105180.28226@utopia.booyaka.com>
References: <alpine.DEB.2.00.1108222319310.28226@utopia.booyaka.com>
	<alpine.DEB.2.00.1108230105180.28226@utopia.booyaka.com>
Message-ID: <alpine.DEB.2.00.1108300104010.26173@utopia.booyaka.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Tony,

On Tue, 23 Aug 2011, Paul Walmsley wrote:

> The following changes since commit fcb8ce5cfe30ca9ca5c9a79cdfe26d1993e65e0c:
> 
>   Linux 3.1-rc3 (2011-08-22 11:42:53 -0700)
> 
> are available in the git repository at:
>   git://git.pwsan.com/linux-2.6 prcm-fixes-a-3.1rc

Just checking up on this.  Any issues with this branch?

> I've dropped Tomi's patches until the changelogs for those are fixed.

Tomi's patches have been queued for 3.2, by the way.

> Note that for these changes to boot successfully on 3.1-rc3, the following 
> patch is needed:
> 
>   http://marc.info/?l=linux-omap&m=131407622527432&w=2

And Linus has resolved this problem for 3.1-rc4 with commit 
69dd3d8e29e294caaf63eb5e8a72d250279f9e5f ("Revert "irq: Always set 
IRQF_ONESHOT if no primary handler is specified"").

> 
> Paul Walmsley (4):
>       OMAP4: clock: re-enable previous clockdomain enable/disable sequence
>       OMAP4: clock: fix compile warning
>       OMAP3: clock: indicate that gpt12_fck and wdt1_fck are in the WKUP clockdomain
>       Merge branches 'pwrdm_clkdm_fixes_3.1rc', 'non_hwmod_compliant_fix_3.1rc', 'omap4_clock_fixes_3.1rc' and 'omap3_clock_fixes_3.1rc' into prcm-fixes-a-3.1rc
> 
> Rajendra Nayak (1):
>       OMAP: powerdomains: Make all powerdomain target states as ON at init
> 
> Santosh Shilimkar (1):
>       OMAP: clockdomain: Wait for powerdomain to be ON when using clockdomain force wakeup
> 
>  arch/arm/mach-omap2/clock3xxx_data.c |    2 ++
>  arch/arm/mach-omap2/clock44xx_data.c |   10 +++++++++-
>  arch/arm/mach-omap2/clockdomain.c    |    2 ++
>  arch/arm/mach-omap2/pm.c             |    2 --
>  arch/arm/mach-omap2/powerdomain.c    |   25 ++++++++++++++++---------
>  5 files changed, 29 insertions(+), 12 deletions(-)
> 


- Paul
