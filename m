From: shawnguo@kernel.org (Shawn Guo)
Date: Sat, 24 Feb 2018 15:17:04 +0800
Subject: [PATCH 3/3] ARM: dts: phycore-imx6: set buck regulator modes
 explicitly
In-Reply-To: <1518170721-28198-4-git-send-email-chf.fritz@googlemail.com>
References: <1518170721-28198-1-git-send-email-chf.fritz@googlemail.com>
 <1518170721-28198-4-git-send-email-chf.fritz@googlemail.com>
Message-ID: <20180224071702.GD3217@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Feb 09, 2018 at 11:05:21AM +0100, Christoph Fritz wrote:
> This patch sets initial buck regulator modes explicitly to a state
> this hardware needs.  So a wrong initial mode set by bootloader or
> pmic itself does not interfere anymore.
> 
> Signed-off-by: Christoph Fritz <chf.fritz@googlemail.com>
> Signed-off-by: Christian Hemp <c.hemp@phytec.de>

Looks good to me.  Ping me to pick it up when first two patches are
accepted.

Shawn

> ---
>  arch/arm/boot/dts/imx6qdl-phytec-phycore-som.dtsi | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/imx6qdl-phytec-phycore-som.dtsi b/arch/arm/boot/dts/imx6qdl-phytec-phycore-som.dtsi
> index 53e4337..2ad1336 100644
> --- a/arch/arm/boot/dts/imx6qdl-phytec-phycore-som.dtsi
> +++ b/arch/arm/boot/dts/imx6qdl-phytec-phycore-som.dtsi
> @@ -109,6 +109,7 @@
>  				regulator-name = "vdd_arm";
>  				regulator-min-microvolt = <730000>;
>  				regulator-max-microvolt = <1380000>;
> +				regulator-initial-mode = <2>; /* SYNC */
>  				regulator-always-on;
>  			};
>  
> @@ -116,6 +117,7 @@
>  				regulator-name = "vdd_soc";
>  				regulator-min-microvolt = <730000>;
>  				regulator-max-microvolt = <1380000>;
> +				regulator-initial-mode = <2>; /* SYNC */
>  				regulator-always-on;
>  			};
>  
> @@ -123,6 +125,7 @@
>  				regulator-name = "vdd_ddr3";
>  				regulator-min-microvolt = <1500000>;
>  				regulator-max-microvolt = <1500000>;
> +				regulator-initial-mode = <2>; /* SYNC */
>  				regulator-always-on;
>  			};
>  
> @@ -130,6 +133,7 @@
>  				regulator-name = "vdd_eth";
>  				regulator-min-microvolt = <1200000>;
>  				regulator-max-microvolt = <1200000>;
> +				regulator-initial-mode = <2>; /* SYNC */
>  				regulator-always-on;
>  			};
>  
> -- 
> 2.1.4
> 
