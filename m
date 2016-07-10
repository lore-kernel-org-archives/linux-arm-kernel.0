From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Sun, 10 Jul 2016 23:38:04 +0100
Subject: [PATCH] ARM: dts: armada-388-clearfog: remove duplicate mdio entry
In-Reply-To: <20160710222743.GN8426@lunn.ch>
References: <E1bMGdu-00005c-Dy@rmk-PC.armlinux.org.uk>
 <20160710203751.GB26397@lunn.ch>
 <20160710204546.GS1041@n2100.armlinux.org.uk>
 <20160710222743.GN8426@lunn.ch>
Message-ID: <20160710223804.GT1041@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 11, 2016 at 12:27:43AM +0200, Andrew Lunn wrote:
> On Sun, Jul 10, 2016 at 09:45:46PM +0100, Russell King - ARM Linux wrote:
> > On Sun, Jul 10, 2016 at 10:37:51PM +0200, Andrew Lunn wrote:
> > > The armada-38x.dtsi has
> > > 
> > >                                 ref_clk0_pins: ref-clk-pins-0 {
> > >                                         marvell,pins = "mpp45";
> > >                                         marvell,function = "ref";
> > >                                 };
> > > 
> > > which you could reference rather then defining it yourself.
> > 
> > Weren't these going to be deleted from the main SoC dtsi files,
> > eventually?  I thought that was the idea, to prevent cluttering
> > up the .dtb files with nodes which aren't ever used.
> 
> I've not heard they are going to be removed....
> 
> Having work on mvebu, and a Freescale Vybrid board, i see two
> different styles. mvebu defines all the common pinctrl values in the
> .dtsi file, so making the .dts file pretty minimalist. For the vybrid
> board there was nothing in the .dtsi file, the dts file is huge, and i
> made at least one error, missing at required pin which took me a while
> to debug.
> 
> I would also say cluttered .dtb because of unused nodes it a compiler
> issue. Why does it not optimise them out?

How does it know that the pinmux nodes (which are nodes in their own
right, just like any node specifying a real device) are "unused" ?

It doesn't - there's no way that the compiler can possibly know that
these aren't going to be iterated over as a child of the pinctrl at 18000
node.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
