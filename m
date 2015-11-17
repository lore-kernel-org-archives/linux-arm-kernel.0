From: suzuki.poulose@arm.com (Suzuki K. Poulose)
Date: Tue, 17 Nov 2015 18:30:38 +0000
Subject: [PATCH 0/2] ARM CoreLink CCI-550 PMU driver
Message-ID: <1447785040-18599-1-git-send-email-suzuki.poulose@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This series adds the driver for CCI-550 PMU. CCI-550 PMU shares
most of the attributes (i.e, counters, event code format, event
codes, PMU register file) with that of CCI-500, except for an
additional master interface support (MI6). So, we share most of
the CCI-500 PMU bits except for a CCI-550 specific event validation.

Patch 1 : Renames the shared bits of CCI-500 PMU defintions to
	  CCI5xx, including the Kconfig symbol, which will support both
	  the PMUs.

Patch 2 : Adds the CCI550_PMU driver

Tested on fast model and an FPGA model.

This series is based on :
	4.4-rc1 + [1] + [2]
and is also available at :
	git://linux-arm.org/linux-skp.git cci-updates/4.4-rc1

[1] arm-cci: simplify sysfs attr handling
http://lists.infradead.org/pipermail/linux-arm-kernel/2015-September/373129.html

[2] arm-cci500: Workaround pmu_event_set_period
http://lists.infradead.org/pipermail/linux-arm-kernel/2015-November/385849.html



Suzuki K. Poulose (2):
  arm-cci500: Rearrange PMU driver for code sharing with CCI-550 PMU
  arm-cci: CoreLink CCI-550 PMU driver

 Documentation/devicetree/bindings/arm/cci.txt |    2 +
 drivers/bus/Kconfig                           |   10 +-
 drivers/bus/arm-cci.c                         |  303 ++++++++++++++++---------
 3 files changed, 202 insertions(+), 113 deletions(-)

-- 
1.7.9.5
