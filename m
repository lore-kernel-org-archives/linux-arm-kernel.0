From: nm@ti.com (Nishanth Menon)
Date: Mon, 1 Jul 2013 10:34:21 -0500
Subject: [-next PATCH 0/2] ARM: OMAP5: fix build breakage due to SCU usage
In-Reply-To: <1372257587-21720-1-git-send-email-nm@ti.com>
References: <1372257587-21720-1-git-send-email-nm@ti.com>
Message-ID: <51D1A17D.9070701@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Tony,

Any chance of picking these up?

I see that next-20130701 is broke as well in an OMAP5 only build. beyond 
the fixes already merged in - the missing series seems to be the 
$subject series to allow an OMAP5 only build.

On 06/26/2013 09:39 AM, Nishanth Menon wrote:
> Hi,
>
> Cortex-A15 based OMAP5 does not use Snoop Control Unit(SCU)[1].
> However, there is lot of code that is shared between Cortex-A9 based
> OMAP4 and OMAP5, hence functionality code is shared with runtime usage
> of SCU based on SoC worked on. However on building with OMAP5 only
> generates the following errors:
> arch/arm/mach-omap2/built-in.o: In function `scu_gp_set':
> arch/arm/mach-omap2/sleep44xx.S:132: undefined reference to `scu_power_mode'
> arch/arm/mach-omap2/built-in.o: In function `scu_gp_clear':
> arch/arm/mach-omap2/sleep44xx.S:229: undefined reference to `scu_power_mode'
> arch/arm/mach-omap2/built-in.o: In function `omap4_smp_init_cpus':
> arch/arm/mach-omap2/omap-smp.c:185: undefined reference to `scu_get_core_count'
> arch/arm/mach-omap2/built-in.o: In function `omap4_smp_prepare_cpus':
> arch/arm/mach-omap2/omap-smp.c:211: undefined reference to `scu_enable'
>
> This was attempted to be "fixed" in various attempts in the past [2] [3].
>
> This series applies on top of the other fixes in discussion for linux-next [4] [5].
>
> Based on:
> git://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git  next-20130626
>
> Nishanth Menon (2):
>    ARM: OMAP4: sleep: build OMAP4 specific functions only for OMAP4
>    ARM: scu: provide inline dummy functions when SCU is not present
>
>   arch/arm/include/asm/smp_scu.h  |   13 ++++++++++++-
>   arch/arm/mach-omap2/sleep44xx.S |    6 +++++-
>   2 files changed, 17 insertions(+), 2 deletions(-)
>
> [1] http://infocenter.arm.com/help/index.jsp?topic=/com.arm.doc.ddi0407e/CHDFJICC.html
> [2] https://patchwork.kernel.org/patch/2568091/
> [3] http://marc.info/?t=137120115400001&r=1&w=2
> [4] http://lists.infradead.org/pipermail/linux-arm-kernel/2013-June/178209.html
> [5] https://patchwork.kernel.org/patch/2781471/
>
> Regards,
> Nishanth Menon
>


-- 
Regards,
Nishanth Menon
