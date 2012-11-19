From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Mon, 19 Nov 2012 17:31:17 +0100
Subject: [GIT PULL] at91: fixes for 3.7-rc7
Message-ID: <50AA5ED5.8090901@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Arnd, Olof,

Here is another "fixes" pull request for AT91. It enables the sd/mmc driver
for Device Tree enabled platforms. Those patches where part of a series that
was split in two for reaching upstream: the MMC part is already in Linus' tree
and this is the arm-soc part.
I have placed these patches on top of the fixes that you already have for AT91.

The following changes since commit 641f3ce64b050961d454a0716bb6dbf528315aac:

  ARM: at91/usbh: fix overcurrent gpio setup (2012-11-16 10:46:29 +0100)

are available in the git repository at:

  git://github.com/at91linux/linux-at91.git tags/at91-fixes

for you to fetch changes up to 83ce1c55cfb639438c2516cb05f3b8ee472023e5:

  ARM: at91/dts: add nodes for atmel hsmci controllers for atmel boards (2012-11-19 17:02:40 +0100)

----------------------------------------------------------------
Add entries for enabling the use of sd/mmc driver on AT91.
Those entries where missing for device tree use on these
platforms.

----------------------------------------------------------------
Ludovic Desroches (3):
      ARM: at91: add clocks for DT entries
      ARM: at91/dts: add nodes for atmel hsmci controllers for atmel SOCs
      ARM: at91/dts: add nodes for atmel hsmci controllers for atmel boards

 arch/arm/boot/dts/at91sam9260.dtsi          |  9 +++++++++
 arch/arm/boot/dts/at91sam9263.dtsi          | 18 ++++++++++++++++++
 arch/arm/boot/dts/at91sam9263ek.dts         | 10 ++++++++++
 arch/arm/boot/dts/at91sam9g20ek_2mmc.dts    | 12 ++++++++++++
 arch/arm/boot/dts/at91sam9g20ek_common.dtsi |  9 +++++++++
 arch/arm/boot/dts/at91sam9g25ek.dts         | 18 ++++++++++++++++++
 arch/arm/boot/dts/at91sam9g45.dtsi          | 18 ++++++++++++++++++
 arch/arm/boot/dts/at91sam9m10g45ek.dts      | 19 +++++++++++++++++++
 arch/arm/boot/dts/at91sam9n12.dtsi          |  9 +++++++++
 arch/arm/boot/dts/at91sam9n12ek.dts         |  9 +++++++++
 arch/arm/boot/dts/at91sam9x5.dtsi           | 18 ++++++++++++++++++
 arch/arm/mach-at91/at91sam9260.c            |  1 +
 arch/arm/mach-at91/at91sam9263.c            |  2 ++
 arch/arm/mach-at91/at91sam9g45.c            |  2 ++
 arch/arm/mach-at91/at91sam9n12.c            |  1 +
 arch/arm/mach-at91/at91sam9x5.c             |  2 ++
 16 files changed, 157 insertions(+)

-- 
Nicolas Ferre
