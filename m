From: khilman@deeprootsystems.com (Kevin Hilman)
Date: Thu, 25 Sep 2014 12:05:42 -0700
Subject: [GIT PULL] PM / AVS changes for v3.18 - v2
Message-ID: <7ha95nikqh.fsf@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Rafael,

The first pull request was missing a dependency on a feature that went
in through Mark Brown's regulator tree, so it wouldn't actually compile
properly by itself.  This version pulls in that topic branch from Marks
tree (topic/voltage-ev branch, already part of -next), and now compiles fine.

Kevin

The following changes since commit 7d1311b93e58ed55f3a31cc8f94c4b8fe988a2b9:

  Linux 3.17-rc1 (2014-08-16 10:40:26 -0600)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/khilman/linux.git tags/avs-for-3.18

for you to fetch changes up to cd8caa18deff6d2d87a4e3161b4dd8c6da3c4f38:

  Merge branch 'topic/voltage-ev' of git://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator into avs-next (2014-09-25 09:57:57 -0700)

----------------------------------------------------------------
PM / AVS changes for v3.18

- Add new driver for Rockchip IO voltage domains
- update MAINTAINERS to reflect maintenance of drivers/power/avs/*

----------------------------------------------------------------
Heiko St?bner (2):
      regulator: core: Add REGULATOR_EVENT_PRE_VOLTAGE_CHANGE (and ABORT)
      PM / AVS: rockchip-io: add driver handling Rockchip io domains

Kevin Hilman (2):
      MAINTAINERS: update entry for drivers/power/avs
      Merge branch 'topic/voltage-ev' of git://git.kernel.org/.../broonie/regulator into avs-next

 Documentation/devicetree/bindings/power/rockchip-io-domain.txt |  83 +++++++++++++++++++
 MAINTAINERS                                                    |   4 +-
 drivers/power/avs/Kconfig                                      |   8 ++
 drivers/power/avs/Makefile                                     |   1 +
 drivers/power/avs/rockchip-io-domain.c                         | 351 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 drivers/regulator/core.c                                       |  63 +++++++++++++--
 include/linux/regulator/consumer.h                             |  20 +++++
 7 files changed, 521 insertions(+), 9 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/power/rockchip-io-domain.txt
 create mode 100644 drivers/power/avs/rockchip-io-domain.c
