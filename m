From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 25 Nov 2014 12:57:30 +0100
Subject: [PATCH V4] arm64: amd-seattle: Adding device tree for AMD Seattle
 platform
In-Reply-To: <1416865877-8347-1-git-send-email-suravee.suthikulpanit@amd.com>
References: <1416865877-8347-1-git-send-email-suravee.suthikulpanit@amd.com>
Message-ID: <2285363.CoMWhviz1f@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 24 November 2014 15:51:17 suravee.suthikulpanit at amd.com wrote:
> 
> +	gic: interrupt-controller at e1101000 {
> +		compatible = "arm,gic-400", "arm,cortex-a15-gic";
> +		interrupt-controller;
> +		#interrupt-cells = <3>;
> +		#address-cells = <2>;
> +		#size-cells = <2>;
> +		reg = <0x0 0xe1110000 0 0x1000>,
> +		      <0x0 0xe112f000 0 0x2000>,
> +		      <0x0 0xe1140000 0 0x10000>,
> +		      <0x0 0xe1160000 0 0x10000>;
> +		interrupts = <1 9 0xf04>;
> +		ranges;
> +		v2m0: v2m at e1180000 {
> +			compatible = "arm,gic-v2m-frame";
> +			msi-controller;
> +			arm,msi-base-spi = <64>;
> +			arm,msi-num-spis = <256>;
> +			reg = <0x0 0xe1180000 0 0x1000>;
> +		};
> +	};


Having an empty ranges property in the gic seems strange, especially
since the registers of the v2m seem to directly follow the gic's own
registers. Could you limit the ranges to only the registers that
are in the gic or its child devices itself?

	Arnd
