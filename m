From: daniel@ffwll.ch (Daniel Vetter)
Date: Tue, 14 Aug 2018 12:42:42 +0200
Subject: [PATCH v2 4/7] drm/i2c: tda998x: convert to bridge driver
In-Reply-To: <20180810171630.GR30658@n2100.armlinux.org.uk>
References: <20180730164137.GD17271@n2100.armlinux.org.uk>
 <E1fkBFV-00048s-O2@rmk-PC.armlinux.org.uk>
 <20180808190930.GQ20303@art_vandelay>
 <20180808221547.GN30658@n2100.armlinux.org.uk>
 <20180810161105.GT20303@art_vandelay>
 <20180810165037.GQ30658@n2100.armlinux.org.uk>
 <20180810170229.GU20303@art_vandelay>
 <20180810171630.GR30658@n2100.armlinux.org.uk>
Message-ID: <20180814104242.GO21634@phenom.ffwll.local>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Aug 10, 2018 at 06:16:30PM +0100, Russell King - ARM Linux wrote:
> On Fri, Aug 10, 2018 at 01:02:29PM -0400, Sean Paul wrote:
> > On Fri, Aug 10, 2018 at 05:50:37PM +0100, Russell King - ARM Linux wrote:
> > > Almost none of my DRM specific patches on dri-devel this time around
> > > received any feedback what so ever, even after myself and David chasing
> > > them up.  Over the Armada changes, David Airlie eventually said to me
> > > "if it works for you, send it to me I suppose".
> > > 
> > > David also tried poking the tda998x/component discussion thread as well
> > > from the beginning of July (or so David told me), with seemingly the
> > > same result.
> > > 
> > > So, in summary, it's been almost impossible to get any feedback on any
> > > of the patches and discussions I've sent - I think extracting blood
> > > from a rock might be easier! ;)
> > 
> > Yeah, I suspect a lot of people have blinders wrt tda given that it's off in
> > i2c/. Feel free to ping me on irc in future if you're looking for a review. Once
> > tda moves to bridge/ and drm-misc, it'll likely be much easier to get people
> > engaged.
> 
> I suspect that those who actually use it don't have such blinders, yet
> they also have ignored the patches despite being copied with them.  I
> can't see that the location of the driver would make any difference
> for them.

Expecting review to magically happen doesn't work. You need to actively
solicit that, and often that involves a bit of reviewing trading.
Especially anywhere where a part of the kernel is officially
group-maintained like drm_bridge.

Given your past track record of handling other contributors I think it's
entirely understandably that people do not choose to collaborate with you
voluntarily. Fixing that is entirely up to you though.

I good first step here would imo be to move the tda driver under bridge,
formally put it under the drm-misc group maintainership, actively solict
and ack for that from other bridge maintainers and then also suggest other
authors and contributors to the tda driver to join as committers and
co-maintainers.

Thanks, Daniel
-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
