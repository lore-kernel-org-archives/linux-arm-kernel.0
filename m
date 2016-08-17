From: santosh.shilimkar@oracle.com (Santosh Shilimkar)
Date: Wed, 17 Aug 2016 09:23:51 -0700
Subject: [PATCH 1/1] ARM: keystone: defconfig: Fix USB configuration
In-Reply-To: <1471430690-17143-2-git-send-email-rogerq@ti.com>
References: <1471430690-17143-1-git-send-email-rogerq@ti.com>
 <1471430690-17143-2-git-send-email-rogerq@ti.com>
Message-ID: <ef561ff0-bf6d-5515-7d10-7c03aa69dd4c@oracle.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd, Olof,

Can you please pick-up the fix for 4.8-rcx ?
Roger reported that USB ports are broken on Keystone2 boards
since v4.8-rc1 because USB_HPY config option got dropped.


On 8/17/2016 3:44 AM, Roger Quadros wrote:
> Simply enabling CONFIG_KEYSTONE_USB_PHY doesn't work anymore
> as it depends on CONFIG_NOP_USB_XCEIV. We need to enable
> that as well.
>
> This fixes USB on Keystone boards from v4.8-rc1 onwards.
>
> Signed-off-by: Roger Quadros <rogerq@ti.com>
> ---
Acked-by: Santosh Shilimkar <ssantosh@kernel.org>


>  arch/arm/configs/keystone_defconfig | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/arch/arm/configs/keystone_defconfig b/arch/arm/configs/keystone_defconfig
> index 71b42e6..78cd2f1 100644
> --- a/arch/arm/configs/keystone_defconfig
> +++ b/arch/arm/configs/keystone_defconfig
> @@ -161,6 +161,7 @@ CONFIG_USB_MON=y
>  CONFIG_USB_XHCI_HCD=y
>  CONFIG_USB_STORAGE=y
>  CONFIG_USB_DWC3=y
> +CONFIG_NOP_USB_XCEIV=y
>  CONFIG_KEYSTONE_USB_PHY=y
>  CONFIG_NEW_LEDS=y
>  CONFIG_LEDS_CLASS=y
>
