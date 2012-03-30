From: swarren@wwwdotorg.org (Stephen Warren)
Date: Fri, 30 Mar 2012 17:00:04 -0600
Subject: [PATCH 11/11] ARM: dt: tegra20: add pinmux to device tree
In-Reply-To: <1333148404-17691-1-git-send-email-swarren@wwwdotorg.org>
References: <1333148404-17691-1-git-send-email-swarren@wwwdotorg.org>
Message-ID: <1333148404-17691-12-git-send-email-swarren@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Stephen Warren <swarren@nvidia.com>

This adds a complete pinmux configuration to all Tegra20 device tree
files. This allows removal of board-dt-tegra20.c's use of the pinmux
board files, and the special device tree handling in board-pinmux.c.

Signed-off-by: Stephen Warren <swarren@nvidia.com>
---
 arch/arm/boot/dts/tegra-harmony.dts    |  224 +++++++++++++++++++++++++++++
 arch/arm/boot/dts/tegra-paz00.dts      |  220 +++++++++++++++++++++++++++++
 arch/arm/boot/dts/tegra-seaboard.dts   |  243 ++++++++++++++++++++++++++++++++
 arch/arm/boot/dts/tegra-trimslice.dts  |  230 ++++++++++++++++++++++++++++++
 arch/arm/boot/dts/tegra-ventana.dts    |  230 ++++++++++++++++++++++++++++++
 arch/arm/mach-tegra/board-dt-tegra20.c |   30 ----
 arch/arm/mach-tegra/board-pinmux.c     |    4 +-
 7 files changed, 1148 insertions(+), 33 deletions(-)

diff --git a/arch/arm/boot/dts/tegra-harmony.dts b/arch/arm/boot/dts/tegra-harmony.dts
index 6e8447d..1a0b1f1 100644
--- a/arch/arm/boot/dts/tegra-harmony.dts
+++ b/arch/arm/boot/dts/tegra-harmony.dts
@@ -10,6 +10,230 @@
 		reg = < 0x00000000 0x40000000 >;
 	};
 
