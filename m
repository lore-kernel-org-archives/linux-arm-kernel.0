From: nm@ti.com (Nishanth Menon)
Date: Tue, 5 Jun 2018 01:26:37 -0500
Subject: [RFC PATCH 0/3] firmware: Add K3 Support for TISCI driver
Message-ID: <20180605062640.3356-1-nm@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

The following series enables TI System Control Interface(TISCI) support for
the newest addition in TI's SoC portfolio - AM654 SoC.

The series is an RFC based off next-20180604 and will post formally once
v4.18-rc1 is available.

The series (part 4 of 4) is available here:
https://github.com/nmenon/linux-2.6-playground/commits/upstream/next-20180604/k3-4-am6-tisci

Full Boot log is available here: https://pastebin.ubuntu.com/p/vWCzMKtBCW/

The Linux development follows closely the 66AK2G SoC model in aarch64 with a
few additions to handle the flexibility of firmware.

The architecture and dts support depends on part 1 of the series:
https://marc.info/?l=linux-arm-kernel&m=152817866312732&w=2

See AM65x Technical Reference Manual (SPRUID7, April 2018)
for further details: http://www.ti.com/lit/pdf/spruid7

Nishanth Menon (3):
  Documentation: dt: keystone: ti-sci: Add optional host-id parameter
  firmware: ti_sci: Provide host-id as an optional dt parameter
  arm64: dts: ti: k3-am6: Add Device Management Security Controller
    support

 .../devicetree/bindings/arm/keystone/ti,sci.txt    |  4 +++
 arch/arm64/boot/dts/ti/k3-am6.dtsi                 | 32 ++++++++++++++++++++++
 drivers/firmware/ti_sci.c                          | 24 +++++++++++++---
 3 files changed, 56 insertions(+), 4 deletions(-)

-- 
2.15.1
