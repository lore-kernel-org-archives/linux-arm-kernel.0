From: andrew@lunn.ch (Andrew Lunn)
Date: Sun, 16 Nov 2014 03:31:59 +0100
Subject: [PATCHv1 2/3] arm: mvebu: add .dts file for Synology DS213j
In-Reply-To: <20141116020024.GC15870@lunn.ch>
References: <cover.1416095841.git.arno@natisbad.org>
 <1eb26f8c1946622910a7e2318c895a7082fea7e5.1416095841.git.arno@natisbad.org>
 <20141116020024.GC15870@lunn.ch>
Message-ID: <20141116023159.GF15870@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> > +				pmx_uart0: pmx-uart0 {
> > +					marvell,pins = "mpp0", "mpp1";
> > +					marvell,function = "uart0";
> > +				};
> 
> This however does not seem to be in armada-370.dtsi. This is probably
> because there are a few options:
> 
>            MPP_FUNCTION(0x0, "gpio", NULL),
>            MPP_FUNCTION(0x1, "uart0", "rxd")),
>         MPP_MODE(1,
>            MPP_FUNCTION(0x0, "gpo", NULL),
>            MPP_FUNCTION(0x1, "uart0", "txd")),
>         MPP_MODE(2,
>            MPP_FUNCTION(0x0, "gpio", NULL),
>            MPP_FUNCTION(0x1, "i2c0", "sck"),
>            MPP_FUNCTION(0x2, "uart0", "txd")),
>         MPP_MODE(3,
>            MPP_FUNCTION(0x0, "gpio", NULL),
>            MPP_FUNCTION(0x1, "i2c0", "sda"),
>            MPP_FUNCTION(0x2, "uart0", "rxd")),
> 
> What we found with Kirkwood, is that everybody picks the
> same. Probably because of Marvell's RDK and U-boot etc.  It is not
> clear from the current 370 boards what is being used. I should go look
> at Mirabox and 370 RD. If they are all mpp0 & mpp1, i suggest we put
> this into armada-370.dtsi

So i went and checked. Both Mirabox and 370 RD use mpp0 and mmp1. So i
suggest you add these to armada-370.dtsi.

	Andrew
