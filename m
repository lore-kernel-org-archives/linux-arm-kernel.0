From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Tue, 25 Feb 2014 13:38:57 +0100
Subject: [PATCH resend 1/3] binfmt_elf: add ELF_HWCAP2 to compat auxv entries
In-Reply-To: <1393331939-31289-1-git-send-email-ard.biesheuvel@linaro.org>
References: <1393331939-31289-1-git-send-email-ard.biesheuvel@linaro.org>
Message-ID: <1393331939-31289-2-git-send-email-ard.biesheuvel@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add ELF_HWCAP2 to the set of auxv entries that is passed to
a 32-bit ELF program running in 32-bit compat mode under a
64-bit kernel.

Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Acked-by: Catalin Marinas <catalin.marinas@arm.com>
Acked-by: Andrew Morton <akpm@linux-foundation.org>
---
 fs/compat_binfmt_elf.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/fs/compat_binfmt_elf.c b/fs/compat_binfmt_elf.c
index a81147e2e4ef..4d24d17bcfc1 100644
--- a/fs/compat_binfmt_elf.c
+++ b/fs/compat_binfmt_elf.c
@@ -88,6 +88,11 @@ static void cputime_to_compat_timeval(const cputime_t cputime,
 #define	ELF_HWCAP		COMPAT_ELF_HWCAP
 #endif
 
+#ifdef	COMPAT_ELF_HWCAP2
+#undef	ELF_HWCAP2
+#define	ELF_HWCAP2		COMPAT_ELF_HWCAP2
+#endif
+
 #ifdef	COMPAT_ARCH_DLINFO
 #undef	ARCH_DLINFO
 #define	ARCH_DLINFO		COMPAT_ARCH_DLINFO
-- 
1.8.3.2
