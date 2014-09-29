From: sboyd@codeaurora.org (Stephen Boyd)
Date: Mon, 29 Sep 2014 15:20:45 -0700
Subject: [PATCH 4/4] ARM: DT: apq8064: Add SATA controller support.
In-Reply-To: <1411982134-8090-1-git-send-email-srinivas.kandagatla@linaro.org>
References: <1411982044-7873-1-git-send-email-srinivas.kandagatla@linaro.org>
 <1411982134-8090-1-git-send-email-srinivas.kandagatla@linaro.org>
Message-ID: <5429DB3D.5080701@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/29/14 02:15, Srinivas Kandagatla wrote:
> @@ -396,6 +407,35 @@
>  			usb-phy		= <&usb4_phy>;
>  		};
>  
> +		sata_phy0:sata-phy at 1b400000{

add some spaces here?

> +			compatible	= "qcom,apq8064-sata-phy";
> +			reg		= <0x1b400000 0x200>;
> +			reg-names	= "phy_mem";
> +			clocks		= <&gcc SATA_PHY_CFG_CLK>;
> +			clock-names = "cfg";
> +			#phy-cells = <0>;

These two lost the pretty tabs.

> +		};
> +
> +		sata0: sata at 29000000 {
> +			compatible	= "generic-ahci";
> +			reg		= <0x29000000 0x180>;
> +			interrupts	= <0 209 0>;

Sorry I'm nitpicking but it annoys me. Either align it all or don't
align it.

> +			clocks = <&gcc SFAB_SATA_S_H_CLK>, <&gcc SATA_H_CLK>,
> +				 <&gcc SATA_A_CLK>, <&gcc SATA_RXOOB_CLK>,
> +				 <&gcc SATA_PMALIVE_CLK>;
> +
> +			clock-names = "slave_iface", "iface",
> +				      "bus", "rxoob",
> +				      "core_pmalive";
> +			assigned-clocks = <&gcc SATA_RXOOB_CLK>,
> +						<&gcc SATA_PMALIVE_CLK>;
> +			assigned-clock-rates = <100000000>, <100000000>;
> +
> +			phys  = <&sata_phy0>;
> +			phy-names = "sata-phy";
> +			target-supply = <&pm8921_s4>;
> +		};
> +
>  		/* Temporary fixed regulator */
>  		vsdcc_fixed: vsdcc-regulator {
>  			compatible = "regulator-fixed";


-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
hosted by The Linux Foundation
