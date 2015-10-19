From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 19 Oct 2015 15:50:27 +0100
Subject: [RFC PATCH v2 1/4] drm: Introduce generic probe function for
 component based masters.
In-Reply-To: <20151019144225.GE13786@phenom.ffwll.local>
References: <1445257313-7147-1-git-send-email-Liviu.Dudau@arm.com>
 <1445257313-7147-2-git-send-email-Liviu.Dudau@arm.com>
 <20151019122537.GZ32532@n2100.arm.linux.org.uk>
 <20151019130258.GU3394@e106497-lin.cambridge.arm.com>
 <20151019132638.GB32532@n2100.arm.linux.org.uk>
 <20151019144225.GE13786@phenom.ffwll.local>
Message-ID: <20151019145027.GF32532@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 19, 2015 at 04:42:25PM +0200, Daniel Vetter wrote:
> On Mon, Oct 19, 2015 at 02:26:38PM +0100, Russell King - ARM Linux wrote:
> > On Mon, Oct 19, 2015 at 02:02:58PM +0100, Liviu Dudau wrote:
> > > On Mon, Oct 19, 2015 at 01:25:37PM +0100, Russell King - ARM Linux wrote:
> > > > Please don't move this into here, it's completely inappropriate.  Just
> > > > because something makes use of this does not mean they only support
> > > > 32-bit DMA.  Besides, this has nothing to do with whether or not it's
> > > > OF-based or not.
> > > 
> > > Understood. My thinking process was that component-based drivers are all
> > > OF-enabled (how else do you make use of the framework?) and 32-bit DMA is
> > > present in 2 out of 3 drivers that are converted, so it looks to be common
> > > enough that adding it to armada would not hurt. It was all done in the name of
> > > collecting common code in a single function.
> > 
> > Which is an utterly crap reason.
> > 
> > It's also not appropriate.  I'm really not sure why you think that moving
> > this here would in any way be appropriate - from my point of view, the
> > mere proposal is utterly insane.
> > 
> > The "container" device does not do any DMA, so it's inappropriate for
> > it to have DMA masks set or negotiated on it.  So, actually, no one
> > should be setting the DMA mask for their container device.  It's wrong.
> 
> I think (and my opinion doesn't carry as much wheight here on dri-devel
> than intel-gfx) the above is over the top bashing of a new contributor to
> drm who really seems trying to do right. I think that's unecessary,
> especially since you follow up with the reasonable reply below.

It's justified because it took _two_ messages to get the point across.
The first one asking nicely didn't make the necessary impact.

-- 
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
