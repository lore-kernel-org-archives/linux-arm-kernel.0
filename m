From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Tue, 05 Jul 2011 22:47:17 -0400
Subject: [PATCH 32/52] ARM: mach-orion5x: convert boot_params to atag_offset
In-Reply-To: <1309920457-21913-1-git-send-email-nicolas.pitre@linaro.org>
References: <1309920457-21913-1-git-send-email-nicolas.pitre@linaro.org>
Message-ID: <1309920457-21913-32-git-send-email-nicolas.pitre@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Nicolas Pitre <nicolas.pitre@linaro.org>
---
 arch/arm/mach-orion5x/d2net-setup.c            |    4 ++--
 arch/arm/mach-orion5x/db88f5281-setup.c        |    2 +-
 arch/arm/mach-orion5x/dns323-setup.c           |    2 +-
 arch/arm/mach-orion5x/edmini_v2-setup.c        |    2 +-
 arch/arm/mach-orion5x/kurobox_pro-setup.c      |    4 ++--
 arch/arm/mach-orion5x/ls-chl-setup.c           |    2 +-
 arch/arm/mach-orion5x/ls_hgl-setup.c           |    2 +-
 arch/arm/mach-orion5x/lsmini-setup.c           |    2 +-
 arch/arm/mach-orion5x/mss2-setup.c             |    2 +-
 arch/arm/mach-orion5x/mv2120-setup.c           |    2 +-
 arch/arm/mach-orion5x/net2big-setup.c          |    2 +-
 arch/arm/mach-orion5x/rd88f5181l-fxo-setup.c   |    2 +-
 arch/arm/mach-orion5x/rd88f5181l-ge-setup.c    |    2 +-
 arch/arm/mach-orion5x/rd88f5182-setup.c        |    2 +-
 arch/arm/mach-orion5x/rd88f6183ap-ge-setup.c   |    2 +-
 arch/arm/mach-orion5x/terastation_pro2-setup.c |    2 +-
 arch/arm/mach-orion5x/ts209-setup.c            |    2 +-
 arch/arm/mach-orion5x/ts409-setup.c            |    2 +-
 arch/arm/mach-orion5x/ts78xx-setup.c           |    2 +-
 arch/arm/mach-orion5x/wnr854t-setup.c          |    2 +-
 arch/arm/mach-orion5x/wrt350n-v2-setup.c       |    2 +-
 21 files changed, 23 insertions(+), 23 deletions(-)

diff --git a/arch/arm/mach-orion5x/d2net-setup.c b/arch/arm/mach-orion5x/d2net-setup.c
index 19cf5bf..8c83009 100644
--- a/arch/arm/mach-orion5x/d2net-setup.c
+++ b/arch/arm/mach-orion5x/d2net-setup.c
@@ -336,7 +336,7 @@ static void __init d2net_init(void)
 
 #ifdef CONFIG_MACH_D2NET
 MACHINE_START(D2NET, "LaCie d2 Network")
-	.boot_params	= 0x00000100,
+	.atag_offset	= 0x100,
 	.init_machine	= d2net_init,
 	.map_io		= orion5x_map_io,
 	.init_early	= orion5x_init_early,
@@ -348,7 +348,7 @@ MACHINE_END
 
 #ifdef CONFIG_MACH_BIGDISK
 MACHINE_START(BIGDISK, "LaCie Big Disk Network")
-	.boot_params	= 0x00000100,
+	.atag_offset	= 0x100,
 	.init_machine	= d2net_init,
 	.map_io		= orion5x_map_io,
 	.init_early	= orion5x_init_early,
diff --git a/arch/arm/mach-orion5x/db88f5281-setup.c b/arch/arm/mach-orion5x/db88f5281-setup.c
index f95d3cb..5af3a76 100644
--- a/arch/arm/mach-orion5x/db88f5281-setup.c
+++ b/arch/arm/mach-orion5x/db88f5281-setup.c
@@ -358,7 +358,7 @@ static void __init db88f5281_init(void)
 
 MACHINE_START(DB88F5281, "Marvell Orion-2 Development Board")
 	/* Maintainer: Tzachi Perelstein <tzachi@marvell.com> */
