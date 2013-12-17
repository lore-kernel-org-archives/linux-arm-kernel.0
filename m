From: andrew@lunn.ch (Andrew Lunn)
Date: Tue, 17 Dec 2013 22:41:09 +0100
Subject: [RFC PATCH v5 0/4] Dove Cpufreq driver
In-Reply-To: <20131204145413.GD29200@e106331-lin.cambridge.arm.com>
References: <20131204145413.GD29200@e106331-lin.cambridge.arm.com>
Message-ID: <1387316473-3250-1-git-send-email-andrew@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This is an RFC where i attempt to address Mark Rutland's request for a
PMU node in DT, and all clocks and interrupts required by the cpufreq
driver are within this node. I would like to receive comments about
this binding.

This version does not address any other comments made to the code. I
will fix those issues once the binding is mostly decided.

Thanks
	Andrew

Andrew Lunn (4):
  cpufreq: Add a cpufreq driver for Marvell Dove
  mvebu: Dove: Indicate the architecture supports cpufreq.
  mvebu: Dove: Enable cpufreq driver in defconfig
  mvebu: Dove: Add PMU node for cpufreq driver

 .../devicetree/bindings/cpufreq/cpufreq-dove.txt   |  23 ++
 arch/arm/Kconfig                                   |   1 +
 arch/arm/boot/dts/dove.dtsi                        |  10 +
 arch/arm/configs/dove_defconfig                    |   2 +
 drivers/cpufreq/Kconfig.arm                        |   5 +
 drivers/cpufreq/Makefile                           |   1 +
 drivers/cpufreq/dove-cpufreq.c                     | 265 +++++++++++++++++++++
 7 files changed, 307 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/cpufreq/cpufreq-dove.txt
 create mode 100644 drivers/cpufreq/dove-cpufreq.c

-- 
1.8.5.1
