From: sboyd@codeaurora.org (Stephen Boyd)
Date: Mon, 30 Dec 2013 13:15:26 -0800
Subject: [PATCH v2 0/7] Allow MSM DT platforms to be built multi-platform
Message-ID: <1388438133-431-1-git-send-email-sboyd@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

These patches allow the DT based MSM platforms to be built as part of the
multi-platform kernel. I need acks from Chris Ball on the mmc patch and
Rob/Dave on the drm patch. I dropped Arnd's ack on patch 6 because I've
rebased that patch on top of the patchset David sent out (which this is in
reply to). The rebase was fairly minor and the new patch for drm/msm is
trivial. Please consider for v3.14.

Changes since v1:
 * Rebased onto David's v3.14 patchset
 * Picked up acks
 * New patch for drm/msm driver

Ivan T. Ivanov (1):
  usb: phy: msm: Move mach dependent code to platform data

Stephen Boyd (6):
  mmc: msm_sdcc: Limit driver to platforms that use it
  tty: serial: Limit msm_serial_hs driver to platforms that use it
  ARM: msm: Only build clock.c on proc_comm based platforms
  ARM: msm: Only build timer.c if required
  drm/msm: Drop unnecessary mach include
  ARM: msm: Move MSM's DT based hardware to multi-platform support

 arch/arm/Kconfig                            |  4 +-
 arch/arm/mach-msm/Kconfig                   | 85 ++++++++++++++++-------------
 arch/arm/mach-msm/Makefile                  |  4 +-
 arch/arm/mach-msm/board-msm7x30.c           | 35 ++++++++++++
 arch/arm/mach-msm/board-qsd8x50.c           | 35 ++++++++++++
 drivers/gpu/drm/msm/mdp4/mdp4_dtv_encoder.c |  2 -
 drivers/mmc/host/Kconfig                    |  2 +-
 drivers/tty/serial/Kconfig                  |  2 +-
 drivers/usb/phy/phy-msm-usb.c               | 35 +++++-------
 include/linux/usb/msm_hsusb.h               |  3 +
 10 files changed, 142 insertions(+), 65 deletions(-)

-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
hosted by The Linux Foundation
