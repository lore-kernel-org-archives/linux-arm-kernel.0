From: santosh.shilimkar@ti.com (Santosh Shilimkar)
Date: Wed, 20 Feb 2013 21:08:55 +0530
Subject: [PATCH 8/8] ARM: dts: OMAP5: Add ocp address space for all hwmods
In-Reply-To: <1361374735-22018-1-git-send-email-santosh.shilimkar@ti.com>
References: <1361374735-22018-1-git-send-email-santosh.shilimkar@ti.com>
Message-ID: <1361374735-22018-9-git-send-email-santosh.shilimkar@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Patch adds the OCP address space for all missing hwmod from existing
DT file. Note that the compatible isn't added by purpose to ensure that for
these hwmod, devices are not getting created.

Cc: Benoit Cousson <b-cousson@ti.com>

Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
---
 arch/arm/boot/dts/omap5.dtsi |  238 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 238 insertions(+)

diff --git a/arch/arm/boot/dts/omap5.dtsi b/arch/arm/boot/dts/omap5.dtsi
index 269a328..915fd11 100644
--- a/arch/arm/boot/dts/omap5.dtsi
+++ b/arch/arm/boot/dts/omap5.dtsi
@@ -500,5 +500,243 @@
 			hw-caps-ll-interface;
 			hw-caps-temp-alert;
 		};
