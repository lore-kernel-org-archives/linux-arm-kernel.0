From: rubini-list@gnudd.com (Alessandro Rubini)
Date: Sat, 5 Dec 2009 12:31:42 +0100
Subject: [PATCH V2 2/2] arm nomadik: add platform device for rng in cpu-8815
In-Reply-To: <376a2243795aadfb87c8a7f5ea039.1260011962.git.rubini@unipv.it>
References: <376a2243795aadfb87c8a7f5ea039.1260011962.git.rubini@unipv.it>
Message-ID: <a135a3e02bc15b34fb93648f09.1260011962.git.rubini@unipv.it>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Alessandro Rubini <rubini@unipv.it>


Signed-off-by: Alessandro Rubini <rubini@unipv.it>
Acked-by: Andrea Gallo <andrea.gallo@stericsson.com>
Cc: Matt Mackall <mpm@selenic.com>
Cc: Herbert Xu <herbert@gondor.apana.org.au>
---
 arch/arm/mach-nomadik/cpu-8815.c |    8 ++++++++
 1 files changed, 8 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-nomadik/cpu-8815.c b/arch/arm/mach-nomadik/cpu-8815.c
index f93c596..9bf33b3 100644
--- a/arch/arm/mach-nomadik/cpu-8815.c
+++ b/arch/arm/mach-nomadik/cpu-8815.c
@@ -86,11 +86,19 @@ static struct amba_device cpu8815_amba_gpio[] = {
 	},
 };
 
+static struct amba_device cpu8815_amba_rng = {
+	.dev = {
+		.init_name = "rng",
+	},
+	__MEM_4K_RESOURCE(NOMADIK_RNG_BASE),
+};
+
 static struct amba_device *amba_devs[] __initdata = {
 	cpu8815_amba_gpio + 0,
 	cpu8815_amba_gpio + 1,
 	cpu8815_amba_gpio + 2,
 	cpu8815_amba_gpio + 3,
+	&cpu8815_amba_rng
 };
 
 static int __init cpu8815_init(void)
-- 
1.6.0.2
