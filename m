From: sebastian.hesselbarth@gmail.com (Sebastian Hesselbarth)
Date: Tue, 18 Nov 2014 20:39:10 +0100
Subject: [PATCH 1/2] phy: berlin_usb: depends on RESET_CONTROLLER
In-Reply-To: <1416231192-27056-2-git-send-email-antoine.tenart@free-electrons.com>
References: <1416231192-27056-1-git-send-email-antoine.tenart@free-electrons.com>
 <1416231192-27056-2-git-send-email-antoine.tenart@free-electrons.com>
Message-ID: <546BA05E.4090605@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 17.11.2014 14:33, Antoine Tenart wrote:
> The Berlin USB PHY driver uses the Berlin reset controller
> unconditionally. Make it depending on RESET_CONTROLLER.
>
> Signed-off-by: Antoine Tenart <antoine.tenart@free-electrons.com>

Acked-by: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>

> ---
>   drivers/phy/Kconfig | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/phy/Kconfig b/drivers/phy/Kconfig
> index b6da75f563e7..38ca6ff00aef 100644
> --- a/drivers/phy/Kconfig
> +++ b/drivers/phy/Kconfig
> @@ -17,7 +17,7 @@ config GENERIC_PHY
>
>   config PHY_BERLIN_USB
>   	tristate "Marvell Berlin USB PHY Driver"
> -	depends on ARCH_BERLIN && HAS_IOMEM && OF
> +	depends on ARCH_BERLIN && RESET_CONTROLLER && HAS_IOMEM && OF
>   	select GENERIC_PHY
>   	help
>   	  Enable this to support the USB PHY on Marvell Berlin SoCs.
>
