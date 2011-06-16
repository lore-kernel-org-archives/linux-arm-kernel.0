From: premi@ti.com (Premi, Sanjeev)
Date: Thu, 16 Jun 2011 15:23:08 +0530
Subject: [PATCH] omap3evm: Add Mistral WL12XX config support
In-Reply-To: <1308053788-25937-1-git-send-email-shahar@wizery.com>
References: <y> <1308053788-25937-1-git-send-email-shahar@wizery.com>
Message-ID: <B85A65D85D7EB246BE421B3FB0FBB593024D563C4B@dbde02.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> -----Original Message-----
> From: linux-omap-owner at vger.kernel.org 
> [mailto:linux-omap-owner at vger.kernel.org] On Behalf Of Shahar Lev
> Sent: Tuesday, June 14, 2011 5:46 PM
> To: linux-omap at vger.kernel.org
> Cc: linux-arm; Tony Lindgren; Shahar Lev
> Subject: [PATCH] omap3evm: Add Mistral WL12XX config support
> 
> Add Kconfig entries indicating the existence of omap3evm's
> wlan/bt wl12xx daughter card (see
> http://mistralsolutions.com/component/jumi/Download_Common_Cod
> e.html?docid=298),
> and the exact reference clock type that the wl12xx device is hardwired
> to (the wl12xx driver must know this).
> 
> In addition, start using CONFIG_OMAP3EVM_MISTRAL_WL12XX in
> the omap3evm's board file instead of CONFIG_WL12XX_PLATFORM_DATA,
> because the latter only indicates that the driver is being built, and
> shouldn't be used to assume the existence of extension cards.
> 
> Signed-off-by: Shahar Lev <shahar@wizery.com>
> ---
>  arch/arm/mach-omap2/Kconfig          |   23 +++++++++++++++++++++++
>  arch/arm/mach-omap2/board-omap3evm.c |   12 ++++++------
>  2 files changed, 29 insertions(+), 6 deletions(-)
> 
> diff --git a/arch/arm/mach-omap2/Kconfig b/arch/arm/mach-omap2/Kconfig
> index 19d5891..8ef012d 100644
> --- a/arch/arm/mach-omap2/Kconfig
> +++ b/arch/arm/mach-omap2/Kconfig
> @@ -342,6 +342,29 @@ config OMAP3_SDRC_AC_TIMING
>  	  wish to say no.  Selecting yes without understanding what is
>  	  going on could result in system crashes;
>  
> +config OMAP3EVM_MISTRAL_WL12XX

[sp] Could this be renamed simply as: OMAP3EVM_WL12XX?
     OR is there a specific reason to add vendor/manufacturers' name
     to the defintion? 

~sanjeev

[snip]...[snip]
