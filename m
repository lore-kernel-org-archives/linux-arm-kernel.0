From: f.fainelli@gmail.com (Florian Fainelli)
Date: Sun, 2 Apr 2017 14:14:57 -0700
Subject: [PATCH] ARM: dts: BCM5301X: Specify MDIO bus in the DT
In-Reply-To: <20170402210840.11429-1-zajec5@gmail.com>
References: <20170402210840.11429-1-zajec5@gmail.com>
Message-ID: <5a6ecda9-2cf6-2171-7210-6b3a1d4c6012@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Le 04/02/17 ? 14:08, Rafa? Mi?ecki a ?crit :
> From: Rafa? Mi?ecki <rafal@milecki.pl>
> 
> Northstar devices have MDIO bus that may contain various PHYs attached.
> A common example is USB 3.0 PHY (that doesn't have an MDIO driver yet).
> 
> Signed-off-by: Rafa? Mi?ecki <rafal@milecki.pl>
> ---
>  arch/arm/boot/dts/bcm5301x.dtsi | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/bcm5301x.dtsi b/arch/arm/boot/dts/bcm5301x.dtsi
> index acee36a61004..6a2afe7880ae 100644
> --- a/arch/arm/boot/dts/bcm5301x.dtsi
> +++ b/arch/arm/boot/dts/bcm5301x.dtsi
> @@ -320,6 +320,13 @@
>  		};
>  	};
>  
> +	mdio at 18003000 {
> +		compatible = "brcm,iproc-mdio";
> +		reg = <0x18003000 0x8>;
> +		#size-cells = <1>;
> +		#address-cells = <0>;
> +	};

This looks fine, but usually the block should be enabled on a per-board
basis, such that there should be a status = "disabled" property here by
default.
-- 
Florian
