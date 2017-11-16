From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Thu, 16 Nov 2017 12:02:04 +0100
Subject: [linux-sunxi] Cedrus driver
In-Reply-To: <693e8786-af83-9d77-0fd4-50fa1f6a135f@micronovasrl.com>
References: <1510059543-7064-1-git-send-email-giulio.benetti@micronovasrl.com>
 <1b12fa21-bfe6-9ba7-ae1d-8131ac6f4668@micronovasrl.com>
 <6fcdc0d9-d0f8-785a-bb00-b1b41c684e59@imkreisrum.de>
 <693e8786-af83-9d77-0fd4-50fa1f6a135f@micronovasrl.com>
Message-ID: <20171116110204.poakahqjz4sj7pmu@flea>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

I'm not sure why there's so many recipients (Russell, Rob or Mark have
a limited interest in this I assume), and why you're also missing some
key ones (like the v4l2 list).

On Thu, Nov 16, 2017 at 11:37:30AM +0100, Giulio Benetti wrote:
> Il 16/11/2017 11:31, Andreas Baierl ha scritto:
> > Am 16.11.2017 um 11:13 schrieb Giulio Benetti:
> > > Hello,
> > > 
> > Hello,
> > > I'm wondering why cedrus
> > > https://github.com/FlorentRevest/linux-sunxi-cedrus has never been
> > > merged with linux-sunxi sunxi-next.
> > > 
> > Because it is not ready to be merged. It depends on the v4l2 request
> > API, which was not merged and which is re-worked atm.
> > Also, sunxi-cedrus itself is not in a finished state and is not as
> > feature-complete to be merged. Anyway it might be something for
> > staging... Has there been a [RFC] on the mailing list at all?
> 
> Where can I find a list of TODOs to get it ready to be merged?

Assuming that the request API is in, we'd need to:
  - Finish the MPEG4 support
  - Work on more useful codecs (H264 comes to my mind)
  - Implement the DRM planes support for the custom frame format
  - Implement the DRM planes support for scaling
  - Test it on more SoCs

Or something along those lines.

> > > I see it seems to be dead, no commit in 1 year.
> >
> > Yes, because the author did this during an internship, which ended ...
> > Afaik nobody picked up his work yet.

That's not entirely true. Some work has been done by Thomas (in CC),
especially on the display engine side, but last time we talked his
work was not really upstreamable.

We will also resume that effort starting next march.

> > > since we need video acceleration on A20 and A33.
> > > 
> > ack.
> 
> By the way, when you answer to google group, is it right that all CC I
> inserted are not inserted too?
> Because this causes mess with mailing lists (seems to me).

Yes, that's one of the many brain-damaged thing happening on that
list...

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20171116/fc3ef62c/attachment.sig>
