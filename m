From: f.fainelli@gmail.com (Florian Fainelli)
Date: Tue, 10 Jan 2017 12:12:32 -0800
Subject: [PATCH net-next 5/8] net: dsa: Export dev_to_net_device()
In-Reply-To: <20170110201235.21771-1-f.fainelli@gmail.com>
References: <20170110201235.21771-1-f.fainelli@gmail.com>
Message-ID: <20170110201235.21771-6-f.fainelli@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We are going to need this in net/dsa/dsa2.c as well, so make it
avaialable.

Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 include/net/dsa.h | 1 +
 net/dsa/dsa.c     | 3 ++-
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/include/net/dsa.h b/include/net/dsa.h
index 16a502a6c26a..b9394379affb 100644
--- a/include/net/dsa.h
+++ b/include/net/dsa.h
@@ -396,6 +396,7 @@ struct dsa_switch_driver {
 void register_switch_driver(struct dsa_switch_driver *type);
 void unregister_switch_driver(struct dsa_switch_driver *type);
 struct mii_bus *dsa_host_dev_to_mii_bus(struct device *dev);
+struct net_device *dev_to_net_device(struct device *dev);
 
 static inline bool dsa_uses_tagged_protocol(struct dsa_switch_tree *dst)
 {
diff --git a/net/dsa/dsa.c b/net/dsa/dsa.c
index 2306d1b87c83..691ffc3f8ee6 100644
--- a/net/dsa/dsa.c
+++ b/net/dsa/dsa.c
@@ -491,7 +491,7 @@ struct mii_bus *dsa_host_dev_to_mii_bus(struct device *dev)
 }
 EXPORT_SYMBOL_GPL(dsa_host_dev_to_mii_bus);
 
-static struct net_device *dev_to_net_device(struct device *dev)
+struct net_device *dev_to_net_device(struct device *dev)
 {
 	struct device *d;
 
@@ -508,6 +508,7 @@ static struct net_device *dev_to_net_device(struct device *dev)
 
 	return NULL;
 }
+EXPORT_SYMBOL_GPL(dev_to_net_device);
 
 #ifdef CONFIG_OF
 static int dsa_of_setup_routing_table(struct dsa_platform_data *pd,
-- 
2.9.3
