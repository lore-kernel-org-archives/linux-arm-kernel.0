From: sboyd@codeaurora.org (Stephen Boyd)
Date: Wed,  4 Dec 2013 11:39:07 -0800
Subject: [PATCH 0/5] Allow MSM DT platforms to be built multi-platform
Message-ID: <1386185952-27259-1-git-send-email-sboyd@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

These patches allow the MSM code to be built as part of the multi-platform
kernel. To be fully functional you need the first patch from Ivan's series[1]
so that the usb-phy driver doesn't use mach specific APIs. I'm hoping that
we can send these all through arm-soc so driver maintainers please ack
the first two changes.

Stephen Boyd (5):
  mmc: msm_sdcc: Limit driver to platforms that use it
  tty: serial: Limit msm_serial_hs driver to platforms that use it
  ARM: msm: Only build clock.c on proc_comm based platforms
  ARM: msm: Only build timer.c if required
  ARM: msm: Move MSM's DT based hardware to multi-platform support

 arch/arm/Kconfig           |  4 +--
 arch/arm/mach-msm/Kconfig  | 66 ++++++++++++++++++++++++++++------------------
 arch/arm/mach-msm/Makefile |  4 +--
 drivers/mmc/host/Kconfig   |  2 +-
 drivers/tty/serial/Kconfig |  2 +-
 5 files changed, 46 insertions(+), 32 deletions(-)

[1] https://lkml.org/lkml/2013/11/12/722 
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
hosted by The Linux Foundation
