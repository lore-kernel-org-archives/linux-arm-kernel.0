From: f.fainelli@gmail.com (Florian Fainelli)
Date: Sat, 20 Feb 2016 11:46:21 -0800
Subject: [GIT PULL 2/8] Broadcom soc-arm64 changes for 4.6
In-Reply-To: <1455997587-17564-1-git-send-email-f.fainelli@gmail.com>
References: <1455997587-17564-1-git-send-email-f.fainelli@gmail.com>
Message-ID: <1455997587-17564-2-git-send-email-f.fainelli@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

  Linux 4.5-rc1 (2016-01-24 13:06:47 -0800)

are available in the git repository at:

  http://github.com/Broadcom/stblinux.git tags/arm-soc/for-4.6/soc-arm64

for you to fetch changes up to 9eb8a2cdf65ce47c3aa68f1297c84d8bcf5a7b3a:

  arm64: cputype info for Broadcom Vulcan (2016-02-20 10:42:38 -0800)

----------------------------------------------------------------
This pull request contains Broadcom ARM64-based SoC/platform changes:

- Anup, Ray and Dhanajay enable COMMON_CLK_IPROC, PINCTRL and GPIOLIB for iProc
  SoCs to get the corresponding iProc-based drivers to be available and work

- Zi adds support for Broadcom's Vulcan processor by adding a reference
  board Device Tree file along with a config ARCH_VULCAN symbol

- Jayachandran C. adds the Broadcom implementor ID and part ID for the Vulcan
  processors

----------------------------------------------------------------
Anup Patel (1):
      arm64: Select COMMON_CLK_IPROC, PINCTRL and GPIOLIB for iProc SoCs

Jayachandran C (1):
      arm64: cputype info for Broadcom Vulcan

Zi Shen Lim (1):
      arm64: Broadcom Vulcan support

 arch/arm64/Kconfig.platforms                 |   8 ++
 arch/arm64/boot/dts/broadcom/Makefile        |   1 +
 arch/arm64/boot/dts/broadcom/vulcan-eval.dts |  33 ++++++
 arch/arm64/boot/dts/broadcom/vulcan.dtsi     | 144 +++++++++++++++++++++++++++
 arch/arm64/include/asm/cputype.h             |   3 +
 5 files changed, 189 insertions(+)
 create mode 100644 arch/arm64/boot/dts/broadcom/vulcan-eval.dts
 create mode 100644 arch/arm64/boot/dts/broadcom/vulcan.dtsi