-	.boot_params	= 0x00000100,
+	.atag_offset	= 0x100,
 	.init_machine	= db88f5281_init,
 	.map_io		= orion5x_map_io,
 	.init_early	= orion5x_init_early,
diff --git a/arch/arm/mach-orion5x/dns323-setup.c b/arch/arm/mach-orion5x/dns323-setup.c
index 855e0e7..23c46af 100644
--- a/arch/arm/mach-orion5x/dns323-setup.c
+++ b/arch/arm/mach-orion5x/dns323-setup.c
@@ -730,7 +730,7 @@ static void __init dns323_init(void)
 /* Warning: D-Link uses a wrong mach-type (=526) in their bootloader */
 MACHINE_START(DNS323, "D-Link DNS-323")
 	/* Maintainer: Herbert Valerio Riedel <hvr@gnu.org> */
-	.boot_params	= 0x00000100,
+	.atag_offset	= 0x100,
 	.init_machine	= dns323_init,
 	.map_io		= orion5x_map_io,
 	.init_early	= orion5x_init_early,
diff --git a/arch/arm/mach-orion5x/edmini_v2-setup.c b/arch/arm/mach-orion5x/edmini_v2-setup.c
index b67cff0..70a4e92 100644
--- a/arch/arm/mach-orion5x/edmini_v2-setup.c
+++ b/arch/arm/mach-orion5x/edmini_v2-setup.c
@@ -251,7 +251,7 @@ static void __init edmini_v2_init(void)
 /* Warning: LaCie use a wrong mach-type (0x20e=526) in their bootloader. */
 MACHINE_START(EDMINI_V2, "LaCie Ethernet Disk mini V2")
 	/* Maintainer: Christopher Moore <moore@free.fr> */
-	.boot_params	= 0x00000100,
+	.atag_offset	= 0x100,
 	.init_machine	= edmini_v2_init,
 	.map_io		= orion5x_map_io,
 	.init_early	= orion5x_init_early,
diff --git a/arch/arm/mach-orion5x/kurobox_pro-setup.c b/arch/arm/mach-orion5x/kurobox_pro-setup.c
index c0eb646..6323ec3 100644
--- a/arch/arm/mach-orion5x/kurobox_pro-setup.c
+++ b/arch/arm/mach-orion5x/kurobox_pro-setup.c
@@ -379,7 +379,7 @@ static void __init kurobox_pro_init(void)
 #ifdef CONFIG_MACH_KUROBOX_PRO
 MACHINE_START(KUROBOX_PRO, "Buffalo/Revogear Kurobox Pro")
 	/* Maintainer: Ronen Shitrit <rshitrit@marvell.com> */
-	.boot_params	= 0x00000100,
+	.atag_offset	= 0x100,
 	.init_machine	= kurobox_pro_init,
 	.map_io		= orion5x_map_io,
 	.init_early	= orion5x_init_early,
@@ -392,7 +392,7 @@ MACHINE_END
 #ifdef CONFIG_MACH_LINKSTATION_PRO
 MACHINE_START(LINKSTATION_PRO, "Buffalo Linkstation Pro/Live")
 	/* Maintainer: Byron Bradley <byron.bbradley@gmail.com> */
-	.boot_params	= 0x00000100,
+	.atag_offset	= 0x100,
 	.init_machine	= kurobox_pro_init,
 	.map_io		= orion5x_map_io,
 	.init_early	= orion5x_init_early,
diff --git a/arch/arm/mach-orion5x/ls-chl-setup.c b/arch/arm/mach-orion5x/ls-chl-setup.c
index 5065803..9503fff 100644
--- a/arch/arm/mach-orion5x/ls-chl-setup.c
+++ b/arch/arm/mach-orion5x/ls-chl-setup.c
@@ -318,7 +318,7 @@ static void __init lschl_init(void)
 
 MACHINE_START(LINKSTATION_LSCHL, "Buffalo Linkstation LiveV3 (LS-CHL)")
 	/* Maintainer: Ash Hughes <ashley.hughes@blueyonder.co.uk> */
-	.boot_params	= 0x00000100,
+	.atag_offset	= 0x100,
 	.init_machine	= lschl_init,
 	.map_io		= orion5x_map_io,
 	.init_early	= orion5x_init_early,
