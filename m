From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 19 Dec 2013 17:53:36 +0000
Subject: OMAP display subsystem - does it work?
In-Reply-To: <52B1A922.6020901@ti.com>
References: <20131218120023.GG4360@n2100.arm.linux.org.uk>
 <52B1A922.6020901@ti.com>
Message-ID: <20131219175336.GD32243@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Dec 18, 2013 at 03:54:42PM +0200, Tomi Valkeinen wrote:
> On 2013-12-18 14:00, Russell King - ARM Linux wrote:
> 
> > So, here goes.  LDP3430:
> > 
> > OMAP DSS rev 2.0
> > omapdss DPI error: can't get VDDS_DSI regulator
> > omapfb omapfb: failed to connect default display
> > omapfb omapfb: failed to init overlay connections
> > omapfb omapfb: failed to setup omapfb
> > platform omapfb: Driver omapfb requests probe deferral
> > 
> > I don't see evidence of it being re-probed, but I do see this during boot
> > which implies that there's nothing there:
> > 
> > XIO:  fatal IO error 104 (Connection reset by peer) on X server ":0.0"
> >       after 0 requests (0 known processed) with 0 events remaining.
> 
> I don't have an LDP board at hand, and I wasn't able to find out anything
> from the logs.

Well, the X server dies because of some issue with tslib.  No idea
about that.  However, disabling touschreen stuff, the X server comes
up, but the LCD remains blank.

Since the LDP has openembedded stuff on it, it normally would boot
with a progress splash - that also is never displayed.  Maybe there's
something up with the backlight support?  This used to work with
mainline kernels I don't know how long ago.
