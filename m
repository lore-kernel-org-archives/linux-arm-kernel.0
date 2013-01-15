From: horms+renesas@verge.net.au (Simon Horman)
Date: Tue, 15 Jan 2013 09:49:34 +0900
Subject: [PATCH 4/5] ARM: mach-shmobile: armadillo: update defconfig
In-Reply-To: <1358210975-26970-1-git-send-email-horms+renesas@verge.net.au>
References: <1358210975-26970-1-git-send-email-horms+renesas@verge.net.au>
Message-ID: <1358210975-26970-5-git-send-email-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Enable ARM_APPENDED_DTB

  Typically the bootloader of an armadillo board does not support DT
  so this option is useful.

* Do not disable SUSPEND

  Suspend seems to work fine on the armadillo

* Enable PM_RUNTIME

  This also seems to work fine.

* Move command line to dts

  This brings us one small step closer to sharing defconfig
  between armadillo and other boards

Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/r8a7740-armadillo800eva.dts |    4 ++++
 arch/arm/configs/armadillo800eva_defconfig    |    5 ++---
 2 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/arch/arm/boot/dts/r8a7740-armadillo800eva.dts b/arch/arm/boot/dts/r8a7740-armadillo800eva.dts
index a7505a9..52cfead 100644
--- a/arch/arm/boot/dts/r8a7740-armadillo800eva.dts
+++ b/arch/arm/boot/dts/r8a7740-armadillo800eva.dts
@@ -15,6 +15,10 @@
 	model = "armadillo 800 eva";
 	compatible = "renesas,armadillo800eva";
 
+	chosen {
+		bootargs = "console=tty0 console=ttySC1,115200 earlyprintk=sh-sci.1,115200 ignore_loglevel root=/dev/nfs ip=dhcp nfsroot=,rsize=4096,wsize=4096 rw";
+	};
+
 	memory {
 		device_type = "memory";
 		reg = <0x40000000 0x20000000>;
diff --git a/arch/arm/configs/armadillo800eva_defconfig b/arch/arm/configs/armadillo800eva_defconfig
index 2e1a825..f9e2701 100644
--- a/arch/arm/configs/armadillo800eva_defconfig
+++ b/arch/arm/configs/armadillo800eva_defconfig
@@ -34,12 +34,11 @@ CONFIG_AEABI=y
 CONFIG_FORCE_MAX_ZONEORDER=13
 CONFIG_ZBOOT_ROM_TEXT=0x0
 CONFIG_ZBOOT_ROM_BSS=0x0
-CONFIG_CMDLINE="console=tty0 console=ttySC1,115200 earlyprintk=sh-sci.1,115200 ignore_loglevel root=/dev/nfs ip=dhcp nfsroot=,rsize=4096,wsize=4096 rw"
-CONFIG_CMDLINE_FORCE=y
+CONFIG_ARM_APPENDED_DTB=y
 CONFIG_KEXEC=y
 CONFIG_VFP=y
 # CONFIG_CORE_DUMP_DEFAULT_ELF_HEADERS is not set
-# CONFIG_SUSPEND is not set
+CONFIG_PM_RUNTIME=y
 CONFIG_NET=y
 CONFIG_PACKET=y
 CONFIG_UNIX=y
-- 
1.7.10.4
