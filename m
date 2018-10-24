From: s-anna@ti.com (Suman Anna)
Date: Tue, 23 Oct 2018 20:19:09 -0500
Subject: [PATCH] rpmsg: virtio_rpmsg_bus: replace "%p" with "%pK"
Message-ID: <20181024011909.21674-1-s-anna@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The virtio_rpmsg_bus driver uses the "%p" format-specifier for
printing the vring buffer address. This prints only a hashed
pointer even for previliged users. Use "%pK" instead so that
the address can be printed during debug using kptr_restrict
sysctl.

Signed-off-by: Suman Anna <s-anna@ti.com>
---
 drivers/rpmsg/virtio_rpmsg_bus.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/rpmsg/virtio_rpmsg_bus.c b/drivers/rpmsg/virtio_rpmsg_bus.c
index f29dee731026..1345f373a1a0 100644
--- a/drivers/rpmsg/virtio_rpmsg_bus.c
+++ b/drivers/rpmsg/virtio_rpmsg_bus.c
@@ -950,7 +950,7 @@ static int rpmsg_probe(struct virtio_device *vdev)
 		goto vqs_del;
 	}
 
-	dev_dbg(&vdev->dev, "buffers: va %p, dma %pad\n",
+	dev_dbg(&vdev->dev, "buffers: va %pK, dma %pad\n",
 		bufs_va, &vrp->bufs_dma);
 
 	/* half of the buffers is dedicated for RX */
-- 
2.19.1
