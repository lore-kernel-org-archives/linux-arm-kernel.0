From: isubramanian@apm.com (Iyappan Subramanian)
Date: Wed, 29 Oct 2014 17:56:18 -0700
Subject: [PATCH v1 0/2] drivers: net: xgene: Fix crash for backward
 compatibility
Message-ID: <1414630580-24640-1-git-send-email-isubramanian@apm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch set fixes the following issues that were reported during regression.

Patch 1/2: Disables 10GbE and SGMII based 1GbE by default for backward
	   compatiblity with older firmware (<= 1.13.28).  Newer firmware
	   will enable these interfaces based on its configuration.
Patch 2/2: Use separate hardware resources (descriptor ring, prefetch buffer)
	   that are not shared with the firmware
---

Iyappan Subramanian (2):
  dtb: xgene: fix: Disable 10GbE and SGMII based 1GbE by default
  drivers: net: xgene: fix: Use separate resources

 arch/arm64/boot/dts/apm-mustang.dts              | 8 --------
 arch/arm64/boot/dts/apm-storm.dtsi               | 4 ++--
 drivers/net/ethernet/apm/xgene/xgene_enet_main.c | 6 +++---
 drivers/net/ethernet/apm/xgene/xgene_enet_main.h | 3 +++
 4 files changed, 8 insertions(+), 13 deletions(-)

-- 
1.9.1
