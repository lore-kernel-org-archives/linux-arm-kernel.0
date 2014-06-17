From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Tue, 17 Jun 2014 21:56:18 +0200
Subject: [PATCH RESEND 0/2] ARM: topology: Allow to set the frequency through
 a clock
Message-ID: <1403034980-19112-1-git-send-email-maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

This patch series add the possibility for the topology code to get the
CPU frequency through a DT clock handle instead of needing a
clock-frequency property.

Indeed, this information can be quite redundant if the clock tree
defined in the DT is already describing the CPU parent clock.

Maxime

Maxime Ripard (2):
  ARM: topology: Use a clock if possible to get the CPU frequency
  ARM: sunxi: Add clocks node to the CPU nodes

 arch/arm/boot/dts/sun6i-a31.dtsi |  4 ++++
 arch/arm/boot/dts/sun7i-a20.dtsi |  2 ++
 arch/arm/kernel/topology.c       | 24 +++++++++++++++++-------
 3 files changed, 23 insertions(+), 7 deletions(-)

-- 
2.0.0
