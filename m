From: rmk@arm.linux.org.uk (Russell King)
Date: Mon, 06 Jun 2016 17:59:24 +0100
Subject: [PATCH kexec-tools v2 08/32] kexec: add max_size to memory_ranges
In-Reply-To: <20160606164129.GM1041@n2100.armlinux.org.uk>
References: <20160606164129.GM1041@n2100.armlinux.org.uk>
Message-ID: <E1b9xs4-0003sB-0u@e0050434b2927.dyn.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Many implementations statically allocate the memory range array, which
therefore will have a maximum allowable size.  Add this information to
the memory_ranges structure, so we don't have to carry it around.

Reviewed-by: Pratyush Anand <panand@redhat.com>
Signed-off-by: Russell King <rmk@arm.linux.org.uk>
---
 kexec/kexec.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kexec/kexec.h b/kexec/kexec.h
index c02ac8f..9194f1c 100644
--- a/kexec/kexec.h
+++ b/kexec/kexec.h
@@ -142,6 +142,7 @@ struct memory_range {
 
 struct memory_ranges {
         unsigned int size;
+	unsigned int max_size;
         struct memory_range *ranges;
 };
 
-- 
1.9.1
