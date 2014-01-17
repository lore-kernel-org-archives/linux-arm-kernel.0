From: andreas.herrmann@calxeda.com (Andreas Herrmann)
Date: Fri, 17 Jan 2014 12:08:30 +0100
Subject: [PATCH v2 08/11] of: Increase MAX_PHANDLE_ARGS
In-Reply-To: <1389876263-25759-9-git-send-email-andreas.herrmann@calxeda.com>
References: <1389876263-25759-1-git-send-email-andreas.herrmann@calxeda.com>
 <1389876263-25759-9-git-send-email-andreas.herrmann@calxeda.com>
Message-ID: <20140117110830.GW3471@alberich>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


arm-smmu driver uses of_parse_phandle_with_args when parsing DT
information to determine stream IDs for a master device.
Thus the number of stream IDs per master device is bound by
MAX_PHANDLE_ARGS.

To support Calxeda ECX-2000 hardware arm-smmu driver requires a
slightly higher value for MAX_PHANDLE_ARGS as this hardware has 10
stream IDs for one master device.

Increasing it to 16 seems a reasonable choice.

Cc: Grant Likely <grant.likely@linaro.org>
Cc: Rob Herring <robh+dt@kernel.org>
Cc: devicetree at vger.kernel.org
Cc: Andreas Herrmann <herrmann.der.user@googlemail.com>
Acked-by: Rob Herring <robh@kernel.org>
Signed-off-by: Andreas Herrmann <andreas.herrmann@calxeda.com>
---
 include/linux/of.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/of.h b/include/linux/of.h
index 276c546..24e1b28 100644
--- a/include/linux/of.h
+++ b/include/linux/of.h
@@ -67,7 +67,7 @@ struct device_node {
 #endif
 };
 
-#define MAX_PHANDLE_ARGS 8
+#define MAX_PHANDLE_ARGS 16
 struct of_phandle_args {
 	struct device_node *np;
 	int args_count;
-- 
1.7.9.5
