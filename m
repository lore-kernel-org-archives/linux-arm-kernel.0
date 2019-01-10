Return-Path: <SRS0=vaNk=PS=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5943C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 17:23:32 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8E1FF2177B
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 17:23:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="QrerCBFT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8E1FF2177B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=L/olmg0kgEdd2Xegof0Uhg/YIf50DJgadwXZWC03X+c=; b=QrerCBFTXOO/81
	hKXPUuOcfHnvJBbiFa96AaQaOqkqcW3eK1Y1WKOEV/+IaQZt6PZ7zxj8ap8ujl2bj3LiaUYJj8vqf
	8ZPc6aCOp/iEGklMHraOAt1rwQhfk3wll1jEyCRBtvnwSz0qnCgJ6IA4+hVCjd9vCFH3eHxw6NrIP
	mumT7zoTwksAjp5WUVaRN5JNha+N6bGGvrDr/OD9hlFxeS8lHwjgiXr/r9OVtZHk6GMP4qyVi4T/H
	UGBT2kyjc7SW9jdA+uRXRpTeXBVGabp5zPn7DL/scI545M0mtQHhpRYcq2dEeEB95kVeZ5VlA7dFF
	WbsT/Ow5iQw0CO6EeKrw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1ghe3D-00084V-2G; Thu, 10 Jan 2019 17:23:27 +0000
Received: from mout.kundenserver.de ([217.72.192.73])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1ghe3A-00083L-81
 for linux-arm-kernel@lists.infradead.org; Thu, 10 Jan 2019 17:23:26 +0000
Received: from wuerfel.lan ([109.192.41.194]) by mrelayeu.kundenserver.de
 (mreue109 [212.227.15.145]) with ESMTPA (Nemesis) id
 1Mzhax-1hTojh0PtR-00veYw; Thu, 10 Jan 2019 18:22:24 +0100
From: Arnd Bergmann <arnd@arndb.de>
To: y2038@lists.linaro.org, linux-api@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: [PATCH 02/11] time: Add struct __kernel_timex
Date: Thu, 10 Jan 2019 18:22:07 +0100
Message-Id: <20190110172216.313063-3-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20190110172216.313063-1-arnd@arndb.de>
References: <20190110172216.313063-1-arnd@arndb.de>
MIME-Version: 1.0
X-Provags-ID: V03:K1:bbac36R+LhLZ8+Oo9xPSyADBJ/5d5ogzU0cFHDJf8/4GxYsw3Wg
 sIiWb4Ab2BE1p/973p3l1oNrVyQRYpf/5LO2l8Au8n1Zim29u9sj0NT8nEMvl2pI3HJBo8J
 /r+du4G7mSKK8Ln0J8bA7+RTkjO5HPsOyqvEvvFnS2vZwg5USJendgIxpfX5jGSxpP3dJd4
 Rkn0UKeAupw2nM5fGsddw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:RuICwid1NJg=:wqiEQ8d5BExfHMlaj5msbB
 BtgfdXYe5ZBZnmu/1NFkQfvgPM/zjEoPd1dg6JhnXviB38uZshNxJfLUlplLaqag57wr1RN/U
 J0CLo5Gsy5wme4nx20oB9y+h5I21TKg9fmdfJYTRCMQrFIUDyOr9UH4ZMdlg9N9W3nIhIYvEe
 6QZWIILf9pEQ+pnHKZw+98tQ7RdibZzulxWi64QYE0m4ADqBZsRbPTCd2bwzdPOoLjYJETUYz
 3SvPcI/7gjUZsikMT4ATJ09sZc4OWOUBcTNe4W5GyB0vaAAJSKLAVDB7FoLDbl8mm2lEmwH9G
 KHgPyElAkFvCCOdwv1VhwroG9vvkMMCclLKAl0D21e4BhOehmtDJyRHHifjpidJgyvKjJs8lp
 rc6AVemgT2ooKsAlXqFO8K48KmlxG55+V1QVjrbMSd0SR7CiVAW09z/Er6/rpEU9lv0/L//XP
 j1S6qbqWMmZtssCn+vVDusJYHWUfJ18lTZph+Z3APFTeJ8uoQccIcllCaa0K1aKYDWHoZ0L6G
 8BFVr1Do0WK42PGwQmaP5j4DZLX/CC1jDHX0ej9ho9r+yeLsYyugCYe2edqC0MO5sOrSdHvfz
 4q9ItE5ijNINmAwb1E1pINKALcv6CsUzgJi96+Pk8Lux2yxkA1Fsoak+3WtDe6SOnmdOtocd2
 q9O5CiDE78pK7LiG9JhMfNIB0mKjayGb6O0cA6pkGWheJAQoyOdp+6unsxzTIv6sYlQtkaHSx
 t0VAud/LURaO8e8TxVgWWknitX0EuB7BnIEa3w==
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190110_092324_586692_3B920A2E 
X-CRM114-Status: GOOD (  14.82  )
X-BeenThere: linux-arm-kernel@lists.infradead.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <linux-arm-kernel.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>, 
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>, 
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: dalias@libc.org, linux-ia64@vger.kernel.org, linux-sh@vger.kernel.org,
 catalin.marinas@arm.com, will.deacon@arm.com, jcmvbkbc@gmail.com,
 deepa.kernel@gmail.com, hpa@zytor.com, sparclinux@vger.kernel.org,
 linux-arch@vger.kernel.org, linux-s390@vger.kernel.org, mpe@ellerman.id.au,
 deller@gmx.de, x86@kernel.org, linux@armlinux.org.uk, mingo@redhat.com,
 geert@linux-m68k.org, benh@kernel.crashing.org, firoz.khan@linaro.org,
 mattst88@gmail.com, fenghua.yu@intel.com, Arnd Bergmann <arnd@arndb.de>,
 heiko.carstens@de.ibm.com, linux-fsdevel@vger.kernel.org,
 linux-m68k@lists.linux-m68k.org, luto@kernel.org, tglx@linutronix.de,
 linux-arm-kernel@lists.infradead.org, monstr@monstr.eu, tony.luck@intel.com,
 linux-parisc@vger.kernel.org, netdev@vger.kernel.org,
 linux-mips@vger.kernel.org, paul.burton@mips.com, ebiederm@xmission.com,
 linux-alpha@vger.kernel.org, schwidefsky@de.ibm.com, akpm@linux-foundation.org,
 linuxppc-dev@lists.ozlabs.org, davem@davemloft.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

