From: samitolvanen@google.com (Sami Tolvanen)
Date: Fri,  3 Nov 2017 10:11:54 -0700
Subject: [PATCH 09/15] arm64: keep .altinstructions and .altinstr_replacement
In-Reply-To: <20171103171203.107569-1-samitolvanen@google.com>
References: <20171103171203.107569-1-samitolvanen@google.com>
Message-ID: <20171103171203.107569-11-samitolvanen@google.com>
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
2.15.0.403.gc27cc4dac6-goog
