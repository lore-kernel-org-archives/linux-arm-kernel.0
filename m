From: antoine.tenart@free-electrons.com (Antoine Tenart)
Date: Thu, 25 Feb 2016 11:14:50 +0100
Subject: [PATCH 0/7] arm/arm64: Alpine patches for 4.6
Message-ID: <1456395297-6505-1-git-send-email-antoine.tenart@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd, Olof and Kevin,

Here are the Alpine patches for 4.6. As seen with Olof these patches are
sent to you as a series as there are only 7 of them. I'll get my gpg key
signed and setup a git tree somewhere for next time.

The first 3 patches introduce a basic arm64 Alpine support, by adding
the Alpine v2 EVP board. The last 4 patches add an MSIX node in both
Alpine v1 (arm) and Alpine v2 (arm64) dtsi and select the Alpine MSI
controller driver.

Thanks!

Antoine

Antoine Tenart (7):
  arm64: add Alpine SoC family
  arm64: dts: add the Alpine v2 EVP
  arm64: defconfig: enable the Alpine family
  arm64: dts: alpine: add the MSIX node in the Alpine v2 dtsi
  ARM: dts: alpine: add the MSIX node
  arm64: alpine: select the Alpine MSI controller driver
  ARM: alpine: select the Alpine MSI controller driver

 arch/arm/boot/dts/alpine.dtsi            |  10 ++
 arch/arm/mach-alpine/Kconfig             |   1 +
 arch/arm64/Kconfig.platforms             |   7 +
 arch/arm64/boot/dts/Makefile             |   1 +
 arch/arm64/boot/dts/al/Makefile          |   5 +
 arch/arm64/boot/dts/al/alpine-v2-evp.dts |  53 +++++++
 arch/arm64/boot/dts/al/alpine-v2.dtsi    | 236 +++++++++++++++++++++++++++++++
 arch/arm64/configs/defconfig             |   1 +
 8 files changed, 314 insertions(+)
 create mode 100644 arch/arm64/boot/dts/al/Makefile
 create mode 100644 arch/arm64/boot/dts/al/alpine-v2-evp.dts
 create mode 100644 arch/arm64/boot/dts/al/alpine-v2.dtsi

-- 
2.7.1
