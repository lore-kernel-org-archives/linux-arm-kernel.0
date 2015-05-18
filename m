From: Liviu.Dudau@arm.com (Liviu Dudau)
Date: Mon, 18 May 2015 18:28:24 +0100
Subject: [PATCH v2 0/5]  arm64: Juno DT updates and new DT for Juno R1
Message-ID: <1431970109-8902-1-git-send-email-Liviu.Dudau@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This series restructures the Juno DT files and introduces the DT
for the new Juno R1. The board is an update of the Juno R0 with
support for PCIe, but the current series only brings the board to
parity with Juno R0. The series that enable the PCIe Generic Host
Bridge to be used on Juno R1 will be posted separately.

Changes from v1:
 - Moved memory node inside juno-base.dtsi as this is common between
   boards and unlikely to change soon.
 - Added "arm,juno-r1" as compatible string in juno-r1.dts at Jon Medhurst's
   suggestion.

Liviu Dudau (5):
  arm64: Juno: Fix the GIC node address label and the frequency of FAXI
    clock.
  arm64: Juno: Split juno.dts into juno-base.dtsi and juno.dts.
  arm64: Juno: Add memory mapped timer node
  arm64: Juno: Add GICv2m support in device tree.
  arm64: Add DT support for Juno r1 board.

 arch/arm64/boot/dts/arm/Makefile         |   2 +-
 arch/arm64/boot/dts/arm/juno-base.dtsi   | 154 +++++++++++++++++++++++++++++++
 arch/arm64/boot/dts/arm/juno-clocks.dtsi |   4 +-
 arch/arm64/boot/dts/arm/juno-r1.dts      | 116 +++++++++++++++++++++++
 arch/arm64/boot/dts/arm/juno.dts         | 129 +-------------------------
 5 files changed, 274 insertions(+), 131 deletions(-)
 create mode 100644 arch/arm64/boot/dts/arm/juno-base.dtsi
 create mode 100644 arch/arm64/boot/dts/arm/juno-r1.dts

-- 
2.4.0
