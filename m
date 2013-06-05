From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Wed,  5 Jun 2013 09:05:01 +0200
Subject: [PATCH 8/8] arm: mvebu: disable DEBUG_LL/EARLY_PRINTK in defconfig
In-Reply-To: <1370415901-4721-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1370415901-4721-1-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <1370415901-4721-9-git-send-email-thomas.petazzoni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Now that we have two different addresses for the UART, depending on
which bootloader is used, it is no longer desirable to enable
earlyprintk by default in the defconfig. Users who need earlyprintk
support will have to enable it explicitly, and select the right UART
configuration depending on their platform.

Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
---
 arch/arm/configs/mvebu_defconfig | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/arm/configs/mvebu_defconfig b/arch/arm/configs/mvebu_defconfig
index f3e8ae0..680940a 100644
--- a/arch/arm/configs/mvebu_defconfig
+++ b/arch/arm/configs/mvebu_defconfig
@@ -96,5 +96,3 @@ CONFIG_TIMER_STATS=y
 # CONFIG_DEBUG_BUGVERBOSE is not set
 CONFIG_DEBUG_INFO=y
 CONFIG_DEBUG_USER=y
-CONFIG_DEBUG_LL=y
-CONFIG_EARLY_PRINTK=y
-- 
1.8.1.2