+
+		l4_emif_ocp_fw: l4_emif_ocp_fw at 4a20c000 {
+			reg = <0x4a20c000 0x100>;
+			ti,hwmods = "emif_ocp_fw";
+		};
+
+		mpu_l3_main_1: mpu_l3_main_1 at 44000000 {
+			reg = <0x44000000 0x2000>;
+			ti,hwmods = "l3_main_1";
+		};
+
+		mpu_l3_main_2: mpu_l3_main_2 at 44800000 {
+			reg = <0x44800000 0x3000>;
+			ti,hwmods = "l3_main_2";
+		};
+
+		mpu_l3_main_3: mpu_l3_main_3 at 45000000 {
+			reg = <0x44800000 0x4000>;
+			ti,hwmods = "l3_main_3";
+		};
+
+		l4_ocp_wp_noc: l4_ocp_wp_noc at 4a102000 {
+			reg = <0x44800000 0x80>;
+			ti,hwmods = "ocp_wp_noc";
+		};
+
+		abe_aess: abe_aess at 401f1000 {
+			reg = <0x44800000 0x400>;
+			ti,hwmods = "aess";
+		};
+
+		c2c: c2c at 5c000000 {
+			reg = <0x5c000000 0x100>;
+			ti,hwmods = "c2c";
+		};
+
+		ctrl_module_core: ctrl_module_core at 4a002000 {
+			reg = <0x4a002000 0x800>,
+			      <0x4a002800 0x1000>;
+			ti,hwmods = "ctrl_module_core";
+		};
+
+		ctrl_module_wkup: ctrl_module_wkup at 4a002000 {
+			reg = <0x4ae0c000 0x800>,
+			      <0x4ae0c800 0x800>;
+			ti,hwmods = "ctrl_module_wkup";
+		};
+
+		dss: dss at 58000000 {
+			reg = <0x58000000 0x80>;
+			ti,hwmods = "dss_core";
+		};
+
+		dss_dispc: dss_dispc at 58001000 {
+			reg = <0x58001000 0x1000>;
+			ti,hwmods = "dss_dispc";
+		};
+
+		dss_dsi1_a: dss_dsi1_a at 58004000 {
+			reg = <0x58004000 0x200>;
+			ti,hwmods = "dss_dsi1_a";
+		};
+
+		dss_dsi1_b: dss_dsi1_b at 58005000 {
+			reg = <0x58005000 0x200>;
+			ti,hwmods = "dss_dsi1_b";
+		};
+
+		dss_dsi1_c: dss_dsi1_c at 58009000 {
+			reg = <0x58009000 0x200>;
+			ti,hwmods = "dss_dsi1_c";
+		};
+
+		dss_hdmi: dss_hdmi at 58060000 {
+			reg = <0x58060000 0x19000>;
+			ti,hwmods = "dss_hdmi";
+		};
+
+		dss_rfbi: dss_rfbi at 580020000 {
+			reg = <0x58002000 0x100>;
+			ti,hwmods = "dss_rfbi";
+		};
+
+		elm: elm at 48078000 {
+			reg = <0x48078000 0x1000>;
+			ti,hwmods = "elm";
+		};
+
+		fdif: elm at 4a10a000 {
+			reg = <0x4a10a000 0x200>;
+			ti,hwmods = "fdif";
+		};
+
+		gpmc: gpmc at 50000000 {
+			reg = <0x50000000 0x400>;
+			ti,hwmods = "gpmc";
+		};
+
+		gpu: gpu at 5600fe00 {
+			reg = <0x5600fe00 0x2000>;
+			ti,hwmods = "gpu";
+		};
+
+
+		hdq1w: hdq1w at 480b2000 {
+			reg = <0x480b2000 0x20>;
+			ti,hwmods = "hdq1w";
+		};
+
+		hsi: hsi at 4a05a000 {
+			reg = <0x4a05a000 0x2000>;
+			ti,hwmods = "hsi";
+		};
+
+		ipu: ipu at 55082000 {
+			reg = <0x55082000 0x100>;
+			ti,hwmods = "ipu";
+		};
+
+		intc_ipu_c0: intc_ipu_c0 at 48211000 {
+			reg = <0x48211000 0x2000>;
+			ti,hwmods = "intc_ipu_c0";
+		};
+
+		intc_ipu_c1: intc_ipu_c1 at 48211000 {
+			reg = <0x48211000 0x2000>;
+			ti,hwmods = "intc_ipu_c1";
+		};
+
+		mmu_ipu: mmu_ipu at 55080800 {
+			reg = <0x55080800 0x1000>;
+			ti,hwmods = "mmu_ipu";
+		};
+
+		iss: iss at 52000000 {
+			reg = <0x52000000 0x20>;
+			ti,hwmods = "iss";
+		};
+
+		iva: iva at 5a05a400 {
+			reg = <0x5a05a400 0x80>;
+			ti,hwmods = "iva";
+		};
+
+		mailbox: mailbox at 4a0f4000 {
+			reg = <0x4a0f4000 0x200>;
+			ti,hwmods = "mailbox";
+		};
+
+		mcasp: mcasp at 40128000 {
+			reg = <0x40128000 0x400>;
+			ti,hwmods = "mcasp";
+		};
+
+		mcspi1: mcspi1 at 48098000 {
+			reg = <0x48098000 0x200>;
+			ti,hwmods = "mcspi1";
+		};
+
+		mcspi2: mcspi2 at 4809a000 {
+			reg = <0x4809a000 0x200>;
+			ti,hwmods = "mcspi2";
+		};
+
+		mcspi3: mcspi3 at 480b8000 {
+			reg = <0x480b8000 0x200>;
+			ti,hwmods = "mcspi3";
+		};
+
+		mcspi4: mcspi4 at 480ba000 {
+			reg = <0x480ba000 0x200>;
+			ti,hwmods = "mcspi4";
+		};
+
+		ocp2scp1: ocp2scp1 at 4a080000 {
+			reg = <0x4a080000 0x20>;
+			ti,hwmods = "ocp2scp1";
+		};
+
+		sata: sata at 4a141100 {
+			reg = <0x4a141100 0x08>;
+			ti,hwmods = "sata";
+		};
+
+		scrm: scrm at 4ae0a000 {
+			reg = <0x4ae0a000 0x800>;
+			ti,hwmods = "scrm";
+		};
+
+		slimbus1: slimbus1 at 4012c000 {
+			reg = <0x4012c000 0x400>;
+			ti,hwmods = "slimbus1";
+		};
+
+		smartreflex_core: smartreflex_core at 4a0dd000 {
+			reg = <0x4a0dd000 0x40>;
+			ti,hwmods = "smartreflex_core";
+		};
+
+		smartreflex_mm: smartreflex_mm at 4a0db000 {
+			reg = <0x4a0db000 0x40>;
+			ti,hwmods = "smartreflex_mm";
+		};
+
+		smartreflex_mpu: smartreflex_mpu at 4a0d9000 {
+			reg = <0x4a0d9000 0x40>;
+			ti,hwmods = "smartreflex_mpu";
+		};
+
+		spinlock: spinlock at 4a0f6000 {
+			reg = <0x4a0f6000 0x1000>;
+			ti,hwmods = "spinlock";
+		};
+
+		usb_host_hs: usb_host_hs at 4a064c00 {
+			reg = <0x4a064c00 0x100>;
+			ti,hwmods = "usb_host_hs";
+		};
+
+		usb_otg_ss: usb_otg_ss at 4a030000 {
+			reg = <0x4a030000 0x100>;
+			ti,hwmods = "usb_otg_ss";
+		};
+
+		usb_tll_hs: usb_tll_hs at 4a062800 {
+			reg = <0x4a062800 0x400>;
+			ti,hwmods = "usb_tll_hs";
+		};
+
+		wd_timer2: wd_timer2 at 4ae14000 {
+			reg = <0x4ae14000 0x80>;
+			ti,hwmods = "wd_timer2";
+		};
+
+		wd_timer3: wd_timer3 at 40130000 {
+			reg = <0x40130000 0x80>;
+			ti,hwmods = "wd_timer3";
+		};
 	};
 };
-- 
1.7.9.5
