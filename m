From: pavel@ucw.cz (Pavel Machek)
Date: Tue, 18 Apr 2017 11:05:05 +0200
Subject: [PATCH v6 17/39] platform: add video-multiplexer subdevice driver
In-Reply-To: <1492502989.2432.23.camel@pengutronix.de>
References: <1490661656-10318-1-git-send-email-steve_longerbeam@mentor.com>
 <1490661656-10318-18-git-send-email-steve_longerbeam@mentor.com>
 <20170404124732.GD3288@valkosipuli.retiisi.org.uk>
 <1492091578.2383.39.camel@pengutronix.de>
 <20170414203216.GA10920@amd>
 <1492502989.2432.23.camel@pengutronix.de>
Message-ID: <20170418090505.GA25414@amd>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi!

> That self-referencing mux-controls property looks a bit superfluous:
> 
> 	mux: video-multiplexer {
> 		mux-controls = <&mux>;
> 	};
> 
> Other than that, I'm completely fine with splitting the compatible into
> something like video-mux-gpio and video-mux-mmio and reusing the
> mux-gpios property for video-mux-gpio.

Agreed, I overseen that.

> > You should be able to use code in drivers/mux as a library...
> 
> This is a good idea in principle, but this requires some rework of the
> mux subsystem, and that subsystem hasn't even landed yet. For now I'd
> like to focus on getting the DT bindings right.
> 
> I'd honestly prefer to not add this rework as a requirement for the i.MX
> media drivers to get into staging.

Hmm. staging/ normally accepts code with bigger design problems than
that.

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170418/1c115102/attachment.sig>
