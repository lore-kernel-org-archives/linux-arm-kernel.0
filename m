From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 8 Sep 2015 12:29:09 +0100
Subject: I.MX6 HDMI support in v4.2
In-Reply-To: <1441710467.13536.13.camel@pengutronix.de>
References: <m3bnde5whx.fsf@t19.piap.pl>
 <20150907112555.GS21084@n2100.arm.linux.org.uk>
 <m337yp5gvv.fsf@t19.piap.pl>
 <1441709778.13536.8.camel@pengutronix.de>
 <20150908110135.GW21084@n2100.arm.linux.org.uk>
 <1441710467.13536.13.camel@pengutronix.de>
Message-ID: <20150908112909.GX21084@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Sep 08, 2015 at 01:07:47PM +0200, Lucas Stach wrote:
> Am Dienstag, den 08.09.2015, 12:01 +0100 schrieb Russell King - ARM
> Linux:
> > On Tue, Sep 08, 2015 at 12:56:18PM +0200, Lucas Stach wrote:
> > > This is expected, it's the overlay adapter which doesn't really work
> > > with imx-drm yet.
> > 
> > No, it's imx-drm which isn't working.  As I explained in my previous
> > email, overlay planes are expected to do scaling.  imx-drm errors out
> > attempts for that.  This is a kernel bug, not an Xorg driver bug.
> > 
> I would argue that this is a bug of the interface between kernel and
> userspace.

Yes, only in so far as knowing beforehand whether scaling is possible.
The only time that you get to know is when the call to display the plane
fails.  That's a really poor interface.

> Scaling isn't something that can be expected to be usable on every
> hardware (and in fact the IPU isn't able to do arbitrary scaling with
> its 1024 in/out pixel constraints), but there is no clear way to
> communicate this to userspace other than flat out rejecting the plane
> update. Atomic may provide some better ways, but we are not there yet
> for imx-drm.

I think that depends on your point of view - I suspect x86 people would
be surprised by that comment. :)

There was talk a while back when the overlay plane support went in that
it was possible to do >1024 pixels, but it was complex, but the impression
I was left with was one day it would work - and I'm still waiting.  I
suspect that the iMX6 is going to be obsolete before we have a decent
working video playback story on this hardware.

-- 
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
