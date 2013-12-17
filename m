From: robin.murphy@arm.com (Robin Murphy)
Date: Tue, 17 Dec 2013 18:31:13 +0000
Subject: [PATCH 1/2] kvmtool: Support unsigned int options
In-Reply-To: <1387305074-29421-1-git-send-email-robin.murphy@arm.com>
References: <1387305074-29421-1-git-send-email-robin.murphy@arm.com>
Message-ID: <1387305074-29421-2-git-send-email-robin.murphy@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add support for unsigned int command-line options by implementing the
OPT_UINTEGER macro.

Signed-off-by: Robin Murphy <robin.murphy@arm.com>
Acked-by: Will Deacon <will.deacon@arm.com>
---
 tools/kvm/include/kvm/parse-options.h |    9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/tools/kvm/include/kvm/parse-options.h b/tools/kvm/include/kvm/parse-options.h
index 09a5fca..b03f151 100644
--- a/tools/kvm/include/kvm/parse-options.h
+++ b/tools/kvm/include/kvm/parse-options.h
@@ -109,6 +109,15 @@ struct option {
 	.help = (h)                         \
 }
 
+#define OPT_UINTEGER(s, l, v, h)            \
+{                                           \
+	.type = OPTION_UINTEGER,            \
+	.short_name = (s),                  \
+	.long_name = (l),                   \
+	.value = check_vtype(v, unsigned int *), \
+	.help = (h)                         \
+}
+
 #define OPT_U64(s, l, v, h)                 \
 {                                           \
 	.type = OPTION_U64,                 \
-- 
1.7.9.5
