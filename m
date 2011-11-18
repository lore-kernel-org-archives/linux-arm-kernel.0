From: B29396@freescale.com (Dong Aisheng-B29396)
Date: Fri, 18 Nov 2011 03:51:35 +0000
Subject: [PATCH v5 0/3] ARM: mxs: add recording support for saif
In-Reply-To: <1321003855-13430-1-git-send-email-b29396@freescale.com>
References: <1321003855-13430-1-git-send-email-b29396@freescale.com>
Message-ID: <65EE16ACC360FA4D99C96DC085B3F7722E464C@039-SN1MPN1-002.039d.mgd.msft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi All,

> -----Original Message-----
> From: linux-arm-kernel-bounces at lists.infradead.org [mailto:linux-arm-
> kernel-bounces at lists.infradead.org] On Behalf Of Dong Aisheng
> Sent: Friday, November 11, 2011 5:31 PM
> To: linux-arm-kernel at lists.infradead.org
> Cc: alsa-devel at alsa-project.org; s.hauer at pengutronix.de;
> broonie at opensource.wolfsonmicro.com; w.sang at pengutronix.de;
> kernel at pengutronix.de; u.kleine-koenig at pengutronix.de; lrg at ti.com; Guo
> Shawn-R65073
> Subject: [PATCH v5 0/3] ARM: mxs: add recording support for saif
>
> Changes since v4:
>  * use new added master_id and master_mode in platform_data.
>  The new changes depend on another patch:
>  0001-ASoC-mxs-saif-remove-function-in-platform_data.patch
> 
> Changes since v3:
>  * remove unneeded locking according to Sascha.
> The patches are based on imx-features branch since commit:
> ca4e419c2.
> 
> Changes since v2:
>  * separate clkmux code into another patch according to Uwe
>  * add lock according to Wolfram
>  * Other minus fixes suggested by Uwe and Wolfram.
>  * remove Wolfram's fix saif clock setting patch which is in v2 series
>    since Wolfram will reform the clock code and send it out himself.
>    For test purpose, user still needs that patch. People can get it
>    from v2 series.
>    The patch is:
>    [PATCH v2 3/3] arm: mxs: disable clock-gates when setting saif-clocks
> 
> The patches are based on imx-features branch since commit:
> f4f01e31835f.
> 
> Changes since v1:
> The main changes are move mach-specific code(clkmux in DIGCTL) from saif
> driver to mach-specific layer based on Wolfram's suggestion.
> 
> Note that the last patch is a RFC patch and sent out for testing since
> without that patch the saif may not work.
> 
> Dong Aisheng (3):
>   ARM: mxs: add saif clkmux functions
>   ARM: mx28evk: add platform data for saif
>   ARM: mx28evk: set a initial clock rate for saif
> 
>  arch/arm/mach-mxs/clock-mx28.c                  |   38
> +++++++++++++++++++++++
>  arch/arm/mach-mxs/devices-mx28.h                |    3 +-
>  arch/arm/mach-mxs/devices/platform-mxs-saif.c   |    5 ++-
>  arch/arm/mach-mxs/include/mach/common.h         |    1 +
>  arch/arm/mach-mxs/include/mach/devices-common.h |    4 ++-
>  arch/arm/mach-mxs/include/mach/digctl.h         |   21 ++++++++++++
>  arch/arm/mach-mxs/mach-mx28evk.c                |   18 +++++++++-
>  7 files changed, 84 insertions(+), 6 deletions(-)  create mode 100644
> arch/arm/mach-mxs/include/mach/digctl.h
> 
Any comment or tag for this new series?

Regards
Dong Aisheng
