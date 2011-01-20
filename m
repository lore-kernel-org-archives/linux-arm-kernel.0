From: dwalker@codeaurora.org (Daniel Walker)
Date: Thu, 20 Jan 2011 12:32:38 -0800
Subject: [PATCH 0/7] Nexus One Support
Message-ID: <1295555565-21563-1-git-send-email-dwalker@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This series adds basic Nexus One support which includes a booting
kernel, and functional MMC .

Most people won't be able to use this yet unfortunately because
you need a serial cable to get any output. However, it's a start.

Brian Swetland (1):
  [ARM] msm: qsd8k memory base is at 0x20000000

Daniel Walker (6):
  msm: qsd8x50: add uart platform data
  msm: qsd8x50: add acpuclock code
  msm: mahimahi: add mahimahi board file
  msm: mahimahi: add in mmc support code
  msm: mahimahi: add gpio pin muxing code
  msm: mahimahi: initialize mmc at start up

 arch/arm/mach-msm/Kconfig              |    8 +-
 arch/arm/mach-msm/Makefile             |    5 +-
 arch/arm/mach-msm/Makefile.boot        |    5 +
 arch/arm/mach-msm/acpuclock-qsd8x50.c  |  457 ++++++++++++++++++++++++++++++++
 arch/arm/mach-msm/board-mahimahi-mmc.c |  238 +++++++++++++++++
 arch/arm/mach-msm/board-mahimahi.c     |   52 +++-
 arch/arm/mach-msm/board-mahimahi.h     |  147 ++++++++++
 arch/arm/mach-msm/devices-qsd8x50.c    |   42 +++
 arch/arm/mach-msm/include/mach/board.h |    1 +
 9 files changed, 942 insertions(+), 13 deletions(-)
 create mode 100644 arch/arm/mach-msm/acpuclock-qsd8x50.c
 create mode 100644 arch/arm/mach-msm/board-mahimahi-mmc.c
 create mode 100644 arch/arm/mach-msm/board-mahimahi.h

-- 
Sent by a consultant of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
