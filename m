From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Fri, 25 Apr 2014 22:00:18 +0200
Subject: [RFC 0/5] berlin: add support for clocks sharing registers
Message-ID: <1398456024-27876-1-git-send-email-alexandre.belloni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Some clock on the berlin are sharing registers, this is an attempt at supporting
them.

I think there is a third set of regiters to enable/disable the clocks but I
don't have any information on that.

I'm also not completely sure of the DT bindings and I know that this is not the
way Sebastian was envisionning it.

Alexandre Belloni (5):
  clk: berlin: add support for clock groups
  clk: berlin: add berlin clock groups DT bindings documentation
  ARM: berlin/dt: add support for the clock group to BG2
  ARM: berlin/dt: add support for the clock group to BG2D
  ARM: berlin/dt: add support for the clock group to BG2Q

 .../devicetree/bindings/clock/berlin-clock.txt     |  29 +++
 arch/arm/boot/dts/berlin2.dtsi                     |  30 ++-
 arch/arm/boot/dts/berlin2cd.dtsi                   |  36 +++-
 arch/arm/boot/dts/berlin2q.dtsi                    |  24 ++-
 drivers/clk/berlin/Makefile                        |   2 +-
 drivers/clk/berlin/grp.c                           | 208 +++++++++++++++++++++
 6 files changed, 310 insertions(+), 19 deletions(-)
 create mode 100644 drivers/clk/berlin/grp.c

-- 
1.9.1
