From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Wed, 24 Oct 2012 16:01:39 +0200
Subject: [PATCH 2/2] arm: mvebu: adding SATA support: dt binding and
 config update
In-Reply-To: <1351086561-13569-3-git-send-email-gregory.clement@free-electrons.com>
References: <1351086561-13569-1-git-send-email-gregory.clement@free-electrons.com>
 <1351086561-13569-3-git-send-email-gregory.clement@free-electrons.com>
Message-ID: <20121024160139.6dbf5e16@skate>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

Shouldn't you split into one commit adding the SATA definition in
the .dtsi + doing the defconfig change (the "SoC" level modifications),
and then another commit for the .dts change? I don't really care
personally, it's really up to Jason/Andrew on this.

Another comment below, though.

On Wed, 24 Oct 2012 15:49:21 +0200, Gregory CLEMENT wrote:

> diff --git a/arch/arm/boot/dts/armada-370-xp.dtsi b/arch/arm/boot/dts/armada-370-xp.dtsi
> index 94b4b9e..3f08233 100644
> --- a/arch/arm/boot/dts/armada-370-xp.dtsi
> +++ b/arch/arm/boot/dts/armada-370-xp.dtsi
> @@ -69,6 +69,16 @@
>  			compatible = "marvell,armada-addr-decoding-controller";
>  			reg = <0xd0020000 0x258>;
>  		};
> +
> +		sata at d00a0000 {
> +                        compatible = "marvell,orion-sata";
> +                        reg = <0xd00a0000 0x2400>;
> +                        interrupts = <55>;
> +                        nr-ports = <2>;
> +			clocks = <&coreclk 0>;//,  <&coreclk 0>;

Alignment problem + remainings of tests or something like that.

Thomas
-- 
Thomas Petazzoni, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
