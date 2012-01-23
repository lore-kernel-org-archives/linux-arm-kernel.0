From: hvaibhav@ti.com (Hiremath, Vaibhav)
Date: Mon, 23 Jan 2012 08:47:23 +0000
Subject: [PATCH 0/3] ARM: OMAP1/2+: 32k-timer: Add hwmod lookup for
 32k-timer
In-Reply-To: <1326983304-14619-1-git-send-email-hvaibhav@ti.com>
References: <1326983304-14619-1-git-send-email-hvaibhav@ti.com>
Message-ID: <79CD15C6BA57404B839C016229A409A8317AF2D2@DBDE01.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 19, 2012 at 19:58:21, Hiremath, Vaibhav wrote:
> This patch series cleans up the existing 32k-sync timer implementation
> without any major code change and adds hwmod lookup for omap2+ devices,
> if lookup fails then fall back to gp-timer.
> 
> With this, we should be able to support multi-omap boot
> including devices with/without 32k-sync timer.
> For example, AM33xx device doesn't have 32k-sync timer available,
> which breaks multi-omap boot.
> 
> This patch-series has been boot tested on AM37xEVM platform, it
> would be helpful if somebody help me to validate it on OMAP2
> platform.
> 
> Background:
> ==========
> In 2010 timeframe 'Fillipe Balbi' had submitted first version
> of 32k-sync timer cleanup patches, but it did not made its way
> to the mainline.
> 
> http://www.mail-archive.com/linux-omap at vger.kernel.org/msg37403.html
> 
> Yesterday I had submitted the RFC version patch-series, which was
> built on top of earlier cleanup patches from 'Fillipe Balbi'.
> 
> http://www.spinics.net/lists/linux-omap/msg63004.html
> 
> Based on comments (Thanks to Russell, Marc and Tony) from community
> it was clear that, arch_init is not the correct way here.
> 
> 
> Vaibhav Hiremath (3):
>   ARM: OMAP2+: 32k-counter: Use hwmod lookup to check presence of 32k
>     timer
>   ARM: OMAP2/3: Add idle_st bits for ST_32KSYNC timer to prcm-common
>     header
>   ARM: OMAP2+: hwmod data: Add 32k-sync timer data to hwmod database
> 

Tony,

If there are no review comments, can this be merged?

Thanks,
Vaibhav

>  arch/arm/mach-omap2/omap_hwmod_2420_data.c |   53 ++++++++++++++++++
>  arch/arm/mach-omap2/omap_hwmod_2430_data.c |   52 +++++++++++++++++
>  arch/arm/mach-omap2/omap_hwmod_3xxx_data.c |   51 +++++++++++++++++
>  arch/arm/mach-omap2/omap_hwmod_44xx_data.c |    2 +-
>  arch/arm/mach-omap2/prcm-common.h          |    4 +
>  arch/arm/mach-omap2/timer.c                |   27 ++++-----
>  arch/arm/plat-omap/counter_32k.c           |   83 ++++++++++++++-------------
>  7 files changed, 215 insertions(+), 57 deletions(-)
> 
> 
