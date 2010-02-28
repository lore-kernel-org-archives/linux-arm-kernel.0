From: albert_herranz@yahoo.es (Albert Herranz)
Date: Sun, 28 Feb 2010 15:07:55 +0100
Subject: [RFC PATCH v2 2/9] wii: have generic dma coherent
In-Reply-To: <1267366082-15248-1-git-send-email-albert_herranz@yahoo.es>
References: <1267366082-15248-1-git-send-email-albert_herranz@yahoo.es>
Message-ID: <1267366082-15248-3-git-send-email-albert_herranz@yahoo.es>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Let the Nintendo Wii gaming console use per-device dma coherent allocations.
This will be used later by some of its drivers.

Signed-off-by: Albert Herranz <albert_herranz@yahoo.es>
---
 arch/powerpc/platforms/embedded6xx/Kconfig |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/platforms/embedded6xx/Kconfig b/arch/powerpc/platforms/embedded6xx/Kconfig
index 524d971..fe77ab2 100644
--- a/arch/powerpc/platforms/embedded6xx/Kconfig
+++ b/arch/powerpc/platforms/embedded6xx/Kconfig
@@ -119,6 +119,7 @@ config WII
 	bool "Nintendo-Wii"
 	depends on EMBEDDED6xx
 	select GAMECUBE_COMMON
+	select HAVE_GENERIC_DMA_COHERENT
 	help
 	  Select WII if configuring for the Nintendo Wii.
 	  More information at: <http://gc-linux.sourceforge.net/>
-- 
1.6.3.3
