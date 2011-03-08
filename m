From: robherring2@gmail.com (Rob Herring)
Date: Tue,  8 Mar 2011 17:34:32 -0600
Subject: [PATCH v3 2/7] ARM: realview: add sp804 clock
In-Reply-To: <1299627277-20311-1-git-send-email-robherring2@gmail.com>
References: <1299627277-20311-1-git-send-email-robherring2@gmail.com>
Message-ID: <1299627277-20311-3-git-send-email-robherring2@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Rob Herring <rob.herring@calxeda.com>

Add a clock for sp804 timer.

Signed-off-by: Rob Herring <rob.herring@calxeda.com>
---
 arch/arm/mach-realview/core.c |    7 +++++++
 1 files changed, 7 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-realview/core.c b/arch/arm/mach-realview/core.c
index 75dbc87..ee07755 100644
--- a/arch/arm/mach-realview/core.c
+++ b/arch/arm/mach-realview/core.c
@@ -315,6 +315,10 @@ static struct clk ref24_clk = {
 	.rate	= 24000000,
 };
 
+static struct clk sp804_clk = {
+	.rate	= 1000000,
+};
+
 static struct clk dummy_apb_pclk;
 
 static struct clk_lookup lookups[] = {
@@ -357,6 +361,9 @@ static struct clk_lookup lookups[] = {
 	}, {	/* SSP */
 		.dev_id		= "dev:ssp0",
 		.clk		= &ref24_clk,
+	}, {	/* SP804 Timer */
+		.dev_id		= "sp804",
+		.clk		= &sp804_clk,
 	}
 };
 
-- 
1.7.1
