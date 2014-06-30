From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Mon, 30 Jun 2014 12:12:21 +0200
Subject: [PATCH v2 0/2] ARM: topology: Allow to set the frequency through a
 clock
Message-ID: <1404123143-13041-1-git-send-email-maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

This patch series add the possibility for the topology code to get the
CPU frequency through a DT clock handle instead of needing a
clock-frequency property.

Indeed, this information can be quite redundant if the clock tree
defined in the DT is already describing the CPU parent clock.

Maxime

Changes from v1:
  - Rebased on top of 3.16
  - Reworked a bit the code in the first patch as requested by Rob
    Herring

Maxime Ripard (2):
  ARM: topology: Use a clock if possible to get the CPU frequency
  ARM: sunxi: Add clocks node to the CPU nodes

 arch/arm/boot/dts/sun6i-a31.dtsi |  4 ++++
 arch/arm/boot/dts/sun7i-a20.dtsi |  2 ++
 arch/arm/kernel/topology.c       | 25 ++++++++++++++++++-------
 3 files changed, 24 insertions(+), 7 deletions(-)

-- 
2.0.0
