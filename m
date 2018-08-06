From: daniel@ffwll.ch (Daniel Vetter)
Date: Mon, 6 Aug 2018 17:48:39 +0200
Subject: [PATCH v3 00/10] Add helper for plane reset
In-Reply-To: <7271371.hQdeefBnlA@avalon>
References: <20180804161530.12275-1-alexandru-cosmin.gheorghe@arm.com>
 <15977863.ZBGtPEODRU@avalon>
 <20180806122038.GA6755@e114479-lin.cambridge.arm.com>
 <7271371.hQdeefBnlA@avalon>
Message-ID: <20180806154839.GR3008@phenom.ffwll.local>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Aug 06, 2018 at 03:28:06PM +0300, Laurent Pinchart wrote:
> Hi Alex,
> 
> On Monday, 6 August 2018 15:20:38 EEST Alexandru-Cosmin Gheorghe wrote:
> > On Mon, Aug 06, 2018 at 02:45:42PM +0300, Laurent Pinchart wrote:
> > > On Monday, 6 August 2018 14:07:27 EEST Alexandru-Cosmin Gheorghe wrote:
> > >> On Sat, Aug 04, 2018 at 05:15:20PM +0100, Alexandru Gheorghe wrote:
> > >>> No significant change since v2, fixed a spelling mistake and
> > >>> added/removed some newlines in 01 and 07 patches.
> > >>> 
> > >>> I plan to apply the first patch of the series and the patches for
> > >>> the drivers maintained through drm-misc(that go Reviewed/Ack) in
> > >>> drm-misc-next on Monday.
> > >>> 
> > >>> For the other drivers please let me know if you want me to push them
> > >>> in drm-misc-next as well.
> > >> 
> > >> Pushed the following patch to drm-misc-next:
> > >> 
> > >> drm/atomic: Add __drm_atomic_helper_plane_reset
> > >> drm: mali-dp: Use __drm_atomic_helper_plane_reset instead of copying the
> > >> logic
> > >> drm: atmel-hlcdc: Use __drm_atomic_helper_plane_reset instead of copying
> > >> the logic
> > >> drm/imx: Use __drm_atomic_helper_plane_reset instead of copying the
> > >> logic
> > >> drm/sun4i: Use __drm_atomic_helper_plane_reset instead of copying the
> > >> logic
> > > 
> > > I've acked the rcar-du part, could it be merged with the rest of the code
> > > ?
> > 
> > Done, it's in drm-misc-next now. I didn't know how to handle this for
> > drivers that have their own tree, so I just pushed the patches where I was
> > explicitly asked.
> 
> No worries. It's actually better to ask than pushing changes directly, as 
> maintainers could have conflicting patches queued up. I should have made this 
> clear in my review, thank you for handling it.

Poke them a few times, if no response then just get someone to review the
remaining ones and push them all into drm-misc-next. This is needed all
the time because many drivers aren't group maintained and the single
maintainer swamped/absent. Worst case there's a conflict or a
double-merge, which isn't really all that bad.
-Daniel
-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
