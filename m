From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sat, 19 Feb 2011 15:48:39 +0000
Subject: [PATCH 3/3] Make amba_driver id_table const
Message-ID: <20110219154839.GL29493@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Now that the bus level code deals with a const id table, we can also
make the ID table in the amba_driver structure also const.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 include/linux/amba/bus.h |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/amba/bus.c b/drivers/amba/bus.c
diff --git a/include/linux/amba/bus.h b/include/linux/amba/bus.h
index a0ccf28..9cd7f8e 100644
--- a/include/linux/amba/bus.h
+++ b/include/linux/amba/bus.h
@@ -48,7 +48,7 @@ struct amba_driver {
 	void			(*shutdown)(struct amba_device *);
 	int			(*suspend)(struct amba_device *, pm_message_t);
 	int			(*resume)(struct amba_device *);
-	struct amba_id		*id_table;
+	const struct amba_id	*id_table;
 };
 
 enum amba_vendor {
