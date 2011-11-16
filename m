From: will.deacon@arm.com (Will Deacon)
Date: Wed, 16 Nov 2011 16:48:13 +0000
Subject: [PATCH 3/4] ARM: proc-*.S: place cpu_reset functions into .idmap.text
 section
In-Reply-To: <1321462094-6647-1-git-send-email-will.deacon@arm.com>
References: <1321462094-6647-1-git-send-email-will.deacon@arm.com>
Message-ID: <1321462094-6647-4-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The CPU reset functions disable the MMU and therefore must be executed
with an identity mapping in place.

This patch places the CPU reset functions into the .idmap.text section,
causing the idmap code to include them as part of the identity mapping.

Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 arch/arm/mm/proc-arm1020.S  |    3 +++
 arch/arm/mm/proc-arm1020e.S |    3 +++
 arch/arm/mm/proc-arm1022.S  |    3 +++
 arch/arm/mm/proc-arm1026.S  |    3 +++
 arch/arm/mm/proc-arm6_7.S   |    4 ++++
 arch/arm/mm/proc-arm720.S   |    3 +++
 arch/arm/mm/proc-arm740.S   |    3 +++
 arch/arm/mm/proc-arm7tdmi.S |    3 +++
 arch/arm/mm/proc-arm920.S   |    3 +++
 arch/arm/mm/proc-arm922.S   |    3 +++
 arch/arm/mm/proc-arm925.S   |    3 +++
 arch/arm/mm/proc-arm926.S   |    3 +++
 arch/arm/mm/proc-arm940.S   |    3 +++
 arch/arm/mm/proc-arm946.S   |    3 +++
 arch/arm/mm/proc-arm9tdmi.S |    3 +++
 arch/arm/mm/proc-fa526.S    |    3 +++
 arch/arm/mm/proc-feroceon.S |    3 +++
 arch/arm/mm/proc-mohawk.S   |    3 +++
 arch/arm/mm/proc-sa110.S    |    3 +++
 arch/arm/mm/proc-sa1100.S   |    3 +++
 arch/arm/mm/proc-v6.S       |    3 +++
 arch/arm/mm/proc-v7.S       |    2 ++
 arch/arm/mm/proc-xsc3.S     |    3 +++
 arch/arm/mm/proc-xscale.S   |    3 +++
 24 files changed, 72 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mm/proc-arm1020.S b/arch/arm/mm/proc-arm1020.S
index 6746966..2349513 100644
--- a/arch/arm/mm/proc-arm1020.S
+++ b/arch/arm/mm/proc-arm1020.S
@@ -95,6 +95,7 @@ ENTRY(cpu_arm1020_proc_fin)
  * loc: location to jump to for soft reset
  */
 	.align	5
+	.pushsection	.idmap.text, "ax"
 ENTRY(cpu_arm1020_reset)
 	mov	ip, #0
 	mcr	p15, 0, ip, c7, c7, 0		@ invalidate I,D caches
@@ -107,6 +108,8 @@ ENTRY(cpu_arm1020_reset)
 	bic	ip, ip, #0x1100 		@ ...i...s........
 	mcr	p15, 0, ip, c1, c0, 0		@ ctrl register
 	mov	pc, r0
+ENDPROC(cpu_arm1020_reset)
+	.popsection
 
 /*
  * cpu_arm1020_do_idle()
diff --git a/arch/arm/mm/proc-arm1020e.S b/arch/arm/mm/proc-arm1020e.S
index 4251421..c244b06 100644
--- a/arch/arm/mm/proc-arm1020e.S
+++ b/arch/arm/mm/proc-arm1020e.S
@@ -95,6 +95,7 @@ ENTRY(cpu_arm1020e_proc_fin)
  * loc: location to jump to for soft reset
  */
 	.align	5
+	.pushsection	.idmap.text, "ax"
 ENTRY(cpu_arm1020e_reset)
 	mov	ip, #0
 	mcr	p15, 0, ip, c7, c7, 0		@ invalidate I,D caches
@@ -107,6 +108,8 @@ ENTRY(cpu_arm1020e_reset)
 	bic	ip, ip, #0x1100 		@ ...i...s........
 	mcr	p15, 0, ip, c1, c0, 0		@ ctrl register
 	mov	pc, r0