+	pinmux at 70000000 {
+		pinctrl-names = "default";
+		pinctrl-0 = <&state_default>;
+
+		state_default: pinmux {
+			ata {
+				nvidia,pins = "ata";
+				nvidia,function = "ide";
+			};
+			atb {
+				nvidia,pins = "atb", "gma", "gme";
+				nvidia,function = "sdio4";
+			};
+			atc {
+				nvidia,pins = "atc";
+				nvidia,function = "nand";
+			};
+			atd {
+				nvidia,pins = "atd", "ate", "gmb", "gmd", "gpu",
+					"spia", "spib", "spic";
+				nvidia,function = "gmi";
+			};
+			cdev1 {
+				nvidia,pins = "cdev1";
+				nvidia,function = "plla_out";
+			};
+			cdev2 {
+				nvidia,pins = "cdev2";
+				nvidia,function = "pllp_out4";
+			};
+			crtp {
+				nvidia,pins = "crtp";
+				nvidia,function = "crt";
+			};
+			csus {
+				nvidia,pins = "csus";
+				nvidia,function = "vi_sensor_clk";
+			};
+			dap1 {
+				nvidia,pins = "dap1";
+				nvidia,function = "dap1";
+			};
+			dap2 {
+				nvidia,pins = "dap2";
+				nvidia,function = "dap2";
+			};
+			dap3 {
+				nvidia,pins = "dap3";
+				nvidia,function = "dap3";
+			};
+			dap4 {
+				nvidia,pins = "dap4";
+				nvidia,function = "dap4";
+			};
+			ddc {
+				nvidia,pins = "ddc";
+				nvidia,function = "i2c2";
+			};
+			dta {
+				nvidia,pins = "dta", "dtd";
+				nvidia,function = "sdio2";
+			};
+			dtb {
+				nvidia,pins = "dtb", "dtc", "dte";
+				nvidia,function = "rsvd1";
+			};
+			dtf {
+				nvidia,pins = "dtf";
+				nvidia,function = "i2c3";
+			};
+			gmc {
+				nvidia,pins = "gmc";
+				nvidia,function = "uartd";
+			};
+			gpu7 {
+				nvidia,pins = "gpu7";
+				nvidia,function = "rtck";
+			};
+			gpv {
+				nvidia,pins = "gpv", "slxa", "slxk";
+				nvidia,function = "pcie";
+			};
+			hdint {
+				nvidia,pins = "hdint", "pta";
+				nvidia,function = "hdmi";
+			};
+			i2cp {
+				nvidia,pins = "i2cp";
+				nvidia,function = "i2cp";
+			};
+			irrx {
+				nvidia,pins = "irrx", "irtx";
+				nvidia,function = "uarta";
+			};
+			kbca {
+				nvidia,pins = "kbca", "kbcb", "kbcc", "kbcd",
+					"kbce", "kbcf";
+				nvidia,function = "kbc";
+			};
+			lcsn {
+				nvidia,pins = "lcsn", "ld0", "ld1", "ld2",
+					"ld3", "ld4", "ld5", "ld6", "ld7",
+					"ld8", "ld9", "ld10", "ld11", "ld12",
+					"ld13", "ld14", "ld15", "ld16", "ld17",
+					"ldc", "ldi", "lhp0", "lhp1", "lhp2",
+					"lhs", "lm0", "lm1", "lpp", "lpw0",
+					"lpw1", "lpw2", "lsc0", "lsc1", "lsck",
+					"lsda", "lsdi", "lspi", "lvp0", "lvp1",
+					"lvs";
+				nvidia,function = "displaya";
+			};
+			owc {
+				nvidia,pins = "owc", "spdi", "spdo", "uac";
+				nvidia,function = "rsvd2";
+			};
+			pmc {
+				nvidia,pins = "pmc";
+				nvidia,function = "pwr_on";
+			};
+			rm {
+				nvidia,pins = "rm";
+				nvidia,function = "i2c1";
+			};
+			sdb {
+				nvidia,pins = "sdb", "sdc", "sdd";
+				nvidia,function = "pwm";
+			};
+			sdio1 {
+				nvidia,pins = "sdio1";
+				nvidia,function = "sdio1";
+			};
+			slxc {
+				nvidia,pins = "slxc", "slxd";
+				nvidia,function = "spdif";
+			};
+			spid {
+				nvidia,pins = "spid", "spie", "spif";
+				nvidia,function = "spi1";
+			};
+			spig {
+				nvidia,pins = "spig", "spih";
+				nvidia,function = "spi2_alt";
+			};
+			uaa {
+				nvidia,pins = "uaa", "uab", "uda";
+				nvidia,function = "ulpi";
+			};
+			uad {
+				nvidia,pins = "uad";
+				nvidia,function = "irda";
+			};
+			uca {
+				nvidia,pins = "uca", "ucb";
+				nvidia,function = "uartc";
+			};
+			conf_ata {
+				nvidia,pins = "ata", "atb", "atc", "atd", "ate",
+					"cdev1", "dap1", "dtb", "gma", "gmb",
+					"gmc", "gmd", "gme", "gpu7", "gpv",
+					"i2cp", "pta", "rm", "slxa", "slxk",
+					"spia", "spib";
+				nvidia,pull = <0>;
+				nvidia,tristate = <0>;
+			};
+			conf_cdev2 {
+				nvidia,pins = "cdev2", "csus", "spid", "spif";
+				nvidia,pull = <1>;
+				nvidia,tristate = <1>;
+			};
+			conf_ck32 {
+				nvidia,pins = "ck32", "ddrc", "pmca", "pmcb",
+					"pmcc", "pmcd", "pmce", "xm2c", "xm2d";
+				nvidia,pull = <0>;
+			};
+			conf_crtp {
+				nvidia,pins = "crtp", "dap2", "dap3", "dap4",
+					"dtc", "dte", "dtf", "gpu", "sdio1",
+					"slxc", "slxd", "spdi", "spdo", "spig",
+					"uac", "uda";
+				nvidia,pull = <0>;
+				nvidia,tristate = <1>;
+			};
+			conf_ddc {
+				nvidia,pins = "ddc", "dta", "dtd", "kbca",
+					"kbcb", "kbcc", "kbcd", "kbce", "kbcf",
+					"sdc";
+				nvidia,pull = <2>;
+				nvidia,tristate = <0>;
+			};
+			conf_hdint {
+				nvidia,pins = "hdint", "lcsn", "ldc", "lm1",
+					"lpw1", "lsc1", "lsck", "lsda", "lsdi",
+					"lvp0", "owc", "sdb";
+				nvidia,tristate = <1>;
+			};
+			conf_irrx {
+				nvidia,pins = "irrx", "irtx", "sdd", "spic",
+					"spie", "spih", "uaa", "uab", "uad",
+					"uca", "ucb";
+				nvidia,pull = <2>;
+				nvidia,tristate = <1>;
+			};
+			conf_lc {
+				nvidia,pins = "lc", "ls";
+				nvidia,pull = <2>;
+			};
+			conf_ld0 {
+				nvidia,pins = "ld0", "ld1", "ld2", "ld3", "ld4",
+					"ld5", "ld6", "ld7", "ld8", "ld9",
+					"ld10", "ld11", "ld12", "ld13", "ld14",
+					"ld15", "ld16", "ld17", "ldi", "lhp0",
+					"lhp1", "lhp2", "lhs", "lm0", "lpp",
+					"lpw0", "lpw2", "lsc0", "lspi", "lvp1",
+					"lvs", "pmc";
+				nvidia,tristate = <0>;
+			};
+			conf_ld17_0 {
+				nvidia,pins = "ld17_0", "ld19_18", "ld21_20",
+					"ld23_22";
+				nvidia,pull = <1>;
+			};
+		};
+	};
+
 	pmc at 7000f400 {
 		nvidia,invert-interrupt;
 	};
diff --git a/arch/arm/boot/dts/tegra-paz00.dts b/arch/arm/boot/dts/tegra-paz00.dts
index 6c02abb..10943fb 100644
--- a/arch/arm/boot/dts/tegra-paz00.dts
+++ b/arch/arm/boot/dts/tegra-paz00.dts
@@ -10,6 +10,226 @@
 		reg = <0x00000000 0x20000000>;
 	};
 
