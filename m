From: stuart.yoder@nxp.com (Stuart Yoder)
Date: Fri, 30 Sep 2016 13:57:59 +0000
Subject: [PATCH v2 1/1] arm64: Add DTS support for FSL's LS1012A SoC
In-Reply-To: <1472207241-18461-1-git-send-email-Bhaskar.Upadhaya@nxp.com>
References: <1472207241-18461-1-git-send-email-Bhaskar.Upadhaya@nxp.com>
Message-ID: <VI1PR0401MB2638C032B77C9313C17BBE898DC10@VI1PR0401MB2638.eurprd04.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> +		dspi0: dspi at 2100000 {
> +			compatible = "fsl,ls1012a-dspi",
> +				     "fsl,ls1043a-dspi",
> +				     "fsl,ls1021a-v1.0-dspi";
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +			reg = <0x0 0x2100000 0x0 0x10000>;
> +			interrupts = <0 64 0x4>;
> +			clock-names = "dspi";
> +			clocks = <&clockgen 4 0>;
> +			spi-num-chipselects = <5>;
> +			big-endian;
> +			status = "enabled";

"enabled" is not a valid status value.

Stuart
