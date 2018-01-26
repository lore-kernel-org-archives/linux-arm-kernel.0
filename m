From: dongas86@gmail.com (Dong Aisheng)
Date: Fri, 26 Jan 2018 17:05:45 +0800
Subject: [PATCH 3/3] ARM: dts: imx6ull: address some more
 incompatibilites between i.MX6UL and i.MX6ULL
In-Reply-To: <1516955032-21167-4-git-send-email-LW@KARO-electronics.de>
References: <1516955032-21167-1-git-send-email-LW@KARO-electronics.de>
 <1516955032-21167-4-git-send-email-LW@KARO-electronics.de>
Message-ID: <20180126090545.GD14058@b29396-OptiPlex-7040>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 26, 2018 at 09:23:52AM +0100, Lothar Wa?mann wrote:
> The i.MX6ULL doesn't have the CAAM engine nor any SIM interface.
> These are currently not implemented for i.MX6UL but it cannot hurt to
> delete the corresponding nodes from the i.MX6ULL DTB anyway.
> 
> Signed-off-by: Lothar Wa?mann <LW@KARO-electronics.de>

Acked-by: Dong Aisheng <aisheng.dong@nxp.com>

Regards
Dong Aisheng

> ---
>  arch/arm/boot/dts/imx6ull.dtsi | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/imx6ull.dtsi b/arch/arm/boot/dts/imx6ull.dtsi
> index 8724fdb2..da325cd 100644
> --- a/arch/arm/boot/dts/imx6ull.dtsi
> +++ b/arch/arm/boot/dts/imx6ull.dtsi
> @@ -67,6 +67,12 @@
>  			};
>  		};
>  
> +		aips-bus at 2100000 {
> +			/delete-node/ caam at 21400000;
> +			/delete-node/ sim at 218c0000;
> +			/delete-node/ sim at 21b40000;
> +		};
> +
>  		aips3: aips-bus at 2200000 {
>  			compatible = "fsl,aips-bus", "simple-bus";
>  			#address-cells = <1>;
> -- 
> 2.1.4
> 
