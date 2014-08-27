From: javier.martinez@collabora.co.uk (Javier Martinez Canillas)
Date: Wed, 27 Aug 2014 13:02:21 +0200
Subject: [PATCH 2/2] ARM: multi_v7_defconfig: Enable Control Groups support
In-Reply-To: <1409137341-20516-1-git-send-email-javier.martinez@collabora.co.uk>
References: <1409137341-20516-1-git-send-email-javier.martinez@collabora.co.uk>
Message-ID: <1409137341-20516-2-git-send-email-javier.martinez@collabora.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

systemd needs control groups support to be enabled in the
kernel so let's enable it by default since is quite likely
that a user-space with systemd will be used.

Signed-off-by: Javier Martinez Canillas <javier.martinez@collabora.co.uk>
---
 arch/arm/configs/multi_v7_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/multi_v7_defconfig b/arch/arm/configs/multi_v7_defconfig
index 7cfa5fa..abf6490 100644
--- a/arch/arm/configs/multi_v7_defconfig
+++ b/arch/arm/configs/multi_v7_defconfig
@@ -3,6 +3,7 @@ CONFIG_FHANDLE=y
 CONFIG_IRQ_DOMAIN_DEBUG=y
 CONFIG_NO_HZ=y
 CONFIG_HIGH_RES_TIMERS=y
+CONFIG_CGROUPS=y
 CONFIG_BLK_DEV_INITRD=y
 CONFIG_EMBEDDED=y
 CONFIG_PERF_EVENTS=y
-- 
2.0.1
