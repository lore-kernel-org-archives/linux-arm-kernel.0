From: shawn.guo@freescale.com (Shawn Guo)
Date: Tue, 1 Jul 2014 17:17:41 +0800
Subject: [PATCH 5/5] ARM: imx_v6_v7_defconfig: Enable flexcan driver for
 can support
In-Reply-To: <9816fbb23593185b711c1fe32836ec5b763b688d.1404132504.git.silvio.fricke@gmail.com>
References: <cover.1404132504.git.silvio.fricke@gmail.com>
 <9816fbb23593185b711c1fe32836ec5b763b688d.1404132504.git.silvio.fricke@gmail.com>
Message-ID: <20140701091740.GK14471@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 30, 2014 at 03:28:09PM +0200, Silvio Fricke wrote:
> Signed-off-by: Silvio Fricke <silvio.fricke@gmail.com>
> ---
>  arch/arm/configs/imx_v6_v7_defconfig | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/arch/arm/configs/imx_v6_v7_defconfig b/arch/arm/configs/imx_v6_v7_defconfig
> index c331de8..88877226 100644
> --- a/arch/arm/configs/imx_v6_v7_defconfig
> +++ b/arch/arm/configs/imx_v6_v7_defconfig
> @@ -69,6 +69,8 @@ CONFIG_IP_PNP_DHCP=y
>  # CONFIG_INET_LRO is not set
>  CONFIG_IPV6=y
>  CONFIG_NETFILTER=y
> +CONFIG_CAN=m
> +CONFIG_CAN_FLEXCAN=m

Would it be better to have them as 'y'?  It gets more chance to be
compile-tested since zImage build is more often than module build.

Shawn

>  CONFIG_CFG80211=y
>  CONFIG_MAC80211=y
>  CONFIG_RFKILL=y
> -- 
> 2.0.0
> 
