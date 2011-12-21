From: ohad@wizery.com (Ohad Ben-Cohen)
Date: Wed, 21 Dec 2011 13:21:13 +0200
Subject: [PATCH 2/2] rpmsg: depend on EXPERIMENTAL
In-Reply-To: <1324466473-5128-1-git-send-email-ohad@wizery.com>
References: <1324466473-5128-1-git-send-email-ohad@wizery.com>
Message-ID: <1324466473-5128-2-git-send-email-ohad@wizery.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

There isn't any binary change in sight or evidence of any stability
issue, but as we just begin to get traction we can't rule them out
completely.

To be on the safe side, let's mark rpmsg as EXPERIMENTAL, and remove
it later on after we have several happy users.

Signed-off-by: Ohad Ben-Cohen <ohad@wizery.com>
Cc: Stephen Boyd <sboyd@codeaurora.org>
Cc: Rob Clark <rob@ti.com>
Cc: Mark Grosen <mgrosen@ti.com>
Cc: Ludovic BARRE <ludovic.barre@stericsson.com>
---
 drivers/rpmsg/Kconfig |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/drivers/rpmsg/Kconfig b/drivers/rpmsg/Kconfig
index 98aca55..32aead6 100644
--- a/drivers/rpmsg/Kconfig
+++ b/drivers/rpmsg/Kconfig
@@ -1,9 +1,10 @@
-menu "Rpmsg drivers"
+menu "Rpmsg drivers (EXPERIMENTAL)"
 
 # RPMSG always gets selected by whoever wants it
 config RPMSG
 	tristate
 	select VIRTIO
 	select VIRTIO_RING
+	depends on EXPERIMENTAL
 
 endmenu
-- 
1.7.5.4
