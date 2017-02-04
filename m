From: hkallweit1@gmail.com (Heiner Kallweit)
Date: Sat, 4 Feb 2017 22:03:34 +0100
Subject: [PATCH 0/2] scpi: RfC - Allow to ignore invalid SCPI DVFS clock rates
Message-ID: <a4c725a9-2f79-a48b-b732-61e1fe31aba8@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On the Odroid C2 (Amlogic S905GXBB) the firmware defines SCPI DVFS cpu
clock rates which make the system crash or at least unstable.
Therefore cpufreq can't be used on this system as of today.
Other systems might face similar issues with too optimistic SCPI SVFS
clock rates.

This RfC patch series addresses this by allowing to define a max
frequency per clock via DT. All frequencies for the respective clock
exceeding this threshold will be ignored.

Heiner Kallweit (2):
  clk: scpi: RfC - Allow to ignore invalid SCPI DVFS clock rates
  cpufreq: scpi: RfC - Allow to ignore invalid SCPI DVFS clock rates

 Documentation/devicetree/bindings/arm/arm,scpi.txt |  7 +++++++
 drivers/clk/clk-scpi.c                             | 15 ++++++++++++++-
 drivers/cpufreq/scpi-cpufreq.c                     | 22 ++++++++++++++++++++++
 3 files changed, 43 insertions(+), 1 deletion(-)

-- 
2.11.0
