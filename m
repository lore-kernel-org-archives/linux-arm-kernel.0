From: hdoyu@nvidia.com (Hiroshi Doyu)
Date: Fri, 11 Jan 2013 15:11:52 +0200
Subject: [PATCH 0/2] ARM: tegra: Add cpu node in device tree
Message-ID: <1357909914-28994-1-git-send-email-hdoyu@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

>From the discussion(*1) of CPU core# detection, DT cpu node will be
the only way to do it right. So we need to add cpu nodes on the
existing Tegra SoCs(T20/T30) first in order to remove the existing A9
SCU detection later, where DT cpu# detection fails, we would consider
a single cpu core avalable.

Tested only with T30.

Hiroshi Doyu (2):
  ARM: tegra20: Add cpu node
  ARM: tegra30: Add cpu node

 arch/arm/boot/dts/tegra20.dtsi |   29 +++++++++++++++++++++++++++++
 arch/arm/boot/dts/tegra30.dtsi |   29 +++++++++++++++++++++++++++++
 2 files changed, 58 insertions(+)

*1:
http://lists.infradead.org/pipermail/linux-arm-kernel/2013-January/140209.html

-- 
1.7.9.5
