Return-Path: <SRS0=2lwk=Q5=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C52E6C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 12:43:11 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8FDF12070B
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 12:43:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="LTzKWAFU";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ocnrplVk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8FDF12070B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=0XtpxsSBt3hP8bOgMe6nJcHKFg7BZ8delPYNxLLkmzY=; b=LTzKWAFUORGwaC
	ifNJY4Z40hd+K8EQngBV8GEkzGbu2jlLNL5NNUoeD8/BzPGC3jGb0v9otg1prelIu07T4CT3rfBOx
	vjQw9M19FYpRzBkepgxLG9MOr6H2qFMk/miHdpms1n8Se9vYapLrZAJuzeXsV7DB9pH9BjlQzL+2x
	eZKJxa04o1KoINi5+6ilqA+S6XGABLIBF1D+g8egHIWWVXGQddfOQQKlTCjpW/bEI57G7wYliRDqU
	tc9G9fZ0EuE5WWbNh/LKhiD95XESWfmq5rNMkDkzQ4q7J/A1QHX9xVIF01BroxUtgeori6otpl28Z
	HaqxrefPIWDKRc+Tca5w==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gxAAV-0002Eh-Sn; Fri, 22 Feb 2019 12:43:07 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gxAAS-00020c-MW
 for linux-arm-kernel@bombadil.infradead.org; Fri, 22 Feb 2019 12:43:04 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
 Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=wa8C15WRI0rR5OlNFlQF/zB3+7OkBglSFYWFeDWJYAo=; b=ocnrplVkz11WvUBSWCMkUHmfcX
 MdQotXSe92r/PlXo2/UoLdQPgPQJcNG1K2jHXZS/2KoqCD6Jtr2uEzRPildNPiKa2Wyqi8/mJ+/og
 Ac2ldY1v73CxXJmxuhBgpcAjAA2XBxkq4vG5vIb8GUcXnFKn0y65XfFeXsgw/hAyVGEEoOMqCdpyt
 tbKrn0cIb5/DaId6BttlFlt4IbP7zTJ5MzcRR/y9WUsnVjwKwaXBVioHvIG0ZfSSKxpJLov5Wvfw5
 S3XL8g97C8Sx4iUcX9tcNz32oFuclXErol+dvD+VsAizJCgVqQtxcfXp1Htasr6YqQ/UKGcEkTDqe
 aQilvzkA==;
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]
 helo=foss.arm.com)
 by casper.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gx9ud-0005qR-St
 for linux-arm-kernel@lists.infradead.org; Fri, 22 Feb 2019 12:26:46 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 88843165C;
 Fri, 22 Feb 2019 04:26:42 -0800 (PST)
Received: from e119884-lin.cambridge.arm.com (e119884-lin.cambridge.arm.com
 [10.1.196.72])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0AB993F690;
 Fri, 22 Feb 2019 04:26:39 -0800 (PST)
From: Vincenzo Frascino <vincenzo.frascino@arm.com>
To: linux-arch@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH v5 23/23] kselftest: Extend vDSO selftest
Date: Fri, 22 Feb 2019 12:24:30 +0000
Message-Id: <20190222122430.21180-24-vincenzo.frascino@arm.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190222122430.21180-1-vincenzo.frascino@arm.com>
References: <20190222122430.21180-1-vincenzo.frascino@arm.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190222_122644_268764_5967A3B3 
X-CRM114-Status: GOOD (  19.84  )
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
Cc: Shuah Khan <shuah@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
 Catalin Marinas <catalin.marinas@arm.com>,
 Daniel Lezcano <daniel.lezcano@linaro.org>, Will Deacon <will.deacon@arm.com>,
 Russell King <linux@armlinux.org.uk>, Ralf Baechle <ralf@linux-mips.org>,
 Mark Salyzyn <salyzyn@android.com>, Paul Burton <paul.burton@mips.com>,
 Dmitry Safonov <0x7f454c46@gmail.com>,
 Rasmus Villemoes <linux@rasmusvillemoes.dk>,
 Thomas Gleixner <tglx@linutronix.de>, Peter Collingbourne <pcc@google.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

The current version of the multiarch vDSO selftest verifies only
gettimeofday.

Extend the vDSO selftest to the other library functions:
 - time
 - clock_getres
 - clock_gettime

The extension has been used to verify the unified vdso library on the
supported architectures.

Cc: Shuah Khan <shuah@kernel.org>
Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
---
 tools/testing/selftests/vDSO/Makefile         |   2 +
 tools/testing/selftests/vDSO/vdso_full_test.c | 246 ++++++++++++++++++
 2 files changed, 248 insertions(+)
 create mode 100644 tools/testing/selftests/vDSO/vdso_full_test.c

