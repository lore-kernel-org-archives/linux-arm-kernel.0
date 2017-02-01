From: javier@osg.samsung.com (Javier Martinez Canillas)
Date: Wed,  1 Feb 2017 17:05:20 -0300
Subject: [PATCH 0/2] [media] exynos-gsc: Fix support for NV21 and NV61 formats
Message-ID: <1485979523-32404-1-git-send-email-javier@osg.samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

Commit 652bb68018a5 ("[media] exynos-gsc: do proper bytesperline and
sizeimage calculation") fixed corrupted frames for most exynos-gsc
formats, but even after that patch two issues were still remaining:

1) Frames were still not correct for NV21 and NV61 formats.
2) Y42B format didn't work when used as output (only as input).

This patch series fixes (1).

Best regards,
Javier


Thibault Saunier (2):
  [media] exynos-gsc: Do not swap cb/cr for semi planar formats
  [media] exynos-gsc: Add support for NV{16,21,61}M pixel formats

 drivers/media/platform/exynos-gsc/gsc-core.c | 29 ++++++++++++++++++++++++++--
 1 file changed, 27 insertions(+), 2 deletions(-)

-- 
2.7.4
