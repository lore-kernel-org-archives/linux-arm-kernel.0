From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 12 Feb 2015 20:42:32 +0100
Subject: [PATCH 00/11] ARM: random randconfig fixes, soc specific
Message-ID: <1423770163-583064-1-git-send-email-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello maintainers,

I've kept these to myself for too long, and would like to get them into
v3.20. I hope all of these are noncontroversial, but please have
a look and provide an Ack/Nak where appropriate so we can stick
them into the first fixes pull request after the initial merge
for -rc1.

     Arnd

Arnd Bergmann (11):
  ARM: vexpress: use ARM_CPU_SUSPEND if needed
  ARM: sunxi: always select RESET_CONTROLLER
  ARM: BCM: put back ARCH_MULTI_V7 dependency for mobile
  ARM: davinci: davinci_cfg_reg cannot be init
  ARM: davinci: multi-soc kernels require AUTO_ZRELADDR
  ARM: at91: fix pm declarations
  ARM: prima2: do not select SMP_ON_UP
  ARM: ixp4xx: fix {in,out}s{bwl} data types
  ARM: rockchip: make rockchip_suspend_init conditional
  ARM: sti: always enable RESET_CONTROLLER
  ARM: mvebu: build armada375-smp code conditionally

 arch/arm/mach-at91/generic.h            |  8 ++++----
 arch/arm/mach-bcm/Kconfig               |  4 ++--
 arch/arm/mach-davinci/Kconfig           |  2 ++
 arch/arm/mach-davinci/mux.c             |  4 ++--
 arch/arm/mach-ixp4xx/include/mach/io.h  | 19 +++++++++++++------
 arch/arm/mach-mvebu/system-controller.c |  2 +-
 arch/arm/mach-prima2/Kconfig            |  1 -
 arch/arm/mach-rockchip/pm.h             |  6 ++++++
 arch/arm/mach-sti/Kconfig               |  1 +
 arch/arm/mach-sunxi/Kconfig             |  8 ++------
 arch/arm/mach-vexpress/Kconfig          |  1 +
 11 files changed, 34 insertions(+), 22 deletions(-)

-- 
2.1.0.rc2

Cc: Andrew Lunn <andrew@lunn.ch>
Cc: Barry Song <Baohua.Song@csr.com>
Cc: Christian Daudt <bcm@fixthebug.org>
Cc: Florian Fainelli <f.fainelli@gmail.com>
Cc: Gregory Clement <gregory.clement@free-electrons.com>
Cc: Heiko Stuebner <heiko@sntech.de>
Cc: Imre Kaloz <kaloz@openwrt.org>
Cc: Jason Cooper <jason@lakedaemon.net>
Cc: Kevin Hilman <khilman@deeprootsystems.com>
Cc: Krzysztof Halasa <khalasa@piap.pl>
Cc: Liviu Dudau <liviu.dudau@arm.com>
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Maxime Coquelin <maxime.coquelin@st.com>
Cc: Maxime Ripard <maxime.ripard@free-electrons.com>
Cc: Nicolas Ferre <nicolas.ferre@atmel.com>
Cc: Sekhar Nori <nsekhar@ti.com>
Cc: Srinivas Kandagatla <srinivas.kandagatla@gmail.com>
Cc: Sudeep Holla <sudeep.holla@arm.com>
