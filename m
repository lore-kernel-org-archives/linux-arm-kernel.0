From: marc.zyngier@arm.com (Marc Zyngier)
Date: Thu,  3 Sep 2015 13:16:16 +0100
Subject: [PATCH v3 4/4] arm64: dts: Drop linux,
 pci-probe-only from the Seattle DTS
In-Reply-To: <1441282576-7304-1-git-send-email-marc.zyngier@arm.com>
References: <1441282576-7304-1-git-send-email-marc.zyngier@arm.com>
Message-ID: <1441282576-7304-5-git-send-email-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The linux,pci-probe-only property mandates an argument to indicate
whether or not to engage the "probe-only" mode, but the Seattle
DTS just provides a naked property, which is illegal.

Also, it turns out that the board is perfectly happy without
probe-only, so let's drop this altogether.

Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 arch/arm64/boot/dts/amd/amd-overdrive.dts | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm64/boot/dts/amd/amd-overdrive.dts b/arch/arm64/boot/dts/amd/amd-overdrive.dts
index 564a3f7..128fa94 100644
--- a/arch/arm64/boot/dts/amd/amd-overdrive.dts
+++ b/arch/arm64/boot/dts/amd/amd-overdrive.dts
@@ -14,7 +14,6 @@
 
 	chosen {
 		stdout-path = &serial0;
-		linux,pci-probe-only;
 	};
 };
 
-- 
2.1.4
