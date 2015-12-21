From: jonathanh@nvidia.com (Jon Hunter)
Date: Mon, 21 Dec 2015 13:22:51 +0000
Subject: [PATCH] ARM64: tegra: Add chosen node for tegra132 norrin
Message-ID: <1450704171-8345-1-git-send-email-jonathanh@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The NVIDIA bootloader, nvtboot, expects the "chosen" node to be present
in the device-tree blob and it is not then it fails to boot the kernel.
Add the chosen node so we can boot the kernel on tegra132 norrin with
the nvtboot bootloader.

Signed-off-by: Jon Hunter <jonathanh@nvidia.com>
---
 arch/arm64/boot/dts/nvidia/tegra132-norrin.dts | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/boot/dts/nvidia/tegra132-norrin.dts b/arch/arm64/boot/dts/nvidia/tegra132-norrin.dts
index 7dfe1c085966..62f33fc84e3e 100644
--- a/arch/arm64/boot/dts/nvidia/tegra132-norrin.dts
+++ b/arch/arm64/boot/dts/nvidia/tegra132-norrin.dts
@@ -12,6 +12,8 @@
 		rtc1 = "/rtc at 0,7000e000";
 	};
 
+	chosen { };
+
 	memory {
 		device_type = "memory";
 		reg = <0x0 0x80000000 0x0 0x80000000>;
-- 
2.1.4