+ENDPROC(cpu_arm1020e_reset)
+	.popsection
 
 /*
  * cpu_arm1020e_do_idle()
diff --git a/arch/arm/mm/proc-arm1022.S b/arch/arm/mm/proc-arm1022.S
index d283cf3..38fe22e 100644
--- a/arch/arm/mm/proc-arm1022.S
+++ b/arch/arm/mm/proc-arm1022.S
@@ -84,6 +84,7 @@ ENTRY(cpu_arm1022_proc_fin)
  * loc: location to jump to for soft reset
  */
 	.align	5
+	.pushsection	.idmap.text, "ax"
 ENTRY(cpu_arm1022_reset)
 	mov	ip, #0
 	mcr	p15, 0, ip, c7, c7, 0		@ invalidate I,D caches
@@ -96,6 +97,8 @@ ENTRY(cpu_arm1022_reset)
 	bic	ip, ip, #0x1100 		@ ...i...s........
 	mcr	p15, 0, ip, c1, c0, 0		@ ctrl register
 	mov	pc, r0
+ENDPROC(cpu_arm1022_reset)
+	.popsection
 
 /*
  * cpu_arm1022_do_idle()
diff --git a/arch/arm/mm/proc-arm1026.S b/arch/arm/mm/proc-arm1026.S
index 678a1ce..3eb9c3c 100644
--- a/arch/arm/mm/proc-arm1026.S
+++ b/arch/arm/mm/proc-arm1026.S
@@ -84,6 +84,7 @@ ENTRY(cpu_arm1026_proc_fin)
  * loc: location to jump to for soft reset
  */
 	.align	5
+	.pushsection	.idmap.text, "ax"
 ENTRY(cpu_arm1026_reset)
 	mov	ip, #0
 	mcr	p15, 0, ip, c7, c7, 0		@ invalidate I,D caches
@@ -96,6 +97,8 @@ ENTRY(cpu_arm1026_reset)
 	bic	ip, ip, #0x1100 		@ ...i...s........
 	mcr	p15, 0, ip, c1, c0, 0		@ ctrl register
 	mov	pc, r0
+ENDPROC(cpu_arm1026_reset)
+	.popsection
 
 /*
  * cpu_arm1026_do_idle()
diff --git a/arch/arm/mm/proc-arm6_7.S b/arch/arm/mm/proc-arm6_7.S
index e5b974c..4fbeb5b 100644
--- a/arch/arm/mm/proc-arm6_7.S
+++ b/arch/arm/mm/proc-arm6_7.S
@@ -225,6 +225,7 @@ ENTRY(cpu_arm7_set_pte_ext)
  * Params  : r0 = address to jump to
  * Notes   : This sets up everything for a reset
  */
+		.pushsection	.idmap.text, "ax"
 ENTRY(cpu_arm6_reset)
 ENTRY(cpu_arm7_reset)
 		mov	r1, #0
@@ -235,6 +236,9 @@ ENTRY(cpu_arm7_reset)
 		mov	r1, #0x30
 		mcr	p15, 0, r1, c1, c0, 0		@ turn off MMU etc
 		mov	pc, r0
+ENDPROC(cpu_arm6_reset)
+ENDPROC(cpu_arm7_reset)
+		.popsection
 
 		__CPUINIT
 
diff --git a/arch/arm/mm/proc-arm720.S b/arch/arm/mm/proc-arm720.S
index 55f4e29..0ac908c 100644
--- a/arch/arm/mm/proc-arm720.S
+++ b/arch/arm/mm/proc-arm720.S
@@ -101,6 +101,7 @@ ENTRY(cpu_arm720_set_pte_ext)
  * Params  : r0 = address to jump to
  * Notes   : This sets up everything for a reset
  */
+		.pushsection	.idmap.text, "ax"
 ENTRY(cpu_arm720_reset)
 		mov	ip, #0
 		mcr	p15, 0, ip, c7, c7, 0		@ invalidate cache
@@ -112,6 +113,8 @@ ENTRY(cpu_arm720_reset)
 		bic	ip, ip, #0x2100			@ ..v....s........
 		mcr	p15, 0, ip, c1, c0, 0		@ ctrl register
 		mov	pc, r0
+ENDPROC(cpu_arm720_reset)
+		.popsection
 
 	__CPUINIT
 
