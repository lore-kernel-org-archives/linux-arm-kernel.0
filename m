Return-Path: <SRS0=gVCq=ON=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA286C04EB9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 02:32:05 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AC92820850
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 02:32:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="dwAxUbOW";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="g+cBqkd0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AC92820850
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=p6XpDJY4xm/Pvvl8MHvFAYfqb3YHYWSV3b2ZtEUHiFA=; b=dwAxUbOWYsmX0p
	S7Sz3bruUJiOPj5350UVgMAnLePn/IPL12ij5cnn+h/T+scMESn9End6H4iSjB6fbR1E69xbUkvoK
	XIfExywXdOkYtR6+oL/SzT3JQWcAxiN1ReeasfT/mEBByc62kgqPYlMRufMUsC027kPP9rxb0FkgC
	jGZOSBDeafd8S9lSh9APZ+rGi+q+GZltSl7O3rSryjpA5LljKpOGiVOpTGG8TLZrtTVfcAtyHYBg5
	7yGUgMrLda9EYTSZiS4zT3n2Pwc1IY+ojFvFx1lCMIj1MBuDy5qJaGrEMKvIEmNrLLwWh1M/nSYjc
	bEnLUb/wTLlr1xqnvZdQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gU0VF-0003Dc-Bv; Tue, 04 Dec 2018 02:32:01 +0000
Received: from merlin.infradead.org ([2001:8b0:10b:1231::1])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gU0Uq-0002kS-Ol
 for linux-arm-kernel@bombadil.infradead.org; Tue, 04 Dec 2018 02:31:36 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
 Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=cG3hc1VAVfD8wWFZaih2VFAzKLNIKJ7wRo6SMY3snp0=; b=g+cBqkd0krgJVXNARGw6yJPnhR
 LmNhpr6Ba9N9UjeS1FtgHWzcXBVqK7vgxFrMnEC7Dc2EqSgo/md4B2MY/Hz0ZzOXmKgfp7gvJ9nAs
 eBMRSPPZhunuI15AInuDHQt2cA+98gb0/rW5tIDtpOMei17KKrI/YACMvl1daja4DedV7wvG1IVSq
 dLK1cO4JC0JZT3AfN918n6iKOX8mgO+iwbHiQe34DYOqMdDIyHF5xLHA2+91z4PDkzCKfXcQQoD3X
 cWRU9sx4MREeTLew5bwTfHTtUpR02HT83U5kabC8PINhvX44Cv5UJgwcQ6JJUJV4s6vPmEkUn5dH2
 pX2255AA==;
Received: from smtpbguseast2.qq.com ([54.204.34.130])
 by merlin.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gTzlA-0004rT-MR
 for linux-arm-kernel@lists.infradead.org; Tue, 04 Dec 2018 01:44:25 +0000
X-QQ-mid: bizesmtp20t1543887823tk2oxihg
Received: from Macbook.pro (unknown [210.22.22.130])
 by esmtp6.qq.com (ESMTP) with 
 id ; Tue, 04 Dec 2018 09:43:42 +0800 (CST)
X-QQ-SSF: 01400000002000F0FL51B00A0000000
X-QQ-FEAT: MQWYnVJPtOMIb5enrEdkcxRuHu0OK8WLjGi9cNdQVPUHGdSTslmfD789KXpcd
 sdww2lhew9KGk2uEcjhXQiQDKWNu31vJeEi7ayt01kR/Eil7cQKfZrmePOklbtPrnbw9Vb5
 G5dOAbbOCRCczm4JRgPhGiuK3ct2d6tMBwW99mSYsto9bZd2QBwxhGPAS4DuR+YPVE0v4rW
 zZHZowxkheuZ676ouAXacyyvcxSSKlwkz/3qGIfOoP2pzuiShG71n5CxF8hq53khP/ZlNV4
 SXnvGcxXNKVdSyFFq5ZPgglxw68lofkPrnWfL/4cgaljBN
X-QQ-GoodBg: 2
From: Jackie Liu <liuyun01@kylinos.cn>
To: will.deacon@arm.com
Subject: [PATCH v6 1/2] arm64/neon: add workaround for ambiguous C99 stdint.h
 types
Date: Tue,  4 Dec 2018 09:43:22 +0800
Message-Id: <20181204014323.1438-2-liuyun01@kylinos.cn>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181204014323.1438-1-liuyun01@kylinos.cn>
References: <20181204014323.1438-1-liuyun01@kylinos.cn>
MIME-Version: 1.0
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:kylinos.cn:qybgforeign:qybgforeign4
X-QQ-Bgrelay: 1
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181203_204424_841735_0728056C 
X-CRM114-Status: GOOD (  14.99  )
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
Cc: linux-block@vger.kernel.org, catalin.marinas@arm.com,
 Jackie Liu <liuyun01@kylinos.cn>, linux-arm-kernel@lists.infradead.org,
 ard.biesheuvel@linaro.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

In a way similar to ARM commit 09096f6a0ee2 ("ARM: 7822/1: add workaround
for ambiguous C99 stdint.h types"), this patch redefines the macros that
are used in stdint.h so its definitions of uint64_t and int64_t are
compatible with those of the kernel.

This patch comes from: https://patchwork.kernel.org/patch/3540001/
Wrote by: Ard Biesheuvel <ard.biesheuvel@linaro.org>

We mark this file as a private file and don't have to override asm/types.h

Signed-off-by: Jackie Liu <liuyun01@kylinos.cn>
Reviewed-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---
 arch/arm64/include/asm/neon-intrinsics.h | 39 ++++++++++++++++++++++++++++++++
 1 file changed, 39 insertions(+)
 create mode 100644 arch/arm64/include/asm/neon-intrinsics.h

diff --git a/arch/arm64/include/asm/neon-intrinsics.h b/arch/arm64/include/asm/neon-intrinsics.h
new file mode 100644
index 0000000..2ba6c6b
--- /dev/null
+++ b/arch/arm64/include/asm/neon-intrinsics.h
@@ -0,0 +1,39 @@
+/*
+ * Copyright (C) 2018 Linaro, Ltd. <ard.biesheuvel@linaro.org>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#ifndef __ASM_NEON_INTRINSICS_H
+#define __ASM_NEON_INTRINSICS_H
+
+#include <asm-generic/int-ll64.h>
+
+/*
+ * In the kernel, u64/s64 are [un]signed long long, not [un]signed long.
+ * So by redefining these macros to the former, we can force gcc-stdint.h
+ * to define uint64_t / in64_t in a compatible manner.
+ */
+
+#ifdef __INT64_TYPE__
+#undef __INT64_TYPE__
+#define __INT64_TYPE__		long long
+#endif
+
+#ifdef __UINT64_TYPE__
+#undef __UINT64_TYPE__
+#define __UINT64_TYPE__		unsigned long long
+#endif
+
+/*
+ * genksyms chokes on the ARM NEON instrinsics system header, but we
+ * don't export anything it defines anyway, so just disregard when
+ * genksyms execute.
+ */
+#ifndef __GENKSYMS__
+#include <arm_neon.h>
+#endif
+
+#endif /* __ASM_NEON_INTRINSICS_H */
-- 
2.7.4




_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
