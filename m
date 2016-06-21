From: ben.dooks@codethink.co.uk (Ben Dooks)
Date: Tue, 21 Jun 2016 16:16:19 +0100
Subject: [PATCH 2/2] bus: mvebu-mbus: make mvebu_mbus_syscore_ops static
In-Reply-To: <1466522179-22198-1-git-send-email-ben.dooks@codethink.co.uk>
References: <1466522179-22198-1-git-send-email-ben.dooks@codethink.co.uk>
Message-ID: <1466522179-22198-2-git-send-email-ben.dooks@codethink.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Make mvebu_mbus_syscore_ops static as it does not get
used or declared outside mvebu-mbus.c to fix the following
sparse warning:

linux/drivers/bus/mvebu-mbus.c:1092:20: warning: symbol 'mvebu_mbus_syscore_ops' was not declared. Should it be static?

Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
---
Cc: Jason Cooper <jason@lakedaemon.net>
Cc: Andrew Lunn <andrew@lunn.ch>
Cc: Gregory CLEMENT <gregory.clement@free-electrons.com>
Cc: Evan Wang <xswang@marvell.com>
Cc: linux-kernel at vger.kernel.org
Cc: linux-arm-kernel at lists.infradead.org
---
 drivers/bus/mvebu-mbus.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/bus/mvebu-mbus.c b/drivers/bus/mvebu-mbus.c
index 8cac3b8..c7f3969 100644
--- a/drivers/bus/mvebu-mbus.c
+++ b/drivers/bus/mvebu-mbus.c
@@ -1089,7 +1089,7 @@ static void mvebu_mbus_resume(void)
 	}
 }
 
-struct syscore_ops mvebu_mbus_syscore_ops = {
+static struct syscore_ops mvebu_mbus_syscore_ops = {
 	.suspend	= mvebu_mbus_suspend,
 	.resume		= mvebu_mbus_resume,
 };
-- 
2.8.1
