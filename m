From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Mon, 21 Jul 2014 10:21:51 +0200
Subject: [PATCH] ARM: i.MX6: add more chip revision support
In-Reply-To: <20140721070647.GK8537@dragon>
References: <1405921091-28748-1-git-send-email-shawn.guo@freescale.com>
 <20140721063520.GR23235@pengutronix.de>
 <20140721070647.GK8537@dragon>
Message-ID: <20140721082151.GU23235@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 21, 2014 at 03:06:48PM +0800, Shawn Guo wrote:
> On Mon, Jul 21, 2014 at 08:35:20AM +0200, Sascha Hauer wrote:
> > On Mon, Jul 21, 2014 at 01:38:11PM +0800, Shawn Guo wrote:
> > > From: Jason Liu <r64343@freescale.com>
> > > 
> > > Add more revision support for the new i.MX6DQ tap-out (TO1.5).  This
> > > TO1.5 is the Rev 1.3 as documented in i.MX6DQ data sheet, because TO1.3
> > > and TO1.4 are never revealed.
> > 
> > So the chip identifies itself as 1.5 but the data sheet refers to it as
> > 1.3. Is there a way to make that clear somewhere? Otherwise it's really
> > confusing.
> 
> I can add a note about that in the code, but I'm not really sure if
> there is a better way to pass such info to end users.  Suggestions are
> welcomed.

Since the anatop code can be used by other SoCs aswell and you're saying
that even the other i.MX6 SoC variants may have a different numbering I
think adding a comment to the code is the best we can do.

The only other possibility I can think of is to make the info string we
print during boot SoC specific again, but I think we are all glad that
this isn't the case anymore.

So adding a comment should be fine. At least the code would be the place
I would look if I remembered that there is some inconsistency and don't
know exactly what it was.

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
