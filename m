Return-Path: <SRS0=fRgi=OV=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37209C04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 12:22:49 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0937B20839
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 12:22:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="iFW/rUDI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0937B20839
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	References:List-Owner; bh=YaCSFvgIAgeI7hrj2x1NJaPNP/ObWOEfpR0xPuCo2uY=; b=iFW
	/rUDIsP3CZnXOLJw/MvjNjOyrbIY2U1Pqpf0d4m6TtV9Gqmz5YSGnGj6GBsM6BL7f+iUDYB+nPe1N
	3U3zV7qSLSTvcPRB/ODYrMggiOIxvZI+I/O31fvRIrMr5JxBWpQqyVQcfrQ5XkmE6XCCVsg5r+W3r
	vjZv43DD1Gn4bPED06g8tx/qGhWzEjfGBEixjPwCR/O5Zcq00wG0Ew2dW1r19zLa1hAPkUn24RLV0
	nN3G3sJKJV4MRNZpu8bwJjt9fEKttdOfLfqDg+YC/1Tf0R1iZZK6Z6rvWeuDwai0SaiM3v9MmkiDK
	3qWUdSIUxy98PvTpBzs7FlVZzG/0+mg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gX3XK-0005Eq-4V; Wed, 12 Dec 2018 12:22:46 +0000
Received: from foss.arm.com ([217.140.101.70])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gX3XF-00050h-L8
 for linux-arm-kernel@lists.infradead.org; Wed, 12 Dec 2018 12:22:43 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 447BCA78;
 Wed, 12 Dec 2018 04:22:29 -0800 (PST)
Received: from localhost.localdomain (usa-sjc-mx-foss1.foss.arm.com
 [217.140.101.70])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 2BB353F614;
 Wed, 12 Dec 2018 04:22:28 -0800 (PST)
From: Mark Rutland <mark.rutland@arm.com>
To: will.deacon@arm.com,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH] arm64: add <asm/asm-prototypes.h>
Date: Wed, 12 Dec 2018 12:22:19 +0000
Message-Id: <20181212122219.29552-1-mark.rutland@arm.com>
X-Mailer: git-send-email 2.11.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181212_042241_842733_DEDFE404 
X-CRM114-Status: GOOD (  12.05  )
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
Cc: Mark Rutland <mark.rutland@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

While we can export symbols from assembly files, CONFIG_MODVERIONS requires C
declarations of anyhting that's exported.

Let's account for this as other architectures do by placing these declarations
in <asm/asm-prototypes.h>, which kbuild will automatically use to generate
modversion information for assembly files.

Since we already define most prototypes in existing headers, we simply need to
include those headers in <asm/asm-prototypes.h>, and don't need to duplicate
these.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
---
 arch/arm64/include/asm/asm-prototypes.h | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)
 create mode 100644 arch/arm64/include/asm/asm-prototypes.h

Hi Will,

I believe this covers all assembly exports for an arm64 allmodconfig. My laptop
is rather slow at building all of that, so I can't confirm just yet, but I
thought it was better to send this out in the mean time (or in case you can
verify that locally).

Mark.

diff --git a/arch/arm64/include/asm/asm-prototypes.h b/arch/arm64/include/asm/asm-prototypes.h
new file mode 100644
index 000000000000..597434ea857d
--- /dev/null
+++ b/arch/arm64/include/asm/asm-prototypes.h
@@ -0,0 +1,25 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef __ASM_PROTOTYPES_H
+#define __ASM_PROTOTYPES_H
+/*
+ * CONFIG_MODEVERIONS requires a C declaration to generate the appropriate CRC
+ * for each symbol. Since commit:
+ *
+ *   4efca4ed05cbdfd1 ("kbuild: modversions for EXPORT_SYMBOL() for asm")
+ *
+ * ... kbuild will automatically pick these up from <asm/asm-prototypes.h> and
+ * feed this to genksyms when building assembly files.
+ */
+#include <linux/arm-smccc.h>
+
+#include <asm/ftrace.h>
+#include <asm/string.h>
+#include <asm/uaccess.h>
+
+#include <asm-generic/asm-prototypes.h>
+
+long long __ashlti3(long long a, int b);
+long long __ashrti3(long long a, int b);
+long long __lshrti3(long long a, int b);
+
+#endif /* __ASM_PROTOTYPES_H */
-- 
2.11.0


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