diff --git a/arch/arm/mach-orion5x/ls_hgl-setup.c b/arch/arm/mach-orion5x/ls_hgl-setup.c
index 8503d0a..ed6d772 100644
--- a/arch/arm/mach-orion5x/ls_hgl-setup.c
+++ b/arch/arm/mach-orion5x/ls_hgl-setup.c
@@ -265,7 +265,7 @@ static void __init ls_hgl_init(void)
 
 MACHINE_START(LINKSTATION_LS_HGL, "Buffalo Linkstation LS-HGL")
 	/* Maintainer: Zhu Qingsen <zhuqs@cn.fujistu.com> */
-	.boot_params	= 0x00000100,
+	.atag_offset	= 0x100,
 	.init_machine	= ls_hgl_init,
 	.map_io		= orion5x_map_io,
 	.init_early	= orion5x_init_early,
diff --git a/arch/arm/mach-orion5x/lsmini-setup.c b/arch/arm/mach-orion5x/lsmini-setup.c
index 9c82723..743f7f1 100644
--- a/arch/arm/mach-orion5x/lsmini-setup.c
+++ b/arch/arm/mach-orion5x/lsmini-setup.c
@@ -267,7 +267,7 @@ static void __init lsmini_init(void)
 #ifdef CONFIG_MACH_LINKSTATION_MINI
 MACHINE_START(LINKSTATION_MINI, "Buffalo Linkstation Mini")
 	/* Maintainer: Alexey Kopytko <alexey@kopytko.ru> */
-	.boot_params	= 0x00000100,
+	.atag_offset	= 0x100,
 	.init_machine	= lsmini_init,
 	.map_io		= orion5x_map_io,
 	.init_early	= orion5x_init_early,
diff --git a/arch/arm/mach-orion5x/mss2-setup.c b/arch/arm/mach-orion5x/mss2-setup.c
index 59263b7..5062060 100644
--- a/arch/arm/mach-orion5x/mss2-setup.c
+++ b/arch/arm/mach-orion5x/mss2-setup.c
@@ -261,7 +261,7 @@ static void __init mss2_init(void)
 
 MACHINE_START(MSS2, "Maxtor Shared Storage II")
 	/* Maintainer: Sylver Bruneau <sylver.bruneau@googlemail.com> */
-	.boot_params	= 0x00000100,
+	.atag_offset	= 0x100,
 	.init_machine	= mss2_init,
 	.map_io		= orion5x_map_io,
 	.init_early	= orion5x_init_early,
diff --git a/arch/arm/mach-orion5x/mv2120-setup.c b/arch/arm/mach-orion5x/mv2120-setup.c
index 63ff10c..b3356ad 100644
--- a/arch/arm/mach-orion5x/mv2120-setup.c
+++ b/arch/arm/mach-orion5x/mv2120-setup.c
@@ -229,7 +229,7 @@ static void __init mv2120_init(void)
 /* Warning: HP uses a wrong mach-type (=526) in their bootloader */
 MACHINE_START(MV2120, "HP Media Vault mv2120")
 	/* Maintainer: Martin Michlmayr <tbm@cyrius.com> */
-	.boot_params	= 0x00000100,
+	.atag_offset	= 0x100,
 	.init_machine	= mv2120_init,
 	.map_io		= orion5x_map_io,
 	.init_early	= orion5x_init_early,
diff --git a/arch/arm/mach-orion5x/net2big-setup.c b/arch/arm/mach-orion5x/net2big-setup.c
index e43b39c..6197c79 100644
--- a/arch/arm/mach-orion5x/net2big-setup.c
+++ b/arch/arm/mach-orion5x/net2big-setup.c
@@ -419,7 +419,7 @@ static void __init net2big_init(void)
 
 /* Warning: LaCie use a wrong mach-type (0x20e=526) in their bootloader. */
 MACHINE_START(NET2BIG, "LaCie 2Big Network")
-	.boot_params	= 0x00000100,
+	.atag_offset	= 0x100,
 	.init_machine	= net2big_init,
 	.map_io		= orion5x_map_io,
 	.init_early	= orion5x_init_early,
