From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Thu, 14 Apr 2016 17:38:33 +0200
Subject: [PATCH v2 4/4] arm64: dts: marvell: enable one PCIe interface on
 Armada 7040-DB
In-Reply-To: <1460648313-31642-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1460648313-31642-1-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <1460648313-31642-5-git-send-email-thomas.petazzoni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This commit enables one PCIe interface on Armada 7040-DB, now that
PCIe support for this SoC has been enabled.

Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
---
 arch/arm64/boot/dts/marvell/armada-7040-db.dts | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm64/boot/dts/marvell/armada-7040-db.dts b/arch/arm64/boot/dts/marvell/armada-7040-db.dts
index 064a251..33ba5dc 100644
--- a/arch/arm64/boot/dts/marvell/armada-7040-db.dts
+++ b/arch/arm64/boot/dts/marvell/armada-7040-db.dts
@@ -89,4 +89,10 @@
 			};
 		};
 	};
+
+	cp110-master {
+		pcie at f2640000 {
+			status = "okay";
+		};
+	};
 };
-- 
2.6.4
