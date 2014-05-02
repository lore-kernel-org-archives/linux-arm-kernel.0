From: george.cherian@ti.com (George Cherian)
Date: Fri, 2 May 2014 12:01:58 +0530
Subject: [PATCH v2 0/6] Add CPTS support for AM437x 
Message-ID: <1399012324-20737-1-git-send-email-george.cherian@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The series adds CPTS support for AM4372.

Patch 1 - DT changes w.r.t clock changes for AM33xx.
Patch 2 - CPTS clock name harcoding in the driver is removed. 
	  Easier to pass the clock name from dt rather than hardcoding in driver.
	  Also in prepration for DRA7x CPTS support.
Patch 3 - Enable the CPTS support for both DRA7x and AM4372 in the driver.
Patch 4 - Enable the Annexe F for L2 PTP for AM437x and DRA7x.
Patch 5 - Change the default clocksource to dpll_core_m5 
Patch 6 - DT changes for AM4372.


v1 -> v2
	Patch 1 and 2 Re-ordering.
	Seperate TS_BITS define for Hw version V2 and V3

George Cherian (6):
  ARM: dts: am33xx: Add clock names for cpsw and cpts
  drivers: net: cpts: Remove hardcoded clock name for CPTS
  drivers: net: cpsw: Enable CPTS for DRA7xx and AM4372
  drivers: net: cpsw: Enable Annexe F Time sync
  ARM: AM43xx: clk: Change the cpts ref clock source to dpll_core_m5 clk
  ARM: dts: am4372: Add clock names for cpsw and cpts

 arch/arm/boot/dts/am33xx.dtsi  |  2 ++
 arch/arm/boot/dts/am4372.dtsi  |  2 ++
 drivers/clk/ti/clk-43xx.c      | 16 ++++++++++++
 drivers/net/ethernet/ti/cpsw.c | 56 +++++++++++++++++++++++++++++++-----------
 drivers/net/ethernet/ti/cpts.c | 11 +++------
 5 files changed, 66 insertions(+), 21 deletions(-)

-- 
1.8.3.1