diff --git a/arch/arm/mach-orion5x/rd88f5181l-fxo-setup.c b/arch/arm/mach-orion5x/rd88f5181l-fxo-setup.c
index 9eec7c2..e241b55 100644
--- a/arch/arm/mach-orion5x/rd88f5181l-fxo-setup.c
+++ b/arch/arm/mach-orion5x/rd88f5181l-fxo-setup.c
@@ -169,7 +169,7 @@ subsys_initcall(rd88f5181l_fxo_pci_init);
 
 MACHINE_START(RD88F5181L_FXO, "Marvell Orion-VoIP FXO Reference Design")
 	/* Maintainer: Nicolas Pitre <nico@marvell.com> */
-	.boot_params	= 0x00000100,
+	.atag_offset	= 0x100,
 	.init_machine	= rd88f5181l_fxo_init,
 	.map_io		= orion5x_map_io,
 	.init_early	= orion5x_init_early,
diff --git a/arch/arm/mach-orion5x/rd88f5181l-ge-setup.c b/arch/arm/mach-orion5x/rd88f5181l-ge-setup.c
index 0cc90bb..7ef3e43 100644
--- a/arch/arm/mach-orion5x/rd88f5181l-ge-setup.c
+++ b/arch/arm/mach-orion5x/rd88f5181l-ge-setup.c
@@ -181,7 +181,7 @@ subsys_initcall(rd88f5181l_ge_pci_init);
 
 MACHINE_START(RD88F5181L_GE, "Marvell Orion-VoIP GE Reference Design")
 	/* Maintainer: Lennert Buytenhek <buytenh@marvell.com> */
-	.boot_params	= 0x00000100,
+	.atag_offset	= 0x100,
 	.init_machine	= rd88f5181l_ge_init,
 	.map_io		= orion5x_map_io,
 	.init_early	= orion5x_init_early,
diff --git a/arch/arm/mach-orion5x/rd88f5182-setup.c b/arch/arm/mach-orion5x/rd88f5182-setup.c
index 48da39b..3352c07 100644
--- a/arch/arm/mach-orion5x/rd88f5182-setup.c
+++ b/arch/arm/mach-orion5x/rd88f5182-setup.c
@@ -305,7 +305,7 @@ static void __init rd88f5182_init(void)
 
 MACHINE_START(RD88F5182, "Marvell Orion-NAS Reference Design")
 	/* Maintainer: Ronen Shitrit <rshitrit@marvell.com> */
-	.boot_params	= 0x00000100,
+	.atag_offset	= 0x100,
 	.init_machine	= rd88f5182_init,
 	.map_io		= orion5x_map_io,
 	.init_early	= orion5x_init_early,
diff --git a/arch/arm/mach-orion5x/rd88f6183ap-ge-setup.c b/arch/arm/mach-orion5x/rd88f6183ap-ge-setup.c
index ad2eba9..e06fdae 100644
--- a/arch/arm/mach-orion5x/rd88f6183ap-ge-setup.c
+++ b/arch/arm/mach-orion5x/rd88f6183ap-ge-setup.c
@@ -122,7 +122,7 @@ subsys_initcall(rd88f6183ap_ge_pci_init);
 
 MACHINE_START(RD88F6183AP_GE, "Marvell Orion-1-90 AP GE Reference Design")
 	/* Maintainer: Lennert Buytenhek <buytenh@marvell.com> */
-	.boot_params	= 0x00000100,
+	.atag_offset	= 0x100,
 	.init_machine	= rd88f6183ap_ge_init,
 	.map_io		= orion5x_map_io,
 	.init_early	= orion5x_init_early,
diff --git a/arch/arm/mach-orion5x/terastation_pro2-setup.c b/arch/arm/mach-orion5x/terastation_pro2-setup.c
index 29ce826..2b7164f 100644
--- a/arch/arm/mach-orion5x/terastation_pro2-setup.c
+++ b/arch/arm/mach-orion5x/terastation_pro2-setup.c
@@ -358,7 +358,7 @@ static void __init tsp2_init(void)
 
 MACHINE_START(TERASTATION_PRO2, "Buffalo Terastation Pro II/Live")
 	/* Maintainer:  Sylver Bruneau <sylver.bruneau@googlemail.com> */
