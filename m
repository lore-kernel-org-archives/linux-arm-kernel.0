From: l.stach@pengutronix.de (Lucas Stach)
Date: Tue, 08 Sep 2015 13:07:47 +0200
Subject: I.MX6 HDMI support in v4.2
In-Reply-To: <20150908110135.GW21084@n2100.arm.linux.org.uk>
References: <m3bnde5whx.fsf@t19.piap.pl>
 <20150907112555.GS21084@n2100.arm.linux.org.uk>
 <m337yp5gvv.fsf@t19.piap.pl> <1441709778.13536.8.camel@pengutronix.de>
 <20150908110135.GW21084@n2100.arm.linux.org.uk>
Message-ID: <1441710467.13536.13.camel@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Dienstag, den 08.09.2015, 12:01 +0100 schrieb Russell King - ARM
Linux:
> On Tue, Sep 08, 2015 at 12:56:18PM +0200, Lucas Stach wrote:
> > This is expected, it's the overlay adapter which doesn't really work
> > with imx-drm yet.
> 
> No, it's imx-drm which isn't working.  As I explained in my previous
> email, overlay planes are expected to do scaling.  imx-drm errors out
> attempts for that.  This is a kernel bug, not an Xorg driver bug.
> 
I would argue that this is a bug of the interface between kernel and
userspace.
Scaling isn't something that can be expected to be usable on every
hardware (and in fact the IPU isn't able to do arbitrary scaling with
its 1024 in/out pixel constraints), but there is no clear way to
communicate this to userspace other than flat out rejecting the plane
update. Atomic may provide some better ways, but we are not there yet
for imx-drm.

Regards,
Lucas
-- 
Pengutronix e.K.             | Lucas Stach                 |
Industrial Linux Solutions   | http://www.pengutronix.de/  |
