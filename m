From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 23 Sep 2014 18:29:48 +0200
Subject: [PATCH v4 3/9] Documentation: bindings: net: add the Marvell
 PXA168 Ethernet controller
In-Reply-To: <542195B0.6080706@gmail.com>
References: <1411474536-22626-1-git-send-email-antoine.tenart@free-electrons.com>
 <4014272.rJbSfrLcuB@wuerfel> <542195B0.6080706@gmail.com>
Message-ID: <9401592.hUYDkriFVO@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 23 September 2014 17:45:52 Sebastian Hesselbarth wrote:
> For reference, this is what we have for MVEBU SoCs with multiple ports
> per controller:
> 
> eth: ethernet-ctrl at 72000 {
>         compatible = "marvell,orion-eth";
>         #address-cells = <1>;
>         #size-cells = <0>;
>         reg = <0x72000 0x4000>;
>         clocks = <&gate_clk 2>;
>         marvell,tx-checksum-limit = <1600>;
>         status = "disabled";
> 
>         ethernet-port at 0 {
>                 compatible = "marvell,orion-eth-port";
>                 reg = <0>;
>                 interrupts = <29>;
>                 /* overwrite MAC address in bootloader */
>                 local-mac-address = [00 00 00 00 00 00];
>                 phy-handle = <&ethphy>;
>         };
> };
> 
> mdio: mdio-bus at 72004 {
>         compatible = "marvell,orion-mdio";
>         #address-cells = <1>;
>         #size-cells = <0>;
>         reg = <0x72004 0x84>;
>         interrupts = <30>;
>         clocks = <&gate_clk 2>;
>         status = "disabled";
>         ethphy: ethernet-phy {
>                 /* set phy address in board file */
>         };
> };
> 

But in this example, you have the same registers and the same
clocks in two nodes, which are even used by the same device driver
at the moment. It's not a big issue, but my feeling is that Antoine's
approach was actually better because it more closely reflects
the way that the hardware is built.

	Arnd
