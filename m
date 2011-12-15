From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Thu, 15 Dec 2011 14:23:36 +0100
Subject: [RFC PATCH v2 4/4] mmc: sdhci-esdhc-imx: using pinmux subsystem
In-Reply-To: <20111215121752.GD10522@S2101-09.ap.freescale.net>
References: <CACRpkdYHtgx3Qgx4QRdgOahQXjvSWE_iogWCZjaYQ-VnyS62uQ@mail.gmail.com>
 <20111215070505.GA22541@S2101-09.ap.freescale.net>
 <CACRpkdbN26q1_d4tPkJp4f4_KdvoEEk9uCCRyOfEU97DOWAnEw@mail.gmail.com>
 <7FE21149F4667147B645348EC60578850564C5@039-SN2MPN1-013.039d.mgd.msft.net>
 <20111215093319.GO27267@pengutronix.de>
 <20111215112140.GA10522@S2101-09.ap.freescale.net>
 <7FE21149F4667147B645348EC60578850567C3@039-SN2MPN1-013.039d.mgd.msft.net>
 <20111215115300.GB10522@S2101-09.ap.freescale.net>
 <20111215115428.GQ27267@pengutronix.de>
 <20111215121752.GD10522@S2101-09.ap.freescale.net>
Message-ID: <20111215132336.GR27267@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Dec 15, 2011 at 08:17:54PM +0800, Shawn Guo wrote:
> On Thu, Dec 15, 2011 at 12:54:28PM +0100, Sascha Hauer wrote:
> > On Thu, Dec 15, 2011 at 07:53:05PM +0800, Shawn Guo wrote:
> > > On Thu, Dec 15, 2011 at 07:28:18PM +0800, Dong Aisheng-B29396 wrote:
> > > > > -----Original Message-----
> > > > > 
> > > > My understanding is that pinmux_get will return an error if no proper pinmux
> > > > Found without dummy pinmux. That's a real error.
> > > > But with dummy pinmux, if no proper pinmux found, the pinctrl core may check
> > > > If dummy pinmux is supported, if supported, it will fakely success with returning
> > > > a dummy pinmux. Then real error is hiden.
> > > > This is due to for supporting one single image, the dummy pinmux may also be enabled
> > > > For platforms like mx6q with real pinmux.
> > > > 
> > > Got your point.  So your concern is about the fake success when dummy
> > > pinmux comes to play rather than 'fake error'.  I'm not concerned about
> > > that case much, since we will know the failure with a simple debug/info
> > > message in the pinmux core, saying 'I do not find any available pinmux,
> > > and I'm falling into the dummy pinmux'.  When you see this message
> > > imx6q, you know something goes wrong.
> > 
> > So i.MX3/5 people must know that it's safe to ignore this message
> > whereas i.MX6 people must know there's something wrong Adding messages
> > saying "there might or might not be something wrong" is not good.
> > People will frequently ask on the mailing list about these messages.
> > 
> Usually, people checking the serial output and asking question on list
> are developers not users.  It's not too hard for developers to figure
> out such message.  Or we can making it a debug message, and when some
> driver is not working, turn on debug option, you know where it goes
> wrong.

So we as developers have to figure out ourselves what can go wrong and
the users, well who cares about users?

> 
> Anyway, it's not a problem to me.  I have seen similar messages on my
> kernel serial output.  I fail to see why pinmux can not do something
> that other subsystems are doing.

Yes, and everytime I see such a message I dig through the sourcecode
trying to find out if that's important or not. That's easy for me on
the systems I work with, but on my PC I am only a user, and honestly
on my PC I *want* to be only a user.

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
