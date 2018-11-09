From: vincenzo.frascino@arm.com (Vincenzo Frascino)
Date: Fri,  9 Nov 2018 12:37:08 +0000
Subject: [PATCH 05/27] kernel: Add clock_mode support
In-Reply-To: <20181109123730.8743-1-vincenzo.frascino@arm.com>
References: <20181109123730.8743-1-vincenzo.frascino@arm.com>
Message-ID: <20181109123730.8743-6-vincenzo.frascino@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Some architectures store the clock mode into the vDSO datapage,
consequently the generic datapage needs to be aligned to expose this
information.

This patch adds support for clock_mode in datapage.h.

Cc: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
---
 include/vdso/datapage.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/vdso/datapage.h b/include/vdso/datapage.h
index fb6ce4c3f2d0..9a934158f1b8 100644
--- a/include/vdso/datapage.h
+++ b/include/vdso/datapage.h
@@ -43,6 +43,7 @@ struct vdso_data {
 	__u32 tz_minuteswest;	/* Whacky timezone stuff */
 	__u32 tz_dsttime;
 	__u32 use_syscall;
+	__u32 clock_mode;
 };
 
 #endif /* !__ASSEMBLY__ */
-- 
2.19.1
