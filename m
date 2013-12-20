From: broonie@kernel.org (Mark Brown)
Date: Fri, 20 Dec 2013 12:52:44 +0000
Subject: [PATCH 2/2] arm64: dts: Reduce size of virtio block device for
 foundation model
In-Reply-To: <1387543964-15057-1-git-send-email-broonie@kernel.org>
References: <1387543964-15057-1-git-send-email-broonie@kernel.org>
Message-ID: <1387543964-15057-2-git-send-email-broonie@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Mark Brown <broonie@linaro.org>

Will Deacon observed that kvmtool uses a size of 0x200 for virtio
block memory region and that the virtio block spec only uses 31 bytes in
the device specific region at 0x100 so reduce the region to a less
wasteful 0x200.

Signed-off-by: Mark Brown <broonie@linaro.org>
---
 arch/arm64/boot/dts/foundation-v8.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/foundation-v8.dts b/arch/arm64/boot/dts/foundation-v8.dts
index 519c4b2c0687..4a060906809d 100644
--- a/arch/arm64/boot/dts/foundation-v8.dts
+++ b/arch/arm64/boot/dts/foundation-v8.dts
@@ -224,7 +224,7 @@
 
 			virtio_block at 0130000 {
 				compatible = "virtio,mmio";
-				reg = <0x130000 0x1000>;
+				reg = <0x130000 0x200>;
 				interrupts = <42>;
 			};
 		};
-- 
1.8.5.2
