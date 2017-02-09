From: thibault.saunier@osg.samsung.com (Thibault Saunier)
Date: Thu,  9 Feb 2017 16:43:10 -0300
Subject: [PATCH 0/4] [media] Fixes for colorspace logic in exynos-gsc and
 s5p-mfc drivers
Message-ID: <20170209194314.5908-1-thibault.saunier@osg.samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

This patchset fixes a few issues on the colorspace logic for the exynos-gsc
and s5p-mfc drivers.

We now handle the colorspace in those drivers, and make sure to respect user setting if
possible.

We also now set the 'v4l2_pix_format:field' if userspace passed ANY, avoiding GStreamer
spamming error at us about the driver not following the standard.

Best regards,

Thibault Saunier


Javier Martinez Canillas (1):
  [media] exynos-gsc: Use 576p instead 720p as a threshold for
    colorspaces

Thibault Saunier (3):
  [media] exynos-gsc: Respect userspace colorspace setting
  [media] s5p-mfc: Set colorspace in VIDIO_{G,TRY}_FMT
  [media] s5p-mfc: Always check and set 'v4l2_pix_format:field' field

 drivers/media/platform/exynos-gsc/gsc-core.c | 22 +++++++++++----
 drivers/media/platform/s5p-mfc/s5p_mfc_dec.c | 42 ++++++++++++++++++++++++++--
 2 files changed, 57 insertions(+), 7 deletions(-)

-- 
2.11.1
