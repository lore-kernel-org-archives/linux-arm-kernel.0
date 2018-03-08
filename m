From: monstr@monstr.eu (Michal Simek)
Date: Thu, 8 Mar 2018 08:26:46 +0100
Subject: [GIT PULL] Xilinx DT changes for v4.17
Message-ID: <8bb0e8ce-54ab-f502-595b-d23de77ece64@monstr.eu>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

please pull these DT changes to your tree. All new DTS files were
reviewed by Rob.

Note: In past I was sending separate pull requests for zynq(arm32) and
zynqmp(arm64). There is dependency on
Documentation/devicetree/bindings/arm/xilinx.txt and I have also seen
you are merging them together that's why only one pull request now.

Thanks,
Michal

The following changes since commit 7928b2cbe55b2a410a0f5c1f154610059c57b1b2:

  Linux 4.16-rc1 (2018-02-11 15:04:29 -0800)

are available in the git repository at:

  https://github.com/Xilinx/linux-xlnx.git tags/xilinx-dt-for-4.17

for you to fetch changes up to ba5c7a032c2ae66d5467820daab898e5f9048405:

  arm: dts: zynq: Add Digilent Zybo Z7 board (2018-03-08 08:11:35 +0100)

----------------------------------------------------------------
arm: Xilinx(Zynq and ZynqMP) DT changes for v4.17

- Use SPDX license identifier
- Add Xilinx ZynqMP boards
  zcu100-revC, zcu102-revA/revB/rev1.0, zcu104-revA, zcu106-revA,
  zcu111-revA, zc1751 dc1/dc2/dc3/dc4
- Add Xilinx Zynq boards
  cc108, zc770 dc1/dc2/dc3/dc4
- Add Digilent Zybo Z7
- Minor fixes in current DTSes

----------------------------------------------------------------
Anurag Kumar Vulisha (1):
      arm64: zynqmp: Added OOB timing settings in zynqmp-ep108.dts

Michal Simek (19):
      arm64: zynqmp: Use zynqmp specific compatible string for macb
      arm64: zynqmp: Fix alignment in dts files
      arm64: zynqmp: Add SPDX license identifier
      dt-bindings: xilinx: Add description for ZynqMP
      arm64: zynqmp: Add support for Xilinx zcu100-revC
      arm64: zynqmp: Add support for Xilinx zcu102
      arm64: zynqmp: Add support for Xilinx zcu104-revA
      arm64: zynqmp: Add support for Xilinx zcu106-revA
      arm64: zynqmp: Add support for Xilinx zcu111-revA
      arm64: zynqmp: Add support for Xilinx zc12XX boards
      arm64: zynqmp: Add support for Xilinx zc1751
      arm: zynq: Use i2c-mux instead of i2cswitch for pca9548
      arm: dts: zynq: Use SPDX-License-Identifier
      arm: zynq: Add missing address node name in microzed board
      arm: zynq: Add Xilinx cc108 board
      arm: zynq: Add support for Xilinx zc770 xm010 dc1 board
      arm: zynq: Add support for Xilinx zc770 xm011 dc2 board
      arm: zynq: Add support for Xilinx zc770 xm012 dc3 board
      arm: zynq: Add support for Xilinx zc770 xm013 dc4 board

Nobuhiro Iwamatsu (1):
      arm: dts: zynq: Add Digilent Zybo Z7 board

P L Sai Krishna (1):
      arm64: zynqmp: Add 8-bit bus width property for ep108

 Documentation/devicetree/bindings/arm/xilinx.txt       |  56 +++++++++
 arch/arm/boot/dts/Makefile                             |   8 +-
 arch/arm/boot/dts/zynq-7000.dtsi                       |  12 +-
 arch/arm/boot/dts/zynq-cc108.dts                       |  75 +++++++++++
 arch/arm/boot/dts/zynq-microzed.dts                    |  12 +-
 arch/arm/boot/dts/zynq-parallella.dts                  |  10 +-
 arch/arm/boot/dts/zynq-zc702.dts                       |  12 +-
 arch/arm/boot/dts/zynq-zc706.dts                       |  12 +-
 arch/arm/boot/dts/zynq-zc770-xm010.dts                 |  95 ++++++++++++++
 arch/arm/boot/dts/zynq-zc770-xm011.dts                 |  64 ++++++++++
 arch/arm/boot/dts/zynq-zc770-xm012.dts                 |  64 ++++++++++
 arch/arm/boot/dts/zynq-zc770-xm013.dts                 |  78 ++++++++++++
 arch/arm/boot/dts/zynq-zed.dts                         |  10 +-
 arch/arm/boot/dts/zynq-zybo-z7.dts                     |  58 +++++++++
 arch/arm/boot/dts/zynq-zybo.dts                        |  10 +-
 arch/arm64/boot/dts/xilinx/Makefile                    |  16 +++
 arch/arm64/boot/dts/xilinx/zynqmp-clk.dtsi             | 213
