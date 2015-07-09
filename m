From: dhdang@apm.com (Duc Dang)
Date: Thu,  9 Jul 2015 14:20:10 -0700
Subject: [PATCH v3 0/2] pci: xgene: Add multiple memory ranges support
In-Reply-To: <1481643.dA4ocqzitg@wuerfel>
References: <1481643.dA4ocqzitg@wuerfel>
Message-ID: <cover.1436476099.git.dhdang@apm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch set adds 1 large (up to 64GB) memory window for each PCIe
controller nodes in X-Gene device tree and fix PCIe controller driver
to handle multiple memory ranges correctly. These changes are required
to support PCIe devices that have huge BAR.

v3 changes:
	1. Explicitly mention in change log that: Each PCIe node in dts 
	will have 1 32-bit non-prefetchable memory window and 1 64-bit 
	prefetchable memory window.

v2 changes:
        1. Separate device-tree changes and driver changes into different
        patches
        2. Explicitly define new large window as 64-bit prefetchable in dts.
        3. Use IORESOURCE_PREFETCH flag to determine which PCIe controller
        register to be used to configure the memory ranges.
 
 arch/arm64/boot/dts/apm/apm-storm.dtsi | 23 ++++++++++++++---------
 drivers/pci/host/pci-xgene.c           | 12 ++++++++++--
 2 files changed, 24 insertions(+), 11 deletions(-)

-- 
1.9.1
