From: khilman@deeprootsystems.com (Kevin Hilman)
Date: Fri, 16 Oct 2009 12:09:19 -0700
Subject: [PATCH 15/46] davinci: dm646x: Add support for 3.x silicon revision
In-Reply-To: <1255720190-7452-16-git-send-email-khilman@deeprootsystems.com>
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
Message-ID: <1255720190-7452-17-git-send-email-khilman@deeprootsystems.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Hemant Pedanekar <hemantp@ti.com>

DM6467 silicon revisions 3.x have variant field in JTAGID register as '1'.
This path adds entry for the same in dm646x_ids to be able to boot on boards
with 3.x revision chips.

Also modifies name for 'variant=0' (revisions 1.0, 1.1).

Signed-off-by: Hemant Pedanekar <hemantp@ti.com>
Signed-off-by: Kevin Hilman <khilman@deeprootsystems.com>
---
 arch/arm/mach-davinci/dm646x.c |    9 ++++++++-
 1 files changed, 8 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-davinci/dm646x.c b/arch/arm/mach-davinci/dm646x.c
index 0976049..36e4fb4 100644
--- a/arch/arm/mach-davinci/dm646x.c
+++ b/arch/arm/mach-davinci/dm646x.c
@@ -789,7 +789,14 @@ static struct davinci_id dm646x_ids[] = {
 		.part_no	= 0xb770,
 		.manufacturer	= 0x017,
 		.cpu_id		= DAVINCI_CPU_ID_DM6467,
-		.name		= "dm6467",
+		.name		= "dm6467_rev1.x",
+	},
+	{
+		.variant	= 0x1,
+		.part_no	= 0xb770,
+		.manufacturer	= 0x017,
+		.cpu_id		= DAVINCI_CPU_ID_DM6467,
+		.name		= "dm6467_rev3.x",
 	},
 };
 
-- 
1.6.4.3
