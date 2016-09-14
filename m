From: stephen.boyd@linaro.org (Stephen Boyd)
Date: Tue, 13 Sep 2016 22:58:26 -0700
Subject: [RFC/PATCH] usb: misc: Add a driver for TC7USB40MU
In-Reply-To: <20160914033200.GE30760@b29397-desktop>
References: <20160914014246.31847-1-stephen.boyd@linaro.org>
 <20160914033200.GE30760@b29397-desktop>
Message-ID: <147383270635.1464.10706917860873291816@sboyd-linaro>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Quoting Peter Chen (2016-09-13 20:32:00)
> On Tue, Sep 13, 2016 at 06:42:46PM -0700, Stephen Boyd wrote:
> > On the db410c 96boards platform we have a TC7USB40MU[1] on the
> > board to mux the D+/D- lines from the SoC between a micro usb
> > "device" port and a USB hub for "host" roles. Upon a role switch,
> > we need to change this mux to forward the D+/D- lines to either
> > the port or the hub. Therefore, introduce a driver for this
> > device that intercepts extcon USB_HOST events and logically
> > asserts a gpio to mux the "host" D+/D- lines when a host cable is
> > attached. When the cable goes away, it will logically deassert
> > the gpio and mux the "device" lines.
> 
> Would you please draw the design? It can also help me review your
> chipidea patch well.
> 
> 1. How many ports on the board?
> 2. How the lines are connected on the board?
> 

The schematic for the db410c is publically available here[2][3].

There's also the 96boards spec[4] which talks about this switch based
design a little bit. See the section titled "Single USB port Example".

[2] https://github.com/96boards/documentation/blob/master/ConsumerEdition/DragonBoard-410c/HardwareDocs/Schematics_DragonBoard.pdf
[3] https://github.com/96boards/documentation/raw/master/ConsumerEdition/DragonBoard-410c/HardwareDocs/Schematics_DragonBoard.pdf
[4] https://www.96boards.org/wp-content/uploads/2015/02/96BoardsCESpecificationv1.0-EA1.pdf
