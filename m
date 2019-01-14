Return-Path: <SRS0=baBj=PW=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7CE8C43444
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 16:23:22 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 91F0F20873
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 16:23:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Ia19rlVl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 91F0F20873
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:List-Subscribe:List-Help:
	List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:Subject:To:
	From:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=hNP7LzJZSt0aQ/DMTJCa7jR89H3QWBkVQIRV3BM74As=; b=Ia19rlVlvsIGiu
	Pvgupf1E75i+ef71cbiF1M6CI9IJ3RuMVHljLRvwQm7Zg5ODbG/JmOXxkOL+cjOrcsgXvGu7eLpF7
	NkGdz2h5HaxOniluRuQxk4nMUvvPYLU1GnOKN7qw5V/STLF4sL+pgxwprbEvVvyZHjLKffyoCKqxp
	omyh42JW5PBI0pKN41bUMQSYlqVnyIO/49lv+KbGXOSI3E7+1Pt1E4i6+PchnVbekawd6EMZKQD9i
	FfShXjO+e0Xa9kSlDiZRutqGRZlsqgm/bQriu4tOvzGARH0b6+sUKig8uIoUL4SI+REcbiHXX/Mt8
	TKs8OQMJRNfW9Xbt4W2w==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gj51C-0004nI-NR; Mon, 14 Jan 2019 16:23:18 +0000
Received: from foss.arm.com ([217.140.101.70])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gj511-0004bw-BZ
 for linux-arm-kernel@lists.infradead.org; Mon, 14 Jan 2019 16:23:12 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CA63C80D
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 14 Jan 2019 08:23:06 -0800 (PST)
Received: from login2.euhpc.arm.com (login2.euhpc.arm.com [10.6.27.34])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 54D9C3F5BD
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 14 Jan 2019 08:23:06 -0800 (PST)
From: Vladimir Murzin <vladimir.murzin@arm.com>
To: linux-arm-kernel@lists.infradead.org
Subject: [PATCH] arm64: init: inline empty stubs
Date: Mon, 14 Jan 2019 16:22:55 +0000
Message-Id: <1547482975-24059-1-git-send-email-vladimir.murzin@arm.com>
X-Mailer: git-send-email 2.0.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190114_082307_687044_0E518086 
X-CRM114-Status: GOOD (  10.93  )
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
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

It looks like compiler is smart enough to eliminate empty __init stubs,
yet inlining stubs is a common and recognisable idiom.

Signed-off-by: Vladimir Murzin <vladimir.murzin@arm.com>
Acked-by: Mark Rutland <mark.rutland@arm.com>
---
 arch/arm64/mm/init.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c
index 7205a90..ab4df62 100644
--- a/arch/arm64/mm/init.c
+++ b/arch/arm64/mm/init.c
@@ -140,11 +140,11 @@ static void __init kexec_reserve_crashkres_pages(void)
 #endif
 }
 #else
-static void __init reserve_crashkernel(void)
+static inline void reserve_crashkernel(void)
 {
 }
 
-static void __init kexec_reserve_crashkres_pages(void)
+static inline void kexec_reserve_crashkres_pages(void)
 {
 }
 #endif /* CONFIG_KEXEC_CORE */
@@ -195,7 +195,7 @@ static void __init reserve_elfcorehdr(void)
 		elfcorehdr_size >> 10, elfcorehdr_addr);
 }
 #else
-static void __init reserve_elfcorehdr(void)
+static inline void reserve_elfcorehdr(void)
 {
 }
 #endif /* CONFIG_CRASH_DUMP */
-- 
2.7.4


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