diff --git a/tools/testing/selftests/vDSO/Makefile b/tools/testing/selftests/vDSO/Makefile
index 9e03d61f52fd..68e9b4a1cdcf 100644
--- a/tools/testing/selftests/vDSO/Makefile
+++ b/tools/testing/selftests/vDSO/Makefile
@@ -5,6 +5,7 @@ uname_M := $(shell uname -m 2>/dev/null || echo not)
 ARCH ?= $(shell echo $(uname_M) | sed -e s/i.86/x86/ -e s/x86_64/x86/)
 
 TEST_GEN_PROGS := $(OUTPUT)/vdso_test
+TEST_GEN_PROGS += $(OUTPUT)/vdso_full_test
 ifeq ($(ARCH),x86)
 TEST_GEN_PROGS += $(OUTPUT)/vdso_standalone_test_x86
 endif
@@ -18,6 +19,7 @@ endif
 
 all: $(TEST_GEN_PROGS)
 $(OUTPUT)/vdso_test: parse_vdso.c vdso_test.c
+$(OUTPUT)/vdso_full_test: parse_vdso.c vdso_full_test.c
 $(OUTPUT)/vdso_standalone_test_x86: vdso_standalone_test_x86.c parse_vdso.c
 	$(CC) $(CFLAGS) $(CFLAGS_vdso_standalone_test_x86) \
 		vdso_standalone_test_x86.c parse_vdso.c \
