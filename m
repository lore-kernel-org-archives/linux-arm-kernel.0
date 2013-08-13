From: tomasz.figa@gmail.com (Tomasz Figa)
Date: Tue, 13 Aug 2013 23:11:25 +0200
Subject: [PATCH 12/18] ARM: s3c64xx: Add support for DMA using generic
 amba-pl08x driver
In-Reply-To: <20130813203536.GI6427@sirena.org.uk>
References: <1376243970-6489-1-git-send-email-tomasz.figa@gmail.com>
 <4262768.VLqddFvVic@flatron> <20130813203536.GI6427@sirena.org.uk>
Message-ID: <7183441.XhIsgkmB55@flatron>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 13 of August 2013 21:35:36 Mark Brown wrote:
> On Tue, Aug 13, 2013 at 01:10:02PM -0700, Tomasz Figa wrote:
> > On Tuesday 13 of August 2013 18:52:51 Mark Brown wrote:
> > > On Sun, Aug 11, 2013 at 07:59:24PM +0200, Tomasz Figa wrote:
> > > > +#define pl330_filter pl08x_filter_id
> > > 
> > > So, this is pretty fun and probably not going to play too nicely for
> > > multiplatform kernels...
> > 
> > Yes, this is really funny and only shows the brokenness of current
> > channel filtering mechanism used in DMA engine subsystem. Fortunately
> > this is quite irrelevant to multiplatform kernels, because no users
> > of it will be compiled in, since it's used only for legacy (non-DT)
> > channel filtering.
> Well, the thing here is more about the fact that the match function is
> silently being hijacked - it should be possible to do this in the device
> registrations.  I'd expect you could get a non-DT kernel which was
> affected, but you'd probably have to try.

Let me see what I can do to improve things for now.

> > Anyway, I would happily redesign and rewrite the DMA engine channel
> > matching completely to make it much more sane, but I guess I would
> > need an ack from Vinod and Dan to do it.
> 
> I'd be really keen to get this code merged sooner rather than later for
> ASoC development so if there's a way to do it separately to fixing the
> filtering that'd be good.

I fully agree on this. I still have other things to work on, so the 
possible redesign of channel filtering would not probably happen before 
3.12 merge window closes.

Best regards,
Tomasz
