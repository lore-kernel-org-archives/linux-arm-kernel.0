From: javier@osg.samsung.com (Javier Martinez Canillas)
Date: Mon, 7 Sep 2015 11:30:03 +0200
Subject: [PATCH 2/4] ARM: multi_v7_defconfig: Enable ACT8865 PMIC driver
In-Reply-To: <1441570566-14001-3-git-send-email-sjoerd.simons@collabora.co.uk>
References: <1441570566-14001-1-git-send-email-sjoerd.simons@collabora.co.uk>
 <1441570566-14001-3-git-send-email-sjoerd.simons@collabora.co.uk>
Message-ID: <55ED591B.4070600@osg.samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Sjoerd,

On 09/06/2015 10:16 PM, Sjoerd Simons wrote:
> Active Semi act8846 is used as the PMIC on various Rockchip boards,
> enable the ACT8865 driver to support this.
>
> Signed-off-by: Sjoerd Simons <sjoerd.simons@collabora.co.uk>
> ---
> 
>  arch/arm/configs/multi_v7_defconfig | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/arm/configs/multi_v7_defconfig b/arch/arm/configs/multi_v7_defconfig
> index 25a1d574..7058fef 100644
> --- a/arch/arm/configs/multi_v7_defconfig
> +++ b/arch/arm/configs/multi_v7_defconfig
> @@ -401,6 +401,7 @@ CONFIG_MFD_TPS65090=y
>  CONFIG_MFD_TPS6586X=y
>  CONFIG_MFD_TPS65910=y
>  CONFIG_REGULATOR_AB8500=y
> +CONFIG_REGULATOR_ACT8865=y

Same question than the previous patch, does this really need to be
built-in? The Kconfig symbol is tristate.

After an explanation why it needs to be built-in or enabling
it as a module:

Reviewed-by: Javier Martinez Canillas <javier@osg.samsung.com>

Best regards,
-- 
Javier Martinez Canillas
Open Source Group
Samsung Research America
