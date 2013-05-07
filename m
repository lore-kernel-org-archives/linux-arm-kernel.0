From: valentin.longchamp@keymile.com (Valentin Longchamp)
Date: Tue,  7 May 2013 17:52:18 +0200
Subject: [RFC PATCH] Alternative clk gate ctrl for Kirkwood variants
Message-ID: <1367941941-19152-1-git-send-email-valentin.longchamp@keymile.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This series introduces a clk gate ctrl for the kirkwood variants embedded in the
Prestera SoCs.

This would allow to get rid of the workaround for the km_kirkwood board support
file that was added previously because of the lack of DT clk gate support.

Valentin Longchamp (3):
  clk: mvebu: add gate ctrl for Prestera kirkwood variants
  ARM: kirkwood: look for alternative gate ctrl of node
  ARM: kirkwood: remove clock gating disabling for km_kirkwood

 .../devicetree/bindings/clock/mvebu-gated-clock.txt   | 17 +++++++++++++++++
 arch/arm/boot/dts/kirkwood-98dx4122.dtsi              |  7 +++++++
 arch/arm/mach-kirkwood/board-dt.c                     |  4 ++++
 arch/arm/mach-kirkwood/board-km_kirkwood.c            | 15 ---------------
 drivers/clk/mvebu/clk-gating-ctrl.c                   | 19 +++++++++++++++++++
 5 files changed, 47 insertions(+), 15 deletions(-)

-- 
1.8.0.1
