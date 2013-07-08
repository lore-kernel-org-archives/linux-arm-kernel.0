From: LW@KARO-electronics.de (=?utf-8?Q?Lothar_Wa=C3=9Fmann?=)
Date: Mon, 8 Jul 2013 10:03:49 +0200
Subject: [PATCH v3 4/6] ARM: dts: imx6q{dl}: fix the wrong RTS/CTS pad name
In-Reply-To: <20130708075004.GR24642@n2100.arm.linux.org.uk>
References: <1373004752-21302-1-git-send-email-b32955@freescale.com>
 <1373004752-21302-5-git-send-email-b32955@freescale.com>
 <20130706050803.GC30164@S2101-09.ap.freescale.net>
 <20953.22066.706534.773272@ipc1.ka-ro>
 <20130708075004.GR24642@n2100.arm.linux.org.uk>
Message-ID: <20954.29285.732132.959465@ipc1.ka-ro>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Russell King - ARM Linux writes:
> On Sun, Jul 07, 2013 at 01:51:14PM +0200, Lothar Wa?mann wrote:
> > Hi,
> > 
> > Shawn Guo writes:
> > > On Fri, Jul 05, 2013 at 02:12:30PM +0800, Huang Shijie wrote:
> > > > There is something wrong with the RTS/CTS pads:
> > > >   The RTS pad is assigned with the CTS's value;
> > > >   while the CTS pad is assigned with the RTS's value.
> > > > 
> > > 
> > > So basically, you are saying that select_input should be set up for CTS
> > > rather than RTS.  It seems that the people who generated the macro got
> > > the wrong input from developer.
> > > 
> > programming 'select_input' only makes sense for inputs, not outputs.
> > Since CTS is an output signal, select_input only makes sense for the
> > RTS function of the pads.
> 
> Note: If you are a DTE, then RTS is an output, CTS is an input.  If you
> are a DCE, then RTS is an input and CTS is an output (normally on a
> standard UART, you just swap the wiring for RTS and CTS but really that's
> all that is going on.)  So swapping them in software should be acceptable
> too, provided you're not having to disable any auto flow control facilities.
>
Freescale had decided to implement their UARTs on the i.MX SoCs as DCE
and later added a bit to switch between DCE and DTE mode. That's where
all the confusion comes from.


Lothar Wa?mann
-- 
___________________________________________________________

Ka-Ro electronics GmbH | Pascalstra?e 22 | D - 52076 Aachen
Phone: +49 2408 1402-0 | Fax: +49 2408 1402-10
Gesch?ftsf?hrer: Matthias Kaussen
Handelsregistereintrag: Amtsgericht Aachen, HRB 4996

www.karo-electronics.de | info at karo-electronics.de
___________________________________________________________
