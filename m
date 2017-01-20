From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Fri, 20 Jan 2017 21:48:11 +0100
Subject: [PATCH v3 5/6] ARM: dts: sunxi: add dtsi file for V3s SoC
In-Reply-To: <20170119175448.11445-5-icenowy@aosc.xyz>
References: <20170119175448.11445-1-icenowy@aosc.xyz>
 <20170119175448.11445-5-icenowy@aosc.xyz>
Message-ID: <20170120204811.oqiscwuzn3emjrx4@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 20, 2017 at 01:54:47AM +0800, Icenowy Zheng wrote:
> As we have the pinctrl and clock support for the V3s SoC, it's now to
> run a mainline Linux on it.
> 
> So add a .dtsi file for it.
> 
> Signed-off-by: Icenowy Zheng <icenowy@aosc.xyz>

Next time, please provide a description of what that SoC in your
commit log.

> +		rtc: rtc at 01c20400 {
> +			compatible = "allwinner,sun6i-a31-rtc";
> +			reg = <0x01c20400 0x54>;
> +			interrupts = <GIC_SPI 40 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 41 IRQ_TYPE_LEVEL_HIGH>;
> +		};

Did you have the chance to actually test how the RTC was behaving?

Other RTC have been pretty bad at keeping time, this is probably
something you want to check.

Applied, 
Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 801 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170120/a60662e8/attachment.sig>