From: Deepa Dinamani <deepa.kernel@gmail.com>

struct timex uses struct timeval internally.
struct timeval is not y2038 safe.
Introduce a new UAPI type struct __kernel_timex
that is y2038 safe.

struct __kernel_timex uses a timeval type that is
similar to struct __kernel_timespec which preserves the
same structure size across 32 bit and 64 bit ABIs.
struct __kernel_timex also restructures other members of the
structure to make the structure the same on 64 bit and 32 bit
architectures.
Note that struct __kernel_timex is the same as struct timex
on a 64 bit architecture.

The above solution is similar to other new y2038 syscalls
that are being introduced: both 32 bit and 64 bit ABIs
have a common entry, and the compat entry supports the old 32 bit
syscall interface.

Alternatives considered were:
1. Add new time type to struct timex that makes use of padded
   bits. This time type could be based on the struct __kernel_timespec.
   modes will use a flag to notify which time structure should be
   used internally.
   This needs some application level changes on both 64 bit and 32 bit
   architectures. Although 64 bit machines could continue to use the
   older timeval structure without any changes.

2. Add a new u8 type to struct timex that makes use of padded bits. This
   can be used to save higher order tv_sec bits. modes will use a flag to
   notify presence of such a type.
   This will need some application level changes on 32 bit architectures.

3. Add a new compat_timex structure that differs in only the size of the
   time type; keep rest of struct timex the same.
   This requires extra syscalls to manage all 3 cases on 64 bit
   architectures. This will not need any application level changes but will
   add more complexity from kernel side.

Signed-off-by: Deepa Dinamani <deepa.kernel@gmail.com>
---
 include/linux/timex.h      |  7 +++++++
 include/uapi/linux/timex.h | 41 ++++++++++++++++++++++++++++++++++++++
 2 files changed, 48 insertions(+)

diff --git a/include/linux/timex.h b/include/linux/timex.h
index 39c25dbebfe8..7f40e9e42ecc 100644
--- a/include/linux/timex.h
+++ b/include/linux/timex.h
@@ -53,6 +53,13 @@
 #ifndef _LINUX_TIMEX_H
 #define _LINUX_TIMEX_H
 
+/* CONFIG_64BIT_TIME enables new 64 bit time_t syscalls in the compat path
+ * and 32-bit emulation.
+ */
+#ifndef CONFIG_64BIT_TIME
+#define __kernel_timex timex
+#endif
+
 #include <uapi/linux/timex.h>
 
 #define ADJ_ADJTIME		0x8000	/* switch between adjtime/adjtimex modes */
diff --git a/include/uapi/linux/timex.h b/include/uapi/linux/timex.h
index 92685d826444..a1c6b73016a5 100644
--- a/include/uapi/linux/timex.h
+++ b/include/uapi/linux/timex.h
@@ -92,6 +92,47 @@ struct timex {
 	int  :32; int  :32; int  :32;
 };
 
+struct __kernel_timex_timeval {
+	__kernel_time64_t       tv_sec;
+	long long		tv_usec;
+};
+
+#ifndef __kernel_timex
+struct __kernel_timex {
+	unsigned int modes;	/* mode selector */
+	int :32;            /* pad */
+	long long offset;	/* time offset (usec) */
+	long long freq;	/* frequency offset (scaled ppm) */
+	long long maxerror;/* maximum error (usec) */
+	long long esterror;/* estimated error (usec) */
+	int status;		/* clock command/status */
+	int :32;            /* pad */
+	long long constant;/* pll time constant */
+	long long precision;/* clock precision (usec) (read only) */
+	long long tolerance;/* clock frequency tolerance (ppm)
+				   * (read only)
+				   */
+	struct __kernel_timex_timeval time;	/* (read only, except for ADJ_SETOFFSET) */
+	long long tick;	/* (modified) usecs between clock ticks */
+
+	long long ppsfreq;/* pps frequency (scaled ppm) (ro) */
+	long long jitter; /* pps jitter (us) (ro) */
+	int shift;              /* interval duration (s) (shift) (ro) */
+	int :32;            /* pad */
+	long long stabil;            /* pps stability (scaled ppm) (ro) */
+	long long jitcnt; /* jitter limit exceeded (ro) */
+	long long calcnt; /* calibration intervals (ro) */
+	long long errcnt; /* calibration errors (ro) */
+	long long stbcnt; /* stability limit exceeded (ro) */
+
+	int tai;		/* TAI offset (ro) */
+
+	int  :32; int  :32; int  :32; int  :32;
+	int  :32; int  :32; int  :32; int  :32;
+	int  :32; int  :32; int  :32;
+};
+#endif
+
 /*
  * Mode codes (timex.mode)
  */
-- 
2.20.0


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
