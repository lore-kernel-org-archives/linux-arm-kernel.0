From: viresh.kumar@st.com (Viresh KUMAR)
Date: Mon, 30 Aug 2010 16:13:56 +0530
Subject: [PATCH 28/74] Incrementing the ecc_pos array to contain 128 char
In-Reply-To: <07ce8daf18d3a9f13864752074af3490a324d84c.1283161023.git.viresh.kumar@st.com>
References: <07ce8daf18d3a9f13864752074af3490a324d84c.1283161023.git.viresh.kumar@st.com>
Message-ID: <a750eadbd743c3a2d5dc8b35c25e0ee82f569e87.1283161023.git.viresh.kumar@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Vipin Kumar <vipin.kumar@st.com>

For a page size of 4096, the number of oob bytes are 128 per page. This demands
for an increased ecc_pos array as well as ecc can be placed at more than 64
locations.

This patch is added because SPEAr platforms NAND controller has 13 bytes of ecc
for each 512 bytes of data. This results in 104 bytes of ecc in case of 4096
byte page.

Signed-off-by: Vipin Kumar <vipin.kumar@st.com>
Signed-off-by: Viresh Kumar <viresh.kumar@st.com>
---
 include/mtd/mtd-abi.h |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/include/mtd/mtd-abi.h b/include/mtd/mtd-abi.h
index 4debb45..ff3f30e 100644
--- a/include/mtd/mtd-abi.h
+++ b/include/mtd/mtd-abi.h
@@ -150,7 +150,7 @@ struct nand_oobfree {
  */
 struct nand_ecclayout {
 	__u32 eccbytes;
-	__u32 eccpos[64];
+	__u32 eccpos[128];
 	__u32 oobavail;
 	struct nand_oobfree oobfree[MTD_MAX_OOBFREE_ENTRIES];
 };
-- 
1.7.2.2
