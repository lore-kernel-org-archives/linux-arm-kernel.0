From: thierry.reding@gmail.com (Thierry Reding)
Date: Fri, 25 Apr 2014 17:44:44 +0200
Subject: [PATCH 0/7] ARM: tegra: HDMI and DSI updates
Message-ID: <1398440691-23366-1-git-send-email-thierry.reding@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Thierry Reding <treding@nvidia.com>

This series enables support for HDMI on Venice2 and Jetson TK1. It also
adds the missing +5V regulators for Harmony, Beaver and Dalmore. Other
boards may also need similar changes, but I don't have access to them.
That said existing boards should continue to work without modifications
since we were completely ignoring the +5V regulator before. So the only
change that this should introduce is that perhaps some additional power
can be saved because the +5V regulator now isn't always on.

The final patch in this series hooks up the DSI power supply on Dalmore
so that it can also be switched of if not used.

Note that I have only an A05 Dalmore and from what I can tell there have
been some changes from A04 (the one supported by the upstream kernel)
and A05 regarding HDMI, so it'd be great if somebody could test these
changes (on top of a recent linux-next) on an A04 Dalmore to make sure
they work there.

Thierry

Thierry Reding (7):
  ARM: tegra: Add Tegra124 HDMI support
  ARM: tegra: venice2 - Enable HDMI
  ARM: tegra: jetson-tk1 - Enable HDMI support
  ARM: tegra: harmony - Add +5V HDMI supply
  ARM: tegra: beaver - Add +5V HDMI supply
  ARM: tegra: dalmore - Add +5V HDMI supply
  ARM: tegra: dalmore - Add DSI power supply

 arch/arm/boot/dts/tegra114-dalmore.dts    | 20 ++++++++++++----
 arch/arm/boot/dts/tegra124-jetson-tk1.dts | 39 +++++++++++++++++++++++++++++--
 arch/arm/boot/dts/tegra124-venice2.dts    | 37 +++++++++++++++++++++++++++--
 arch/arm/boot/dts/tegra124.dtsi           | 12 ++++++++++
 arch/arm/boot/dts/tegra20-harmony.dts     | 12 ++++++++++
 arch/arm/boot/dts/tegra30-beaver.dts      | 12 ++++++++++
 6 files changed, 123 insertions(+), 9 deletions(-)

-- 
1.9.2
