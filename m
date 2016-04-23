From: f.fainelli@gmail.com (Florian Fainelli)
Date: Sat, 23 Apr 2016 12:58:58 -0700
Subject: [GIT PULL 2/4] Broadcom devicetree-arm64 changes for 4.7
In-Reply-To: <1461441540-5095-1-git-send-email-f.fainelli@gmail.com>
References: <1461441540-5095-1-git-send-email-f.fainelli@gmail.com>
Message-ID: <1461441540-5095-2-git-send-email-f.fainelli@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit f55532a0c0b8bb6148f4e07853b876ef73bc69ca:

  Linux 4.6-rc1 (2016-03-26 16:03:24 -0700)

are available in the git repository at:

  http://github.com/Broadcom/stblinux.git tags/arm-soc/for-4.7/devicetree-arm64

for you to fetch changes up to a9abb475a4fd3e23f2de8bf134b71e10b560b910:

  arm64: dts: NS2 secondary core enablement via PSCI (2016-04-22 12:02:28 -0700)

----------------------------------------------------------------
This pull request contains Broadcom ARM64-based SoC Device Tree changes:

- Anup enables a bunch of standard peripherals in the Northstar 2 DTS: PL330
  DMA, GIC maintenance interrupt, PL022 SPI controller

- Anup also re-orgnanizes the clock Device Tree fragments into a separate file
  for consistency with how other Broadcom SoCs are doing this

- Luke switches the SMP enable-method and reboot from a spin-table + syscon to
  the standard PSCI 1.0 firmware interface

----------------------------------------------------------------
Anup Patel (4):
      arm64: dts: Add ARM PL330 DMA DT node for NS2
      arm64: dts: Add maintenance interrupt for GIC in NS2 DT
      arm64: dts: Move NS2 clock DT nodes to separate DT file
      arm64: dts: Add ARM PL022 SPI DT nodes for NS2

Luke Starrett (1):
      arm64: dts: NS2 secondary core enablement via PSCI

 arch/arm64/boot/dts/broadcom/ns2-clock.dtsi | 105 +++++++++++++++++++
 arch/arm64/boot/dts/broadcom/ns2-svk.dts    |  45 ++++++++
 arch/arm64/boot/dts/broadcom/ns2.dtsi       | 155 ++++++++++------------------
 3 files changed, 205 insertions(+), 100 deletions(-)
 create mode 100644 arch/arm64/boot/dts/broadcom/ns2-clock.dtsi
