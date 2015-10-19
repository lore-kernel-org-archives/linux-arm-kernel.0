From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Mon, 19 Oct 2015 21:31:58 +0200
Subject: [GIT PULL] at91: dt for 4.4 #2
Message-ID: <20151019193158.GA20739@piout.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Arnd, Olof, Kevin,

A few more DT changes for AT91.
Small fixes and huge addition to the sama5d2 and its evaluation board.
There may be a simple add/add conflict with Linus Walleij pinctrl tree
that should be an issue.

Thanks, best regards,

The following changes since commit a9b672a636a599cc052afcb6837e3177dc53c143:

  ARM: at91/dt: sama5d2 Xplained: add device pin muxing (2015-09-23 16:26:47 +0200)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/abelloni/linux.git tags/at91-ab-dt2

for you to fetch changes up to 0bddbefb9e731a6090350508f139b9ac3590303c:

  ARM: at91/dt: sama5d2 Xplained: add several devices (2015-10-19 21:22:32 +0200)

----------------------------------------------------------------
Second batch of DT changes for 4.4:
- some DT fixes: pullups, disabled property
- the PMC is now a syscon
- great improvement of sama5d2 support

----------------------------------------------------------------
Alexandre Belloni (1):
      ARM: at91/dt: use syscon for PMC

Gregory CLEMENT (1):
      ARM: at91/dt: sama5d4: add the macb1 node

Ludovic Desroches (2):
      ARM: at91/dt: sama5d2: add missing devices
      ARM: at91/dt: sama5d2 Xplained: add several devices

Michael Opdenacker (1):
      ARM: at91/dt: fix "disabled" property on at91rm9200

Sylvain Rochet (1):
      ARM: at91/dt: add pullup on mmc2 data signals

Wenyou Yang (1):
      ARM: at91/dt: sama5d2_xplained: add regulator nodes

 arch/arm/boot/dts/at91-sama5d2_xplained.dts | 163 ++++++++++++++++++++++++++++
 arch/arm/boot/dts/at91rm9200.dtsi           |   8 +-
 arch/arm/boot/dts/at91sam9260.dtsi          |   2 +-
 arch/arm/boot/dts/at91sam9261.dtsi          |   2 +-
 arch/arm/boot/dts/at91sam9263.dtsi          |   2 +-
 arch/arm/boot/dts/at91sam9g45.dtsi          |   2 +-
 arch/arm/boot/dts/at91sam9n12.dtsi          |   2 +-
 arch/arm/boot/dts/at91sam9rl.dtsi           |   2 +-
 arch/arm/boot/dts/at91sam9x5.dtsi           |   2 +-
 arch/arm/boot/dts/sama5d2.dtsi              | 154 +++++++++++++++++++++++++-
 arch/arm/boot/dts/sama5d3.dtsi              |   2 +-
 arch/arm/boot/dts/sama5d3_mci2.dtsi         |   6 +-
 arch/arm/boot/dts/sama5d4.dtsi              |  32 +++++-
 13 files changed, 360 insertions(+), 19 deletions(-)

-- 
Alexandre Belloni, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
