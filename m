Return-Path: <SRS0=2lwk=Q5=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AE0AC43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 12:57:01 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EDFE9207E0
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 12:57:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="UPwn58V5";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="ngTaPZFj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EDFE9207E0
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=uLNU53sQf/2TZkjUSq8Zo4iAd3Tg1416Sp5os58JeiU=; b=UPwn58V5olw0TG
	/5TM0avE3MDUAiQU0PVgYiU2by33Iok1B1G9F2MV918prHJTvs6+nBmyAE0HUDMlTHQnGOPFhyEiS
	2lJT0OsV23Zn7s2oaClN33G+hSRTfHqFmTooUP5EUiRbxjydrQWYLI7UgmhPQeoYpQUmp9mpCPr0w
	+grRWRFD2/umxNslzDyVcgVpQlg8dzu48BgTsCK+SV8TOwH5KRYbblpGqm+Cm9/69BUXNpFzs8b95
	4NmseYdhZqKujTZzuKpGTylwWO2ZiMJ04jcSu7ZHWWjnoZHlYJ5V5A+HiahhzR9SGlf5oWjkZeqld
	eHUqK0WndkmNKpWIeRFg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gxANs-0003J8-A0; Fri, 22 Feb 2019 12:56:56 +0000
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gxAKw-0007Rk-Pw
 for linux-arm-kernel@lists.infradead.org; Fri, 22 Feb 2019 12:54:03 +0000
Received: by mail-wm1-x342.google.com with SMTP id h22so8844728wmb.0
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 22 Feb 2019 04:53:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=xP0EP9+s7jJBuNL20aZNoIWDJO0QH7KitwsXHnWrFcE=;
 b=ngTaPZFjbMr8UVnv+XHv855CtRTNvKpoDmCRTtKsyfuCSVAX1fHkkeEopamnkFNUkO
 2AxeqdOMs5OS1aAzAdqqAMH6oIYxxx7HXZvCiuu5mGrP4+JLSS3N1MvyfwgLIUpYg7XA
 36WRCDQmvGeM5dFPaSlrAtGT6lqE+t1iYacqOuNf0WL0AvYMXookG0ZRXOCwQj/yAJ64
 Ava6JpCXLFI/teW898eqAG2k52RXgpD4kz9ufk+Lk99Zo8v2WsRFs8gVa3BZjwmle1GK
 pfRIrNVVanNCc8AEbJlDtvFhw5/QlKpS67K/2EsIOQEy8hvKVuwcPksCJr25OCE/XBBn
 QqYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=xP0EP9+s7jJBuNL20aZNoIWDJO0QH7KitwsXHnWrFcE=;
 b=c3J0cX5upUTdl+ywUJBZwYr10Co8JG8PfcLEVZEFSuUWO/Flp/YfzupIUGkibu0uvL
 bkWijMc1Ewhfr11bc4STl1yhXBr2kZjlrsnM1o7k/x9P1hvqAQkXycLiBA6mfNAU+Cpj
 HW0ndn8Zphop0dfz9j5b7S0XiWEU38v6Spd1TOqwv/j6rVGFTWardBWm6YF6yf4NATTM
 iaRKXuZDG23sALAM0+HGH1vtsWB6Af+0x8pYvsxtY1wDGvLAdfBN4wLVpPVX4f5mdUDP
 UB2yt3htcbF1OdOzDTN+J2Hvl7zqbrOEYUv6oz6XWz8Oog8lMV4zUlIIH38egN3xY/A+
 XLeg==
X-Gm-Message-State: AHQUAuZiUY2janFwJGjU7Vvx2LW6cDSV0IDOJx9Fny4O0isABGv7AQxh
 0UykSWMkeb9s3Snnr/yNCWUWSw==
X-Google-Smtp-Source: AHgI3IYWY7Ghxi/h12hQKyhtNx7Svt8SN9NDulSxokwzQOKjvHqoGwEA6m30t17PvUiKofsiFVoIUA==
X-Received: by 2002:a7b:c457:: with SMTP id l23mr2410289wmi.2.1550840033285;
 Fri, 22 Feb 2019 04:53:53 -0800 (PST)
Received: from andreyknvl0.muc.corp.google.com
 ([2a00:79e0:15:13:8ce:d7fa:9f4c:492])
 by smtp.gmail.com with ESMTPSA id o14sm808209wrp.34.2019.02.22.04.53.51
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 22 Feb 2019 04:53:52 -0800 (PST)
From: Andrey Konovalov <andreyknvl@google.com>
To: Catalin Marinas <catalin.marinas@arm.com>,
 Will Deacon <will.deacon@arm.com>, Mark Rutland <mark.rutland@arm.com>,
 Robin Murphy <robin.murphy@arm.com>, Kees Cook <keescook@chromium.org>,
 Kate Stewart <kstewart@linuxfoundation.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Andrew Morton <akpm@linux-foundation.org>, Ingo Molnar <mingo@kernel.org>,
 "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
 Shuah Khan <shuah@kernel.org>,
 Vincenzo Frascino <vincenzo.frascino@arm.com>,
 linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org,
 linux-mm@kvack.org, linux-arch@vger.kernel.org,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v10 12/12] selftests,
 arm64: add a selftest for passing tagged pointers to kernel
