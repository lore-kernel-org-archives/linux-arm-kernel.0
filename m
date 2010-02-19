From: grant.likely@secretlab.ca (Grant Likely)
Date: Fri, 19 Feb 2010 12:27:00 -0700
Subject: [PATCH 1/7] arm-dt: Add ATAG_DEVTREE tag
In-Reply-To: <20100219185953.15318.4850.stgit@angua>
References: <20100219185953.15318.4850.stgit@angua>
Message-ID: <20100219192646.15318.93865.stgit@angua>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Jeremy Kerr <jeremy.kerr@canonical.com>

We'd like to provide a pointer to the device tree blob through the atags
mechanism, so add a tag type containing a physical dtb pointer.

We won't need a parser for this, as we'll need to do the devtree parsing
a little earlier than other tags.

Signed-off-by: Jeremy Kerr <jeremy.kerr@canonical.com>
Signed-off-by: Grant Likely <grant.likely@secretlab.ca>
---

 arch/arm/include/asm/setup.h |    9 +++++++++
 1 files changed, 9 insertions(+), 0 deletions(-)

diff --git a/arch/arm/include/asm/setup.h b/arch/arm/include/asm/setup.h
index dfa9ddf..ee77cec 100644
--- a/arch/arm/include/asm/setup.h
+++ b/arch/arm/include/asm/setup.h
@@ -126,6 +126,14 @@ struct tag_cmdline {
 	char	cmdline[1];	/* this is the minimum size */
 };
 
+/* flattened device tree blob pointer */
+#define ATAG_DEVTREE	0x5441000a
+
+struct tag_devtree {
+	__u32 start;	/* physical start address */
+	__u32 size;	/* size of dtb image in bytes */
+};
+
 /* acorn RiscPC specific information */
 #define ATAG_ACORN	0x41000101
 
@@ -155,6 +163,7 @@ struct tag {
 		struct tag_revision	revision;
 		struct tag_videolfb	videolfb;
 		struct tag_cmdline	cmdline;
+		struct tag_devtree	devtree;
 
 		/*
 		 * Acorn specific
