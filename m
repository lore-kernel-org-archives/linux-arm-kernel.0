From: matthias.bgg@gmail.com (Matthias Brugger)
Date: Mon, 27 Jun 2016 12:20:10 +0200
Subject: [GIT PULL] drm/mediatek: MT8173 gamma & dither support
In-Reply-To: <1466753238-17216-1-git-send-email-bibby.hsieh@mediatek.com>
References: <1466753238-17216-1-git-send-email-bibby.hsieh@mediatek.com>
Message-ID: <558c9efc-d197-a6c3-cf7e-f9fcac60ca64@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 06/24/2016 09:27 AM, Bibby Hsieh wrote:
> Hi Dave,
>
> Please consider merging this tag, which contains the v2 MT8173 gamma & dither function patches I sent on 2016-06-17, rebased onto v4.7-rc1. There have been no further comments.
>
> Thanks
> Bibby
>
> The following changes since commit 1a695a905c18548062509178b98bc91e67510864:
>
>   Linux 4.7-rc1 (2016-05-29 16:29:24 GMT)
>
> are available in the git repository at:
>
>   git at github.com:BibbyHsieh/linux4.7-rc1.git
>
> for you to fetch changes up to dd0eb773bc125f5e6bca735d19c08500dc3730f9:
>
>   drm/mediatek: Add gamma correction
>
> -------------------------------------------------------------------------

As far as I can see, your branch has 3 patches on top from Eddie. It 
seems to me as if you didn't send your patches to the mailinglist before?
Anyway this branch does not fulfill the rules to get merged into the 
linux kernel.

Why do you send a pull request? The normal process is to send the 
patches via email and if the maintainer wants you can send a pull 
request once the patches are ready to be merged.

Regards,
Matthias

> This is MT8173 gamma & dither support PATCH v2, based on 4.7-rc1.
>
> Changes since v1:
>  -According to the suggestion from Daniel,
>   we used the new atomic color management.
>  -Applied gamma function at GAMMA engine (path 2).
>  -Made dithering function support hardware mirroring well.
>  -Removed the bpc variable from mtk_drm_crtc struct.
> -------------------------------------------------------------------------
>
> Bibby Hsieh (2):
>   drm/mediatek: Add gamma correction
>   drm/mediatek: set mt8173 dithering function
>
>  drivers/gpu/drm/mediatek/mtk_disp_ovl.c     |    3 +-
>  drivers/gpu/drm/mediatek/mtk_disp_rdma.c    |    3 +-
>  drivers/gpu/drm/mediatek/mtk_drm_crtc.c     |   26 ++++-
>  drivers/gpu/drm/mediatek/mtk_drm_crtc.h     |    1 +
>  drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.c |  147 ++++++++++++++++++++++++++-
>  drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.h |   16 ++-
>  6 files changed, 184 insertions(+), 12 deletions(-)
>
