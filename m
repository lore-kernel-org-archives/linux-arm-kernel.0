From: sjoerd.simons@collabora.co.uk (Sjoerd Simons)
Date: Mon, 20 Jun 2016 10:57:45 +0200
Subject: [PATCH] ARM: multi_v7_defconfig: Build Atmel maXTouch driver as
 a module
In-Reply-To: <1465939232-19156-1-git-send-email-javier@osg.samsung.com>
References: <1465939232-19156-1-git-send-email-javier@osg.samsung.com>
Message-ID: <1466413065.8812.3.camel@collabora.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hey,

On Tue, 2016-06-14 at 17:20 -0400, Javier Martinez Canillas wrote:
> The driver is for a trackpad device so is not needed for booting and
> makes more sense to have it as module to reduce the kernel image
> size.
> 
> It was probably enabled as built-in because module autoload was not
> working when the I2C device was registered by OF but this got fixed
> in commit b7d21058b40b ("Input: atmel_mxt_ts - add maxtouch to I2C
> table for module autoload") so it's safe to enable as a module now.
> 
> Signed-off-by: Javier Martinez Canillas <javier@osg.samsung.com>

Make sense to me,
Reviewed-by: Sjoerd Simons <sjoerd.simons@collabora.co.uk>
> ---
> 
> ?arch/arm/configs/multi_v7_defconfig | 2 +-
> ?1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm/configs/multi_v7_defconfig
> b/arch/arm/configs/multi_v7_defconfig
> index ee7c884ab5d8..c29bdd070721 100644
> --- a/arch/arm/configs/multi_v7_defconfig
> +++ b/arch/arm/configs/multi_v7_defconfig
> @@ -269,7 +269,7 @@ CONFIG_MOUSE_PS2_ELANTECH=y
> ?CONFIG_MOUSE_CYAPA=m
> ?CONFIG_MOUSE_ELAN_I2C=y
> ?CONFIG_INPUT_TOUCHSCREEN=y
> -CONFIG_TOUCHSCREEN_ATMEL_MXT=y
> +CONFIG_TOUCHSCREEN_ATMEL_MXT=m
> ?CONFIG_TOUCHSCREEN_MMS114=m
> ?CONFIG_TOUCHSCREEN_ST1232=m
> ?CONFIG_TOUCHSCREEN_STMPE=y

-- 

Sjoerd Simons
Collabora Ltd.