diff --git a/arch/arm/mm/proc-arm740.S b/arch/arm/mm/proc-arm740.S
index 4506be3..dc5de5d 100644
--- a/arch/arm/mm/proc-arm740.S
+++ b/arch/arm/mm/proc-arm740.S
@@ -49,6 +49,7 @@ ENTRY(cpu_arm740_proc_fin)
  * Params  : r0 = address to jump to
  * Notes   : This sets up everything for a reset
  */
+	.pushsection	.idmap.text, "ax"
 ENTRY(cpu_arm740_reset)
 	mov	ip, #0
 	mcr	p15, 0, ip, c7, c0, 0		@ invalidate cache
@@ -56,6 +57,8 @@ ENTRY(cpu_arm740_reset)
 	bic	ip, ip, #0x0000000c		@ ............wc..
 	mcr	p15, 0, ip, c1, c0, 0		@ ctrl register
 	mov	pc, r0
+ENDPROC(cpu_arm740_reset)
+	.popsection
 
 	__CPUINIT
 
diff --git a/arch/arm/mm/proc-arm7tdmi.S b/arch/arm/mm/proc-arm7tdmi.S
index 7e0e1fe..6ddea3e 100644
--- a/arch/arm/mm/proc-arm7tdmi.S
+++ b/arch/arm/mm/proc-arm7tdmi.S
@@ -45,8 +45,11 @@ ENTRY(cpu_arm7tdmi_proc_fin)
  * Params  : loc(r0)	address to jump to
  * Purpose : Sets up everything for a reset and jump to the location for soft reset.
  */
+		.pushsection	.idmap.text, "ax"
 ENTRY(cpu_arm7tdmi_reset)
 		mov	pc, r0
+ENDPROC(cpu_arm7tdmi_reset)
+		.popsection
 
 		__CPUINIT
 
diff --git a/arch/arm/mm/proc-arm920.S b/arch/arm/mm/proc-arm920.S
index 88fb3d9..cb941ae 100644
--- a/arch/arm/mm/proc-arm920.S
+++ b/arch/arm/mm/proc-arm920.S
@@ -85,6 +85,7 @@ ENTRY(cpu_arm920_proc_fin)
  * loc: location to jump to for soft reset
  */
 	.align	5
+	.pushsection	.idmap.text, "ax"
 ENTRY(cpu_arm920_reset)
 	mov	ip, #0
 	mcr	p15, 0, ip, c7, c7, 0		@ invalidate I,D caches
@@ -97,6 +98,8 @@ ENTRY(cpu_arm920_reset)
 	bic	ip, ip, #0x1100			@ ...i...s........
 	mcr	p15, 0, ip, c1, c0, 0		@ ctrl register
 	mov	pc, r0
+ENDPROC(cpu_arm920_reset)
+	.popsection
 
 /*
  * cpu_arm920_do_idle()
diff --git a/arch/arm/mm/proc-arm922.S b/arch/arm/mm/proc-arm922.S
index 490e188..4ec0e07 100644
--- a/arch/arm/mm/proc-arm922.S
+++ b/arch/arm/mm/proc-arm922.S
@@ -87,6 +87,7 @@ ENTRY(cpu_arm922_proc_fin)
  * loc: location to jump to for soft reset
  */
 	.align	5
+	.pushsection	.idmap.text, "ax"
 ENTRY(cpu_arm922_reset)
 	mov	ip, #0
 	mcr	p15, 0, ip, c7, c7, 0		@ invalidate I,D caches
@@ -99,6 +100,8 @@ ENTRY(cpu_arm922_reset)
 	bic	ip, ip, #0x1100			@ ...i...s........
 	mcr	p15, 0, ip, c1, c0, 0		@ ctrl register
 	mov	pc, r0
+ENDPROC(cpu_arm922_reset)
+	.popsection
 
 /*
  * cpu_arm922_do_idle()
diff --git a/arch/arm/mm/proc-arm925.S b/arch/arm/mm/proc-arm925.S
index 51d494b..9dccd9a 100644
--- a/arch/arm/mm/proc-arm925.S
+++ b/arch/arm/mm/proc-arm925.S
@@ -108,6 +108,7 @@ ENTRY(cpu_arm925_proc_fin)
  * loc: location to jump to for soft reset
  */
 	.align	5
+	.pushsection	.idmap.text, "ax"
 ENTRY(cpu_arm925_reset)
 	/* Send software reset to MPU and DSP */
 	mov	ip, #0xff000000