+	pinmux at 70000000 {
+		pinctrl-names = "default";
+		pinctrl-0 = <&state_default>;
+
+		state_default: pinmux {
+			ata {
+				nvidia,pins = "ata", "atc", "atd", "ate",
+					"dap2", "gmb", "gmc", "gmd", "spia",
+					"spib", "spic", "spid", "spie";
+				nvidia,function = "gmi";
+			};
+			atb {
+				nvidia,pins = "atb", "gma", "gme";
+				nvidia,function = "sdio4";
+			};
+			cdev1 {
+				nvidia,pins = "cdev1";
+				nvidia,function = "plla_out";
+			};
+			cdev2 {
+				nvidia,pins = "cdev2";
+				nvidia,function = "pllp_out4";
+			};
+			crtp {
+				nvidia,pins = "crtp";
+				nvidia,function = "crt";
+			};
+			csus {
+				nvidia,pins = "csus";
+				nvidia,function = "pllc_out1";
+			};
+			dap1 {
+				nvidia,pins = "dap1";
+				nvidia,function = "dap1";
+			};
+			dap3 {
+				nvidia,pins = "dap3";
+				nvidia,function = "dap3";
+			};
+			dap4 {
+				nvidia,pins = "dap4";
+				nvidia,function = "dap4";
+			};
+			ddc {
+				nvidia,pins = "ddc";
+				nvidia,function = "i2c2";
+			};
+			dta {
+				nvidia,pins = "dta", "dtb", "dtc", "dtd", "dte";
+				nvidia,function = "rsvd1";
+			};
+			dtf {
+				nvidia,pins = "dtf";
+				nvidia,function = "i2c3";
+			};
+			gpu {
+				nvidia,pins = "gpu", "sdb", "sdd";
+				nvidia,function = "pwm";
+			};
+			gpu7 {
+				nvidia,pins = "gpu7";
+				nvidia,function = "rtck";
+			};
+			gpv {
+				nvidia,pins = "gpv", "slxa", "slxk";
+				nvidia,function = "pcie";
+			};
+			hdint {
+				nvidia,pins = "hdint", "pta";
+				nvidia,function = "hdmi";
+			};
+			i2cp {
+				nvidia,pins = "i2cp";
+				nvidia,function = "i2cp";
+			};
+			irrx {
+				nvidia,pins = "irrx", "irtx";
+				nvidia,function = "uarta";
+			};
+			kbca {
+				nvidia,pins = "kbca", "kbcc", "kbce", "kbcf";
+				nvidia,function = "kbc";
+			};
+			kbcb {
+				nvidia,pins = "kbcb", "kbcd";
+				nvidia,function = "sdio2";
+			};
+			lcsn {
+				nvidia,pins = "lcsn", "ld0", "ld1", "ld2",
+					"ld3", "ld4", "ld5", "ld6", "ld7",
+					"ld8", "ld9", "ld10", "ld11", "ld12",
+					"ld13", "ld14", "ld15", "ld16", "ld17",
+					"ldc", "ldi", "lhp0", "lhp1", "lhp2",
+					"lhs", "lm0", "lm1", "lpp", "lpw0",
+					"lpw1", "lpw2", "lsc0", "lsc1", "lsck",
+					"lsda", "lsdi", "lspi", "lvp0", "lvp1",
+					"lvs";
+				nvidia,function = "displaya";
+			};
+			owc {
+				nvidia,pins = "owc";
+				nvidia,function = "owr";
+			};
+			pmc {
+				nvidia,pins = "pmc";
+				nvidia,function = "pwr_on";
+			};
+			rm {
+				nvidia,pins = "rm";
+				nvidia,function = "i2c1";
+			};
+			sdc {
+				nvidia,pins = "sdc";
+				nvidia,function = "twc";
+			};
+			sdio1 {
+				nvidia,pins = "sdio1";
+				nvidia,function = "sdio1";
+			};
+			slxc {
+				nvidia,pins = "slxc", "slxd";
+				nvidia,function = "spi4";
+			};
+			spdi {
+				nvidia,pins = "spdi", "spdo";
+				nvidia,function = "rsvd2";
+			};
+			spif {
+				nvidia,pins = "spif", "uac";
+				nvidia,function = "rsvd4";
+			};
+			spig {
+				nvidia,pins = "spig", "spih";
+				nvidia,function = "spi2_alt";
+			};
+			uaa {
+				nvidia,pins = "uaa", "uab", "uda";
+				nvidia,function = "ulpi";
+			};
+			uad {
+				nvidia,pins = "uad";
+				nvidia,function = "spdif";
+			};
+			uca {
+				nvidia,pins = "uca", "ucb";
+				nvidia,function = "uartc";
+			};
+			conf_ata {
+				nvidia,pins = "ata", "atb", "atc", "atd", "ate",
+					"cdev1", "dap1", "dap2", "dtf", "gma",
+					"gmb", "gmc", "gmd", "gme", "gpu",
+					"gpu7", "gpv", "i2cp", "pta", "rm",
+					"sdio1", "slxk", "spdo", "uac", "uda";
+				nvidia,pull = <0>;
+				nvidia,tristate = <0>;
+			};
+			conf_cdev2 {
+				nvidia,pins = "cdev2";
+				nvidia,pull = <1>;
+				nvidia,tristate = <0>;
+			};
+			conf_ck32 {
+				nvidia,pins = "ck32", "ddrc", "pmca", "pmcb",
+					"pmcc", "pmcd", "pmce", "xm2c", "xm2d";
+				nvidia,pull = <0>;
+			};
+			conf_crtp {
+				nvidia,pins = "crtp", "dap3", "dap4", "dtb",
+					"dtc", "dte", "slxa", "slxc", "slxd",
+					"spdi";
+				nvidia,pull = <0>;
+				nvidia,tristate = <1>;
+			};
+			conf_csus {
+				nvidia,pins = "csus", "spia", "spib", "spid",
+					"spif";
+				nvidia,pull = <1>;
+				nvidia,tristate = <1>;
+			};
+			conf_ddc {
+				nvidia,pins = "ddc", "irrx", "irtx", "kbca",
+					"kbcb", "kbcc", "kbcd", "kbce", "kbcf",
+					"spic", "spig", "uaa", "uab";
+				nvidia,pull = <2>;
+				nvidia,tristate = <0>;
+			};
+			conf_dta {
+				nvidia,pins = "dta", "dtd", "owc", "sdc", "sdd",
+					"spie", "spih", "uad", "uca", "ucb";
+				nvidia,pull = <2>;
+				nvidia,tristate = <1>;
+			};
+			conf_hdint {
+				nvidia,pins = "hdint", "ld0", "ld1", "ld2",
+					"ld3", "ld4", "ld5", "ld6", "ld7",
+					"ld8", "ld9", "ld10", "ld11", "ld12",
+					"ld13", "ld14", "ld15", "ld16", "ld17",
+					"ldc", "ldi", "lhs", "lsc0", "lspi",
+					"lvs", "pmc";
+				nvidia,tristate = <0>;
+			};
+			conf_lc {
+				nvidia,pins = "lc", "ls";
+				nvidia,pull = <2>;
+			};
+			conf_lcsn {
+				nvidia,pins = "lcsn", "lhp0", "lhp1", "lhp2",
+					"lm0", "lm1", "lpp", "lpw0", "lpw1",
+					"lpw2", "lsc1", "lsck", "lsda", "lsdi",
+					"lvp0", "lvp1", "sdb";
+				nvidia,tristate = <1>;
+			};
+			conf_ld17_0 {
+				nvidia,pins = "ld17_0", "ld19_18", "ld21_20",
+					"ld23_22";
+				nvidia,pull = <1>;
+			};
+		};
+	};
+
 	i2c at 7000c000 {
 		clock-frequency = <400000>;
 
diff --git a/arch/arm/boot/dts/tegra-seaboard.dts b/arch/arm/boot/dts/tegra-seaboard.dts
index dbf1c5a..ec33116 100644
--- a/arch/arm/boot/dts/tegra-seaboard.dts
+++ b/arch/arm/boot/dts/tegra-seaboard.dts
@@ -11,6 +11,249 @@
 		reg = < 0x00000000 0x40000000 >;
 	};
 
