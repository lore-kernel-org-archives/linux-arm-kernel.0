From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Wed, 04 Mar 2015 14:28:52 +0100
Subject: [PATCH v5] ARM: mvebu: a385-db-ap: Enable the NAND
In-Reply-To: <1425377805-20573-1-git-send-email-maxime.ripard@free-electrons.com>
References: <1425377805-20573-1-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <54F70894.4040706@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Maxime,

On 03/03/2015 11:16, Maxime Ripard wrote:
> The Armada 385 Access Point Development Board has a 1GB NAND SLC chip from
> Micron as its main storage. Enable it.

applied on mvebu/dt

Thanks,

Gregory


>  Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
> ---
> Changes from v4:
>   - Rebased on top of 4.0-rc1
> 
> 
>  arch/arm/boot/dts/armada-385-db-ap.dts | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/armada-385-db-ap.dts b/arch/arm/boot/dts/armada-385-db-ap.dts
> index 57b9119fb3e0..9e33f7d7276b 100644
> --- a/arch/arm/boot/dts/armada-385-db-ap.dts
> +++ b/arch/arm/boot/dts/armada-385-db-ap.dts
> @@ -150,6 +150,19 @@
>  				phy = <&phy0>;
>  				phy-mode = "rgmii-id";
>  			};
> +
> +			nfc: flash at d0000 {
> +				status = "okay";
> +				#address-cells = <1>;
> +				#size-cells = <1>;
> +
> +				num-cs = <1>;
> +				nand-ecc-strength = <4>;
> +				nand-ecc-step-size = <512>;
> +				marvell,nand-keep-config;
> +				marvell,nand-enable-arbiter;
> +				nand-on-flash-bbt;
> +			};
>  		};
>  
>  		pcie-controller {
> 


-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
