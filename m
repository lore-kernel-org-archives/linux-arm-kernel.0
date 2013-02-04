From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Mon,  4 Feb 2013 18:21:07 +0100
Subject: [PATCH v4 1/2] arm: mvebu: update defconfig with ATAG support when
 using DT
In-Reply-To: <1359998469-28133-1-git-send-email-gregory.clement@free-electrons.com>
References: <1359998469-28133-1-git-send-email-gregory.clement@free-electrons.com>
Message-ID: <1359998469-28133-2-git-send-email-gregory.clement@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Some of the mvebu boards (mainly the development board) come with
plug-in RAM modules. This patch allows to let the bootloaders which
have no support for DTS to give the real amount of memory available on
the board.

Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
---
 arch/arm/configs/mvebu_defconfig |    1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/mvebu_defconfig b/arch/arm/configs/mvebu_defconfig
index b5bc96c..8ec2217 100644
--- a/arch/arm/configs/mvebu_defconfig
+++ b/arch/arm/configs/mvebu_defconfig
@@ -21,6 +21,7 @@ CONFIG_HIGHMEM=y
 CONFIG_ZBOOT_ROM_TEXT=0x0
 CONFIG_ZBOOT_ROM_BSS=0x0
 CONFIG_ARM_APPENDED_DTB=y
+CONFIG_ARM_ATAG_DTB_COMPAT=y
 CONFIG_VFP=y
 CONFIG_NET=y
 CONFIG_INET=y
-- 
1.7.9.5
