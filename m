From: samitolvanen@google.com (Sami Tolvanen)
Date: Thu, 30 Nov 2017 15:39:00 -0800
Subject: [PATCH v2 2/7] arm64: keep .altinstructions and .altinstr_replacement
In-Reply-To: <20171130233905.130602-1-samitolvanen@google.com>
References: <20171129234442.655-1-samitolvanen@google.com>
 <20171130233905.130602-1-samitolvanen@google.com>
Message-ID: <20171130233905.130602-3-samitolvanen@google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Make sure the linker doesn't remove .altinstructions or
.altinstr_replacement when CONFIG_LD_DEAD_CODE_DATA_ELIMINATION is
enabled.

Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
---
 arch/arm64/kernel/vmlinux.lds.S | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/kernel/vmlinux.lds.S b/arch/arm64/kernel/vmlinux.lds.S
index 7da3e5c366a0..15479995869c 100644
--- a/arch/arm64/kernel/vmlinux.lds.S
+++ b/arch/arm64/kernel/vmlinux.lds.S
@@ -138,11 +138,11 @@ SECTIONS
 	. = ALIGN(4);
 	.altinstructions : {
 		__alt_instructions = .;
-		*(.altinstructions)
+		KEEP(*(.altinstructions))
 		__alt_instructions_end = .;
 	}
 	.altinstr_replacement : {
-		*(.altinstr_replacement)
+		KEEP(*(.altinstr_replacement))
 	}
 
 	. = ALIGN(PAGE_SIZE);
-- 
2.15.0.531.g2ccb3012c9-goog
