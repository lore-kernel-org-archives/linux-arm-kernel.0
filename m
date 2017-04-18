From: code@mmayer.net (Markus Mayer)
Date: Tue, 18 Apr 2017 13:17:00 -0700
Subject: [PATCH 0/2] HWMON driver for Broadcom STB DPFE
Message-ID: <20170418201702.57019-1-code@mmayer.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Markus Mayer <mmayer@broadcom.com>

This series introduces a driver to interact with the Broadcom STB DDR
PHY Front End (DPFE), specifically to communicate with the DCPU that is
part of the DDR PHY and which is running its own firmware.

The DCPU provides information such as DRAM refresh rate, which can be
used as indirect indicator for the DRAM temperature (the higher the
refresh rate, the hotter the RAM).

Markus Mayer (2):
  dt/bindings: Add bindings for Broadcom STB DRAM Sensors
  hwmon: (brcmstb) Add driver for Broadcom STB DPFE

 .../devicetree/bindings/hwmon/brcmstb-dpfe.txt     |  68 ++
 MAINTAINERS                                        |   8 +
 drivers/hwmon/Kconfig                              |  13 +
 drivers/hwmon/Makefile                             |   1 +
 drivers/hwmon/brcmstb-dpfe.c                       | 689 +++++++++++++++++++++
 5 files changed, 779 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/hwmon/brcmstb-dpfe.txt
 create mode 100644 drivers/hwmon/brcmstb-dpfe.c

-- 
2.7.4
