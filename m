From: sebastian.hesselbarth@gmail.com (Sebastian Hesselbarth)
Date: Fri, 15 May 2015 12:54:04 +0200
Subject: [GIT PULL] ARM: berlin: Driver changes for v4.2 (round 1)
Message-ID: <1431687246-31039-1-git-send-email-sebastian.hesselbarth@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd, Kevin, Olof,

this is Marvell Berlin driver changes for v4.2 which finally includes
Antoine's rework of System/Chip Controller sub-drivers to simple-mfd
regmaps.

Please pull.

The following changes since commit b787f68c36d49bb1d9236f403813641efa74a031:

  Linux 4.1-rc1 (2015-04-26 17:59:10 -0700)

are available in the git repository at:

  git://git.infradead.org/users/hesselba/linux-berlin.git tags/berlin-driver-4.2-1

for you to fetch changes up to 3c65330675eb60f133fd2098ae92e0a2690b8f18:

  clk: berlin: move to a dedicated sub-node (2015-05-15 11:11:43 +0200)

----------------------------------------------------------------
berlin/driver for v4.2:
- rework of reset/pinctrl/clk driver

----------------------------------------------------------------
Antoine Tenart (4):
      reset: berlin: convert to a platform driver
      pinctrl: berlin: use the regmap provided by syscon
      pinctrl: berlin: use proper compatibles
      clk: berlin: move to a dedicated sub-node

 drivers/clk/berlin/bg2.c              |  7 ++--
 drivers/clk/berlin/bg2q.c             |  7 ++--
 drivers/pinctrl/berlin/berlin-bg2.c   | 26 +------------
 drivers/pinctrl/berlin/berlin-bg2cd.c | 26 +------------
 drivers/pinctrl/berlin/berlin-bg2q.c  | 26 +------------
 drivers/pinctrl/berlin/berlin.c       |  9 +++--
 drivers/reset/reset-berlin.c          | 71 +++++++++++++----------------------
 7 files changed, 46 insertions(+), 126 deletions(-)
