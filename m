From: gustavo@embeddedor.com (Gustavo A. R. Silva)
Date: Mon, 23 Apr 2018 12:37:41 -0500
Subject: [PATCH 00/11] fix potential Spectre variant 1 issues
Message-ID: <cover.1524499368.git.gustavo@embeddedor.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patchset aims to fix various media platform and media usb
cases where we have user controlled array dereferences that could
be exploited due to the Spectre variant 1 vulnerability. All were
reported by Dan Carpenter.

Notice that given that speculation windows are large, the policy is
to kill the speculation on the first load and not worry if it can be
completed with a dependent load/store [1].

[1] https://marc.info/?l=linux-kernel&m=152449131114778&w=2

Thanks

Gustavo A. R. Silva (11):
  media: tm6000: fix potential Spectre variant 1
  exynos4-is: mipi-csis: fix potential Spectre variant 1
  fsl-viu: fix potential Spectre variant 1
  marvell-ccic: mcam-core: fix potential Spectre variant 1
  omap_vout: fix potential Spectre variant 1
  rcar-v4l2: fix potential Spectre variant 1
  rcar_drif: fix potential Spectre variant 1
  sh_vou: fix potential Spectre variant 1
  vimc-debayer: fix potential Spectre variant 1
  vivid-sdr-cap: fix potential Spectre variant 1
  vsp1_rwpf: fix potential Spectre variant 1

 drivers/media/platform/exynos4-is/mipi-csis.c   | 5 ++++-
 drivers/media/platform/fsl-viu.c                | 8 ++++----
 drivers/media/platform/marvell-ccic/mcam-core.c | 3 +++
 drivers/media/platform/omap/omap_vout.c         | 3 +++
 drivers/media/platform/rcar-vin/rcar-v4l2.c     | 4 +++-
 drivers/media/platform/rcar_drif.c              | 4 +++-
 drivers/media/platform/sh_vou.c                 | 3 +++
 drivers/media/platform/vimc/vimc-debayer.c      | 5 ++++-
 drivers/media/platform/vivid/vivid-sdr-cap.c    | 6 ++++++
 drivers/media/platform/vsp1/vsp1_rwpf.c         | 3 +++
 drivers/media/usb/tm6000/tm6000-video.c         | 2 ++
 11 files changed, 38 insertions(+), 8 deletions(-)

-- 
2.7.4
