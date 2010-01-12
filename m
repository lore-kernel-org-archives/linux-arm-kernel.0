From: paul@pwsan.com (Paul Walmsley)
Date: Mon, 11 Jan 2010 18:05:40 -0700
Subject: [PATCH 07/10] OMAP powerdomain/PM: use symbolic constants for the max
	number of power states
In-Reply-To: <20100112010258.6275.97999.stgit@localhost.localdomain>
References: <20100112010258.6275.97999.stgit@localhost.localdomain>
Message-ID: <20100112010539.6275.72390.stgit@localhost.localdomain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Replace some bare constants with symbolic constants.

Signed-off-by: Paul Walmsley <paul@pwsan.com>
Cc: Kevin Hilman <khilman@deeprootsystems.com>
---
 arch/arm/mach-omap2/powerdomain.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/powerdomain.c b/arch/arm/mach-omap2/powerdomain.c
index 411361f..df6446a 100644
--- a/arch/arm/mach-omap2/powerdomain.c
+++ b/arch/arm/mach-omap2/powerdomain.c
@@ -122,7 +122,7 @@ static int _pwrdm_register(struct powerdomain *pwrdm)
 	list_add(&pwrdm->node, &pwrdm_list);
 
 	/* Initialize the powerdomain's state counter */
-	for (i = 0; i < 4; i++)
+	for (i = 0; i < PWRDM_MAX_PWRSTS; i++)
 		pwrdm->state_counter[i] = 0;
 
 	pwrdm_wait_transition(pwrdm);
