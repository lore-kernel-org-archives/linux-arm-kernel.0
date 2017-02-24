From: pavel@ucw.cz (Pavel Machek)
Date: Fri, 24 Feb 2017 21:09:02 +0100
Subject: [PATCH v4 15/36] platform: add video-multiplexer subdevice driver
In-Reply-To: <1487668265.2331.23.camel@pengutronix.de>
References: <1487211578-11360-1-git-send-email-steve_longerbeam@mentor.com>
 <1487211578-11360-16-git-send-email-steve_longerbeam@mentor.com>
 <20170219220237.GD32327@amd>
 <1487668265.2331.23.camel@pengutronix.de>
Message-ID: <20170224200902.GA19893@amd>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi!

> > Plus you might want to describe which port correspond to which gpio
> > state/bitfield values...
> > 
> > > +struct vidsw {
> > 
> > I knew it: it is secretely a switch! :-).
> 
> This driver started as a two-input gpio controlled bus switch.
> I changed the name when adding support for bitfield controlled
> multiplexers with more than two inputs.

We had discussion with Sakari / Rob whether gpio controlled thing is a
switch or a multiplexer :-).

> > > +	if (!pad) {
> > > +		/* Mirror the input side on the output side */
> > > +		cfg->type = vidsw->endpoint[vidsw->active].bus_type;
> > > +		if (cfg->type == V4L2_MBUS_PARALLEL ||
> > > +		    cfg->type == V4L2_MBUS_BT656)
> > > +			cfg->flags = vidsw->endpoint[vidsw->active].bus.parallel.flags;
> > > +	}
> > 
> > Will this need support for other V4L2_MBUS_ values?
> 
> To support CSI-2 multiplexers, yes.

Can you stick switch () { .... default: dev_err() } there, to help
future hackers?

Thank,
									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 181 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170224/521fe700/attachment.sig>
