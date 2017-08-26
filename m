From: bhumirks@gmail.com (Bhumika Goyal)
Date: Sat, 26 Aug 2017 15:50:04 +0530
Subject: [PATCH 02/10] [media] dt3155: make video_device const
In-Reply-To: <1503742812-16139-1-git-send-email-bhumirks@gmail.com>
References: <1503742812-16139-1-git-send-email-bhumirks@gmail.com>
Message-ID: <1503742812-16139-3-git-send-email-bhumirks@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Make this const as it is only used in a copy operation.

Signed-off-by: Bhumika Goyal <bhumirks@gmail.com>
---
 drivers/media/pci/dt3155/dt3155.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/media/pci/dt3155/dt3155.c b/drivers/media/pci/dt3155/dt3155.c
index 6a21969..1775c36 100644
--- a/drivers/media/pci/dt3155/dt3155.c
+++ b/drivers/media/pci/dt3155/dt3155.c
@@ -499,7 +499,7 @@ static int dt3155_init_board(struct dt3155_priv *pd)
 	return 0;
 }
 
-static struct video_device dt3155_vdev = {
+static const struct video_device dt3155_vdev = {
 	.name = DT3155_NAME,
 	.fops = &dt3155_fops,
 	.ioctl_ops = &dt3155_ioctl_ops,
-- 
1.9.1
