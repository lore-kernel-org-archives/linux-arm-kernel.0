From: andre.przywara@arm.com (Andre Przywara)
Date: Tue, 22 Dec 2015 12:27:43 +0000
Subject: [RFC PATCH 1/5] drivers: sunxi-rsb: fix error output type
In-Reply-To: <1450787267-26836-1-git-send-email-andre.przywara@arm.com>
References: <1450787267-26836-1-git-send-email-andre.przywara@arm.com>
Message-ID: <1450787267-26836-2-git-send-email-andre.przywara@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

"len" is actually a size_t in this function here, so properly annotate
the dev_err printf type to allow compilation for 64-bit architectures.

Signed-off-by: Andre Przywara <andre.przywara@arm.com>
---
 drivers/bus/sunxi-rsb.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/bus/sunxi-rsb.c b/drivers/bus/sunxi-rsb.c
index 846bc29..7f26bc1d 100644
--- a/drivers/bus/sunxi-rsb.c
+++ b/drivers/bus/sunxi-rsb.c
@@ -330,7 +330,7 @@ static int sunxi_rsb_read(struct sunxi_rsb *rsb, u8 rtaddr, u8 addr,
 		cmd = RSB_CMD_RD32;
 		break;
 	default:
-		dev_err(rsb->dev, "Invalid access width: %d\n", len);
+		dev_err(rsb->dev, "Invalid access width: %zd\n", len);
 		return -EINVAL;
 	}
 
@@ -372,7 +372,7 @@ static int sunxi_rsb_write(struct sunxi_rsb *rsb, u8 rtaddr, u8 addr,
 		cmd = RSB_CMD_WR32;
 		break;
 	default:
-		dev_err(rsb->dev, "Invalid access width: %d\n", len);
+		dev_err(rsb->dev, "Invalid access width: %zd\n", len);
 		return -EINVAL;
 	}
 
-- 
2.5.1
