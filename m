From: florian.vaussard@epfl.ch (Florian Vaussard)
Date: Wed, 19 Feb 2014 10:15:03 +0100
Subject: [PATCH v2 0/2] ARM: OMAP4: Fix gpmc_fck clock
Message-ID: <1392801305-1698-1-git-send-email-florian.vaussard@epfl.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

Trying to get my SMSC9221 working on OMAP4 with DT,
I faced a misconfigured gpmc_fck (dummy clock set to 0)
resulting in serveral division-by-zero, misconfigured
timings and driver lost in the La La Land.

To solve this, patch 1 removes gpmc_fck from the dummy
clocks, and patch 2 adds the gpmc_fck DT node and
reference it from the gpmc node.

Tested on DuoVero/Parlor (OMAP4430) with SMSC9221.

Regards,
Florian
---
Since v1:
- Removed the gpmc_fck clock node, and reference directly l3_ick

Florian Vaussard (2):
  CLK: TI: OMAP4: Remove gpmc_fck from dummy clocks
  ARM: DTS: OMAP4: Use l3_ick for the gpmc node

 arch/arm/boot/dts/omap4.dtsi | 2 ++
 drivers/clk/ti/clk-44xx.c    | 1 -
 2 files changed, 2 insertions(+), 1 deletion(-)

-- 
1.8.1.2
