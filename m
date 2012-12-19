From: javier.martinez@collabora.co.uk (Javier Martinez Canillas)
Date: Wed, 19 Dec 2012 13:33:40 +0100
Subject: [PATCH 2/2] ARM: OMAP2+: omap2plus_defconfig: enable CMA allocator
In-Reply-To: <1355920420-20852-1-git-send-email-javier.martinez@collabora.co.uk>
References: <1355920420-20852-1-git-send-email-javier.martinez@collabora.co.uk>
Message-ID: <1355920420-20852-2-git-send-email-javier.martinez@collabora.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The OMAP framebuffer driver now uses the standard dma allocator
instead of the (now removed) omap specific vram allocator.

Enable the Contiguous Memory Allocator by default to allow large
dma memory buffers allocation.

Signed-off-by: Javier Martinez Canillas <javier.martinez@collabora.co.uk>
---
 arch/arm/configs/omap2plus_defconfig |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/arch/arm/configs/omap2plus_defconfig b/arch/arm/configs/omap2plus_defconfig
index da530a0..dc4789e 100644
--- a/arch/arm/configs/omap2plus_defconfig
+++ b/arch/arm/configs/omap2plus_defconfig
@@ -64,6 +64,7 @@ CONFIG_MAC80211=m
 CONFIG_MAC80211_RC_PID=y
 CONFIG_MAC80211_RC_DEFAULT_PID=y
 CONFIG_UEVENT_HELPER_PATH="/sbin/hotplug"
+CONFIG_CMA=y
 CONFIG_CONNECTOR=y
 CONFIG_MTD=y
 CONFIG_MTD_CMDLINE_PARTS=y
-- 
1.7.7.6
