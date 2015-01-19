From: stefan@agner.ch (Stefan Agner)
Date: Mon, 19 Jan 2015 11:04:34 +0100
Subject: [PATCH net-next 1/1] ARM: dts: imx6sx: correct i.MX6sx sdb
 board enet phy address
In-Reply-To: <1421660282-29494-1-git-send-email-b38611@freescale.com>
References: <1421660282-29494-1-git-send-email-b38611@freescale.com>
Message-ID: <c590198f7ed3de207da6d7c821a6779b@agner.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2015-01-19 10:38, Fugang Duan wrote:
> The commit (3d125f9c91c5) cause i.MX6SX sdb enet cannot work. The cause is
> the commit add mdio node with un-correct phy address.

Sorry about that, somehow I did not take in consideration that that
could be different on the SoloX board.. Just checked again on Vybrid, it
is correct there, the dual PHY DP83849I addresses the two ports with 0
and 1 respectively.

> 
> The patch just correct i.MX6sx sdb board enet phy address.

Acked-by: Stefan Agner <stefan@agner.ch>

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
