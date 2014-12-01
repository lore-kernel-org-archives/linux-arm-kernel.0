From: monstr@monstr.eu (Michal Simek)
Date: Mon, 01 Dec 2014 09:31:20 +0100
Subject: [GIT PULL] Xilinx Zynq dt changes for v3.19
Message-ID: <547C2758.1020707@monstr.eu>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

please pull these 4 patches to your arm-soc tree.
There will be conflict in DT for parallella because of fix
"ARM: dts: zynq: Enable PL clocks for Parallella"
(sha1: 92c9e0c780e61f821ab8a08f0d4d4fd33ba1197c)

Resolution of this conflict is:
&clkc {
	ps-clk-frequency = <33333333>;
	fclk-enable = <0xf>;
};

Thanks,
Michal


The following changes since commit f114040e3ea6e07372334ade75d1ee0775c355e1:

  Linux 3.18-rc1 (2014-10-19 18:08:38 -0700)

are available in the git repository at:

  https://github.com/Xilinx/linux-xlnx.git tags/zynq-dt-for-3.19

for you to fetch changes up to 7b01abb06c997e5431cdfc62267449aaef1d77c7:

  arm: dts: zynq: Add Digilent ZYBO board (2014-12-01 09:22:53 +0100)

----------------------------------------------------------------
arm: Xilinx Zynq dt patches for v3.19

- Declare Digilent and vendor
- Add Zybo board support
- Fix VDMA documentation to be align with the driver

----------------------------------------------------------------
Andreas F?rber (1):
      Documentation: devicetree: Fix Xilinx VDMA specification

Peter Crosthwaite (3):
      doc: dt: vendor-prefixes: Add Digilent Inc
      arm: dts: zynq: Move crystal freq. to board level
      arm: dts: zynq: Add Digilent ZYBO board

 Documentation/devicetree/bindings/dma/xilinx/xilinx_vdma.txt |  2 +-
 Documentation/devicetree/bindings/vendor-prefixes.txt        |  1 +
 arch/arm/boot/dts/Makefile                                   |  3 ++-
 arch/arm/boot/dts/zynq-7000.dtsi                             |  1 -
 arch/arm/boot/dts/zynq-parallella.dts                        |  4 ++++
 arch/arm/boot/dts/zynq-zc702.dts                             |  4 ++++
 arch/arm/boot/dts/zynq-zc706.dts                             |  4 ++++
 arch/arm/boot/dts/zynq-zed.dts                               |  4 ++++
 arch/arm/boot/dts/zynq-zybo.dts                              | 52 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 9 files changed, 72 insertions(+), 3 deletions(-)
 create mode 100644 arch/arm/boot/dts/zynq-zybo.dts

-- 
Michal Simek, Ing. (M.Eng), OpenPGP -> KeyID: FE3D1F91
w: www.monstr.eu p: +42-0-721842854
Maintainer of Linux kernel - Microblaze cpu - http://www.monstr.eu/fdt/
Maintainer of Linux kernel - Xilinx Zynq ARM architecture
Microblaze U-BOOT custodian and responsible for u-boot arm zynq platform


-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 198 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20141201/9f10c972/attachment.sig>
