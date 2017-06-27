From: s-anna@ti.com (Suman Anna)
Date: Tue, 27 Jun 2017 17:46:07 -0500
Subject: [PATCH 1/4] rpmsg: Drop VIRTUALIZATION dependency from RPMSG_VIRTIO
In-Reply-To: <20170627224610.15321-1-s-anna@ti.com>
References: <20170627224610.15321-1-s-anna@ti.com>
Message-ID: <20170627224610.15321-2-s-anna@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

A dependency to VIRTUALIZATION has been added to RPMSG_VIRTIO (back
when it was named RPMSG) in v3.10 kernel in commit 397944df3290
("rpmsg: fix kconfig dependencies for VIRTIO") to resolve Kconfig
warnings due to the inclusion of the virtio configuration file from
the ARM's KVM config file. The KVM config was fixed properly in the
subsequent release in commit 8bd4ffd6b3a9 ("ARM: kvm: don't include
drivers/virtio/Kconfig"). So, drop this unneeded VIRTUALIZATION
dependency from RPMSG_VIRTIO.

Signed-off-by: Suman Anna <s-anna@ti.com>
---
 drivers/rpmsg/Kconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/rpmsg/Kconfig b/drivers/rpmsg/Kconfig
index 2a5d2b446de2..1323a245763b 100644
--- a/drivers/rpmsg/Kconfig
+++ b/drivers/rpmsg/Kconfig
@@ -36,6 +36,5 @@ config RPMSG_VIRTIO
 	tristate
 	select RPMSG
 	select VIRTIO
-	select VIRTUALIZATION
 
 endmenu
-- 
2.13.1
