From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Fri, 6 Jul 2012 09:54:34 +0200
Subject: Passing GPIO irq edge/level flags from devicetree to driver, how?
Message-ID: <20120706075434.GE30009@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi All,

Several gpio binding documents like the one for mxs have the following
in them:

- #interrupt-cells : Should be 2.  The first cell is the GPIO number.
  The second cell bits[3:0] is used to specify trigger type and level flags:
      1 = low-to-high edge triggered.
      2 = high-to-low edge triggered.
      4 = active high level-sensitive.
      8 = active low level-sensitive.

Does anybody know where this information is evaluated and how this is
passed to the driver?

I am working on i.MX (who would have guessed that) and I am trying to
connect a I2C device with an interrupt source connected to the gpio
interrupt controller. It works fine, only the irq level/edge flags
get lost somewhere.

What I have is:

	maxtouch at 4b {
		compatible = "mXT224";
		reg = <0x4b>;
		interrupt-parent = <&gpio7>;
		interrupts = <13 2>;
	};

Any idea how the maxtouch driver can use the 'high-to-low edge
triggered' information?

BTW. the i.MX GPIO binding document does not claim to support the flags,
but I assume it's just missing in the document, but there maybe also
something missing in the driver to support this.

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
