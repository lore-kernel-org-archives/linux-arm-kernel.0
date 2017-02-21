From: thibault.saunier@osg.samsung.com (Thibault Saunier)
Date: Tue, 21 Feb 2017 16:20:56 -0300
Subject: [PATCH v5 0/3] Fixes for colorspace logic in exynos-gsc and s5p-mfc
 drivers
Message-ID: <20170221192059.29745-1-thibault.saunier@osg.samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

This patchset fixes a few issues on the colorspace logic for the exynos-gsc
and s5p-mfc drivers.

We now handle the colorspace in those drivers, and make sure to respect user setting if
possible.

We also now set the 'v4l2_pix_format:field' if userspace passed ANY, avoiding GStreamer
spamming error at us about the driver not following the standard.

This is the fifth version of the patch serie.

Best regards,

Thibault Saunier

Changes in v5:
- Squash commit to always use output colorspace on the capture side
  inside this one
- Fix typo in commit message
- Just adapt the field and never error out.

Changes in v4:
- Reword commit message to better back our assumptions on specifications
- Set the colorspace only if the user passed V4L2_COLORSPACE_DEFAULT, in
  all other cases just use what userspace provided.

Changes in v3:
- Do not check values in the g_fmt functions as Andrzej explained in previous review
- Added 'Reviewed-by: Andrzej Hajda <a.hajda@samsung.com>'
- Do not check values in the g_fmt functions as Andrzej explained in previous review
- Set colorspace if user passed V4L2_COLORSPACE_DEFAULT in
- Do not check values in the g_fmt functions as Andrzej explained in previous review

Changes in v2:
- Fix a silly build error that slipped in while rebasing the patches

Thibault Saunier (3):
  [media] exynos-gsc: Use user configured colorspace if provided
  [media] s5p-mfc: Set colorspace in VIDIO_{G,TRY}_FMT if DEFAULT
    provided
  [media] s5p-mfc: Check and set 'v4l2_pix_format:field' field in
    try_fmt

 drivers/media/platform/exynos-gsc/gsc-core.c | 20 +++++++++++++++-----
 drivers/media/platform/exynos-gsc/gsc-core.h |  1 +
 drivers/media/platform/s5p-mfc/s5p_mfc_dec.c | 17 +++++++++++++++++
 3 files changed, 33 insertions(+), 5 deletions(-)

-- 
2.11.1
