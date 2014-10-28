From: lokeshvutla@ti.com (Lokesh Vutla)
Date: Tue, 28 Oct 2014 15:28:49 +0530
Subject: [PATCH V4 0/3] rtc: omap: Add support for regulator supply
Message-ID: <1414490332-14856-1-git-send-email-lokeshvutla@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This series adds support for regulator supply.

Changes since V3:
- Removed extra Optional properties header.
- Moved regulator get before platform_set_drvdata().
- Updated commit message for Patch 3/3.
- Added new dt properties for min and max voltages if default voltage needs to be changed.

Changes since v2:
 - Rebased on top of Johan Hovold's recent rtc cleanup series[1]
 - Addressed Johan Hovold's comments.

[1] https://www.mail-archive.com/linux-kernel at vger.kernel.org/msg748519.html
Lokesh Vutla (2):
  rtc: omap: use module_platform_driver
  rtc: omap: Support regulator supply for RTC

Tero Kristo (1):
  rtc: omap: Update Kconfig for OMAP RTC

 Documentation/devicetree/bindings/rtc/rtc-omap.txt |  6 +++
 drivers/rtc/Kconfig                                |  6 +--
 drivers/rtc/rtc-omap.c                             | 47 ++++++++++++++++++++--
 3 files changed, 52 insertions(+), 7 deletions(-)

-- 
1.9.1
