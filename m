From: horms+renesas@verge.net.au (Simon Horman)
Date: Fri, 11 Jan 2013 16:17:02 +0900
Subject: [PATCH 1/5] ARM: mach-shmobile: mackerel: update defconfig
In-Reply-To: <1357888626-4946-1-git-send-email-horms+renesas@verge.net.au>
References: <1357888626-4946-1-git-send-email-horms+renesas@verge.net.au>
Message-ID: <1357888626-4946-2-git-send-email-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Enable ARM_APPENDED_DTB

  Typically the bootloader of a mackerel board does not support DT
  so this option is useful

* Add "rw" to command line

  This appears to be necessary for a successful NFS-root boot

* Remove memchunk from kernel command line,
  it is not used outside of arch/sh

* Move command line to dts

  This brings us one small step closer to sharing defconfig
  between mackerel and other boards

Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/sh7372-mackerel.dts |    4 ++++
 arch/arm/configs/mackerel_defconfig   |    2 +-
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/sh7372-mackerel.dts b/arch/arm/boot/dts/sh7372-mackerel.dts
index 286f0ca..2623de8 100644
--- a/arch/arm/boot/dts/sh7372-mackerel.dts
+++ b/arch/arm/boot/dts/sh7372-mackerel.dts
@@ -15,6 +15,10 @@
 	model = "Mackerel (AP4 EVM 2nd)";
 	compatible = "renesas,mackerel";
 
+	chosen {
+		bootargs = "console=tty0, console=ttySC0,115200 earlyprintk=sh-sci.0,115200 root=/dev/nfs nfsroot=,tcp,v3 ip=dhcp mem=240m rw";
+	};
+
 	memory {
 		device_type = "memory";
 		reg = <0x40000000 0x10000000>;
diff --git a/arch/arm/configs/mackerel_defconfig b/arch/arm/configs/mackerel_defconfig
index 2098ce1..e6881ac 100644
--- a/arch/arm/configs/mackerel_defconfig
+++ b/arch/arm/configs/mackerel_defconfig
@@ -23,7 +23,7 @@ CONFIG_AEABI=y
 CONFIG_FORCE_MAX_ZONEORDER=15
 CONFIG_ZBOOT_ROM_TEXT=0x0
 CONFIG_ZBOOT_ROM_BSS=0x0
-CONFIG_CMDLINE="console=tty0, console=ttySC0,115200 earlyprintk=sh-sci.0,115200 root=/dev/nfs nfsroot=,tcp,v3 ip=dhcp memchunk.vpu=64m memchunk.veu0=8m memchunk.spu0=2m mem=240m"
+CONFIG_ARM_APPENDED_DTB=y
 CONFIG_KEXEC=y
 # CONFIG_CORE_DUMP_DEFAULT_ELF_HEADERS is not set
 CONFIG_PM=y
-- 
1.7.10.4