+	pinmux at 70000000 {
+		pinctrl-names = "default";
+		pinctrl-0 = <&state_default>;
+
+		state_default: pinmux {
+			ata {
+				nvidia,pins = "ata";
+				nvidia,function = "ide";
+			};
+			atb {
+				nvidia,pins = "atb", "gma", "gme";
+				nvidia,function = "sdio4";
+			};
+			atc {
+				nvidia,pins = "atc";
+				nvidia,function = "nand";
+			};
+			atd {
+				nvidia,pins = "atd", "ate", "gmb", "spia",
+					"spib", "spic";
+				nvidia,function = "gmi";
+			};
+			cdev1 {
+				nvidia,pins = "cdev1";
+				nvidia,function = "plla_out";
+			};
+			cdev2 {
+				nvidia,pins = "cdev2";
+				nvidia,function = "pllp_out4";
+			};
+			crtp {
+				nvidia,pins = "crtp", "lm1";
+				nvidia,function = "crt";
+			};
+			csus {
+				nvidia,pins = "csus";
+				nvidia,function = "vi_sensor_clk";
+			};
+			dap1 {
+				nvidia,pins = "dap1";
+				nvidia,function = "dap1";
+			};
+			dap2 {
+				nvidia,pins = "dap2";
+				nvidia,function = "dap2";
+			};
+			dap3 {
+				nvidia,pins = "dap3";
+				nvidia,function = "dap3";
+			};
+			dap4 {
+				nvidia,pins = "dap4";
+				nvidia,function = "dap4";
+			};
+			ddc {
+				nvidia,pins = "ddc", "owc", "spdi", "spdo",
+					"uac";
+				nvidia,function = "rsvd2";
+			};
+			dta {
+				nvidia,pins = "dta", "dtb", "dtc", "dtd", "dte";
+				nvidia,function = "vi";
+			};
+			dtf {
+				nvidia,pins = "dtf";
+				nvidia,function = "i2c3";
+			};
+			gmc {
+				nvidia,pins = "gmc";
+				nvidia,function = "uartd";
+			};
+			gmd {
+				nvidia,pins = "gmd";
+				nvidia,function = "sflash";
+			};
+			gpu {
+				nvidia,pins = "gpu";
+				nvidia,function = "pwm";
+			};
+			gpu7 {
+				nvidia,pins = "gpu7";
+				nvidia,function = "rtck";
+			};
+			gpv {
+				nvidia,pins = "gpv", "slxa", "slxk";
+				nvidia,function = "pcie";
+			};
+			hdint {
+				nvidia,pins = "hdint", "lpw0", "lpw2", "lsc1",
+					"lsck", "lsda", "pta";
+				nvidia,function = "hdmi";
+			};
+			i2cp {
+				nvidia,pins = "i2cp";
+				nvidia,function = "i2cp";
+			};
+			irrx {
+				nvidia,pins = "irrx", "irtx";
+				nvidia,function = "uartb";
+			};
+			kbca {
+				nvidia,pins = "kbca", "kbcb", "kbcc", "kbcd",
+					"kbce", "kbcf";
+				nvidia,function = "kbc";
+			};
+			lcsn {
+				nvidia,pins = "lcsn", "ldc", "lm0", "lpw1",
+					"lsdi", "lvp0";
+				nvidia,function = "rsvd4";
+			};
+			ld0 {
+				nvidia,pins = "ld0", "ld1", "ld2", "ld3", "ld4",
+					"ld5", "ld6", "ld7", "ld8", "ld9",
+					"ld10", "ld11", "ld12", "ld13", "ld14",
+					"ld15", "ld16", "ld17", "ldi", "lhp0",
+					"lhp1", "lhp2", "lhs", "lpp", "lsc0",
+					"lspi", "lvp1", "lvs";
+				nvidia,function = "displaya";
+			};
+			pmc {
+				nvidia,pins = "pmc";
+				nvidia,function = "pwr_on";
+			};
+			rm {
+				nvidia,pins = "rm";
+				nvidia,function = "i2c1";
+			};
+			sdb {
+				nvidia,pins = "sdb", "sdc", "sdd";
+				nvidia,function = "sdio3";
+			};
+			sdio1 {
+				nvidia,pins = "sdio1";
+				nvidia,function = "sdio1";
+			};
+			slxc {
+				nvidia,pins = "slxc", "slxd";
+				nvidia,function = "spdif";
+			};
+			spid {
+				nvidia,pins = "spid", "spie", "spif";
+				nvidia,function = "spi1";
+			};
+			spig {
+				nvidia,pins = "spig", "spih";
+				nvidia,function = "spi2_alt";
+			};
+			uaa {
+				nvidia,pins = "uaa", "uab", "uda";
+				nvidia,function = "ulpi";
+			};
+			uad {
+				nvidia,pins = "uad";
+				nvidia,function = "irda";
+			};
+			uca {
+				nvidia,pins = "uca", "ucb";
+				nvidia,function = "uartc";
+			};
+			conf_ata {
+				nvidia,pins = "ata", "atb", "atc", "atd",
+					"cdev1", "cdev2", "dap1", "dap2",
+					"dap4", "dtf", "gma", "gmc", "gmd",
+					"gme", "gpu", "gpu7", "i2cp", "irrx",
+					"irtx", "pta", "rm", "sdc", "sdd",
+					"slxd", "slxk", "spdi", "spdo", "uac",
+					"uad", "uca", "ucb", "uda";
+				nvidia,pull = <0>;
+				nvidia,tristate = <0>;
+			};
+			conf_ate {
+				nvidia,pins = "ate", "csus", "dap3", "ddc",
+					"gpv", "owc", "slxc", "spib", "spid",
+					"spie";
+				nvidia,pull = <0>;
+				nvidia,tristate = <1>;
+			};
+			conf_ck32 {
+				nvidia,pins = "ck32", "ddrc", "pmca", "pmcb",
+					"pmcc", "pmcd", "pmce", "xm2c", "xm2d";
+				nvidia,pull = <0>;
+			};
+			conf_crtp {
+				nvidia,pins = "crtp", "gmb", "slxa", "spia",
+					"spig", "spih";
+				nvidia,pull = <2>;
+				nvidia,tristate = <1>;
+			};
+			conf_dta {
+				nvidia,pins = "dta", "dtb", "dtc", "dtd";
+				nvidia,pull = <1>;
+				nvidia,tristate = <0>;
+			};
+			conf_dte {
+				nvidia,pins = "dte", "spif";
+				nvidia,pull = <1>;
+				nvidia,tristate = <1>;
+			};
+			conf_hdint {
+				nvidia,pins = "hdint", "lcsn", "ldc", "lm1",
+					"lpw1", "lsc1", "lsck", "lsda", "lsdi",
+					"lvp0";
+				nvidia,tristate = <1>;
+			};
+			conf_kbca {
+				nvidia,pins = "kbca", "kbcb", "kbcc", "kbcd",
+					"kbce", "kbcf", "sdio1", "spic", "uaa",
+					"uab";
+				nvidia,pull = <2>;
+				nvidia,tristate = <0>;
+			};
+			conf_lc {
+				nvidia,pins = "lc", "ls";
+				nvidia,pull = <2>;
+			};
+			conf_ld0 {
+				nvidia,pins = "ld0", "ld1", "ld2", "ld3", "ld4",
+					"ld5", "ld6", "ld7", "ld8", "ld9",
+					"ld10", "ld11", "ld12", "ld13", "ld14",
+					"ld15", "ld16", "ld17", "ldi", "lhp0",
+					"lhp1", "lhp2", "lhs", "lm0", "lpp",
+					"lpw0", "lpw2", "lsc0", "lspi", "lvp1",
+					"lvs", "pmc", "sdb";
+				nvidia,tristate = <0>;
+			};
+			conf_ld17_0 {
+				nvidia,pins = "ld17_0", "ld19_18", "ld21_20",
+					"ld23_22";
+				nvidia,pull = <1>;
+			};
+			drive_sdio1 {
+				nvidia,pins = "drive_sdio1";
+				nvidia,high-speed-mode = <0>;
+				nvidia,schmitt = <0>;
+				nvidia,low-power-mode = <3>;
+				nvidia,pull-down-strength = <31>;
+				nvidia,pull-up-strength = <31>;
+				nvidia,slew-rate-rising = <3>;
+				nvidia,slew-rate-falling = <3>;
+			};
+		};
+	};
+
 	i2c at 7000c000 {
 		clock-frequency = <400000>;
 
diff --git a/arch/arm/boot/dts/tegra-trimslice.dts b/arch/arm/boot/dts/tegra-trimslice.dts
index 2524768..98efd5b 100644
--- a/arch/arm/boot/dts/tegra-trimslice.dts
+++ b/arch/arm/boot/dts/tegra-trimslice.dts
@@ -10,6 +10,236 @@
 		reg = < 0x00000000 0x40000000 >;
 	};
 
