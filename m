From: shawn.guo@linaro.org (Shawn Guo)
Date: Tue, 20 Jan 2015 19:15:36 +0800
Subject: [PATCH net-next v2 1/1] ARM: dts: imx6sx: correct i.MX6sx sdb
 board enet phy address
In-Reply-To: <1421743697-26918-1-git-send-email-b38611@freescale.com>
References: <1421743697-26918-1-git-send-email-b38611@freescale.com>
Message-ID: <20150120111534.GA2766@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 20, 2015 at 04:48:17PM +0800, Fugang Duan wrote:
> The commit (3d125f9c91c5) cause i.MX6SX sdb enet cannot work. The cause is
> the commit add mdio node with un-correct phy address.
> 
> The patch just correct i.MX6sx sdb board enet phy address.
> 
> V2:
> * As Shawn's suggestion that unit-address should match 'reg' property, so
>   update ethernet-phy unit-address.
> 
> Acked-by: Stefan Agner <stefan@agner.ch>
> Signed-off-by: Fugang Duan <B38611@freescale.com>

Acked-by: Shawn Guo <shawn.guo@linaro.org>

David,

I assume that you will send this fix for 3.19, since commit 3d125f9c91c5
was sent via your tree.  Otherwise, let me know and I will manage to
send it via arm-soc tree.

Shawn

> ---
>  arch/arm/boot/dts/imx6sx-sdb.dts |    8 ++++----
>  1 files changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/imx6sx-sdb.dts b/arch/arm/boot/dts/imx6sx-sdb.dts
> index 8c1febd..c108bb4 100644
> --- a/arch/arm/boot/dts/imx6sx-sdb.dts
> +++ b/arch/arm/boot/dts/imx6sx-sdb.dts
> @@ -166,12 +166,12 @@
>  		#address-cells = <1>;
>  		#size-cells = <0>;
>  
> -		ethphy1: ethernet-phy at 0 {
> -			reg = <0>;
> +		ethphy1: ethernet-phy at 1 {
> +			reg = <1>;
>  		};
>  
> -		ethphy2: ethernet-phy at 1 {
> -			reg = <1>;
> +		ethphy2: ethernet-phy at 2 {
> +			reg = <2>;
>  		};
>  	};
>  };
> -- 
> 1.7.8
> 
