From: robin.murphy@arm.com (Robin Murphy)
Date: Mon,  5 Feb 2018 18:39:41 +0000
Subject: [PATCH 0/5] Arm interconnect PMU driver tidyup
Message-ID: <cover.1517855839.git.robin.murphy@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Since system PMUs now have a proper home in drivers/perf/, let's
collect together the Arm interconnect PMU drivers currently squatting
in drivers/bus/. Whilst elbow-deep in the CCI driver I spotted some
further opportunity for cleanup, so a few bonus patches are included
at the end. 

Robin.


Robin Murphy (5):
  drivers/bus: Move Arm CCN PMU driver
  drivers/bus: Split Arm CCI driver
  perf/arm-cci: Simplify CPU hotplug
  bus/arm-cci: Streamline devicetree handling a bit
  perf/arm-cci: Clean up model discovery

 .../bindings/{arm/ccn.txt => perf/arm-ccn.txt}     |    0
 Documentation/{arm/CCN.txt => perf/arm-ccn.txt}    |    0
 drivers/bus/Kconfig                                |   36 -
 drivers/bus/Makefile                               |    2 -
 drivers/bus/arm-cci.c                              | 1751 +-------------------
 drivers/perf/Kconfig                               |   33 +
 drivers/perf/Makefile                              |    2 +
 drivers/{bus => perf}/arm-cci.c                    |  699 +-------
 drivers/{bus => perf}/arm-ccn.c                    |    0
 9 files changed, 86 insertions(+), 2437 deletions(-)
 rename Documentation/devicetree/bindings/{arm/ccn.txt => perf/arm-ccn.txt} (100%)
 rename Documentation/{arm/CCN.txt => perf/arm-ccn.txt} (100%)
 copy drivers/{bus => perf}/arm-cci.c (72%)
 rename drivers/{bus => perf}/arm-ccn.c (100%)

-- 
2.16.1.dirty