+	pinmux at 70000000 {
+		pinctrl-names = "default";
+		pinctrl-0 = <&state_default>;
+
+		state_default: pinmux {
+			ata {
+				nvidia,pins = "ata";
+				nvidia,function = "ide";
+			};
+			atb {
+				nvidia,pins = "atb", "gma";
+				nvidia,function = "sdio4";
+			};
+			atc {
+				nvidia,pins = "atc", "gmb";
+				nvidia,function = "nand";
+			};
+			atd {
+				nvidia,pins = "atd", "ate", "gme", "pta";
+				nvidia,function = "gmi";
+			};
+			cdev1 {
+				nvidia,pins = "cdev1";
+				nvidia,function = "plla_out";
+			};
+			cdev2 {
+				nvidia,pins = "cdev2";
+				nvidia,function = "pllp_out4";
+			};
+			crtp {
+				nvidia,pins = "crtp";
+				nvidia,function = "crt";
+			};
+			csus {
+				nvidia,pins = "csus";
+				nvidia,function = "vi_sensor_clk";
+			};
+			dap1 {
+				nvidia,pins = "dap1";
+				nvidia,function = "dap1";
+			};
+			dap2 {
+				nvidia,pins = "dap2";
+				nvidia,function = "dap2";
+			};
+			dap3 {
+				nvidia,pins = "dap3";
+				nvidia,function = "dap3";
+			};
+			dap4 {
+				nvidia,pins = "dap4";
+				nvidia,function = "dap4";
+			};
+			ddc {
+				nvidia,pins = "ddc";
+				nvidia,function = "i2c2";
+			};
+			dta {
+				nvidia,pins = "dta", "dtb", "dtc", "dtd", "dte";
+				nvidia,function = "vi";
+			};
+			dtf {
+				nvidia,pins = "dtf";
+				nvidia,function = "i2c3";
+			};
+			gmc {
+				nvidia,pins = "gmc", "gmd";
+				nvidia,function = "sflash";
+			};
+			gpu {
+				nvidia,pins = "gpu";
+				nvidia,function = "uarta";
+			};
+			gpu7 {
+				nvidia,pins = "gpu7";
+				nvidia,function = "rtck";
+			};
+			gpv {
+				nvidia,pins = "gpv", "slxa", "slxk";
+				nvidia,function = "pcie";
+			};
+			hdint {
+				nvidia,pins = "hdint";
+				nvidia,function = "hdmi";
+			};
+			i2cp {
+				nvidia,pins = "i2cp";
+				nvidia,function = "i2cp";
+			};
+			irrx {
+				nvidia,pins = "irrx", "irtx";
+				nvidia,function = "uartb";
+			};
+			kbca {
+				nvidia,pins = "kbca", "kbcb", "kbcc", "kbcd",
+					"kbce", "kbcf";
+				nvidia,function = "kbc";
+			};
+			lcsn {
+				nvidia,pins = "lcsn", "ld0", "ld1", "ld2",
+					"ld3", "ld4", "ld5", "ld6", "ld7",
+					"ld8", "ld9", "ld10", "ld11", "ld12",
+					"ld13", "ld14", "ld15", "ld16", "ld17",
+					"ldc", "ldi", "lhp0", "lhp1", "lhp2",
+					"lhs", "lm0", "lm1", "lpp", "lpw0",
+					"lpw1", "lpw2", "lsc0", "lsc1", "lsck",
+					"lsda", "lsdi", "lspi", "lvp0", "lvp1",
+					"lvs";
+				nvidia,function = "displaya";
+			};
+			owc {
+				nvidia,pins = "owc", "uac";
+				nvidia,function = "rsvd2";
+			};
+			pmc {
+				nvidia,pins = "pmc";
+				nvidia,function = "pwr_on";
+			};
+			rm {
+				nvidia,pins = "rm";
+				nvidia,function = "i2c1";
+			};
+			sdb {
+				nvidia,pins = "sdb", "sdc", "sdd";
+				nvidia,function = "pwm";
+			};
+			sdio1 {
+				nvidia,pins = "sdio1";
+				nvidia,function = "sdio1";
+			};
+			slxc {
+				nvidia,pins = "slxc", "slxd";
+				nvidia,function = "sdio3";
+			};
+			spdi {
+				nvidia,pins = "spdi", "spdo";
+				nvidia,function = "spdif";
+			};
+			spia {
+				nvidia,pins = "spia", "spib", "spic";
+				nvidia,function = "spi2";
+			};
+			spid {
+				nvidia,pins = "spid", "spie", "spif";
+				nvidia,function = "spi1";
+			};
+			spig {
+				nvidia,pins = "spig", "spih";
+				nvidia,function = "spi2_alt";
+			};
+			uaa {
+				nvidia,pins = "uaa", "uab", "uda";
+				nvidia,function = "ulpi";
+			};
+			uad {
+				nvidia,pins = "uad";
+				nvidia,function = "irda";
+			};
+			uca {
+				nvidia,pins = "uca", "ucb";
+				nvidia,function = "uartc";
+			};
+			conf_ata {
+				nvidia,pins = "ata", "atc", "atd", "ate",
+					"crtp", "dap2", "dap3", "dap4", "dta",
+					"dtb", "dtc", "dtd", "dte", "gmb",
+					"gme", "i2cp", "pta", "slxc", "slxd",
+					"spdi", "spdo", "uda";
+				nvidia,pull = <0>;
+				nvidia,tristate = <1>;
+			};
+			conf_atb {
+				nvidia,pins = "atb", "cdev1", "dap1", "gma",
+					"gmc", "gmd", "gpu", "gpu7", "gpv",
+					"sdio1", "slxa", "slxk", "uac";
+				nvidia,pull = <0>;
+				nvidia,tristate = <0>;
+			};
+			conf_cdev2 {
+				nvidia,pins = "cdev2", "csus", "spia", "spib",
+					"spid", "spif";
+				nvidia,pull = <1>;
+				nvidia,tristate = <1>;
+			};
+			conf_ck32 {
+				nvidia,pins = "ck32", "ddrc", "pmca", "pmcb",
+					"pmcc", "pmcd", "pmce", "xm2c", "xm2d";
+				nvidia,pull = <0>;
+			};
+			conf_ddc {
+				nvidia,pins = "ddc", "dtf", "rm", "sdc", "sdd";
+				nvidia,pull = <2>;
+				nvidia,tristate = <0>;
+			};
+			conf_hdint {
+				nvidia,pins = "hdint", "lcsn", "ldc", "lm1",
+					"lpw1", "lsc1", "lsck", "lsda", "lsdi",
+					"lvp0", "pmc";
+				nvidia,tristate = <1>;
+			};
+			conf_irrx {
+				nvidia,pins = "irrx", "irtx", "kbca", "kbcb",
+					"kbcc", "kbcd", "kbce", "kbcf", "owc",
+					"spic", "spie", "spig", "spih", "uaa",
+					"uab", "uad", "uca", "ucb";
+				nvidia,pull = <2>;
+				nvidia,tristate = <1>;
+			};
+			conf_lc {
+				nvidia,pins = "lc", "ls";
+				nvidia,pull = <2>;
+			};
+			conf_ld0 {
+				nvidia,pins = "ld0", "ld1", "ld2", "ld3", "ld4",
+					"ld5", "ld6", "ld7", "ld8", "ld9",
+					"ld10", "ld11", "ld12", "ld13", "ld14",
+					"ld15", "ld16", "ld17", "ldi", "lhp0",
+					"lhp1", "lhp2", "lhs", "lm0", "lpp",
+					"lpw0", "lpw2", "lsc0", "lspi", "lvp1",
+					"lvs", "sdb";
+				nvidia,tristate = <0>;
+			};
+			conf_ld17_0 {
+				nvidia,pins = "ld17_0", "ld19_18", "ld21_20",
+					"ld23_22";
+				nvidia,pull = <1>;
+			};
+		};
+	};
+
 	i2c at 7000c000 {
 		clock-frequency = <400000>;
 	};
