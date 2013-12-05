From: ldewangan@nvidia.com (Laxman Dewangan)
Date: Thu, 5 Dec 2013 16:27:48 +0530
Subject: [PATCH 2/4] ARM: tegra: add pinmux controller to tegra124.dtsi
In-Reply-To: <1386241070-4350-1-git-send-email-ldewangan@nvidia.com>
References: <1386241070-4350-1-git-send-email-ldewangan@nvidia.com>
Message-ID: <1386241070-4350-3-git-send-email-ldewangan@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The tegra124 pinmux controller is identical to tegra114 with
removing some of existing pins from T114 and adding new pins.

Signed-off-by: Laxman Dewangan <ldewangan@nvidia.com>
---
 arch/arm/boot/dts/tegra124.dtsi |    6 ++++++
 1 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/arch/arm/boot/dts/tegra124.dtsi b/arch/arm/boot/dts/tegra124.dtsi
index b741300..39bfcce 100644
--- a/arch/arm/boot/dts/tegra124.dtsi
+++ b/arch/arm/boot/dts/tegra124.dtsi
@@ -47,6 +47,12 @@
 		interrupt-controller;
 	};
 
+	pinmux: pinmux {
+		compatible = "nvidia,tegra124-pinmux";
+		reg = <0x70000868 0x164		/* Pad control registers */
+		       0x70003000 0x434>;	/* PinMux registers */
+	};
+
 	/*
 	 * There are two serial driver i.e. 8250 based simple serial
 	 * driver and APB DMA based serial driver for higher baudrate
-- 
1.7.1.1
