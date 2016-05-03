From: rmk@arm.linux.org.uk (Russell King)
Date: Tue, 03 May 2016 11:21:44 +0100
Subject: [PATCH kexec-tools 08/32] kexec: add max_size to memory_ranges
In-Reply-To: <CAHB_GurHc1aVfzJATpNW5yf5s5KkF=t5s09FbWq3+9+ZX39KUg@mail.gmail.com>
References: <CAHB_GurHc1aVfzJATpNW5yf5s5KkF=t5s09FbWq3+9+ZX39KUg@mail.gmail.com>
Message-ID: <E1axXSa-0004hf-Iz@e0050434b2927.dyn.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Many implementations statically allocate the memory range array, which
therefore will have a maximum allowable size.  Add this information to
the memory_ranges structure, so we don't have to carry it around.

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
