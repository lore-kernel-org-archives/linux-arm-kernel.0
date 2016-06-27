From: bibby.hsieh@mediatek.com (Bibby Hsieh)
Date: Mon, 27 Jun 2016 19:29:30 +0800
Subject: [GIT PULL] drm/mediatek: MT8173 gamma & dither support
In-Reply-To: <558c9efc-d197-a6c3-cf7e-f9fcac60ca64@gmail.com>
References: <1466753238-17216-1-git-send-email-bibby.hsieh@mediatek.com>
 <558c9efc-d197-a6c3-cf7e-f9fcac60ca64@gmail.com>
Message-ID: <1467026970.23883.16.camel@mtksdaap41>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 2016-06-27 at 12:20 +0200, Matthias Brugger wrote:
> 
> On 06/24/2016 09:27 AM, Bibby Hsieh wrote:
> > Hi Dave,
> >
> > Please consider merging this tag, which contains the v2 MT8173 gamma & dither function patches I sent on 2016-06-17, rebased onto v4.7-rc1. There have been no further comments.
> >
> > Thanks
> > Bibby
> >
> > The following changes since commit 1a695a905c18548062509178b98bc91e67510864:
> >
> >   Linux 4.7-rc1 (2016-05-29 16:29:24 GMT)
> >
> > are available in the git repository at:
> >
> >   git at github.com:BibbyHsieh/linux4.7-rc1.git
> >
> > for you to fetch changes up to dd0eb773bc125f5e6bca735d19c08500dc3730f9:
> >
> >   drm/mediatek: Add gamma correction
> >
> > -------------------------------------------------------------------------
> 
> As far as I can see, your branch has 3 patches on top from Eddie. It 
> seems to me as if you didn't send your patches to the mailinglist before?
> Anyway this branch does not fulfill the rules to get merged into the 
> linux kernel.
> 
> Why do you send a pull request? The normal process is to send the 
> patches via email and if the maintainer wants you can send a pull 
> request once the patches are ready to be merged.
> 
> Regards,
> Matthias
> 

I sent v1 and v2 on 2016-06-14 and 06-17 respectively [0-8].
After I made some modifications according to Daniel Vetter's comments,
there had been no further comments and I sent the pull request as the
other sub-sys.

I'm sorry for my mistake, I will re-arrange the tree for upstream.
Next time, I will check with maintainer by email first, and sent the
pull request.

Thanks.
Bibby 
 
[0]https://patchwork.kernel.org/patch/9174941/
[1]https://patchwork.kernel.org/patch/9174855/
[2]https://patchwork.kernel.org/patch/9182361/
[3]https://patchwork.kernel.org/patch/9182367/
[4]https://lists.freedesktop.org/archives/dri-devel/2016-June/111178.html
[5]https://lists.freedesktop.org/archives/dri-devel/2016-June/111177.html
[6]https://lists.freedesktop.org/archives/dri-devel/2016-June/111176.html
[7]https://lists.freedesktop.org/archives/dri-devel/2016-June/110781.html
[8]https://lists.freedesktop.org/archives/dri-devel/2016-June/110782.html
[9]https://lists.freedesktop.org/archives/dri-devel/2016-June/110784.html

> > This is MT8173 gamma & dither support PATCH v2, based on 4.7-rc1.
> >
> > Changes since v1:
> >  -According to the suggestion from Daniel,
> >   we used the new atomic color management.
> >  -Applied gamma function at GAMMA engine (path 2).
> >  -Made dithering function support hardware mirroring well.
> >  -Removed the bpc variable from mtk_drm_crtc struct.
> > -------------------------------------------------------------------------
> >
> > Bibby Hsieh (2):
> >   drm/mediatek: Add gamma correction
> >   drm/mediatek: set mt8173 dithering function
> >
> >  drivers/gpu/drm/mediatek/mtk_disp_ovl.c     |    3 +-
> >  drivers/gpu/drm/mediatek/mtk_disp_rdma.c    |    3 +-
> >  drivers/gpu/drm/mediatek/mtk_drm_crtc.c     |   26 ++++-
> >  drivers/gpu/drm/mediatek/mtk_drm_crtc.h     |    1 +
> >  drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.c |  147 ++++++++++++++++++++++++++-
> >  drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.h |   16 ++-
> >  6 files changed, 184 insertions(+), 12 deletions(-)
> >
