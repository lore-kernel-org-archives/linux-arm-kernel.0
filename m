From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 24 Mar 2016 17:42:13 +0100
Subject: [PATCH v2] spi: orion.c: Add direct access mode
In-Reply-To: <56F412B5.2080200@denx.de>
References: <1458663893-13766-1-git-send-email-sr@denx.de>
 <3250653.vvT0RgK8yg@wuerfel> <56F412B5.2080200@denx.de>
Message-ID: <3107533.ZIfFo6QAv3@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 24 March 2016 17:15:49 Stefan Roese wrote:
> > but then we have a
> > problem with how it uses both internal-regs and and its own mbus
> > based reg, so we probably have to move the spi node outside of
> > the internal-regs node to achieve that, similar to how we handle
> > the devbus devices:
> >
> >
> >       soc@ {
> >               spi0 {
> >                         compatible = "marvell,armada-370-spi",
> >                                      "marvell,orion-spi";
> >                       reg = <MBUS_ID(0xf0, 0x01) 0x10600 0x28>,
> >                             <MBUS_ID(0x01, 0x5e) 0 0x100000>;
> >                         #address-cells = <1>;
> >                         #size-cells = <0>;
> >                         pinctrl-0 = <&spi0_pins1>;
> >                         pinctrl-names = "default";
> >                         cell-index = <0>;
> >                         interrupts = <30>;
> >                         clocks = <&coreclk 0>;
> >                         status = "disabled";
> >               };
> >       };
> 
> Do I understand this correctly, that you suggest to list all MBus
> windows here, that the SoC supports (e.g. 8 for the Armada XP).
> And let the SPI driver then extract and dynamically enable (map)
> the one that is currently used?

I had not realize that there is more than one per controller.
Is it one per chip-select, or how do you pick the right ones?

	Arnd
