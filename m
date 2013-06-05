From: horms+renesas@verge.net.au (Simon Horman)
Date: Wed,  5 Jun 2013 13:31:51 +0900
Subject: [PATCH 4/6] ARM: shmobile: bockw: enable CONFIG_PM_RUNTIME in
 defconfig
In-Reply-To: <1370406713-26599-1-git-send-email-horms+renesas@verge.net.au>
References: <1370406713-26599-1-git-send-email-horms+renesas@verge.net.au>
Message-ID: <1370406713-26599-5-git-send-email-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Vladimir Barinov <vladimir.barinov@cogentembedded.com>

Enable CONFIG_PM_RUNTIME in 'bockw_defconfig' -- it's already used by TMU, SCI,
I2C, and Ether drivers to control the clocks...

Signed-off-by: Vladimir Barinov <vladimir.barinov@cogentembedded.com>
Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/configs/bockw_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/bockw_defconfig b/arch/arm/configs/bockw_defconfig
index 2c3f34e..a4bc76d 100644
--- a/arch/arm/configs/bockw_defconfig
+++ b/arch/arm/configs/bockw_defconfig
@@ -31,6 +31,7 @@ CONFIG_CMDLINE="console=ttySC0,115200 ignore_loglevel root=/dev/nfs ip=dhcp"
 CONFIG_CMDLINE_FORCE=y
 # CONFIG_CORE_DUMP_DEFAULT_ELF_HEADERS is not set
 # CONFIG_SUSPEND is not set
+CONFIG_PM_RUNTIME=y
 CONFIG_NET=y
 CONFIG_UNIX=y
 CONFIG_INET=y
-- 
1.8.2.1
