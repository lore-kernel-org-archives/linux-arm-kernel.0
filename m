From: msalter@redhat.com (Mark Salter)
Date: Wed, 04 Sep 2013 10:10:02 -0400
Subject: [PATCH] Documentation/arm64: clarify requirements for DTB placement
Message-ID: <1378303802.3485.36.camel@deneb.redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The current description of DTB placement requirements does not quite
match the kernel code in head.S: __vet_fdt and __create_page_tables.
This patch tweaks the text to match the actual requirements placed on
it by the code.

Signed-off-by: Mark Salter <msalter@redhat.com>
---
 Documentation/arm64/booting.txt | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/Documentation/arm64/booting.txt b/Documentation/arm64/booting.txt
index 5273c4d..98df4a0 100644
--- a/Documentation/arm64/booting.txt
+++ b/Documentation/arm64/booting.txt
@@ -45,9 +45,9 @@ sees fit.)
 
 Requirement: MANDATORY
 
-The device tree blob (dtb) must be no bigger than 2 megabytes in size
-and placed at a 2-megabyte boundary within the first 512 megabytes from
-the start of the kernel image. This is to allow the kernel to map the
+The device tree blob (dtb) must be placed on an 8-byte boundary within
+the first 512 megabytes from the start of the kernel image and must not
+cross a 2-megabyte boundary. This is to allow the kernel to map the
 blob using a single section mapping in the initial page tables.
 
 
-- 
1.8.3.1
