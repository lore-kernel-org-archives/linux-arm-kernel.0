From: f.fainelli@gmail.com (Florian Fainelli)
Date: Tue, 10 Jan 2017 12:12:31 -0800
Subject: [PATCH net-next 4/8] net: dsa: Move ports assignment closer to error
 checking
In-Reply-To: <20170110201235.21771-1-f.fainelli@gmail.com>
References: <20170110201235.21771-1-f.fainelli@gmail.com>
Message-ID: <20170110201235.21771-5-f.fainelli@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Move the assignment of ports in _dsa_register_switch() closer to where
it is checked, no functional change. Re-order declarations to be
preserve the inverted christmas tree style.

Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 net/dsa/dsa2.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/dsa/dsa2.c b/net/dsa/dsa2.c
index 9089b3b1d7f5..ddee540d9a83 100644
--- a/net/dsa/dsa2.c
+++ b/net/dsa/dsa2.c
@@ -600,8 +600,8 @@ static struct device_node *dsa_get_ports(struct dsa_switch *ds,
 static int _dsa_register_switch(struct dsa_switch *ds, struct device *dev)
 {
 	struct device_node *np = dev->of_node;
-	struct device_node *ports = dsa_get_ports(ds, np);
 	struct dsa_switch_tree *dst;
+	struct device_node *ports;
 	u32 tree, index;
 	int i, err;
 
@@ -609,6 +609,7 @@ static int _dsa_register_switch(struct dsa_switch *ds, struct device *dev)
 	if (err)
 		return err;
 
+	ports = dsa_get_ports(ds, np);
 	if (IS_ERR(ports))
 		return PTR_ERR(ports);
 
-- 
2.9.3
