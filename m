From: hunterd42@gmail.com (David Hunter)
Date: Thu, 08 Apr 2010 15:00:02 -0700
Subject: [PATCH] pxa: Remove unused MFP LPM definition
Message-ID: <4BBE51E2.1070103@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

MFP_LPM_INPUT snuck in some time ago as part of "[PATCH] pxa: better
MFP low power state support for pxa25x/pxa27x", but went unused in the
final revision of said patch. Using it on PXA3xx would cause an
out-of-bounds access of mfpr_table[]. Let's remove it before someone
gets hurt.

Signed-off-by: David Hunter <hunterd42@gmail.com>
---
  arch/arm/plat-pxa/include/plat/mfp.h |    1 -
  1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/arch/arm/plat-pxa/include/plat/mfp.h 
b/arch/arm/plat-pxa/include/plat/mfp.h
index 857a683..c5d24e9 100644
--- a/arch/arm/plat-pxa/include/plat/mfp.h
+++ b/arch/arm/plat-pxa/include/plat/mfp.h
@@ -378,7 +378,6 @@ typedef unsigned long mfp_cfg_t;
  #define MFP_LPM_PULL_LOW       (0x3 << 16)
  #define MFP_LPM_PULL_HIGH      (0x4 << 16)
  #define MFP_LPM_FLOAT          (0x5 << 16)
-#define MFP_LPM_INPUT          (0x6 << 16)
  #define MFP_LPM_STATE_MASK     (0x7 << 16)
  #define MFP_LPM_STATE(x)       (((x) >> 16) & 0x7)

--
1.6.0.3
