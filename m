From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Mon, 21 Nov 2016 08:30:47 +0100
Subject: [PATCH 5/5] drm/sun4i: Add support for the overscan profiles
In-Reply-To: <20161111091755.tfqizju5voazjrmm@phenom.ffwll.local>
References: <cover.bb9be34c7fd7767e31823f78a15ae1c127293c34.1476779323.git-series.maxime.ripard@free-electrons.com>
 <b980759ad766658d7bc3d67c18f505c5bf727ef5.1476779323.git-series.maxime.ripard@free-electrons.com>
 <20161108085927.ibyett46cjgyfwu2@phenom.ffwll.local>
 <20161110145630.wvzlh6rxusrufv2r@lukather>
 <20161111091755.tfqizju5voazjrmm@phenom.ffwll.local>
Message-ID: <20161121073047.zv5cfjd3ti4hh4gl@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 11, 2016 at 10:17:55AM +0100, Daniel Vetter wrote:
> On Thu, Nov 10, 2016 at 03:56:30PM +0100, Maxime Ripard wrote:
> > Hi Daniel,
> > 
> > On Tue, Nov 08, 2016 at 09:59:27AM +0100, Daniel Vetter wrote:
> > > On Tue, Oct 18, 2016 at 10:29:38AM +0200, Maxime Ripard wrote:
> > > > Create overscan profiles reducing the displayed zone.
> > > > 
> > > > For each TV standard (PAL and NTSC so far), we create 4 more reduced modes
> > > > by steps of 5% that the user will be able to select.
> > > > 
> > > > Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
> > > 
> > > tbh I think if we agree to do this (and that still seems an open question)
> > > I think there should be a generic helper to add these overscan modes with
> > > increased porches. Anything that only depends upon the sink (and
> > > overscanning is something the sink does) should imo be put into a suitable
> > > helper library for everyone to share.
> > > 
> > > Or maybe even stash it into the probe helpers and call it for all TV
> > > connectors. Definitely not a driver-private thing.
> > 
> > Last time we discussed it, my recollection was that you didn't want to
> > have generic code for it, but I'd be happy to implement it.
> > 
> > I'll come up with something like that.
> 
> Well I can flip-flop around with the nonsense I'm sometimes emitting ;-)
> Since you called me out, feel free to do whatever you want ...

I also found the generic solution to be a much better solution, so
I'll definitely implement it :)

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 801 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20161121/7da26be6/attachment-0001.sig>
