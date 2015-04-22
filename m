From: olof@lixom.net (Olof Johansson)
Date: Tue, 21 Apr 2015 23:11:15 -0700
Subject: [GIT PULL 8/9] ARM: SoC 64-bit changes for v4.1
In-Reply-To: <1429683076-19881-1-git-send-email-olof@lixom.net>
References: <1429683076-19881-1-git-send-email-olof@lixom.net>
Message-ID: <1429683076-19881-9-git-send-email-olof@lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Mostly DT updates for arm64, but also a couple of Kconfig additions.

Main contents:

- Qualcomm MSM8916/APQ8016
- Spreadtrum SC9836
- Xilinx ZynqMP
- Pincontrol entries for MediaTek MT8173


Conflicts: None

----------------------------------------------------------------

The following changes since commit 22f0bdca41c3643afae8368a594e05a3402fd8eb:

  Merge tag 'armsoc-defconfig' into testmerge

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/arm/arm-soc.git tags/armsoc-arm64

for you to fetch changes up to bb1518f39bec1b3061425ad378793cf9c4bdb3d2:

  Merge tag 'v4.0-next-arm64' of https://github.com/mbgg/linux-mediatek into next/arm64

----------------------------------------------------------------

Abhimanyu Kapur (1):
      arm64: qcom: Add support for Qualcomm MSM8916 SoC

Chunyan Zhang (1):
      arm64: dts: sprd: adding coresight entries to Spreadtrum SC9836

Hongzhou Yang (1):
      arm64: dts: mt8173: Add pinctrl/GPIO/EINT node for mt8173.

Kumar Gala (2):
      arm64: dts: Add Qualcomm MSM8916 SoC and evaluation board dts
      arm64: dts: Add Qualcomm APQ8016 SBC evaluation board dts

Michal Simek (1):
      ARM64: Add new Xilinx ZynqMP SoC

Olof Johansson (2):
      Merge tag 'qcom-arm64-for-4.1' of git://git.kernel.org/.../galak/linux-qcom into next/arm64
      Merge tag 'v4.0-next-arm64' of https://github.com/mbgg/linux-mediatek into next/arm64

Will Deacon (1):
      arm64: dts: add interrupt-affinity property to pmu node for juno

Yingjoe Chen (1):
      arm64: mediatek: Select PINCTRL for Mediatek platform

Zhizhou Zhang (2):
      arm64: dts: Add support for Spreadtrum SC9836 SoC in dts and Makefile
      arm64: Add support for Spreadtrum's Sharkl64 Platform in Kconfig and defconfig


 arch/arm64/Kconfig                            |  17 +
 arch/arm64/boot/dts/Makefile                  |   3 +
 arch/arm64/boot/dts/arm/juno.dts              |  14 +-
 arch/arm64/boot/dts/mediatek/mt8173-pinfunc.h | 682 +++++++++++++++++++++
 arch/arm64/boot/dts/mediatek/mt8173.dtsi      |  20 +
 arch/arm64/boot/dts/qcom/Makefile             |   5 +
 arch/arm64/boot/dts/qcom/apq8016-sbc.dts      |  21 +
 arch/arm64/boot/dts/qcom/apq8016-sbc.dtsi     |  33 +
 arch/arm64/boot/dts/qcom/msm8916-mtp.dts      |  22 +
 arch/arm64/boot/dts/qcom/msm8916-mtp.dtsi     |  33 +
 arch/arm64/boot/dts/qcom/msm8916.dtsi         | 196 ++++++
 arch/arm64/boot/dts/sprd/Makefile             |   5 +
 arch/arm64/boot/dts/sprd/sc9836-openphone.dts |  49 ++
 arch/arm64/boot/dts/sprd/sc9836.dtsi          | 129 ++++
 arch/arm64/boot/dts/sprd/sharkl64.dtsi        |  65 ++
 arch/arm64/boot/dts/xilinx/Makefile           |   5 +
 arch/arm64/boot/dts/xilinx/zynqmp-ep108.dts   |  47 ++
 arch/arm64/boot/dts/xilinx/zynqmp.dtsi        | 305 +++++++++
 arch/arm64/configs/defconfig                  |  10 +
 19 files changed, 1657 insertions(+), 4 deletions(-)
 create mode 100644 arch/arm64/boot/dts/mediatek/mt8173-pinfunc.h
 create mode 100644 arch/arm64/boot/dts/qcom/Makefile
 create mode 100644 arch/arm64/boot/dts/qcom/apq8016-sbc.dts
 create mode 100644 arch/arm64/boot/dts/qcom/apq8016-sbc.dtsi
 create mode 100644 arch/arm64/boot/dts/qcom/msm8916-mtp.dts
 create mode 100644 arch/arm64/boot/dts/qcom/msm8916-mtp.dtsi
 create mode 100644 arch/arm64/boot/dts/qcom/msm8916.dtsi
 create mode 100644 arch/arm64/boot/dts/sprd/Makefile
 create mode 100644 arch/arm64/boot/dts/sprd/sc9836-openphone.dts
 create mode 100644 arch/arm64/boot/dts/sprd/sc9836.dtsi
 create mode 100644 arch/arm64/boot/dts/sprd/sharkl64.dtsi
 create mode 100644 arch/arm64/boot/dts/xilinx/Makefile
 create mode 100644 arch/arm64/boot/dts/xilinx/zynqmp-ep108.dts
 create mode 100644 arch/arm64/boot/dts/xilinx/zynqmp.dtsi
