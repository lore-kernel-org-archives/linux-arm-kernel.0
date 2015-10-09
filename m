From: heiko@sntech.de (Heiko Stuebner)
Date: Fri, 09 Oct 2015 02:34:44 +0200
Subject: [GIT PULL 1/2] Rockchip drivers for 4.4
Message-ID: <160496219.B4xWx83NpX@phil>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd, Kevin, Olof,

this is the core powerdomain support for the rk3288 (others to follow later).
After 18 rounds it looks now ready for inclusion.


The following changes since commit 6ff33f3902c3b1c5d0db6b1e2c70b6d76fba357f:

  Linux 4.3-rc1 (2015-09-12 16:35:56 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/mmind/linux-rockchip.git tags/v4.4-rockchip-drivers1

for you to fetch changes up to 7c696693a4f54d12714738b45aee3e4302884ade:

  soc: rockchip: power-domain: Add power domain driver (2015-10-06 09:53:28 +0200)

----------------------------------------------------------------
Add the power-domain base-driver which currently contains
support for the rk3288 powerdomain layout but can be easily
extended for the socs (including arm64) later on.
A big thanks to Ceasar Wang for pulling through on this
during 18 revisions.
Also included is a fix to the pm-clock handling in the generic
powerdomains to adapt it to the per-user clock handling we now
do, Acked by Rafael Wysocki.

----------------------------------------------------------------
Caesar Wang (3):
      dt-bindings: add power-domain header for RK3288 SoCs
      dt-bindings: add document of Rockchip power domains
      soc: rockchip: power-domain: Add power domain driver

Heiko Stuebner (1):
      Merge branch 'v4.4-armsoc/pd-headers' into v4.4-armsoc/drivers

Stephen Boyd (1):
      PM / clk: Do not __clk_get passed in clock-references

 .../bindings/soc/rockchip/power_domain.txt         |  46 ++
 drivers/base/power/clock_ops.c                     |   6 +-
 drivers/soc/Kconfig                                |   1 +
 drivers/soc/Makefile                               |   1 +
 drivers/soc/rockchip/Kconfig                       |  14 +
 drivers/soc/rockchip/Makefile                      |   4 +
 drivers/soc/rockchip/pm_domains.c                  | 490 +++++++++++++++++++++
 include/dt-bindings/power/rk3288-power.h           |  31 ++
 8 files changed, 591 insertions(+), 2 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/soc/rockchip/power_domain.txt
 create mode 100644 drivers/soc/rockchip/Kconfig
 create mode 100644 drivers/soc/rockchip/Makefile
 create mode 100644 drivers/soc/rockchip/pm_domains.c
 create mode 100644 include/dt-bindings/power/rk3288-power.h
