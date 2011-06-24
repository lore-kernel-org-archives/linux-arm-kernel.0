From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 24 Jun 2011 10:01:43 +0100
Subject: [PATCH] ARM: amba: Link fb device to its parent
In-Reply-To: <20110624080721.GC24184@linux-sh.org>
References: <1308602657-28783-1-git-send-email-loic.minier@linaro.org>
	<20110624080721.GC24184@linux-sh.org>
Message-ID: <20110624090143.GC23234@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 24, 2011 at 05:07:21PM +0900, Paul Mundt wrote:
> On Mon, Jun 20, 2011 at 10:44:17PM +0200, Lo??c Minier wrote:
> > Some pieces of userspace like debian-installer expect to find the fb0
> > driver name by readlink-ing /sys/class/graphics/fb0/device/driver but
> > this was broken with amba-clcd as it sets up fb_info manually and missed
> > the .device parent pointer.
> > 
> > Signed-off-by: Lo??c Minier <loic.minier@linaro.org>
> > Cc: Russell King <linux@arm.linux.org.uk>
> > Cc: Paul Mundt <lethal@linux-sh.org>
> > ---
> >  drivers/video/amba-clcd.c |    2 ++
> >  1 files changed, 2 insertions(+), 0 deletions(-)
> > 
> While this is titled as an ARM patch it's certainly fbdev-specific. I'll
> apply it barring any objections from Russell.

Acked-by: Russell King <rmk+kernel@arm.linux.org.uk>
