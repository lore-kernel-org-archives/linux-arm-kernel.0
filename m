From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Fri, 29 Mar 2013 15:59:39 +0100
Subject: [GIT PULL] at91: DT changes for 3.10 #2
Message-ID: <1364569179-24773-1-git-send-email-nicolas.ferre@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Arnd, Olof,

Here is a pull-request for AT91 that is dedicated to Device Tree
modifications. It is stacked on the material that you already have
for 3.10 in your arm-soc/at91/dt branch.
Following our discussion with Arnd, I added the non-urgent patches that I
already proposed too late for 3.9. I also included the moving of macb node
and kept the original patch.

Thanks, best regards,

The following changes since commit 6901d947be5ba1245a0f63271355b95f9056a362:

  ARM: at91/at91sam9x5cm: add 1-wire chip on CM board (2013-03-21 16:07:15 +0100)

are available in the git repository at:

  git://github.com/at91linux/linux-at91.git tags/at91-dt

for you to fetch changes up to cc2e191b0ccc5a987fdb29261ab9c264c608924d:

  ARM: at91/dt: fix macb node declaration (2013-03-29 10:02:04 +0100)

----------------------------------------------------------------
One macb DT node move for 9x5 family: 9g15 doesn't
have an Ethernet interface.
Little fixes mainly related to at91sam9x5 DT and the
RTC addition.
Addition of the Acme Systems Aria G25 board.

----------------------------------------------------------------
Douglas Gilbert (1):
      ARM: at91: add Acme Systems Aria G25 board

Nicolas Ferre (5):
      ARM: at91/at91sam9x5: add RTC node
      ARM: at91/trivial: typos in compatible property
      ARM: at91/trivial: fix model name for SAM9G15-EK
      ARM: at91: remove partial parameter in bootargs for at91sam9x5ek.dtsi
      ARM: at91/dt: fix macb node declaration

 arch/arm/boot/dts/ariag25.dts       | 175 +++++++++++++++++++++++++++++++++++
 arch/arm/boot/dts/at91sam9g15.dtsi  |   2 +-
 arch/arm/boot/dts/at91sam9g15ek.dts |   2 +-
 arch/arm/boot/dts/at91sam9g25.dtsi  |   2 +-
 arch/arm/boot/dts/at91sam9g25ek.dts |   9 ++
 arch/arm/boot/dts/at91sam9g35.dtsi  |   2 +-
 arch/arm/boot/dts/at91sam9g35ek.dts |   9 ++
 arch/arm/boot/dts/at91sam9x25.dtsi  |   2 +-
 arch/arm/boot/dts/at91sam9x25ek.dts |  14 +++
 arch/arm/boot/dts/at91sam9x35.dtsi  |   2 +-
 arch/arm/boot/dts/at91sam9x35ek.dts |   9 ++
 arch/arm/boot/dts/at91sam9x5.dtsi   |   7 ++
 arch/arm/boot/dts/at91sam9x5ek.dtsi |   7 +-
 13 files changed, 230 insertions(+), 12 deletions(-)
 create mode 100644 arch/arm/boot/dts/ariag25.dts

-- 
Nicolas Ferre
