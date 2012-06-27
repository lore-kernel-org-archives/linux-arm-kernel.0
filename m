From: ben.dooks@codethink.co.uk (Ben Dooks)
Date: Wed, 27 Jun 2012 17:26:45 +0100
Subject: [PATCH 2/3] arm: mach-mvebu: check result of of_match_node()
In-Reply-To: <1340814406-26010-1-git-send-email-ben.dooks@codethink.co.uk>
References: <1340805290-9051-1-git-send-email-gregory.clement@free-electrons.com>
 <1340814406-26010-1-git-send-email-ben.dooks@codethink.co.uk>
Message-ID: <1340814406-26010-3-git-send-email-ben.dooks@codethink.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Report if of_match_node() fails.

Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
---
 arch/arm/mach-mvebu/system-controller.c |    1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/mach-mvebu/system-controller.c b/arch/arm/mach-mvebu/system-controller.c
index f39023b..850f8d2 100644
--- a/arch/arm/mach-mvebu/system-controller.c
+++ b/arch/arm/mach-mvebu/system-controller.c
@@ -93,6 +93,7 @@ static int __init mvebu_system_controller_init(void)
 	if (np) {
 		const struct of_device_id *match =
 		    of_match_node(of_system_controller_table, np);
+		BUG_ON(!match);
 		system_controller_base = of_iomap(np, 0);
 		mvebu_sc = (struct mvebu_system_controller *)match->data;
 	}
-- 
1.7.10