++++++++++++++++++++++++++++++++
 arch/arm64/boot/dts/xilinx/zynqmp-ep108-clk.dtsi       |   1 +
 arch/arm64/boot/dts/xilinx/zynqmp-ep108.dts            |  13 +-
 arch/arm64/boot/dts/xilinx/zynqmp-zc1232-revA.dts      |  54 ++++++++
 arch/arm64/boot/dts/xilinx/zynqmp-zc1254-revA.dts      |  42 +++++++
 arch/arm64/boot/dts/xilinx/zynqmp-zc1275-revA.dts      |  42 +++++++
 arch/arm64/boot/dts/xilinx/zynqmp-zc1751-xm015-dc1.dts | 131
++++++++++++++++++++
 arch/arm64/boot/dts/xilinx/zynqmp-zc1751-xm016-dc2.dts | 168
+++++++++++++++++++++++++
 arch/arm64/boot/dts/xilinx/zynqmp-zc1751-xm017-dc3.dts | 150
++++++++++++++++++++++
 arch/arm64/boot/dts/xilinx/zynqmp-zc1751-xm018-dc4.dts | 178
++++++++++++++++++++++++++
 arch/arm64/boot/dts/xilinx/zynqmp-zc1751-xm019-dc5.dts | 125
+++++++++++++++++++
 arch/arm64/boot/dts/xilinx/zynqmp-zcu100-revC.dts      | 289
+++++++++++++++++++++++++++++++++++++++++++
 arch/arm64/boot/dts/xilinx/zynqmp-zcu102-rev1.0.dts    |  36 ++++++
 arch/arm64/boot/dts/xilinx/zynqmp-zcu102-revA.dts      | 548
+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 arch/arm64/boot/dts/xilinx/zynqmp-zcu102-revB.dts      |  40 ++++++
 arch/arm64/boot/dts/xilinx/zynqmp-zcu104-revA.dts      | 195
+++++++++++++++++++++++++++++
 arch/arm64/boot/dts/xilinx/zynqmp-zcu106-revA.dts      | 522
+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 arch/arm64/boot/dts/xilinx/zynqmp-zcu111-revA.dts      | 444
+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 arch/arm64/boot/dts/xilinx/zynqmp.dtsi                 |  17 +--
 35 files changed, 3723 insertions(+), 77 deletions(-)
 create mode 100644 arch/arm/boot/dts/zynq-cc108.dts
 create mode 100644 arch/arm/boot/dts/zynq-zc770-xm010.dts
 create mode 100644 arch/arm/boot/dts/zynq-zc770-xm011.dts
 create mode 100644 arch/arm/boot/dts/zynq-zc770-xm012.dts
 create mode 100644 arch/arm/boot/dts/zynq-zc770-xm013.dts
 create mode 100644 arch/arm/boot/dts/zynq-zybo-z7.dts
 create mode 100644 arch/arm64/boot/dts/xilinx/zynqmp-clk.dtsi
 create mode 100644 arch/arm64/boot/dts/xilinx/zynqmp-zc1232-revA.dts
 create mode 100644 arch/arm64/boot/dts/xilinx/zynqmp-zc1254-revA.dts
 create mode 100644 arch/arm64/boot/dts/xilinx/zynqmp-zc1275-revA.dts
 create mode 100644 arch/arm64/boot/dts/xilinx/zynqmp-zc1751-xm015-dc1.dts
 create mode 100644 arch/arm64/boot/dts/xilinx/zynqmp-zc1751-xm016-dc2.dts
 create mode 100644 arch/arm64/boot/dts/xilinx/zynqmp-zc1751-xm017-dc3.dts
 create mode 100644 arch/arm64/boot/dts/xilinx/zynqmp-zc1751-xm018-dc4.dts
 create mode 100644 arch/arm64/boot/dts/xilinx/zynqmp-zc1751-xm019-dc5.dts
 create mode 100644 arch/arm64/boot/dts/xilinx/zynqmp-zcu100-revC.dts
 create mode 100644 arch/arm64/boot/dts/xilinx/zynqmp-zcu102-rev1.0.dts
 create mode 100644 arch/arm64/boot/dts/xilinx/zynqmp-zcu102-revA.dts
 create mode 100644 arch/arm64/boot/dts/xilinx/zynqmp-zcu102-revB.dts
 create mode 100644 arch/arm64/boot/dts/xilinx/zynqmp-zcu104-revA.dts
 create mode 100644 arch/arm64/boot/dts/xilinx/zynqmp-zcu106-revA.dts
 create mode 100644 arch/arm64/boot/dts/xilinx/zynqmp-zcu111-revA.dts


-- 
Michal Simek, Ing. (M.Eng), OpenPGP -> KeyID: FE3D1F91
w: www.monstr.eu p: +42-0-721842854
Maintainer of Linux kernel - Xilinx Microblaze
Maintainer of Linux kernel - Xilinx Zynq ARM and ZynqMP ARM64 SoCs
U-Boot custodian - Xilinx Microblaze/Zynq/ZynqMP SoCs


-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 198 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180308/9bf1b484/attachment.sig>
