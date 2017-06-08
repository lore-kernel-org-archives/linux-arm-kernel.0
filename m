From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Thu, 8 Jun 2017 21:17:02 +0200
Subject: [PATCH 3/4] arm64: dts: marvell: Enable second SDHCI controller
 in Armada 37xx
In-Reply-To: <20170608165125.27630-4-gregory.clement@free-electrons.com>
References: <20170608165125.27630-1-gregory.clement@free-electrons.com>
 <20170608165125.27630-4-gregory.clement@free-electrons.com>
Message-ID: <20170608211702.27a7b560@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On Thu,  8 Jun 2017 18:51:24 +0200, Gregory CLEMENT wrote:

> diff --git a/arch/arm64/boot/dts/marvell/armada-37xx.dtsi b/arch/arm64/boot/dts/marvell/armada-37xx.dtsi
> index 4d495ec39202..01a9c30be38d 100644
> --- a/arch/arm64/boot/dts/marvell/armada-37xx.dtsi
> +++ b/arch/arm64/boot/dts/marvell/armada-37xx.dtsi
> @@ -292,6 +292,17 @@
>  				};
>  			};
>  
> +			sdhci1: sdhci at d0000 {
> +				compatible = "marvell,armada-3700-sdhci",
> +				"marvell,sdhci-xenon";

One more tab on this second line would be nice.

> +				reg = <0xd0000 0x300
> +				       0x1e808 0x4>;

I'd prefer:

				reg = <0xd0000 0x300>, <0x1e808 0x4>;

Best regards,

Thomas
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