diff --git a/tools/testing/selftests/vDSO/vdso_full_test.c b/tools/testing/selftests/vDSO/vdso_full_test.c
new file mode 100644
index 000000000000..d46776658aa2
--- /dev/null
+++ b/tools/testing/selftests/vDSO/vdso_full_test.c
@@ -0,0 +1,246 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * vdso_full_test.c: Sample code to test all the timers.
+ * Copyright (c) 2019 Arm Ltd.
+ *
+ * Compile with:
+ * gcc -std=gnu99 vdso_full_test.c parse_vdso.c
+ *
+ * Tested on ARM, ARM64, MIPS32 and x86 (32-bit and 64-bit).
+ * Might work on other architectures.
+ */
+
+#include <stdint.h>
+#include <elf.h>
+#include <stdio.h>
+#include <time.h>
+#include <sys/auxv.h>
+#include <sys/time.h>
+#define _GNU_SOURCE
+#include <unistd.h>
+#include <sys/syscall.h>
+
+#include "../kselftest.h"
+
+extern void *vdso_sym(const char *version, const char *name);
+extern void vdso_init_from_sysinfo_ehdr(uintptr_t base);
+extern void vdso_init_from_auxv(void *auxv);
+
+/*
+ * ARM64's vDSO exports its vDSO implementation with different names and
+ * a different version from other architectures, so we need to handle it
+ * as a special case.
+ */
+#if defined(__aarch64__)
+const char *version = "LINUX_2.6.39";
+const char *name[4] = {
+	"__kernel_gettimeofday",
+	"__kernel_clock_gettime",
+	"__kernel_time",
+	"__kernel_clock_getres",
+};
+#else
+/* Tested on x86, arm, mips */
+const char *version = "LINUX_2.6";
+const char *name[4] = {
+	"__vdso_gettimeofday",
+	"__vdso_clock_gettime",
+	"__vdso_time",
+	"__vdso_clock_getres",
+};
+#endif
+
+typedef long (*vdso_gettimeofday_t)(struct timeval *tv, struct timezone *tz);
+typedef long (*vdso_clock_gettime_t)(clockid_t clk_id, struct timespec *ts);
+typedef long (*vdso_clock_getres_t)(clockid_t clk_id, struct timespec *ts);
+typedef time_t (*vdso_time_t)(time_t *t);
+
+static int vdso_test_gettimeofday(void)
+{
+	/* Find gettimeofday. */
+	vdso_gettimeofday_t vdso_gettimeofday =
+		(vdso_gettimeofday_t)vdso_sym(version, name[0]);
+
+	if (!vdso_gettimeofday) {
+		printf("Could not find %s\n", name[0]);
+		return KSFT_SKIP;
+	}
+
+	struct timeval tv;
+	long ret = vdso_gettimeofday(&tv, 0);
+
+	if (ret == 0) {
+		printf("The time is %lld.%06lld\n",
+		       (long long)tv.tv_sec, (long long)tv.tv_usec);
+	} else {
+		printf("%s failed\n", name[0]);
+		return KSFT_FAIL;
+	}
+
+	return 0;
+}
+
+static int vdso_test_clock_gettime(clockid_t clk_id)
+{
+	/* Find clock_gettime. */
+	vdso_clock_gettime_t vdso_clock_gettime =
+		(vdso_clock_gettime_t)vdso_sym(version, name[1]);
+
+	if (!vdso_clock_gettime) {
+		printf("Could not find %s\n", name[1]);
+		return KSFT_SKIP;
+	}
+
+	struct timespec ts;
+	long ret = vdso_clock_gettime(clk_id, &ts);
+
+	if (ret == 0) {
+		printf("The time is %lld.%06lld\n",
+		       (long long)ts.tv_sec, (long long)ts.tv_nsec);
+	} else {
+		printf("%s failed\n", name[1]);
+		return KSFT_FAIL;
+	}
+
+	return 0;
+}
+
+static int vdso_test_time(void)
+{
+	/* Find time. */
+	vdso_time_t vdso_time =
+		(vdso_time_t)vdso_sym(version, name[2]);
+
+	if (!vdso_time) {
+		printf("Could not find %s\n", name[2]);
+		return KSFT_SKIP;
+	}
+
+	long ret = vdso_time(NULL);
+
+	if (ret > 0) {
+		printf("The time in hours since January 1, 1970 is %lld\n",
+				(long long)(ret / 3600));
+	} else {
+		printf("%s failed\n", name[2]);
+		return KSFT_FAIL;
+	}
+
+	return 0;
+}
+
+static int vdso_test_clock_getres(clockid_t clk_id)
+{
+	/* Find clock_getres. */
+	vdso_clock_getres_t vdso_clock_getres =
+		(vdso_clock_getres_t)vdso_sym(version, name[3]);
+
+	if (!vdso_clock_getres) {
+		printf("Could not find %s\n", name[3]);
+		return KSFT_SKIP;
+	}
+
+	struct timespec ts, sys_ts;
+	long ret = vdso_clock_getres(clk_id, &ts);
+
+	if (ret == 0) {
+		printf("The resolution is %lld %lld\n",
+		       (long long)ts.tv_sec, (long long)ts.tv_nsec);
+	} else {
+		printf("%s failed\n", name[3]);
+		return KSFT_FAIL;
+	}
+
+	ret = syscall(SYS_clock_getres, clk_id, &sys_ts);
+
+	if ((sys_ts.tv_sec != ts.tv_sec) || (sys_ts.tv_nsec != ts.tv_nsec)) {
+		printf("%s failed\n", name[3]);
+		return KSFT_FAIL;
+	}
+
+	return 0;
+}
+
+const char *vdso_clock_name[12] = {
+	"CLOCK_REALTIME",
+	"CLOCK_MONOTONIC",
+	"CLOCK_PROCESS_CPUTIME_ID",
+	"CLOCK_THREAD_CPUTIME_ID",
+	"CLOCK_MONOTONIC_RAW",
+	"CLOCK_REALTIME_COARSE",
+	"CLOCK_MONOTONIC_COARSE",
+	"CLOCK_BOOTTIME",
+	"CLOCK_REALTIME_ALARM",
+	"CLOCK_BOOTTIME_ALARM",
+	"CLOCK_SGI_CYCLE",
+	"CLOCK_TAI",
+};
+
+/*
+ * Macro to call vdso_test_clock_gettime and vdso_test_clock_getres
+ * with different values for clock_id.
+ */
+#define vdso_test_clock(clock_id)				\
+do {								\
+	printf("clock_id: %s\n", vdso_clock_name[clock_id]);	\
+	vdso_test_clock_gettime(clock_id);			\
+	vdso_test_clock_getres(clock_id);			\
+} while (0)
+
+int main(int argc, char **argv)
+{
+	unsigned long sysinfo_ehdr = getauxval(AT_SYSINFO_EHDR);
+
+	if (!sysinfo_ehdr) {
+		printf("AT_SYSINFO_EHDR is not present!\n");
+		return KSFT_SKIP;
+	}
+
+	vdso_init_from_sysinfo_ehdr(getauxval(AT_SYSINFO_EHDR));
+
+	vdso_test_gettimeofday();
+
+#if _POSIX_TIMERS > 0
+
+#ifdef CLOCK_REALTIME
+	vdso_test_clock(CLOCK_REALTIME);
+#endif
+
+#ifdef CLOCK_REALTIME_HR
+	vdso_test_clock(CLOCK_REALTIME_HR);
+#endif
+
+#ifdef CLOCK_BOOTTIME
+	vdso_test_clock(CLOCK_BOOTTIME);
+#endif
+
+#ifdef CLOCK_TAI
+	vdso_test_clock(CLOCK_TAI);
+#endif
+
+#ifdef CLOCK_REALTIME_COARSE
+	vdso_test_clock(CLOCK_REALTIME_COARSE);
+#endif
+
+#ifdef CLOCK_REALTIME_HR
+	vdso_test_clock(CLOCK_REALTIME_HR);
+#endif
+
+#ifdef CLOCK_MONOTONIC
+	vdso_test_clock(CLOCK_MONOTONIC);
+#endif
+
+#ifdef CLOCK_MONOTONIC_RAW
+	vdso_test_clock(CLOCK_MONOTONIC_RAW);
+#endif
+
+#ifdef CLOCK_MONOTONIC_COARSE
+	vdso_test_clock(CLOCK_MONOTONIC_COARSE);
+#endif
+
+#endif
+
+	vdso_test_time();
+
+	return 0;
+}
-- 
2.20.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
