From: heiko@sntech.de (Heiko =?ISO-8859-1?Q?St=FCbner?=)
Date: Tue, 18 Nov 2014 16:33:19 +0100
Subject: [GIT PULL 1/2] ARM: rockchip: second batch of soc related changes
Message-ID: <11809616.LUBsxGXhAZ@diego>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd, Olof,

here is the second batch of soc related changes, consisting only
of the smp support for rk3288.

Due to the slight misheap of the v3.18 cpuclk pull being merge, it is based
on exactly this merge commit from Olof to next/soc.


The following changes since commit 9576d3e622f325e617b272172dd68e329e742f77:

  Merge tag 'v3.18-rockchip-cpufreqdev-v2' of git://git.kernel.org/pub/scm/linux/kernel/git/mmind/linux-rockchip into next/soc (2014-11-03 20:49:01 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/mmind/linux-rockchip.git tags/v3.19-rockchip-soc2

for you to fetch changes up to 3ee851e212d0bb6be8c462059fba74ce2e3f6064:

  ARM: rockchip: add basic smp support for rk3288 (2014-11-05 22:18:40 +0100)

----------------------------------------------------------------
code part of the rk3288 smp support

----------------------------------------------------------------
Heiko Stuebner (2):
      ARM: rockchip: convert to regmap and use pmu syscon if available
      ARM: rockchip: add option to access the pmu via a phandle in smp_operations

Kever Yang (1):
      ARM: rockchip: add basic smp support for rk3288

 Documentation/devicetree/bindings/arm/cpus.txt |   9 +
 arch/arm/mach-rockchip/headsmp.S               |   5 +-
 arch/arm/mach-rockchip/platsmp.c               | 223 ++++++++++++++++++++-----
 3 files changed, 193 insertions(+), 44 deletions(-)
