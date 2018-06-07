From: manish.narani@xilinx.com (Manish Narani)
Date: Thu, 7 Jun 2018 17:41:38 +0530
Subject: [RFC PATCH 1/3] arm64: zynqmp: dt: Add support for setting SD tap
 delays
Message-ID: <1528373500-24663-1-git-send-email-manish.narani@xilinx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds support for setting SD tap delays from Device Tree.
Earlier, these tap values were made static via macros in the driver.
So changing the tap values in the device tree makes the driver free
from handling different tap values inside it.

Signed-off-by: Manish Narani <manish.narani@xilinx.com>
---
 arch/arm64/boot/dts/xilinx/zynqmp.dtsi | 40 ++++++++++++++++++++++++++++++++++
 1 file changed, 40 insertions(+)

diff --git a/arch/arm64/boot/dts/xilinx/zynqmp.dtsi b/arch/arm64/boot/dts/xilinx/zynqmp.dtsi
index a091e6f..696aac8 100644
--- a/arch/arm64/boot/dts/xilinx/zynqmp.dtsi
+++ b/arch/arm64/boot/dts/xilinx/zynqmp.dtsi
@@ -491,6 +491,26 @@
                        interrupts = <0 48 4>;
                        reg = <0x0 0xff160000 0x0 0x1000>;
                        clock-names = "clk_xin", "clk_ahb";
+                       xlnx,itap_delay_sd_hsd = <0x15>;
+                       xlnx,otap_delay_sd_hsd = <0x5>;
+                       xlnx,itap_delay_sdr25 = <0x15>;
+                       xlnx,otap_delay_sdr25 = <0x5>;
+                       xlnx,itap_delay_sdr50 = <0>;
+                       xlnx,otap_delay_sdr50 = <0x3>;
+                       xlnx,itap_delay_sd_ddr50 = <0x3D>;
+                       xlnx,otap_delay_sd_ddr50 = <0x4>;
+                       xlnx,itap_delay_mmc_hsd = <0x15>;
+                       xlnx,otap_delay_mmc_hsd = <0x6>;
+                       xlnx,itap_delay_mmc_ddr50 = <0x12>;
+                       xlnx,otap_delay_mmc_ddr50 = <0x6>;
+                       xlnx,itap_delay_sdr104_b0 = <0>;
+                       xlnx,otap_delay_sdr104_b0 = <0x3>;
+                       xlnx,itap_delay_sdr104_b2 = <0>;
+                       xlnx,otap_delay_sdr104_b2 = <0x2>;
+                       xlnx,itap_delay_mmc_hs200_b0 = <0>;
+                       xlnx,otap_delay_mmc_hs200_b0 = <0x3>;
+                       xlnx,itap_delay_mmc_hs200_b2 = <0>;
+                       xlnx,otap_delay_mmc_hs200_b2 = <0x2>;
                };

                sdhci1: sdhci at ff170000 {
@@ -500,6 +520,26 @@
                        interrupts = <0 49 4>;
                        reg = <0x0 0xff170000 0x0 0x1000>;
                        clock-names = "clk_xin", "clk_ahb";
+                       xlnx,itap_delay_sd_hsd = <0x15>;
+                       xlnx,otap_delay_sd_hsd = <0x5>;
+                       xlnx,itap_delay_sdr25 = <0x15>;
+                       xlnx,otap_delay_sdr25 = <0x5>;
+                       xlnx,itap_delay_sdr50 = <0>;
+                       xlnx,otap_delay_sdr50 = <0x3>;
+                       xlnx,itap_delay_sd_ddr50 = <0x3D>;
+                       xlnx,otap_delay_sd_ddr50 = <0x4>;
+                       xlnx,itap_delay_mmc_hsd = <0x15>;
+                       xlnx,otap_delay_mmc_hsd = <0x6>;
+                       xlnx,itap_delay_mmc_ddr50 = <0x12>;
+                       xlnx,otap_delay_mmc_ddr50 = <0x6>;
+                       xlnx,itap_delay_sdr104_b0 = <0>;
+                       xlnx,otap_delay_sdr104_b0 = <0x3>;
+                       xlnx,itap_delay_sdr104_b2 = <0>;
+                       xlnx,otap_delay_sdr104_b2 = <0x2>;
+                       xlnx,itap_delay_mmc_hs200_b0 = <0>;
+                       xlnx,otap_delay_mmc_hs200_b0 = <0x3>;
+                       xlnx,itap_delay_mmc_hs200_b2 = <0>;
+                       xlnx,otap_delay_mmc_hs200_b2 = <0x2>;
                };

                smmu: smmu at fd800000 {
--
2.7.4

This email and any attachments are intended for the sole use of the named recipient(s) and contain(s) confidential information that may be proprietary, privileged or copyrighted under applicable law. If you are not the intended recipient, do not read, copy, or forward this email message or any attachments. Delete this email message and any attachments immediately.
