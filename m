From: robherring2@gmail.com (Rob Herring)
Date: Mon,  1 Apr 2013 17:21:13 -0500
Subject: [PATCH v2 03/13] OF: add empty of_device_is_available for !OF
In-Reply-To: <1364854883-5961-1-git-send-email-robherring2@gmail.com>
References: <1364854883-5961-1-git-send-email-robherring2@gmail.com>
Message-ID: <1364854883-5961-4-git-send-email-robherring2@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Rob Herring <rob.herring@calxeda.com>

Add an empty version of of_device_is_available.

Signed-off-by: Rob Herring <rob.herring@calxeda.com>
---
 include/linux/of.h |    5 +++++
 1 file changed, 5 insertions(+)

diff --git a/include/linux/of.h b/include/linux/of.h
index a0f1292..95c8583 100644
--- a/include/linux/of.h
+++ b/include/linux/of.h
@@ -379,6 +379,11 @@ static inline int of_device_is_compatible(const struct device_node *device,
 	return 0;
 }
 
+static inline int of_device_is_available(const struct device_node *device)
+{
+	return 0;
+}
+
 static inline struct property *of_find_property(const struct device_node *np,
 						const char *name,
 						int *lenp)
-- 
1.7.10.4
