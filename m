From: khilman@deeprootsystems.com (Kevin Hilman)
Date: Fri, 16 Oct 2009 12:09:42 -0700
Subject: [PATCH 38/46] davinci: fix compilation error when using mach/system.h
In-Reply-To: <1255720190-7452-39-git-send-email-khilman@deeprootsystems.com>
References: <1255720190-7452-1-git-send-email-khilman@deeprootsystems.com>
	<1255720190-7452-2-git-send-email-khilman@deeprootsystems.com>
	<1255720190-7452-3-git-send-email-khilman@deeprootsystems.com>
	<1255720190-7452-4-git-send-email-khilman@deeprootsystems.com>
	<1255720190-7452-5-git-send-email-khilman@deeprootsystems.com>
	<1255720190-7452-6-git-send-email-khilman@deeprootsystems.com>
	<1255720190-7452-7-git-send-email-khilman@deeprootsystems.com>
	<1255720190-7452-8-git-send-email-khilman@deeprootsystems.com>
	<1255720190-7452-9-git-send-email-khilman@deeprootsystems.com>
	<1255720190-7452-10-git-send-email-khilman@deeprootsystems.com>
	<1255720190-7452-11-git-send-email-khilman@deeprootsystems.com>
	<1255720190-7452-12-git-send-email-khilman@deeprootsystems.com>
	<1255720190-7452-13-git-send-email-khilman@deeprootsystems.com>
	<1255720190-7452-14-git-send-email-khilman@deeprootsystems.com>
	<1255720190-7452-15-git-send-email-khilman@deeprootsystems.com>
	<1255720190-7452-16-git-send-email-khilman@deeprootsystems.com>
	<1255720190-7452-17-git-send-email-khilman@deeprootsystems.com>
	<1255720190-7452-18-git-send-email-khilman@deeprootsystems.com>
	<1255720190-7452-19-git-send-email-khilman@deeprootsystems.com>
	<1255720190-7452-20-git-send-email-khilman@deeprootsystems.com>
	<1255720190-7452-21-git-send-email-khilman@deeprootsystems.com>
	<1255720190-7452-22-git-send-email-khilman@deeprootsystems.com>
	<1255720190-7452-23-git-send-email-khilman@deeprootsystems.com>
	<1255720190-7452-24-git-send-email-khilman@deeprootsystems.com>
	<1255720190-7452-25-git-send-email-khilman@deeprootsystems.com>
	<1255720190-7452-26-git-send-email-khilman@deeprootsystems.com>
	<1255720190-7452-27-git-send-email-khilman@deeprootsystems.com>
	<1255720190-7452-28-git-send-email-khilman@deeprootsystems.com>
	<1255720190-7452-29-git-send-email-khilman@deeprootsystems.com>
	<1255720190-7452-30-git-send-email-khilman@deeprootsystems.com>
	<1255720190-7452-31-git-send-email-khilman@deeprootsystems.com>
	<1255720190-7452-32-git-send-email-khilman@deeprootsystems.com>
	<1255720190-7452-33-git-send-email-khilman@deeprootsystems.com>
	<1255720190-7452-34-git-send-email-khilman@deeprootsystems.com>
	<1255720190-7452-35-git-send-email-khilman@deeprootsystems.com>
	<1255720190-7452-36-git-send-email-khilman@deeprootsystems.com>
	<1255720190-7452-37-git-send-email-khilman@deeprootsystems.com>
	<1255720190-7452-38-git-send-email-khilman@deeprootsystems.com>
	<1255720190-7452-39-git-send-email-khilman@deeprootsystems.com>
Message-ID: <1255720190-7452-40-git-send-email-khilman@deeprootsystems.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Sekhar Nori <nsekhar@ti.com>

include/mach/system.h uses the cpu_do_idle() function which is
defined in asm/proc-fns.h. Without this patch including system.h
leads to error of the sort:

error: implicit declaration of function 'cpu_do_idle'

Signed-off-by: Sekhar Nori <nsekhar@ti.com>
Signed-off-by: Kevin Hilman <khilman@deeprootsystems.com>
---
 arch/arm/mach-davinci/include/mach/system.h |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-davinci/include/mach/system.h b/arch/arm/mach-davinci/include/mach/system.h
index 8e4f10f..f1a5f3d 100644
--- a/arch/arm/mach-davinci/include/mach/system.h
+++ b/arch/arm/mach-davinci/include/mach/system.h
@@ -13,6 +13,7 @@
 
 #include <linux/io.h>
 #include <mach/hardware.h>
+#include <asm/proc-fns.h>
 
 extern void davinci_watchdog_reset(void);
 
-- 
1.6.4.3
