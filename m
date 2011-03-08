From: robherring2@gmail.com (Rob Herring)
Date: Tue,  8 Mar 2011 17:34:31 -0600
Subject: [PATCH v3 1/7] ARM: integrator cp: add sp804 clock
In-Reply-To: <1299627277-20311-1-git-send-email-robherring2@gmail.com>
References: <1299627277-20311-1-git-send-email-robherring2@gmail.com>
Message-ID: <1299627277-20311-2-git-send-email-robherring2@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Rob Herring <rob.herring@calxeda.com>

Add a clock for sp804 timer.

Signed-off-by: Rob Herring <rob.herring@calxeda.com>
---
 arch/arm/mach-integrator/integrator_cp.c |    8 +++++++-
 1 files changed, 7 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-integrator/integrator_cp.c b/arch/arm/mach-integrator/integrator_cp.c
index 9e3ce26..a9cec65 100644
--- a/arch/arm/mach-integrator/integrator_cp.c
+++ b/arch/arm/mach-integrator/integrator_cp.c
@@ -228,12 +228,18 @@ static struct clk cp_auxclk = {
 	.params	= &cp_auxvco_params,
 	.vcoreg	= CM_AUXOSC,
 };
+static struct clk sp804_clk = {
+	.rate = 1000000,
+};
 
 static struct clk_lookup cp_lookups[] = {
 	{	/* CLCD */
 		.dev_id		= "mb:c0",
 		.clk		= &cp_auxclk,
-	},
+	}, {	/* SP804 Timer */
+		.dev_id		= "sp804",
+		.clk		= &sp804_clk,
+	}
 };
 
 /*
-- 
1.7.1
