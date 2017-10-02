From: elfring@users.sourceforge.net (SF Markus Elfring)
Date: Mon, 2 Oct 2017 20:03:25 +0200
Subject: [PATCH 5/6] ARM: s3c24xx: Improve a size determination in
 s3c2412_iotiming_get()
In-Reply-To: <d2ae00c8-da57-9ffc-3692-67ed6daa95e0@users.sourceforge.net>
References: <d2ae00c8-da57-9ffc-3692-67ed6daa95e0@users.sourceforge.net>
Message-ID: <28b8f35c-bed7-564f-9519-6d08e9c4edf9@users.sourceforge.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Mon, 2 Oct 2017 19:38:42 +0200

Replace the specification of a data structure by a pointer dereference
as the parameter for the operator "sizeof" to make the corresponding size
determination a bit safer according to the Linux coding style convention.

This issue was detected by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 arch/arm/mach-s3c24xx/iotiming-s3c2412.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-s3c24xx/iotiming-s3c2412.c b/arch/arm/mach-s3c24xx/iotiming-s3c2412.c
index f09d5d5ea7ed..01bcd7d5dac7 100644
--- a/arch/arm/mach-s3c24xx/iotiming-s3c2412.c
+++ b/arch/arm/mach-s3c24xx/iotiming-s3c2412.c
@@ -242,7 +242,7 @@ int s3c2412_iotiming_get(struct s3c_cpufreq_config *cfg,
 		if (!bank_is_io(bank, bankcfg))
 			continue;
 
-		bt = kzalloc(sizeof(struct s3c2412_iobank_timing), GFP_KERNEL);
+		bt = kzalloc(sizeof(*bt), GFP_KERNEL);
 		if (!bt)
 			return -ENOMEM;
 
-- 
2.14.2
