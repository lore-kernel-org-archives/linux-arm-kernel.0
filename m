From: robin.murphy@arm.com (Robin Murphy)
Date: Tue, 24 May 2016 18:55:42 +0100
Subject: [PATCH 3/3] openrisc: Remove orphaned __addr_ok() definition
In-Reply-To: <4656e09e40e832b2690fb0280975c70a541fb7ef.1464111462.git.robin.murphy@arm.com>
References: <4656e09e40e832b2690fb0280975c70a541fb7ef.1464111462.git.robin.murphy@arm.com>
Message-ID: <2d34650818ced1b3c362dfc75d087b70c0f7edef.1464111462.git.robin.murphy@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Since commit b48b2c3e5043 ("openrisc: use generic strnlen_user()
function"), the definition of __addr_ok() has been languishing unused;
eradicate the sucker.

CC: Jonas Bonn <jonas@southpole.se>
Signed-off-by: Robin Murphy <robin.murphy@arm.com>
---
 arch/openrisc/include/asm/uaccess.h | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/arch/openrisc/include/asm/uaccess.h b/arch/openrisc/include/asm/uaccess.h
index a6bd07ca3d6c..74bcb34c6d0b 100644
--- a/arch/openrisc/include/asm/uaccess.h
+++ b/arch/openrisc/include/asm/uaccess.h
@@ -59,9 +59,6 @@
  */
 #define __range_ok(addr, size) (size <= get_fs() && addr <= (get_fs()-size))
 
-/* Ensure that addr is below task's addr_limit */
-#define __addr_ok(addr) ((unsigned long) addr < get_fs())
-
 #define access_ok(type, addr, size) \
 	__range_ok((unsigned long)addr, (unsigned long)size)
 
-- 
2.8.1.dirty
