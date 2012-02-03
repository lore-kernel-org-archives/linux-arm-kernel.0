From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 03 Feb 2012 20:00:57 +0000
Subject: [PATCH 19/20] ARM: sa1111: use dev_err() rather than printk()
In-Reply-To: <20120203195419.GH14129@n2100.arm.linux.org.uk>
References: <20120203195419.GH14129@n2100.arm.linux.org.uk>
Message-ID: <E1RtPJZ-00044y-TY@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use dev_err() to report device specific errors rather than printk().

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/common/sa1111.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/common/sa1111.c b/arch/arm/common/sa1111.c
index 8d86338..9173d11 100644
--- a/arch/arm/common/sa1111.c
+++ b/arch/arm/common/sa1111.c
@@ -655,7 +655,7 @@ sa1111_init_one_child(struct sa1111 *sachip, struct resource *parent,
 
 	ret = request_resource(parent, &dev->res);
 	if (ret) {
-		printk("SA1111: failed to allocate resource for %s\n",
+		dev_err(sachip->dev, "failed to allocate resource for %s\n",
 			dev->res.name);
 		goto err_resource;
 	}
-- 
1.7.4.4
