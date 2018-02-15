From: robin.murphy@arm.com (Robin Murphy)
Date: Thu, 15 Feb 2018 18:51:40 +0000
Subject: [PATCH v2 0/6] Arm interconnect PMU driver tidyup
Message-ID: <cover.1518717258.git.robin.murphy@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi arm-soc folks,

PLease consider this series tidying up the Arm interconnect code
in drivers/bus to separate the PMU parts out into drivers/perf
where Will and Mark can handle future maintenance more easily.

FWIW, the patches are also available on a branch here:

  git://linux-arm.org/linux-rm.git perf

Thanks,
Robin.

---

Since v1:
 - Add acks.
 - Extra patch to break the direct cci_ctrl_base dependency.

Robin Murphy (6):
  drivers/bus: Move Arm CCN PMU driver
  drivers/bus: Split Arm CCI driver
  perf/arm-cci: Simplify CPU hotplug
  bus/arm-cci: Streamline devicetree handling a bit
  perf/arm-cci: Clean up model discovery
  perf/arm-cci: Untangle global cci_ctrl_base

 .../bindings/{arm/ccn.txt => perf/arm-ccn.txt}     |    0
 Documentation/{arm/CCN.txt => perf/arm-ccn.txt}    |    0
 drivers/bus/Kconfig                                |   36 -
 drivers/bus/Makefile                               |    2 -
 drivers/bus/arm-cci.c                              | 1763 +-------------------
 drivers/perf/Kconfig                               |   33 +
 drivers/perf/Makefile                              |    2 +
 drivers/{bus => perf}/arm-cci.c                    |  738 +-------
 drivers/{bus => perf}/arm-ccn.c                    |    0
 9 files changed, 117 insertions(+), 2457 deletions(-)
 rename Documentation/devicetree/bindings/{arm/ccn.txt => perf/arm-ccn.txt} (100%)
 rename Documentation/{arm/CCN.txt => perf/arm-ccn.txt} (100%)
 copy drivers/{bus => perf}/arm-cci.c (71%)
 rename drivers/{bus => perf}/arm-ccn.c (100%)

-- 
2.16.1.dirty
