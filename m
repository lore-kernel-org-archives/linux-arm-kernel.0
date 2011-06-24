From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Fri, 24 Jun 2011 09:57:06 -0400 (EDT)
Subject: [PATCH] ARM: amba: Link fb device to its parent
In-Reply-To: <20110624080721.GC24184@linux-sh.org>
References: <1308602657-28783-1-git-send-email-loic.minier@linaro.org>
	<20110624080721.GC24184@linux-sh.org>
Message-ID: <alpine.LFD.2.00.1106240949590.2142@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 24 Jun 2011, Paul Mundt wrote:

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

BTW this should be "Lo?c Minier" not "Lo??c Minier" The original email 
was fine with proper UTF-8 in that regard.  Maybe you should have a look 
at your MUA config so the resulting patch log going into git is not 
dammaged.


Nicolas
