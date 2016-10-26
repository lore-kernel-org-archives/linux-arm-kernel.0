From: antoine.tenart@free-electrons.com (Antoine Tenart)
Date: Wed, 26 Oct 2016 16:57:54 +0200
Subject: [RFC PATCH 3/5] w1: report errors returned by w1_family_notify
In-Reply-To: <20161026145756.21689-1-antoine.tenart@free-electrons.com>
References: <20161026145756.21689-1-antoine.tenart@free-electrons.com>
Message-ID: <20161026145756.21689-4-antoine.tenart@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Antoine Tenart <antoine.tenart@free-electrons.com>
---
 drivers/w1/w1.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/w1/w1.c b/drivers/w1/w1.c
index bb34362e930a..80d0cc4e6e7f 100644
--- a/drivers/w1/w1.c
+++ b/drivers/w1/w1.c
@@ -702,7 +702,9 @@ static int __w1_attach_slave_device(struct w1_slave *sl)
 			dev_name(&sl->dev), err);
 		return err;
 	}
-	w1_family_notify(BUS_NOTIFY_ADD_DEVICE, sl);
+	err = w1_family_notify(BUS_NOTIFY_ADD_DEVICE, sl);
+	if (err)
+		return err;
 
 	dev_set_uevent_suppress(&sl->dev, false);
 	kobject_uevent(&sl->dev.kobj, KOBJ_ADD);
-- 
2.10.1
