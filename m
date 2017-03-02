From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Thu, 2 Mar 2017 14:58:12 +0100
Subject: [PATCH] arm: dts: sun8i: split Allwinner H3 .dtsi
In-Reply-To: <20170301201342.47583-3-icenowy@aosc.xyz>
References: <20170301201342.47583-1-icenowy@aosc.xyz>
 <20170301201342.47583-3-icenowy@aosc.xyz>
Message-ID: <20170302135812.kvvqw6trjipjhhu5@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 02, 2017 at 04:13:40AM +0800, Icenowy Zheng wrote:
> From: Andre Przywara <andre.przywara@arm.com>
> 
> The new Allwinner H5 SoC is pin-compatible to the H3 SoC, but with the
> Cortex-A7 cores replaced by Cortex-A53 cores and the MMC controller
> updated. So we should really share almost the whole .dtsi.
> In preparation for that move the peripheral parts of the existing
> sun8i-h3.dtsi into a new sunxi-h3-h5.dtsi.
> The actual sun8i-h3.dtsi then includes that and defines the H3 specific
> parts on top of it.
> According to "Allwinner H3 Datasheet Version 1.2 Apr. 23, 2015" [1]
> Chapter 4.12. GIC and "Allwinner H5 Datasheet Revision 1.0 May. 20,
> 2016" [2] Chapter 4.12. GIC, the two SoCs both use ARM GIC-400 interrupt
> controller (see the "Note" after the interrupt source table), so the GIC
> node is extracted to sunxi-h3-h5.dtsi as well, and the compatible is
> changed to "arm,gic-400".

This should be in a separate patch.

> On the way get rid of skeleton.dtsi, as recommended in that very file.

That too.

> The inclusion of pinctrl-a10.h is also dropped, as it's now not needed
> at all after changing pinctrl binding to the generic pinconf binding.

And that as well...

> [1] http://linux-sunxi.org/File:Allwinner_H3_Datasheet_V1.2.pdf
> [2] https://github.com/OrangePiLibra/OrangePi_H5SDK/blob/master/Documentation/Hardware/H5_User_Manual.pdf

Please don't put URLs in commit logs.

Thanks!
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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170302/027496b3/attachment.sig>
