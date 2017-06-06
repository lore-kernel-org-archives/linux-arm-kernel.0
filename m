From: hotran@apm.com (Hoan Tran)
Date: Tue,  6 Jun 2017 11:02:23 -0700
Subject: [PATCH v3 0/3] perf: xgene: Add support for SoC PMU version 3
Message-ID: <1496772146-11084-1-git-send-email-hotran@apm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch set adds support for SoC-wide (AKA uncore) Performance Monitoring
Unit version 3.

It can support up to
 - 2 IOB PMU instances
 - 8 L3C PMU instances
 - 2 MCB PMU instances
 - 8 MCU PMU instances
and these PMUs support 64 bit counter

v3:
 * Seperate acpi_pmu_probe_active_mcb_mcu_l3c for v3
 * Consistent PMU event name
 * Update comment
 * Correct active MCU detection

v2:
 * Split into separate patches
 * Use the function pointers for the PMU leaf functions
 * Parse PMU subnode by the match table
 * Dont allow user change agent id by config1 for SoC PMU v3

Hoan Tran (3):
  perf: xgene: Parse PMU subnode from the match table
  perf: xgene: Move PMU leaf functions into function pointer structure
  perf: xgene: Add support for SoC PMU version 3

 drivers/perf/xgene_pmu.c | 677 +++++++++++++++++++++++++++++++++++++++++++----
 1 file changed, 622 insertions(+), 55 deletions(-)

-- 
1.9.1
