From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 14 Aug 2018 11:18:46 +0200
Subject: [PATCH 2/2] ARM: rpc: mark ecard_devices_proc_show as __maybe_unused
In-Reply-To: <20180814091904.2186262-1-arnd@arndb.de>
References: <20180814091904.2186262-1-arnd@arndb.de>
Message-ID: <20180814091904.2186262-2-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

A new build error appeared with CONFIG_PROC_FS disabled:

arch/arm/mach-rpc/ecard.c:646:12: error: 'ecard_devices_proc_show' defined but not used [-Werror=unused-function]

This marks the function as __maybe_unused to let the compiler drop
it silently.

Fixes: 3f3942aca6da ("proc: introduce proc_create_single{,_data}")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/arm/mach-rpc/ecard.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-rpc/ecard.c b/arch/arm/mach-rpc/ecard.c
index 6fb51d49ad26..761a629f9e9d 100644
--- a/arch/arm/mach-rpc/ecard.c
+++ b/arch/arm/mach-rpc/ecard.c
@@ -643,7 +643,7 @@ static int ecard_prints(struct seq_file *m, ecard_t *ec)
 	return 0;
 }
 
-static int ecard_devices_proc_show(struct seq_file *m, void *v)
+static int __maybe_unused ecard_devices_proc_show(struct seq_file *m, void *v)
 {
 	ecard_t *ec = cards;
 
-- 
2.18.0
