From: jason@lakedaemon.net (Jason Cooper)
Date: Mon, 15 Dec 2014 13:06:06 -0500
Subject: [PATCHv0 5/5] dt-bindings: fix isl vs isil prefix issue for
 Intersil
In-Reply-To: <87388gkcv5.fsf@natisbad.org>
References: <cover.1418519430.git.arno@natisbad.org>
 <b2c34bea6fc7bd42d636c9cadfe1b7e5ec523aeb.1418519430.git.arno@natisbad.org>
 <20141215135545.GC967@titan.lakedaemon.net>
 <87388gkcv5.fsf@natisbad.org>
Message-ID: <20141215180606.GF967@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Dec 15, 2014 at 07:05:18PM +0100, Arnaud Ebalard wrote:
> Hi,
> 
> Jason Cooper <jason@lakedaemon.net> writes:
> 
> >> AFAICT, it seems it makes sense to *definitively* settle for isil
> >> as the vendor prefix for Intersil, as Philip did in 7a6540ca856a:
> >> it's the NASDAQ symbol and this choice requires less changes than
> >> opting for isl.
> >> 
> >> So, this patch changes compatible strings in .dts files to use isil
> >> where isl was found before, and modify drivers w/ compatible
> >> strings using isl to add one using isil. In those cases, a comment
> >> is made that the old compatible string is kept for backward
> >> compatibility (w/ out-fo-tree users of those drivers).
> >> Additionally, it leaves only isil as prefix in vendor-prefixes.txt.
> >> Those changes should prevent any new inclusion of isl compatible
> >> strings for Intersil devices due to copy-and-paste.
> >> 
> >> Signed-off-by: Arnaud Ebalard <arno@natisbad.org> ---
> >> Documentation/devicetree/bindings/i2c/trivial-devices.txt | 5 ++---
> >> Documentation/devicetree/bindings/regulator/isl9305.txt   | 4 ++--
> >> Documentation/devicetree/bindings/vendor-prefixes.txt     | 3 +--
> >
> >>  arch/arm/boot/dts/tegra30-cardhu.dtsi                     | 2 +-
> >>  arch/arm/boot/dts/zynq-parallella.dts                     | 2 +-
> >
> >>  drivers/regulator/isl9305.c                               | 6
> >>  ++++-- drivers/rtc/rtc-isl12022.c                                |
> >>  3 ++- drivers/rtc/rtc-isl12057.c                                |
> >>  3 ++- drivers/staging/iio/light/isl29028.c                      |
> >>  4 ++-- 9 files changed, 17 insertions(+), 15 deletions(-)
> >
> > Please split the dts{i} changes out into a separate patch.  The
> > different maintainers under drivers/ may want separate patches as
> > well.
> 
> I will prepare that, and then let get_maintainer.pl decide who should
> be added to the CC: list. But before doing that work, I would like to
> at least get some feedback that there will not be a big NAK on the
> whole approach in the end.

As long as you are maintaining compatibility with old dtbs (which you
are), then there shouldn't be a problem.  I think the original dust up
occurred because two different maintainers merged two different
solutions and didn't run into each other.  This looks like a sane
cleanup of the resulting mess. :)

thx,

Jason.