diff --git a/arch/arm/boot/dts/tegra-ventana.dts b/arch/arm/boot/dts/tegra-ventana.dts
index 2dcff87..71eb2e5 100644
--- a/arch/arm/boot/dts/tegra-ventana.dts
+++ b/arch/arm/boot/dts/tegra-ventana.dts
@@ -10,6 +10,236 @@
 		reg = < 0x00000000 0x40000000 >;
 	};
 
+	pinmux at 70000000 {
+		pinctrl-names = "default";
+		pinctrl-0 = <&state_default>;
+
+		state_default: pinmux {
+			ata {
+				nvidia,pins = "ata";
+				nvidia,function = "ide";
+			};
+			atb {
+				nvidia,pins = "atb", "gma", "gme";
+				nvidia,function = "sdio4";
+			};
+			atc {
+				nvidia,pins = "atc";
+				nvidia,function = "nand";
+			};
+			atd {
+				nvidia,pins = "atd", "ate", "gmb", "spia",
+					"spib", "spic";
+				nvidia,function = "gmi";
+			};
+			cdev1 {
+				nvidia,pins = "cdev1";
+				nvidia,function = "plla_out";
+			};
+			cdev2 {
+				nvidia,pins = "cdev2";
+				nvidia,function = "pllp_out4";
+			};
+			crtp {
+				nvidia,pins = "crtp", "lm1";
+				nvidia,function = "crt";
+			};
+			csus {
+				nvidia,pins = "csus";
+				nvidia,function = "vi_sensor_clk";
+			};
+			dap1 {
+				nvidia,pins = "dap1";
+				nvidia,function = "dap1";
+			};
+			dap2 {
+				nvidia,pins = "dap2";
+				nvidia,function = "dap2";
+			};
+			dap3 {
+				nvidia,pins = "dap3";
+				nvidia,function = "dap3";
+			};
+			dap4 {
+				nvidia,pins = "dap4";
+				nvidia,function = "dap4";
+			};
+			ddc {
+				nvidia,pins = "ddc", "owc", "spdi", "spdo",
+					"uac";
+				nvidia,function = "rsvd2";
+			};
+			dta {
+				nvidia,pins = "dta", "dtb", "dtc", "dtd", "dte";
+				nvidia,function = "vi";
+			};
+			dtf {
+				nvidia,pins = "dtf";
+				nvidia,function = "i2c3";
+			};
+			gmc {
+				nvidia,pins = "gmc";
+				nvidia,function = "uartd";
+			};
+			gmd {
+				nvidia,pins = "gmd";
+				nvidia,function = "sflash";
+			};
+			gpu {
+				nvidia,pins = "gpu";
+				nvidia,function = "pwm";
+			};
+			gpu7 {
+				nvidia,pins = "gpu7";
+				nvidia,function = "rtck";
+			};
+			gpv {
+				nvidia,pins = "gpv", "slxa", "slxk";
+				nvidia,function = "pcie";
+			};
+			hdint {
+				nvidia,pins = "hdint", "pta";
+				nvidia,function = "hdmi";
+			};
+			i2cp {
+				nvidia,pins = "i2cp";
+				nvidia,function = "i2cp";
+			};
+			irrx {
+				nvidia,pins = "irrx", "irtx";
+				nvidia,function = "uartb";
+			};
+			kbca {
+				nvidia,pins = "kbca", "kbcb", "kbcc", "kbcd",
+					"kbce", "kbcf";
+				nvidia,function = "kbc";
+			};
+			lcsn {
+				nvidia,pins = "lcsn", "ldc", "lm0", "lpw1",
+					"lsdi", "lvp0";
+				nvidia,function = "rsvd4";
+			};
+			ld0 {
+				nvidia,pins = "ld0", "ld1", "ld2", "ld3", "ld4",
+					"ld5", "ld6", "ld7", "ld8", "ld9",
+					"ld10", "ld11", "ld12", "ld13", "ld14",
+					"ld15", "ld16", "ld17", "ldi", "lhp0",
+					"lhp1", "lhp2", "lhs", "lpp", "lpw0",
+					"lpw2", "lsc0", "lsc1", "lsck", "lsda",
+					"lspi", "lvp1", "lvs";
+				nvidia,function = "displaya";
+			};
+			pmc {
+				nvidia,pins = "pmc";
+				nvidia,function = "pwr_on";
+			};
+			rm {
+				nvidia,pins = "rm";
+				nvidia,function = "i2c1";
+			};
+			sdb {
+				nvidia,pins = "sdb", "sdc", "sdd", "slxc";
+				nvidia,function = "sdio3";
+			};
+			sdio1 {
+				nvidia,pins = "sdio1";
+				nvidia,function = "sdio1";
+			};
+			slxd {
+				nvidia,pins = "slxd";
+				nvidia,function = "spdif";
+			};
+			spid {
+				nvidia,pins = "spid", "spie", "spif";
+				nvidia,function = "spi1";
+			};
+			spig {
+				nvidia,pins = "spig", "spih";
+				nvidia,function = "spi2_alt";
+			};
+			uaa {
+				nvidia,pins = "uaa", "uab", "uda";
+				nvidia,function = "ulpi";
+			};
+			uad {
+				nvidia,pins = "uad";
+				nvidia,function = "irda";
+			};
+			uca {
+				nvidia,pins = "uca", "ucb";
+				nvidia,function = "uartc";
+			};
+			conf_ata {
+				nvidia,pins = "ata", "atb", "atc", "atd",
+					"cdev1", "cdev2", "dap1", "dap2",
+					"dap4", "ddc", "dtf", "gma", "gmc",
+					"gme", "gpu", "gpu7", "i2cp", "irrx",
+					"irtx", "pta", "rm", "sdc", "sdd",
+					"slxc", "slxd", "slxk", "spdi", "spdo",
+					"uac", "uad", "uca", "ucb", "uda";
+				nvidia,pull = <0>;
+				nvidia,tristate = <0>;
+			};
+			conf_ate {
+				nvidia,pins = "ate", "csus", "dap3", "gmd",
+					"gpv", "owc", "spia", "spib", "spic",
+					"spid", "spie", "spig";
+				nvidia,pull = <0>;
+				nvidia,tristate = <1>;
+			};
+			conf_ck32 {
+				nvidia,pins = "ck32", "ddrc", "pmca", "pmcb",
+					"pmcc", "pmcd", "pmce", "xm2c", "xm2d";
+				nvidia,pull = <0>;
+			};
+			conf_crtp {
+				nvidia,pins = "crtp", "gmb", "slxa", "spih";
+				nvidia,pull = <2>;
+				nvidia,tristate = <1>;
+			};
+			conf_dta {
+				nvidia,pins = "dta", "dtb", "dtc", "dtd";
+				nvidia,pull = <1>;
+				nvidia,tristate = <0>;
+			};
+			conf_dte {
+				nvidia,pins = "dte", "spif";
+				nvidia,pull = <1>;
+				nvidia,tristate = <1>;
+			};
+			conf_hdint {
+				nvidia,pins = "hdint", "lcsn", "ldc", "lm1",
+					"lpw1", "lsck", "lsda", "lsdi", "lvp0";
+				nvidia,tristate = <1>;
+			};
+			conf_kbca {
+				nvidia,pins = "kbca", "kbcb", "kbcc", "kbcd",
+					"kbce", "kbcf", "sdio1", "uaa", "uab";
+				nvidia,pull = <2>;
+				nvidia,tristate = <0>;
+			};
+			conf_lc {
+				nvidia,pins = "lc", "ls";
+				nvidia,pull = <2>;
+			};
+			conf_ld0 {
+				nvidia,pins = "ld0", "ld1", "ld2", "ld3", "ld4",
+					"ld5", "ld6", "ld7", "ld8", "ld9",
+					"ld10", "ld11", "ld12", "ld13", "ld14",
+					"ld15", "ld16", "ld17", "ldi", "lhp0",
+					"lhp1", "lhp2", "lhs", "lm0", "lpp",
+					"lpw0", "lpw2", "lsc0", "lsc1", "lspi",
+					"lvp1", "lvs", "pmc", "sdb";
+				nvidia,tristate = <0>;
+			};
+			conf_ld17_0 {
+				nvidia,pins = "ld17_0", "ld19_18", "ld21_20",
+					"ld23_22";
+				nvidia,pull = <1>;
+			};
+		};
+	};
+
 	i2c at 7000c000 {
 		clock-frequency = <400000>;
 
diff --git a/arch/arm/mach-tegra/board-dt-tegra20.c b/arch/arm/mach-tegra/board-dt-tegra20.c
index 65a5249..5b9d5f4 100644
--- a/arch/arm/mach-tegra/board-dt-tegra20.c
+++ b/arch/arm/mach-tegra/board-dt-tegra20.c
@@ -47,14 +47,7 @@
 #include "clock.h"
 #include "devices.h"
 
-void harmony_pinmux_init(void);
-void paz00_pinmux_init(void);
-void seaboard_pinmux_init(void);
-void trimslice_pinmux_init(void);
-void ventana_pinmux_init(void);
-
 struct of_dev_auxdata tegra20_auxdata_lookup[] __initdata = {
-	OF_DEV_AUXDATA("nvidia,tegra20-pinmux", TEGRA_APB_MISC_BASE + 0x14, "tegra-pinmux", NULL),
 	OF_DEV_AUXDATA("nvidia,tegra20-sdhci", TEGRA_SDMMC1_BASE, "sdhci-tegra.0", NULL),
 	OF_DEV_AUXDATA("nvidia,tegra20-sdhci", TEGRA_SDMMC2_BASE, "sdhci-tegra.1", NULL),
 	OF_DEV_AUXDATA("nvidia,tegra20-sdhci", TEGRA_SDMMC3_BASE, "sdhci-tegra.2", NULL),
@@ -94,33 +87,10 @@ static struct of_device_id tegra_dt_match_table[] __initdata = {
 	{}
 };
 
-static struct {
-	char *machine;
-	void (*init)(void);
-} pinmux_configs[] = {
-	{ "compulab,trimslice", trimslice_pinmux_init },
-	{ "nvidia,harmony", harmony_pinmux_init },
-	{ "compal,paz00", paz00_pinmux_init },
-	{ "nvidia,seaboard", seaboard_pinmux_init },
-	{ "nvidia,ventana", ventana_pinmux_init },
-};
-
 static void __init tegra_dt_init(void)
 {
-	int i;
-
 	tegra_clk_init_from_table(tegra_dt_clk_init_table);
 
-	for (i = 0; i < ARRAY_SIZE(pinmux_configs); i++) {
-		if (of_machine_is_compatible(pinmux_configs[i].machine)) {
-			pinmux_configs[i].init();
-			break;
-		}
-	}
-
-	WARN(i == ARRAY_SIZE(pinmux_configs),
-		"Unknown platform! Pinmuxing not initialized\n");
-
 	/*
 	 * Finished with the static registrations now; fill in the missing
 	 * devices
diff --git a/arch/arm/mach-tegra/board-pinmux.c b/arch/arm/mach-tegra/board-pinmux.c
index 3b7ad07..a5574c7 100644
--- a/arch/arm/mach-tegra/board-pinmux.c
+++ b/arch/arm/mach-tegra/board-pinmux.c
@@ -15,7 +15,6 @@
 #include <linux/device.h>
 #include <linux/kernel.h>
 #include <linux/notifier.h>
-#include <linux/of.h>
 #include <linux/string.h>
 
 #include "board-pinmux.h"
@@ -84,6 +83,5 @@ void tegra_board_pinmux_init(struct tegra_board_pinmux_conf *conf_a,
 	if (conf_b)
 		pinctrl_register_mappings(conf_b->maps, conf_b->map_count);
 
-	if (!of_machine_is_compatible("nvidia,tegra20"))
-		platform_add_devices(devices, ARRAY_SIZE(devices));
+	platform_add_devices(devices, ARRAY_SIZE(devices));
 }
-- 
1.7.0.4