-	.boot_params	= 0x00000100,
+	.atag_offset	= 0x100,
 	.init_machine	= tsp2_init,
 	.map_io		= orion5x_map_io,
 	.init_early	= orion5x_init_early,
diff --git a/arch/arm/mach-orion5x/ts209-setup.c b/arch/arm/mach-orion5x/ts209-setup.c
index 47162fd..cae76f4 100644
--- a/arch/arm/mach-orion5x/ts209-setup.c
+++ b/arch/arm/mach-orion5x/ts209-setup.c
@@ -322,7 +322,7 @@ static void __init qnap_ts209_init(void)
 
 MACHINE_START(TS209, "QNAP TS-109/TS-209")
 	/* Maintainer: Byron Bradley <byron.bbradley@gmail.com> */
-	.boot_params	= 0x00000100,
+	.atag_offset	= 0x100,
 	.init_machine	= qnap_ts209_init,
 	.map_io		= orion5x_map_io,
 	.init_early	= orion5x_init_early,
diff --git a/arch/arm/mach-orion5x/ts409-setup.c b/arch/arm/mach-orion5x/ts409-setup.c
index 5aacc7a..6c4ffe2 100644
--- a/arch/arm/mach-orion5x/ts409-setup.c
+++ b/arch/arm/mach-orion5x/ts409-setup.c
@@ -311,7 +311,7 @@ static void __init qnap_ts409_init(void)
 
 MACHINE_START(TS409, "QNAP TS-409")
 	/* Maintainer:  Sylver Bruneau <sylver.bruneau@gmail.com> */
-	.boot_params	= 0x00000100,
+	.atag_offset	= 0x100,
 	.init_machine	= qnap_ts409_init,
 	.map_io		= orion5x_map_io,
 	.init_early	= orion5x_init_early,
diff --git a/arch/arm/mach-orion5x/ts78xx-setup.c b/arch/arm/mach-orion5x/ts78xx-setup.c
index 6b7b541..6c75cd3 100644
--- a/arch/arm/mach-orion5x/ts78xx-setup.c
+++ b/arch/arm/mach-orion5x/ts78xx-setup.c
@@ -621,7 +621,7 @@ static void __init ts78xx_init(void)
 
 MACHINE_START(TS78XX, "Technologic Systems TS-78xx SBC")
 	/* Maintainer: Alexander Clouter <alex@digriz.org.uk> */
-	.boot_params	= 0x00000100,
+	.atag_offset	= 0x100,
 	.init_machine	= ts78xx_init,
 	.map_io		= ts78xx_map_io,
 	.init_early	= orion5x_init_early,
diff --git a/arch/arm/mach-orion5x/wnr854t-setup.c b/arch/arm/mach-orion5x/wnr854t-setup.c
index 444a1c7..612a7c4 100644
--- a/arch/arm/mach-orion5x/wnr854t-setup.c
+++ b/arch/arm/mach-orion5x/wnr854t-setup.c
@@ -172,7 +172,7 @@ subsys_initcall(wnr854t_pci_init);
 
 MACHINE_START(WNR854T, "Netgear WNR854T")
 	/* Maintainer: Imre Kaloz <kaloz@openwrt.org> */
-	.boot_params	= 0x00000100,
+	.atag_offset	= 0x100,
 	.init_machine	= wnr854t_init,
 	.map_io		= orion5x_map_io,
 	.init_early	= orion5x_init_early,
diff --git a/arch/arm/mach-orion5x/wrt350n-v2-setup.c b/arch/arm/mach-orion5x/wrt350n-v2-setup.c
index d1952be..9c73237 100644
--- a/arch/arm/mach-orion5x/wrt350n-v2-setup.c
+++ b/arch/arm/mach-orion5x/wrt350n-v2-setup.c
@@ -260,7 +260,7 @@ subsys_initcall(wrt350n_v2_pci_init);
 
 MACHINE_START(WRT350N_V2, "Linksys WRT350N v2")
 	/* Maintainer: Lennert Buytenhek <buytenh@marvell.com> */
-	.boot_params	= 0x00000100,
+	.atag_offset	= 0x100,
 	.init_machine	= wrt350n_v2_init,
 	.map_io		= orion5x_map_io,
 	.init_early	= orion5x_init_early,
-- 
1.7.4
