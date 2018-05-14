From: robin.murphy@arm.com (Robin Murphy)
Date: Mon, 14 May 2018 14:34:50 +0100
Subject: [PATCH v2 0/3] perf: make Arm CCI driver modular
Message-ID: <cover.1526303815.git.robin.murphy@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Now that it has been surgically removed from the MCPM port-control code,
we can let the CCI PMU driver be modular. Probing the PMU in the first
place still depends on the bus driver stub being built-in, but it's a
small price to pay compared to the major upheaval of completely reworking
the DT-handling code across the two drivers.

Robin.

v2: Fix Kconfig dependencies per kbuild robot report

Robin Murphy (3):
  perf/arm-cc*: Fix MODULE_LICENSE() tags
  perf/arm-cci: Remove pointless PMU disabling
  perf/arm-cci: Allow building as a module

 drivers/perf/Kconfig   | 34 ++++++++++++++++++----------------
 drivers/perf/arm-cci.c | 32 ++++++++++++++++++++------------
 drivers/perf/arm-ccn.c |  2 +-
 3 files changed, 39 insertions(+), 29 deletions(-)

-- 
2.17.0.dirty
