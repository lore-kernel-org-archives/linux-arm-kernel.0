From: mohun106@gmail.com (Radha Mohan)
Date: Mon, 2 Sep 2013 16:18:02 +0530
Subject: [PATCH 1/1] arm64: Align an assembler string properly
Message-ID: <CAC8NTUWvEYpugbUfZ3A54zFbS71mnChfCk2sVKUxxxWAHz+nRw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Corey Minyard <cminyard@mvista.com>

Do a proper align and put it in the right section.

Signed-off-by: Corey Minyard <cminyard@mvista.com>
---
 arch/arm64/mm/proc.S |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/arch/arm64/mm/proc.S b/arch/arm64/mm/proc.S
index 76d8320..1f89adc 100644
--- a/arch/arm64/mm/proc.S
+++ b/arch/arm64/mm/proc.S
@@ -95,10 +95,11 @@ ENTRY(cpu_do_switch_mm)
        ret
 ENDPROC(cpu_do_switch_mm)

+       .section ".rodata"
 cpu_name:
        .ascii  "AArch64 Processor"
-       .align

+       .align 3
        .section ".text.init", #alloc, #execinstr

 /*
--
1.7.1
