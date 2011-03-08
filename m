From: robherring2@gmail.com (Rob Herring)
Date: Tue,  8 Mar 2011 17:34:33 -0600
Subject: [PATCH v3 3/7] ARM: versatile: add sp804 clock
In-Reply-To: <1299627277-20311-1-git-send-email-robherring2@gmail.com>
References: <1299627277-20311-1-git-send-email-robherring2@gmail.com>
Message-ID: <1299627277-20311-4-git-send-email-robherring2@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Rob Herring <rob.herring@calxeda.com>

Add a clock for sp804 timer.

Signed-off-by: Rob Herring <rob.herring@calxeda.com>
---
 arch/arm/mach-versatile/core.c |    7 +++++++
 1 files changed, 7 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-versatile/core.c b/arch/arm/mach-versatile/core.c
index eb7ffa0..e9c5a17 100644
--- a/arch/arm/mach-versatile/core.c
+++ b/arch/arm/mach-versatile/core.c
@@ -375,6 +375,10 @@ static struct clk ref24_clk = {
 	.rate	= 24000000,
 };
 
+static struct clk sp804_clk = {
+	.rate	= 1000000,
+};
+
 static struct clk dummy_apb_pclk;
 
 static struct clk_lookup lookups[] = {
@@ -411,6 +415,9 @@ static struct clk_lookup lookups[] = {
 	}, {	/* CLCD */
 		.dev_id		= "dev:20",
 		.clk		= &osc4_clk,
+	}, {	/* SP804 Timer */
+		.dev_id		= "sp804",
+		.clk		= &sp804_clk,
 	}
 };
 
-- 
1.7.1