Date: Fri, 22 Feb 2019 13:53:24 +0100
Message-Id: <8c08cda0dfdef1b062695241a6f6594487eaa3cb.1550839937.git.andreyknvl@google.com>
X-Mailer: git-send-email 2.21.0.rc0.258.g878e2cd30e-goog
In-Reply-To: <cover.1550839937.git.andreyknvl@google.com>
References: <cover.1550839937.git.andreyknvl@google.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190222_045355_293196_D921FF08 
X-CRM114-Status: GOOD (  15.74  )
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
Cc: Kevin Brodsky <kevin.brodsky@arm.com>,
 Chintan Pandya <cpandya@codeaurora.org>, Jacob Bramley <Jacob.Bramley@arm.com>,
 Ruben Ayrapetyan <Ruben.Ayrapetyan@arm.com>,
 Szabolcs Nagy <Szabolcs.Nagy@arm.com>,
 Andrey Konovalov <andreyknvl@google.com>, Lee Smith <Lee.Smith@arm.com>,
 Kostya Serebryany <kcc@google.com>, Dmitry Vyukov <dvyukov@google.com>,
 Ramana Radhakrishnan <Ramana.Radhakrishnan@arm.com>,
 Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
 Dave Martin <Dave.Martin@arm.com>, Evgeniy Stepanov <eugenis@google.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

This patch adds a simple test, that calls the uname syscall with a
tagged user pointer as an argument. Without the kernel accepting tagged
user pointers the test fails with EFAULT.

Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
---
 tools/testing/selftests/arm64/.gitignore      |  1 +
 tools/testing/selftests/arm64/Makefile        | 11 +++++++++++
 .../testing/selftests/arm64/run_tags_test.sh  | 12 ++++++++++++
 tools/testing/selftests/arm64/tags_test.c     | 19 +++++++++++++++++++
 4 files changed, 43 insertions(+)
 create mode 100644 tools/testing/selftests/arm64/.gitignore
 create mode 100644 tools/testing/selftests/arm64/Makefile
 create mode 100755 tools/testing/selftests/arm64/run_tags_test.sh
 create mode 100644 tools/testing/selftests/arm64/tags_test.c

diff --git a/tools/testing/selftests/arm64/.gitignore b/tools/testing/selftests/arm64/.gitignore
new file mode 100644
index 000000000000..e8fae8d61ed6
--- /dev/null
+++ b/tools/testing/selftests/arm64/.gitignore
@@ -0,0 +1 @@
+tags_test
diff --git a/tools/testing/selftests/arm64/Makefile b/tools/testing/selftests/arm64/Makefile
new file mode 100644
index 000000000000..a61b2e743e99
--- /dev/null
+++ b/tools/testing/selftests/arm64/Makefile
@@ -0,0 +1,11 @@
+# SPDX-License-Identifier: GPL-2.0
+
+# ARCH can be overridden by the user for cross compiling
+ARCH ?= $(shell uname -m 2>/dev/null || echo not)
+
+ifneq (,$(filter $(ARCH),aarch64 arm64))
+TEST_GEN_PROGS := tags_test
+TEST_PROGS := run_tags_test.sh
+endif
+
+include ../lib.mk
diff --git a/tools/testing/selftests/arm64/run_tags_test.sh b/tools/testing/selftests/arm64/run_tags_test.sh
new file mode 100755
index 000000000000..745f11379930
--- /dev/null
+++ b/tools/testing/selftests/arm64/run_tags_test.sh
@@ -0,0 +1,12 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0
+
+echo "--------------------"
+echo "running tags test"
+echo "--------------------"
+./tags_test
+if [ $? -ne 0 ]; then
+	echo "[FAIL]"
+else
+	echo "[PASS]"
+fi
diff --git a/tools/testing/selftests/arm64/tags_test.c b/tools/testing/selftests/arm64/tags_test.c
new file mode 100644
index 000000000000..1452ed7d33f9
--- /dev/null
+++ b/tools/testing/selftests/arm64/tags_test.c
@@ -0,0 +1,19 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <stdio.h>
+#include <unistd.h>
+#include <stdint.h>
+#include <sys/utsname.h>
+
+#define SHIFT_TAG(tag)		((uint64_t)(tag) << 56)
+#define SET_TAG(ptr, tag)	(((uint64_t)(ptr) & ~SHIFT_TAG(0xff)) | \
+					SHIFT_TAG(tag))
+
+int main(void)
+{
+	struct utsname utsname;
+	void *ptr = &utsname;
+	void *tagged_ptr = (void *)SET_TAG(ptr, 0x42);
+	int err = uname(tagged_ptr);
+	return err;
+}
-- 
2.21.0.rc0.258.g878e2cd30e-goog


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