@@ -115,6 +116,8 @@ ENTRY(cpu_arm925_reset)
 	orr	ip, ip, #0x0000ce00
 	mov	r4, #1
 	strh	r4, [ip, #0x10]
+ENDPROC(cpu_arm925_reset)
+	.popsection
 
 	mov	ip, #0
 	mcr	p15, 0, ip, c7, c7, 0		@ invalidate I,D caches
diff --git a/arch/arm/mm/proc-arm926.S b/arch/arm/mm/proc-arm926.S
index 9f8fd91..820259b 100644
--- a/arch/arm/mm/proc-arm926.S
+++ b/arch/arm/mm/proc-arm926.S
@@ -77,6 +77,7 @@ ENTRY(cpu_arm926_proc_fin)
  * loc: location to jump to for soft reset
  */
 	.align	5
+	.pushsection	.idmap.text, "ax"
 ENTRY(cpu_arm926_reset)
 	mov	ip, #0
 	mcr	p15, 0, ip, c7, c7, 0		@ invalidate I,D caches
@@ -89,6 +90,8 @@ ENTRY(cpu_arm926_reset)
 	bic	ip, ip, #0x1100			@ ...i...s........
 	mcr	p15, 0, ip, c1, c0, 0		@ ctrl register
 	mov	pc, r0
+ENDPROC(cpu_arm926_reset)
+	.popsection
 
 /*
  * cpu_arm926_do_idle()
diff --git a/arch/arm/mm/proc-arm940.S b/arch/arm/mm/proc-arm940.S
index ac750d5..9fdc0a1 100644
--- a/arch/arm/mm/proc-arm940.S
+++ b/arch/arm/mm/proc-arm940.S
@@ -48,6 +48,7 @@ ENTRY(cpu_arm940_proc_fin)
  * Params  : r0 = address to jump to
  * Notes   : This sets up everything for a reset
  */
+	.pushsection	.idmap.text, "ax"
 ENTRY(cpu_arm940_reset)
 	mov	ip, #0
 	mcr	p15, 0, ip, c7, c5, 0		@ flush I cache
@@ -58,6 +59,8 @@ ENTRY(cpu_arm940_reset)
 	bic	ip, ip, #0x00001000		@ i-cache
 	mcr	p15, 0, ip, c1, c0, 0		@ ctrl register
 	mov	pc, r0
+ENDPROC(cpu_arm940_reset)
+	.popsection
 
 /*
  * cpu_arm940_do_idle()
diff --git a/arch/arm/mm/proc-arm946.S b/arch/arm/mm/proc-arm946.S
index 683af3a..f684cfe 100644
--- a/arch/arm/mm/proc-arm946.S
+++ b/arch/arm/mm/proc-arm946.S
@@ -55,6 +55,7 @@ ENTRY(cpu_arm946_proc_fin)
  * Params  : r0 = address to jump to
  * Notes   : This sets up everything for a reset
  */
+	.pushsection	.idmap.text, "ax"
 ENTRY(cpu_arm946_reset)
 	mov	ip, #0
 	mcr	p15, 0, ip, c7, c5, 0		@ flush I cache
@@ -65,6 +66,8 @@ ENTRY(cpu_arm946_reset)
 	bic	ip, ip, #0x00001000		@ i-cache
 	mcr	p15, 0, ip, c1, c0, 0		@ ctrl register
 	mov	pc, r0
+ENDPROC(cpu_arm946_reset)
+	.popsection
 
 /*
  * cpu_arm946_do_idle()
diff --git a/arch/arm/mm/proc-arm9tdmi.S b/arch/arm/mm/proc-arm9tdmi.S
index 2120f9e..8881391 100644
--- a/arch/arm/mm/proc-arm9tdmi.S
+++ b/arch/arm/mm/proc-arm9tdmi.S
@@ -45,8 +45,11 @@ ENTRY(cpu_arm9tdmi_proc_fin)
  * Params  : loc(r0)	address to jump to
  * Purpose : Sets up everything for a reset and jump to the location for soft reset.
  */
+		.pushsection	.idmap.text, "ax"
 ENTRY(cpu_arm9tdmi_reset)
 		mov	pc, r0
+ENDPROC(cpu_arm9tdmi_reset)
+		.popsection
 
 		__CPUINIT
 
diff --git a/arch/arm/mm/proc-fa526.S b/arch/arm/mm/proc-fa526.S
index 4c7a571..272558a 100644
--- a/arch/arm/mm/proc-fa526.S
+++ b/arch/arm/mm/proc-fa526.S
@@ -57,6 +57,7 @@ ENTRY(cpu_fa526_proc_fin)
  * loc: location to jump to for soft reset
  */
 	.align	4
+	.pushsection	.idmap.text, "ax"
 ENTRY(cpu_fa526_reset)
 /* TODO: Use CP8 if possible... */
 	mov	ip, #0
@@ -73,6 +74,8 @@ ENTRY(cpu_fa526_reset)
 	nop
 	nop
 	mov	pc, r0
+ENDPROC(cpu_fa526_reset)
+	.popsection
 
 /*
  * cpu_fa526_do_idle()
diff --git a/arch/arm/mm/proc-feroceon.S b/arch/arm/mm/proc-feroceon.S
index 8a6c2f7..ba3c500 100644
--- a/arch/arm/mm/proc-feroceon.S
+++ b/arch/arm/mm/proc-feroceon.S
@@ -98,6 +98,7 @@ ENTRY(cpu_feroceon_proc_fin)
  * loc: location to jump to for soft reset
  */
 	.align	5
+	.pushsection	.idmap.text, "ax"
 ENTRY(cpu_feroceon_reset)
 	mov	ip, #0
 	mcr	p15, 0, ip, c7, c7, 0		@ invalidate I,D caches
@@ -110,6 +111,8 @@ ENTRY(cpu_feroceon_reset)
 	bic	ip, ip, #0x1100			@ ...i...s........
 	mcr	p15, 0, ip, c1, c0, 0		@ ctrl register
 	mov	pc, r0
+ENDPROC(cpu_feroceon_reset)
+	.popsection
 
 /*
  * cpu_feroceon_do_idle()
diff --git a/arch/arm/mm/proc-mohawk.S b/arch/arm/mm/proc-mohawk.S
index db52b0f..cdfedc5 100644
--- a/arch/arm/mm/proc-mohawk.S
+++ b/arch/arm/mm/proc-mohawk.S
@@ -69,6 +69,7 @@ ENTRY(cpu_mohawk_proc_fin)
  * (same as arm926)
  */
 	.align	5
+	.pushsection	.idmap.text, "ax"
 ENTRY(cpu_mohawk_reset)
 	mov	ip, #0
 	mcr	p15, 0, ip, c7, c7, 0		@ invalidate I,D caches
@@ -79,6 +80,8 @@ ENTRY(cpu_mohawk_reset)
 	bic	ip, ip, #0x1100			@ ...i...s........
 	mcr	p15, 0, ip, c1, c0, 0		@ ctrl register
 	mov	pc, r0
+ENDPROC(cpu_mohawk_reset)
+	.popsection
 
 /*
  * cpu_mohawk_do_idle()
diff --git a/arch/arm/mm/proc-sa110.S b/arch/arm/mm/proc-sa110.S
index d50ada2..775d70f 100644
--- a/arch/arm/mm/proc-sa110.S
+++ b/arch/arm/mm/proc-sa110.S
@@ -62,6 +62,7 @@ ENTRY(cpu_sa110_proc_fin)
  * loc: location to jump to for soft reset
  */
 	.align	5
+	.pushsection	.idmap.text, "ax"
 ENTRY(cpu_sa110_reset)
 	mov	ip, #0
 	mcr	p15, 0, ip, c7, c7, 0		@ invalidate I,D caches
@@ -74,6 +75,8 @@ ENTRY(cpu_sa110_reset)
 	bic	ip, ip, #0x1100			@ ...i...s........
 	mcr	p15, 0, ip, c1, c0, 0		@ ctrl register
 	mov	pc, r0
+ENDPROC(cpu_sa110_reset)
+	.popsection
 
 /*
  * cpu_sa110_do_idle(type)
diff --git a/arch/arm/mm/proc-sa1100.S b/arch/arm/mm/proc-sa1100.S
index 7d91545..3aa0da1 100644
--- a/arch/arm/mm/proc-sa1100.S
+++ b/arch/arm/mm/proc-sa1100.S
@@ -70,6 +70,7 @@ ENTRY(cpu_sa1100_proc_fin)
  * loc: location to jump to for soft reset
  */
 	.align	5
+	.pushsection	.idmap.text, "ax"
 ENTRY(cpu_sa1100_reset)
 	mov	ip, #0
 	mcr	p15, 0, ip, c7, c7, 0		@ invalidate I,D caches
@@ -82,6 +83,8 @@ ENTRY(cpu_sa1100_reset)
 	bic	ip, ip, #0x1100			@ ...i...s........
 	mcr	p15, 0, ip, c1, c0, 0		@ ctrl register
 	mov	pc, r0
+ENDPROC(cpu_sa1100_reset)
+	.popsection
 
 /*
  * cpu_sa1100_do_idle(type)
diff --git a/arch/arm/mm/proc-v6.S b/arch/arm/mm/proc-v6.S
index d061d2f..5900cd5 100644
--- a/arch/arm/mm/proc-v6.S
+++ b/arch/arm/mm/proc-v6.S
@@ -55,6 +55,7 @@ ENTRY(cpu_v6_proc_fin)
  *	- loc   - location to jump to for soft reset
  */
 	.align	5
+	.pushsection	.idmap.text, "ax"
 ENTRY(cpu_v6_reset)
 	mrc	p15, 0, r1, c1, c0, 0		@ ctrl register
 	bic	r1, r1, #0x1			@ ...............m
@@ -62,6 +63,8 @@ ENTRY(cpu_v6_reset)
 	mov	r1, #0
 	mcr	p15, 0, r1, c7, c5, 4		@ ISB
 	mov	pc, r0
+ENDPROC(cpu_v6_reset)
+	.popsection
 
 /*
  *	cpu_v6_do_idle()
diff --git a/arch/arm/mm/proc-v7.S b/arch/arm/mm/proc-v7.S
index 2c559ac..66a185f 100644
--- a/arch/arm/mm/proc-v7.S
+++ b/arch/arm/mm/proc-v7.S
@@ -63,6 +63,7 @@ ENDPROC(cpu_v7_proc_fin)
  *      caches disabled.
  */
 	.align	5
+	.pushsection	.idmap.text, "ax"
 ENTRY(cpu_v7_reset)
 	mrc	p15, 0, r1, c1, c0, 0		@ ctrl register
 	bic	r1, r1, #0x1			@ ...............m
@@ -71,6 +72,7 @@ ENTRY(cpu_v7_reset)
 	isb
 	mov	pc, r0
 ENDPROC(cpu_v7_reset)
+	.popsection
 
 /*
  *	cpu_v7_do_idle()
diff --git a/arch/arm/mm/proc-xsc3.S b/arch/arm/mm/proc-xsc3.S
index abf0507..b0d5786 100644
--- a/arch/arm/mm/proc-xsc3.S
+++ b/arch/arm/mm/proc-xsc3.S
@@ -105,6 +105,7 @@ ENTRY(cpu_xsc3_proc_fin)
  * loc: location to jump to for soft reset
  */
 	.align	5
+	.pushsection	.idmap.text, "ax"
 ENTRY(cpu_xsc3_reset)
 	mov	r1, #PSR_F_BIT|PSR_I_BIT|SVC_MODE
 	msr	cpsr_c, r1			@ reset CPSR
@@ -119,6 +120,8 @@ ENTRY(cpu_xsc3_reset)
 	@ already containing those two last instructions to survive.
 	mcr	p15, 0, ip, c8, c7, 0		@ invalidate I and D TLBs
 	mov	pc, r0
+ENDPROC(cpu_xsc3_reset)
+	.popsection
 
 /*
  * cpu_xsc3_do_idle()
diff --git a/arch/arm/mm/proc-xscale.S b/arch/arm/mm/proc-xscale.S
index 3277904..4ffebaa 100644
--- a/arch/arm/mm/proc-xscale.S
+++ b/arch/arm/mm/proc-xscale.S
@@ -142,6 +142,7 @@ ENTRY(cpu_xscale_proc_fin)
  * Beware PXA270 erratum E7.
  */
 	.align	5
+	.pushsection	.idmap.text, "ax"
 ENTRY(cpu_xscale_reset)
 	mov	r1, #PSR_F_BIT|PSR_I_BIT|SVC_MODE
 	msr	cpsr_c, r1			@ reset CPSR
@@ -160,6 +161,8 @@ ENTRY(cpu_xscale_reset)
 	@ already containing those two last instructions to survive.
 	mcr	p15, 0, ip, c8, c7, 0		@ invalidate I & D TLBs
 	mov	pc, r0
+ENDPROC(cpu_xscale_reset)
+	.popsection
 
 /*
  * cpu_xscale_do_idle()
-- 
1.7.4.1
