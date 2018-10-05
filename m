From: leoyang.li@nxp.com (Li Yang)
Date: Fri,  5 Oct 2018 14:30:40 -0500
Subject: [GIT PULL v2] for-next updates for soc/fsl drivers for v4.20 take 2
Message-ID: <20181005193040.28598-1-leoyang.li@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi arm-soc maintainers,

Please merge the following updates for next.

v2: updated tree to include dependency patches by merging soc-fsl-fix-v4.19-2

Regards,
Leo

The following changes since commit 56740a7167cbbbda99ebfd3e8b4e4d51ae39bd06:

  Merge tag 'soc-fsl-fix-v4.19-2' into HEAD (2018-10-05 13:58:35 -0500)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/leo/linux.git tags/soc-fsl-next-v4.20-2

for you to fetch changes up to 6d06009cb216d071e955b3814086595851627910:

  soc: fsl: qbman: add interrupt coalesce changing APIs (2018-10-05 14:06:56 -0500)

----------------------------------------------------------------
NXP/FSL SoC drivers updates for v4.20 take 2

- Update qbman driver to better work with CPU hotplug
- Add Kconfig dependency of 64-bit DMA addressing for qbman driver
- Use last reponse to determine valid bit for qbman driver
- Defer bman_portals probe if bman is not probed
- Add interrupt coalescing APIs to qbman driver

----------------------------------------------------------------
Laurentiu Tudor (1):
      soc: fsl: bman_portals: defer probe after bman's probe

Madalin Bucur (2):
      soc: fsl: qbman: replace CPU 0 with any online CPU in hotplug handlers
      soc: fsl: qbman: add interrupt coalesce changing APIs

Roy Pledge (3):
      soc: fsl: qbman: Check if CPU is offline when initializing portals
      soc: fsl: qbman: Add 64 bit DMA addressing requirement to QBMan
      soc: fsl: qbman: Use last response to determine valid bit

 drivers/soc/fsl/qbman/Kconfig       |  2 +-
 drivers/soc/fsl/qbman/bman.c        |  6 ++---
 drivers/soc/fsl/qbman/bman_portal.c | 14 ++++++++--
 drivers/soc/fsl/qbman/dpaa_sys.h    | 20 ++++++++++++++
 drivers/soc/fsl/qbman/qman.c        | 53 ++++++++++++++++++++++++++++++++-----
 drivers/soc/fsl/qbman/qman_portal.c |  6 +++--
 include/soc/fsl/qman.h              | 28 ++++++++++++++++++++
 7 files changed, 114 insertions(+), 15 deletions(-)
