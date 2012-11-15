From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Thu, 15 Nov 2012 14:30:34 +0100
Subject: [PATCH] ARM i.MX dts: Consistently add labels to devicenodes
In-Reply-To: <20121115134831.GA2546@S2100-06.ap.freescale.net>
References: <1352968312-8321-1-git-send-email-s.hauer@pengutronix.de>
 <20121115134831.GA2546@S2100-06.ap.freescale.net>
Message-ID: <20121115133034.GD10369@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 15, 2012 at 09:48:33PM +0800, Shawn Guo wrote:
> On Thu, Nov 15, 2012 at 09:31:52AM +0100, Sascha Hauer wrote:
> > Having labels before each node allows board bindings to reference
> > to nodes by using the &nodename {} notation.
> 
> I can understand this part.
> 
> > This way boards do not
> > have to resemble the whole devicetree layout. Due to less indention
> > needed the board files also get better readability.
> 
> I do not understand it.  Don't we have to always maintain the device
> tree layout defined by <soc>.dtsi in <board>.dts, do we?

Have a look at for example arch/arm/boot/dts/omap5-evm.dts, it is
written like this:

...

&mmc1 {
        vmmc-supply = <&vmmcsd_fixed>;
        bus-width = <4>;
};

&mmc2 {
        vmmc-supply = <&vmmcsd_fixed>;
        bus-width = <8>;
        ti,non-removable;
};

&mmc3 {
        bus-width = <4>;
        ti,non-removable;
};

...

I've written some board dts from scratch yesterday and this is much
easier to write (and I think also easier to read as I don't have to
care about the tree layout when writing a dts).

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
