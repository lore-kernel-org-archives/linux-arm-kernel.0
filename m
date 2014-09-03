From: apinski@cavium.com (Andrew Pinski)
Date: Wed,  3 Sep 2014 14:19:09 -0700
Subject: [PATCH 15/24] compat_binfmt_elf: coredump: Allow some core dump
 macros be overridden for compat.
In-Reply-To: <1409779158-30963-1-git-send-email-apinski@cavium.com>
References: <1409779158-30963-1-git-send-email-apinski@cavium.com>
Message-ID: <1409779158-30963-16-git-send-email-apinski@cavium.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On some targets (x86 [32bit and x32] and arm64 [aarch32 and ilp32]), there are
two compat elf abis.  This adds a few more "#define * COMPAT_*" for compat
targets to define if needed.

Signed-off-by: Andrew Pinski <apinski@cavium.com>
---
 fs/compat_binfmt_elf.c |   17 +++++++++++++++++
 1 files changed, 17 insertions(+), 0 deletions(-)

diff --git a/fs/compat_binfmt_elf.c b/fs/compat_binfmt_elf.c
index 4d24d17..8307927 100644
--- a/fs/compat_binfmt_elf.c
+++ b/fs/compat_binfmt_elf.c
@@ -130,6 +130,23 @@ static void cputime_to_compat_timeval(const cputime_t cputime,
 #define	arch_setup_additional_pages compat_arch_setup_additional_pages
 #endif
 
+
+#ifdef COMPAT_PR_REG_SIZE
+#define PR_REG_SIZE COMPAT_PR_REG_SIZE
+#endif
+
+#ifdef COMPAT_PRSTATUS_SIZE
+#define PRSTATUS_SIZE COMPAT_PRSTATUS_SIZE
+#endif
+
+#ifdef COMPAT_PR_REG_PTR
+#define PR_REG_PTR COMPAT_PR_REG_PTR
+#endif
+
+#ifdef COMPAT_SET_PR_FPVALID
+#define SET_PR_FPVALID COMPAT_SET_PR_FPVALID
+#endif
+
 /*
  * Rename a few of the symbols that binfmt_elf.c will define.
  * These are all local so the names don't really matter, but it
-- 
1.7.2.5
