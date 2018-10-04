From: leoyang.li@nxp.com (Li Yang)
Date: Thu,  4 Oct 2018 11:47:15 -0500
Subject: [GIT PULL] for-next updates for soc/fsl drivers for v4.20 take 2
Message-ID: <20181004164715.14646-1-leoyang.li@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi arm-soc maintainers,

Please merge the following updates for next.

PS.  One of the patches is depending on the last pull request for fixes to build
https://patchwork.kernel.org/patch/10622883/
I didn't include the fix patches directly in this pull request to prevent a
complicated merge.  Please let me know if there is a more preferred approach
to deal with dependencies between pull requests.

Regards,
Leo

The following changes since commit afa86d264a7ce62ba214bc7c6012e2129141421e:

  soc: fsl: dpio: remove redundant pointer 'priv' (2018-08-30 12:19:02 -0500)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/leo/linux.git tags/soc-fsl-next-v4.20-2

for you to fetch changes up to aeaf982954849e9d2bccffab138703be28edd2ae:

  soc: fsl: qbman: add interrupt coalesce changing APIs (2018-10-02 15:04:19 -0500)

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
 include/soc/fsl/qman.h              | 27 +++++++++++++++++++
 7 files changed, 113 insertions(+), 15 deletions(-)
