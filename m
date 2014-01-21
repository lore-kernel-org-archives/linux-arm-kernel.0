From: jason@lakedaemon.net (Jason Cooper)
Date: Tue, 21 Jan 2014 07:47:46 -0500
Subject: [PATCH v2 15/15] ARM: mvebu: Enable watchdog support in defconfig
In-Reply-To: <1390295561-3466-16-git-send-email-ezequiel.garcia@free-electrons.com>
References: <1390295561-3466-1-git-send-email-ezequiel.garcia@free-electrons.com>
 <1390295561-3466-16-git-send-email-ezequiel.garcia@free-electrons.com>
Message-ID: <20140121124746.GZ29184@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 21, 2014 at 06:12:41AM -0300, Ezequiel Garcia wrote:
> Now that we have proper support for Armada 370/XP watchdog
> let's enable it in the defconfig.
> 
> Signed-off-by: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
> ---
>  arch/arm/configs/mvebu_defconfig | 2 ++
>  1 file changed, 2 insertions(+)

Just a note to myself more than anything: I need to square up multi_v7
with mvebu.  As we make these changes next cycle, we need to be able to
easily test that we aren't breaking multiplat build or boot.

Hopefully I can get some defconfig changes in for -rc1? :)

thx,

Jason.

> diff --git a/arch/arm/configs/mvebu_defconfig b/arch/arm/configs/mvebu_defconfig
> index 594d706..84ec924 100644
> --- a/arch/arm/configs/mvebu_defconfig
> +++ b/arch/arm/configs/mvebu_defconfig
> @@ -60,6 +60,8 @@ CONFIG_GPIOLIB=y
>  CONFIG_GPIO_SYSFS=y
>  CONFIG_THERMAL=y
>  CONFIG_ARMADA_THERMAL=y
> +CONFIG_WATCHDOG=y
> +CONFIG_ORION_WATCHDOG=y
>  CONFIG_USB_SUPPORT=y
>  CONFIG_USB=y
>  CONFIG_USB_EHCI_HCD=y
> -- 
> 1.8.1.5
> 
