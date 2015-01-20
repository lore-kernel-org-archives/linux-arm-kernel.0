From: shawn.guo@linaro.org (Shawn Guo)
Date: Tue, 20 Jan 2015 16:31:57 +0800
Subject: [PATCH net-next 1/1] ARM: dts: imx6sx: correct i.MX6sx sdb board
 enet phy address
In-Reply-To: <1421660282-29494-1-git-send-email-b38611@freescale.com>
References: <1421660282-29494-1-git-send-email-b38611@freescale.com>
Message-ID: <20150120083156.GY2766@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 19, 2015 at 05:38:02PM +0800, Fugang Duan wrote:
> The commit (3d125f9c91c5) cause i.MX6SX sdb enet cannot work. The cause is
> the commit add mdio node with un-correct phy address.
> 
> The patch just correct i.MX6sx sdb board enet phy address.
> 
> Signed-off-by: Fugang Duan <B38611@freescale.com>
> ---
>  arch/arm/boot/dts/imx6sx-sdb.dts |    4 ++--
>  1 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/imx6sx-sdb.dts b/arch/arm/boot/dts/imx6sx-sdb.dts
> index 8c1febd..9db123f 100644
> --- a/arch/arm/boot/dts/imx6sx-sdb.dts
> +++ b/arch/arm/boot/dts/imx6sx-sdb.dts
> @@ -167,11 +167,11 @@
>  		#size-cells = <0>;
>  
>  		ethphy1: ethernet-phy at 0 {

The unit-address should match 'reg' property, so it needs an update too.

Shawn

> -			reg = <0>;
> +			reg = <1>;
>  		};
>  
>  		ethphy2: ethernet-phy at 1 {
> -			reg = <1>;
> +			reg = <2>;
>  		};
>  	};
>  };
> -- 
> 1.7.8
> 
