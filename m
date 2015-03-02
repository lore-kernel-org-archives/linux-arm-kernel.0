From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Mon,  2 Mar 2015 11:48:55 +0000
Subject: [PATCH] arm64: Documentation: clarify Image placement in physical RAM
Message-ID: <1425296935-19097-1-git-send-email-ard.biesheuvel@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The early init code maps the kernel image using statically
allocated page tables. This means that we can only allow
Image to be placed such that we can map its entire static
footprint using a single table entry at all but the lowest
level. So update the documentation to reflect that the Image
should not cross a 512 MB boundary, which ensures the above
on both 4k and 64k pages kernels.

Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---
 Documentation/arm64/booting.txt | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/Documentation/arm64/booting.txt b/Documentation/arm64/booting.txt
index f3c05b5f9f08..728de8b9116c 100644
--- a/Documentation/arm64/booting.txt
+++ b/Documentation/arm64/booting.txt
@@ -113,8 +113,9 @@ The Image must be placed text_offset bytes from a 2MB aligned base
 address near the start of usable system RAM and called there. Memory
 below that base address is currently unusable by Linux, and therefore it
 is strongly recommended that this location is the start of system RAM.
-At least image_size bytes from the start of the image must be free for
-use by the kernel.
+The physical memory region consisting of image_size bytes counting from
+the start of the image must be free for use by the kernel, and must not
+cross a 512 MB physical alignment boundary.
 
 Any memory described to the kernel (even that below the 2MB aligned base
 address) which is not marked as reserved from the kernel e.g. with a
-- 
1.8.3.2
