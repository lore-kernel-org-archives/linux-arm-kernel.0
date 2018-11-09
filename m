From: vincenzo.frascino@arm.com (Vincenzo Frascino)
Date: Fri,  9 Nov 2018 12:37:07 +0000
Subject: [PATCH 04/27] kernel: Add masks support for Raw and NTP time
In-Reply-To: <20181109123730.8743-1-vincenzo.frascino@arm.com>
References: <20181109123730.8743-1-vincenzo.frascino@arm.com>
Message-ID: <20181109123730.8743-5-vincenzo.frascino@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Depending on the clocksource selected there can be supported a
different resolution hence we require a mask to be applied to the
time calculation.

This patch exposes the mask in the datapage for Raw and NTP adjusted
clock.

Cc: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
---
 include/vdso/datapage.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/vdso/datapage.h b/include/vdso/datapage.h
index d50a108afaed..fb6ce4c3f2d0 100644
--- a/include/vdso/datapage.h
+++ b/include/vdso/datapage.h
@@ -36,8 +36,10 @@ struct vdso_data {
 	__u64 tai_sec;		/* International Atomic Time */
 	__u32 tb_seq_count;	/* Timebase sequence counter */
 	__u32 cs_mono_mult;	/* NTP-adjusted clocksource multiplier */
+	__u64 cs_mono_mask;	/* NTP-adjusted clocksource mask */
 	__u32 cs_shift;		/* Clocksource shift (mono = raw) */
 	__u32 cs_raw_mult;	/* Raw clocksource multiplier */
+	__u64 cs_raw_mask;	/* Raw clocksource mask */
 	__u32 tz_minuteswest;	/* Whacky timezone stuff */
 	__u32 tz_dsttime;
 	__u32 use_syscall;
-- 
2.19.1
