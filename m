From: pavel@ucw.cz (Pavel Machek)
Date: Sat, 30 Apr 2016 00:13:59 +0200
Subject: camera application for testing (was Re: v4l subdevs without big
 device)
In-Reply-To: <57230DE7.3020701@xs4all.nl>
References: <20160428084546.GA9957@amd> <20160429071525.GA4823@amd>
 <57230DE7.3020701@xs4all.nl>
Message-ID: <20160429221359.GA29297@amd>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi!

What is reasonable camera application for testing?

N900 looks like a low-end digital camera. I have now have the hardware
working (can set focus to X cm using command line), but that's not
going to be useful for taking photos.

In particular, who is going to do computation neccessary for
autofocus, whitebalance and exposure/gain?

There's http://fcam.garage.maemo.org/gettingStarted.html that should
work on maemo, but a) it is not in Debian, b) it has non-trivial
dependencies and c) will be a lot of fun to get working...

(and d), will not be too useful, anyway, due to 1sec shutter lag:

Fast resolution switching (less shutter lag)
FCam is built on top of V4L2, which doesn't handle rapidly varying
resolutions. When a Shot with a different resolution to the previous
one comes down the pipeline, FCam currently flushes the entire V4L2
pipeline, shuts down and restarts the whole camera subsystem, then
starts streaming at the new resolution. This takes a long time (nearly
a second), and is the cause of the horrible shutter lag on the N900. A
brave kernel hacker may be able to reduce this time by fiddling with
the FCam ISP kernel modules and the guts of the FCam library source
(primarily Daemon.cpp).
Anyone who solves this one will have our undying gratitude. An ideal
solution would be able to insert a 5MP capture into a stream of
640x480 frames running at 30fps, without skipping more than the frame
time of the 5MP capture. That is, the viewfinder would effectively
stay live while taking a photograph.

)

Any other application I should look at? Thanks,
									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
