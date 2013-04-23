From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 23 Apr 2013 17:27:10 +0200
Subject: [PATCH 06/10] usb: musb: ux500: add device tree probing support
In-Reply-To: <20130423151533.GD15177@arwen.pp.htv.fi>
References: <1366729394-11406-1-git-send-email-lee.jones@linaro.org>
 <201304231714.06326.arnd@arndb.de> <20130423151533.GD15177@arwen.pp.htv.fi>
Message-ID: <201304231727.10696.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 23 April 2013, Felipe Balbi wrote:
> On Tue, Apr 23, 2013 at 05:14:06PM +0200, Arnd Bergmann wrote:
> > On Tuesday 23 April 2013, Lee Jones wrote:
> > > +Required properties:
> > > + - compatible : Should be "stericsson,db8500-musb"
> > > + - reg        : Offset and length of registers
> > > + - interrupts : Interrupt; mode, number and trigger
> > > + - mode       : One of; "host", "otg", or "peripheral"
> > 
> > I think we don't have any precedent for this combination of "mode" property
> > and contents. You could either try to match ehci-omap.txt and do
> 
> there is dr_mode which other folks are using. Let's use the same thing.

On that topic, should we support the same property in am35x.c and 
musbhsdma.c? They currently use an integer rather than a string.

	Arnd
