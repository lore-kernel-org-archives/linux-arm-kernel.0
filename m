From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Tue, 10 May 2016 10:03:03 +0200
Subject: [PATCH] ARM: at91/defconfig: sama5: add CONFIG_FHANDLE
In-Reply-To: <572CC603.4000102@denx.de>
References: <572CC603.4000102@denx.de>
Message-ID: <1462867383-31961-1-git-send-email-nicolas.ferre@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

CONFIG_FHANDLE is listed as a mandatory kernel option for systemd. So
explicitly enable it to allow easy use of systemd userspace.

Reported-by: Marek Vasut <marex@denx.de>
Signed-off-by: Nicolas Ferre <nicolas.ferre@atmel.com>
---
Hi Marek,

It seems that on my side, CONFIG_FHANDLE is not selected automatically...
So I add this patch: can you tell me your thoughts?

Bye,
   Nico.

 arch/arm/configs/sama5_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/sama5_defconfig b/arch/arm/configs/sama5_defconfig
index 307f92b31e57..9cb1a85bb166 100644
--- a/arch/arm/configs/sama5_defconfig
+++ b/arch/arm/configs/sama5_defconfig
@@ -1,6 +1,7 @@
 # CONFIG_LOCALVERSION_AUTO is not set
 # CONFIG_SWAP is not set
 CONFIG_SYSVIPC=y
+CONFIG_FHANDLE=y
 CONFIG_IRQ_DOMAIN_DEBUG=y
 CONFIG_LOG_BUF_SHIFT=14
 CONFIG_CGROUPS=y
-- 
2.1.3
