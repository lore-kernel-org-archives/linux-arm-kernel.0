From: jeremy.kerr@canonical.com (Jeremy Kerr)
Date: Tue, 22 Dec 2009 18:54:56 +0800
Subject: [PATCH 04/11] arm-dt: Add ATAG_DEVTREE tag
In-Reply-To: <1261479296.245235.191110925832.0.gpush@pororo>
Message-ID: <1261479296.246767.738000991632.4.gpush@pororo>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We'd like to provide a pointer to the device tree blob through the atags
mechanism, so add a tag type containing a physical dtb pointer.

We won't need a parser for this, as we'll need to do the devtree parsing
a little earlier than other tags.

Signed-off-by: Jeremy Kerr <jeremy.kerr@canonical.com>

---
 arch/arm/include/asm/setup.h |    8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm/include/asm/setup.h b/arch/arm/include/asm/setup.h
index 3fa2555..99ba6db 100644
--- a/arch/arm/include/asm/setup.h
+++ b/arch/arm/include/asm/setup.h
@@ -141,6 +141,13 @@ struct tag_memclk {
 	__u32 fmemclk;
 };
 
+/* OF device tree blob pointer */
+#define ATAG_DEVTREE	0x5441000a
+
+struct tag_devtree {
+	__u32 devtree;		/* physical address */
+};
+
 struct tag {
 	struct tag_header hdr;
 	union {
@@ -153,6 +160,7 @@ struct tag {
 		struct tag_revision	revision;
 		struct tag_videolfb	videolfb;
 		struct tag_cmdline	cmdline;
+		struct tag_devtree	devtree;
 
 		/*
 		 * Acorn specific
