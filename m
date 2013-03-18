From: horms+renesas@verge.net.au (Simon Horman)
Date: Mon, 18 Mar 2013 20:53:18 +0900
Subject: [PATCH 6/9] ARM: shmobile: armadillo800eva: enable NEON on defconfig
In-Reply-To: <1363607601-20366-1-git-send-email-horms+renesas@verge.net.au>
References: <1363607601-20366-1-git-send-email-horms+renesas@verge.net.au>
Message-ID: <1363607601-20366-7-git-send-email-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

The application / library will be stopped by illegal instruction
on current Armaddilo800eva board,
since defconfig doesn't have CONFIG_NEON.
This patch enabled it.
Special thanks to Ishiyama-san

Reported-by: Kiyoshi Ishiyama <kiyoshi.ishiyama.wg@renesas.com>
Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Acked-by: Kiyoshi Ishiyama <kiyoshi.ishiyama.wg@renesas.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/configs/armadillo800eva_defconfig |    1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/armadillo800eva_defconfig b/arch/arm/configs/armadillo800eva_defconfig
index c402294..468c616 100644
--- a/arch/arm/configs/armadillo800eva_defconfig
+++ b/arch/arm/configs/armadillo800eva_defconfig
@@ -36,6 +36,7 @@ CONFIG_ZBOOT_ROM_BSS=0x0
 CONFIG_ARM_APPENDED_DTB=y
 CONFIG_KEXEC=y
 CONFIG_VFP=y
+CONFIG_NEON=y
 # CONFIG_CORE_DUMP_DEFAULT_ELF_HEADERS is not set
 CONFIG_PM_RUNTIME=y
 CONFIG_NET=y
-- 
1.7.10.4
