From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Tue, 29 Sep 2015 22:35:54 +0200
Subject: [PATCH 1/1] Disable CONFIG_UACCESS_WITH_MEMCPY in Atmel config.
In-Reply-To: <1443556987-2788-1-git-send-email-jc@eclis.ch>
References: <1443556987-2788-1-git-send-email-jc@eclis.ch>
Message-ID: <20150929203554.GH3982@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On Tue, Sep 29, 2015 at 10:03:07PM +0200, jc at eclis.ch wrote:
> From: Jean-Christian de Rivaz <jc@eclis.ch>
> 
> According to Russell King:
> In any case, unless you have a Marvell platform, you should have this
> disabled - it provides a performance boost for Marvell platforms, but
> degrades performance everywhere else.  Please ensure that you disable
> CONFIG_UACCESS_WITH_MEMCPY.
> 
> Signed-off-by: Jean-Christian de Rivaz <jc@eclis.ch>
> ---
>  arch/arm/configs/at91_dt_defconfig |    2 +-
>  arch/arm/configs/sama5_defconfig   |    2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm/configs/at91_dt_defconfig b/arch/arm/configs/at91_dt_defconfig
> index 090c5b2..1807d7f 100644
> --- a/arch/arm/configs/at91_dt_defconfig
> +++ b/arch/arm/configs/at91_dt_defconfig
> @@ -21,7 +21,7 @@ CONFIG_SOC_SAM_V4_V5=y
>  CONFIG_SOC_AT91RM9200=y
>  CONFIG_SOC_AT91SAM9=y
>  CONFIG_AEABI=y
> -CONFIG_UACCESS_WITH_MEMCPY=y
> +# CONFIG_UACCESS_WITH_MEMCPY is not set
>  CONFIG_ZBOOT_ROM_TEXT=0x0
>  CONFIG_ZBOOT_ROM_BSS=0x0
>  CONFIG_ARM_APPENDED_DTB=y
What is the reason to add the "# ... is not set" line? Given the default
line of UACCESS_WITH_MEMCPY I suggest to just drop the line without
replacement in the defconfigs.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
