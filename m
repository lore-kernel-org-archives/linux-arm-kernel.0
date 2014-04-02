From: r.schwebel@pengutronix.de (Robert Schwebel)
Date: Wed, 2 Apr 2014 19:44:58 +0200
Subject: [PATCH] ARM i.MX51: Add Digi ConnectCore devicetree
In-Reply-To: <20140402125318.GZ17250@pengutronix.de>
References: <1396075706-25384-1-git-send-email-shc_work@mail.ru>
 <1396075706-25384-2-git-send-email-shc_work@mail.ru>
 <20140402113934.GH8753@dragon>
 <20140402125318.GZ17250@pengutronix.de>
Message-ID: <20140402174458.GC27994@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

[adding Nicolas to Cc]

On Wed, Apr 02, 2014 at 02:53:18PM +0200, Sascha Hauer wrote:
> On Wed, Apr 02, 2014 at 07:39:35PM +0800, Shawn Guo wrote:
> > On Sat, Mar 29, 2014 at 10:48:26AM +0400, Alexander Shiyan wrote:
> > > +&nfc {
> > > +	pinctrl-names = "default";
> > > +	pinctrl-0 = <&pinctrl_nfc>;
> > > +	nand-bus-width = <8>;
> > > +	nand-ecc-mode = "hw";
> > > +	nand-on-flash-bbt;
> > > +	#address-cells = <1>;
> > > +	#size-cells = <1>;
> > > +	status = "okay";
> > > +
> > > +	partition at 0 {
> > > +		label = "boot";
> > > +		reg = <0x00000 0x80000>;
> > > +	};
> > > +
> > > +	partition at 1 {
> > > +		label = "env";
> > > +		reg = <0x80000 0x40000>;
> > > +	};
> > 
> > @Sascha, does the argument that we shouldn't have partition table in the
> > mainline dtb still stands?
> 
> Yes, I still think the partitions shouldn't be in the Linux dts files.

The dtb files for the Atmel Xplained board also has a partition
definition, so the same comment applies there, too.

Besides being no hardware description, this implies a certain way of
using the system; for example, with the "kernel" plus "rootfs"
partitions, it suggests that you can't have the kernel in the standard
root filesystem (which is possible with barebox and the freedesktop.org
bootloader specification).

rsc
-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
