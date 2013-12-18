From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 18 Dec 2013 15:29:27 +0000
Subject: OMAP display subsystem - does it work?
In-Reply-To: <52B1A922.6020901@ti.com>
References: <20131218120023.GG4360@n2100.arm.linux.org.uk>
 <52B1A922.6020901@ti.com>
Message-ID: <20131218152927.GC32243@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Dec 18, 2013 at 03:54:42PM +0200, Tomi Valkeinen wrote:
> On 2013-12-18 14:00, Russell King - ARM Linux wrote:
> > For the SDP4430, it used to detect the displays, even though nothing has
> > ever been displayed on them.  Now it just spits out this:
> 
> Those particular LCDs are supposed to be updated manually using custom ioctl,
> so normal software using fb won't put anything on the display. For testing
> purposes, a SW based automatic update (~20 fps) can be enabled by kernel
> cmdline parameter "omapfb.auto_update" or via sysfs:
> 
> echo 1 > /sys/class/graphics/fb0/update_mode

I'm confused.  How then can the original kernel which came with the board
run two gstreamer videos on these displays by just talking to the
framebuffers and play it back smoothly given that we're talking about
video at normal fps settings?

When I received the board, that's exactly what it did at boot up - it
played back two different video trailers, one on each LCD, and the
playback was smooth, just like you'd expect from watching a DVD on your
TV.  No missing frames, which is what you'd get if you tried to update
at 20fps.
