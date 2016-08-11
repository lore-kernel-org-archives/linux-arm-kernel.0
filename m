From: daniel@ffwll.ch (Daniel Vetter)
Date: Thu, 11 Aug 2016 10:51:50 +0200
Subject: [PATCH v2 0/7] drm/mediatek: cleaning up and refine
In-Reply-To: <1470900806.2493.21.camel@pengutronix.de>
References: <1470279597-60453-1-git-send-email-bibby.hsieh@mediatek.com>
 <1470900806.2493.21.camel@pengutronix.de>
Message-ID: <20160811085150.GJ6232@phenom.ffwll.local>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 11, 2016 at 09:33:26AM +0200, Philipp Zabel wrote:
> Am Donnerstag, den 04.08.2016, 10:59 +0800 schrieb Bibby Hsieh:
> > These patches based on 4.7-rc1 to clean up unused function
> > & variable and use drm core function instead.
> > 
> > The following patches are needed to cleanly apply on top of v4.7-rc1:
> >  - https://patchwork.kernel.org/patch/8044001/
> >    (drm: Deal with rotation in drm_plane_helper_check_update())
> >  - https://patchwork.kernel.org/patch/9248373/
> >    (drm: Warn about negative sizes when calculating scale factor)
> >  - https://patchwork.kernel.org/patch/9248371/
> >    (drm: Store clipped src/dst coordinatee in drm_plane_state)
> >  - https://patchwork.kernel.org/patch/9248363/
> >    (drm/plane-helper: Add drm_plane_helper_check_state())
> >  - https://patchwork.kernel.org/patch/9248361/
> >    (drm/mediatek: Use drm_plane_helper_check_state())
> > 
> > Bibby Hsieh (2):
> >   drm/mediatek: Use drm_atomic destroy_state helpers
> >   drm/mediatek: Fix mtk_atomic_complete for runtime_pm
> > 
> > Daniel Kurtz (5):
> >   drm/mediatek: Remove mtk_drm_crtc_check_flush
> >   drm/mediatek: plane: Remove plane zpos/index
> >   drm/mediatek: Remove mtk_drm_plane
> 
> I have picked up patches 1-5, but not patches 6-7:
> 
> >   drm/mediatek: plane: Merge mtk_plane_enable into
> >     mtk_plane_atomic_update
> >   drm/mediatek: plane: Use FB's format's cpp to compute x offset
> 
> These two don't apply. Could you please rebase them onto
> git.pengutronix.de/git/pza/linux.git mediatek-drm/next

Note that I think most of them are already in drm-misc, and that branch is
non-rebasing.
-Daniel

> 
> regards
> Philipp
> 

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
