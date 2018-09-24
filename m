From: leoyang.li@nxp.com (Li Yang)
Date: Mon, 24 Sep 2018 17:19:54 -0500
Subject: [GIT PULL] fixes for soc/fsl drivers for v4.19
Message-ID: <20180924221954.30473-1-leoyang.li@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi arm-soc maintainers,

Please pull soc/fsl drivers fixes for v4.19.

Regards,
Leo


The following changes since commit 5b394b2ddf0347bef56e50c69a58773c94343ff3:

  Linux 4.19-rc1 (2018-08-26 14:11:59 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/leo/linux.git tags/soc-fsl-fix-v4.19

for you to fetch changes up to 3cb31b634052ed458922e0c8e2b4b093d7fb60b9:

  soc: fsl: qe: Fix copy/paste bug in ucc_get_tdm_sync_shift() (2018-09-17 16:01:46 -0500)

----------------------------------------------------------------
NXP/FSL SoC driver fixes for v4.19

- Fix crash of qman_portal by deferring its probe if qman is not probed
- Fix NULL pointer dereference by adding more checks in qman_portal
- Fix copy/paste bug in ucc_get_tdm_sync_shift()

----------------------------------------------------------------
Alexandre Belloni (2):
      soc: fsl: qbman: qman_portal: defer probing when qman is not available
      soc: fsl: qbman: qman: avoid allocating from non existing gen_pool

Zhao Qiang (1):
      soc: fsl: qe: Fix copy/paste bug in ucc_get_tdm_sync_shift()

 drivers/soc/fsl/qbman/qman.c        | 3 +++
 drivers/soc/fsl/qbman/qman_portal.c | 2 ++
 drivers/soc/fsl/qe/ucc.c            | 2 +-
 3 files changed, 6 insertions(+), 1 deletion(-)
