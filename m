From: swarren@nvidia.com (Stephen Warren)
Date: Fri, 18 Feb 2011 16:18:10 -0700
Subject: [PATCH 0/3] Tegra 640x480 HDMI audio patches
Message-ID: <1298071093-23865-1-git-send-email-swarren@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch set fixes 640x480 HDMI video clocking, audio over HDMI at 640x80,
and especially 44.1KHz audio at that resolution.

It was generated against linux-tegra-2.6.37, but probably is worth applying
to, or merging into, all of:

for-next
android-tegra-2.6.37
linux-tegra-2.6.37
android-tegra-2.6.36
linux-tegra-2.6.36

Stephen Warren (3):
  ARM: Tegra: Add pll_d table entries for 252MHz
  video: tegra: Fix CTS/N table for 25.2MHz pclk, 44.1Hz audio
  video: tegra: Run pll_d at 252mhz for HDMI 640x480

 arch/arm/mach-tegra/tegra2_clocks.c |    5 +++++
 drivers/video/tegra/dc/dc.c         |    4 +++-
 drivers/video/tegra/dc/hdmi.c       |    2 +-
 3 files changed, 9 insertions(+), 2 deletions(-)
