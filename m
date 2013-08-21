From: sboyd@codeaurora.org (Stephen Boyd)
Date: Tue, 20 Aug 2013 23:48:01 -0700
Subject: [PATCH v2 0/5] Document msm_serial bindings and support newer uartdms
Message-ID: <1377067686-31957-1-git-send-email-sboyd@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patchset aligns the msm_serial driver more with downstream usage and
also documents the msm_serial driver's DT binding. Along the way we
update the clock names and add support for newer UARTDM hardware that
isn't part of a GSBI and make the console layer use the extra registers in
UARTDM.

Changes since v1:
 * Dropped _clk postfix from {core,iface}_clk
 * Split DT binding into two files
 * Renamed DT binding files to match compatible strings
 * Fixed up DT review comments
 * Added new patch 5/5 (more than 1 char for UARTDM)

Stephen Boyd (5):
  msm_serial: Switch clock consumer strings and simplify code
  devicetree: serial: Document msm_serial bindings
  msm_serial: Add support for non-GSBI UARTDM devices
  ARM: dts: msm: Update uartdm compatible strings
  msm_serial: Send more than 1 character on the console w/ UARTDM

 .../devicetree/bindings/serial/qcom,msm-uart.txt   | 25 ++++++
 .../devicetree/bindings/serial/qcom,msm-uartdm.txt | 52 +++++++++++++
 arch/arm/boot/dts/msm8660-surf.dts                 |  2 +-
 arch/arm/boot/dts/msm8960-cdp.dts                  |  2 +-
 arch/arm/mach-msm/devices-msm7x00.c                |  6 +-
 arch/arm/mach-msm/devices-msm7x30.c                |  2 +-
 arch/arm/mach-msm/devices-qsd8x50.c                |  6 +-
 drivers/tty/serial/msm_serial.c                    | 88 ++++++++++++++--------
 8 files changed, 144 insertions(+), 39 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/serial/qcom,msm-uart.txt
 create mode 100644 Documentation/devicetree/bindings/serial/qcom,msm-uartdm.txt

-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
hosted by The Linux Foundation
