From: heiko@sntech.de (Heiko Stuebner)
Date: Tue, 15 Nov 2016 23:38:57 +0100
Subject: [PATCH v2 0/3] Rockchip: generalize GRF setup
Message-ID: <20161115223900.30728-1-heiko@sntech.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The General register files contain a big bunch of settings for various
components. Things like the automatic sdmmc/jtag switch may even affect
us in a bad way, while that property (and possibly others) are not even
part of the dw_mmc controller itself.

And while the rk3288 could still carry adaptions to these defaults
in its mach files, this is no longer possible on the arm64 socs, while
things like the jtag-switch from above still can affect us there.

changes in v2:
- address comments from Doug Anderson
- drop platform device, as we actual probing may happen at some
  unspecified later time during boot
- add reviews / acks received in v1

Heiko Stuebner (3):
  dt-bindings: add used but undocumented rockchip grf compatible values
  soc: rockchip: add driver handling grf setup
  ARM: rockchip: drop rk3288 jtag/mmc switch handling

 .../devicetree/bindings/soc/rockchip/grf.txt       |   4 +
 arch/arm/mach-rockchip/rockchip.c                  |  12 --
 drivers/soc/rockchip/Kconfig                       |  10 ++
 drivers/soc/rockchip/Makefile                      |   1 +
 drivers/soc/rockchip/grf.c                         | 134 +++++++++++++++++++++
 5 files changed, 149 insertions(+), 12 deletions(-)
 create mode 100644 drivers/soc/rockchip/grf.c

-- 
2.10.2
