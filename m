From: emilio@elopez.com.ar (=?UTF-8?q?Emilio=20L=C3=B3pez?=)
Date: Tue,  9 Apr 2013 10:48:01 -0300
Subject: [PATCH 0/3] sunxi: unify main oscillator and its gate
Message-ID: <1365515284-32061-1-git-send-email-emilio@elopez.com.ar>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mike,

As discussed previously when introducing the sunxi driver, this patchset
unifies the main oscillator ("osc24M_fixed") and its gate ("osc24M")
into a single clock ("osc24M"). It does so by adding fixed-rate support
into the composite clock and then using it to implement the new clock.

The changes shouldn't require any modifications on current/future users 
of the composite clock, although I haven't tested any to make sure of 
it. @Prashant, can I get a tested-by from you if necessary?

Thanks,

Emilio

Emilio L?pez (3):
  clk: composite: Add fixed-rate support
  clk: sunxi: Unify oscillator clock
  ARM: sunxi: unify osc24M_fixed and osc24M

 arch/arm/boot/dts/sunxi.dtsi  |  8 +-----
 drivers/clk/clk-composite.c   | 57 ++++++++++++++++++++++++++++++++++++++++---
 drivers/clk/sunxi/clk-sunxi.c | 30 +++++++++++++++++------
 include/linux/clk-provider.h  |  6 +++++
 4 files changed, 83 insertions(+), 18 deletions(-)

-- 
1.8.2.1
