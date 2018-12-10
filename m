Return-Path: <SRS0=/awj=OT=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8115C04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 12:52:36 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8331420855
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 12:52:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="EH/9sBt2";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="PdfHiKV/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8331420855
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=sm2WNzwGxO316nkTGYA7izIlicbf7RWd5pJ1s1ZTIOw=; b=EH/9sBt2xjsSrP
	w77tno2bRScCsi2GhL41mtlBIPguG4ZDnhmT5w4wQjBW+5I+lHsBrrL2NhOcBdexr5RP3Kgeqnz8V
	3osxNgOupqPEVMSNRuqtGxQ8Mx4dcvwYigZv0sOl1dl2BNR6KfGNXX1ylHKvo3Yt/fYqYTlWMOAZC
	xBos/nACl+E0at15xBAl8PB0a1Qu0UTghwti6eafzecm7IJg0OodJqG5QsoTN9aepVXuR1i1TTjIu
	kskbXPOg1A8+up/XC6og7z+G8tEt9vGf7UsUXuqRVklyoGyRc+Mp3fEPnz8ambejG/u2z4VT0RauB
	pV8+fFvZGXGUzG/G1rMg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gWL30-0002Q7-6f; Mon, 10 Dec 2018 12:52:30 +0000
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gWL20-0001CW-Mj
 for linux-arm-kernel@lists.infradead.org; Mon, 10 Dec 2018 12:51:34 +0000
Received: by mail-wr1-x444.google.com with SMTP id t27so10336091wra.6
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 10 Dec 2018 04:51:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=THrF65uyQ43y9XI4Oao8ZCD7W0hiODFoiBK2GnkK+6k=;
 b=PdfHiKV/nw+CfvDzzUmvpjA/YhVLjcLEJGbE4xRNKckctV4ggJLQ09SaEpJOCkc/Wd
 TsbWeQ7VqNxHNADvOwoiDxubfQDEDS0+PHacVgOSQwfEz02dQXLOTxmV5IykKVkn0f9a
 qcdjj+pRCBHgfvFs4fxlSCiaYPFMMXTkQUdwp3B9666yUCdbDg9xBDMR3zDN5H2HdY1U
 EAZ/zAia4HQUr1OpEIgycWmDLiok+qqigVLOzimiWXbPovc2JNH66nE7jrGjj0/pP7Xm
 u31n4umKu6azySOlPyk4zWiDSNjuQbTXYYgyyZeCL1TW0iqGcwgkW/T/pb9E8YfCUAZ2
 045Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=THrF65uyQ43y9XI4Oao8ZCD7W0hiODFoiBK2GnkK+6k=;
 b=K832jT9mYAhwfPwD3rENKW2yZ96skwja0osCnJboaN3WJ4PAq0zZRevgIEHc9fDvuv
 +5W85HkQJyg0OMX1/PTbJKD/jR8rX3PWBpRL8hIuSilF/fmO+tN8hC7pz66SlJUsb62x
 W80gYdmobYUyuHyfWHumHbvuuB9qqdcht7EvYDzdTgfG08960RyslBSkuQ+yQILiXN1y
 oGuXGpMFTTBz5g4BAfGRe6GCjpkjQZzkjta1rZyCwu49fYOjQ/RF3OqkKI86u0S1BWfk
 1gCfoKam1v3XcowXdg6sMiQ3bkVE5xLyckU9B/ApkDCIvNLYk+wrfr/g1qrnLN2s7vw8
 yblg==
X-Gm-Message-State: AA+aEWYnWX/AFvOc+m0q4KFs0p7Kt9hD50+bmikCYMiAcBtuP2+fvD9B
 IS0OQjU5ms9LmiqVd0daSu6kGg==
X-Google-Smtp-Source: AFSGD/VI/5BMsRXqnw18fB6Gll7b+Eig1k8PMWahNn8bGC0uXwXuMAwRBnIM/ZnTZkzB47NBiSqZdQ==
X-Received: by 2002:a5d:538a:: with SMTP id d10mr9405307wrv.202.1544446277017; 
 Mon, 10 Dec 2018 04:51:17 -0800 (PST)
Received: from andreyknvl0.muc.corp.google.com
 ([2a00:79e0:15:10:3180:41f8:3010:ff61])
 by smtp.gmail.com with ESMTPSA id l197sm36893363wma.44.2018.12.10.04.51.15
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 10 Dec 2018 04:51:16 -0800 (PST)
From: Andrey Konovalov <andreyknvl@google.com>
To: Catalin Marinas <catalin.marinas@arm.com>,
 Will Deacon <will.deacon@arm.com>, Mark Rutland <mark.rutland@arm.com>,
 Robin Murphy <robin.murphy@arm.com>, Kees Cook <keescook@chromium.org>,
 Kate Stewart <kstewart@linuxfoundation.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Andrew Morton <akpm@linux-foundation.org>, Ingo Molnar <mingo@kernel.org>,
 "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
 Shuah Khan <shuah@kernel.org>, linux-arm-kernel@lists.infradead.org,
 linux-doc@vger.kernel.org, linux-mm@kvack.org, linux-arch@vger.kernel.org,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v9 5/8] lib,
 arm64: untag addrs passed to strncpy_from_user and strnlen_user
Date: Mon, 10 Dec 2018 13:51:02 +0100
Message-Id: <2c573564b456327708d175f3124256bc71081bd8.1544445454.git.andreyknvl@google.com>
X-Mailer: git-send-email 2.20.0.rc2.403.gdbc3b29805-goog
In-Reply-To: <cover.1544445454.git.andreyknvl@google.com>
References: <cover.1544445454.git.andreyknvl@google.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181210_045129_336909_981B707C 
X-CRM114-Status: GOOD (  13.05  )
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
Cc: Chintan Pandya <cpandya@codeaurora.org>,
 Jacob Bramley <Jacob.Bramley@arm.com>,
 Ruben Ayrapetyan <Ruben.Ayrapetyan@arm.com>,
 Andrey Konovalov <andreyknvl@google.com>, Lee Smith <Lee.Smith@arm.com>,
 Kostya Serebryany <kcc@google.com>, Dmitry Vyukov <dvyukov@google.com>,
 Ramana Radhakrishnan <Ramana.Radhakrishnan@arm.com>,
 Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
 Evgeniy Stepanov <eugenis@google.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

strncpy_from_user and strnlen_user accept user addresses as arguments, and
do not go through the same path as copy_from_user and others, so here we
need to handle the case of tagged user addresses separately.

Untag user pointers passed to these functions.

Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
---
 lib/strncpy_from_user.c | 2 ++
 lib/strnlen_user.c      | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/lib/strncpy_from_user.c b/lib/strncpy_from_user.c
index b53e1b5d80f4..97467cd2bc59 100644
--- a/lib/strncpy_from_user.c
+++ b/lib/strncpy_from_user.c
@@ -106,6 +106,8 @@ long strncpy_from_user(char *dst, const char __user *src, long count)
 	if (unlikely(count <= 0))
 		return 0;
 
+	src = untagged_addr(src);
+
 	max_addr = user_addr_max();
 	src_addr = (unsigned long)src;
 	if (likely(src_addr < max_addr)) {
diff --git a/lib/strnlen_user.c b/lib/strnlen_user.c
index 60d0bbda8f5e..8b5f56466e00 100644
--- a/lib/strnlen_user.c
+++ b/lib/strnlen_user.c
@@ -108,6 +108,8 @@ long strnlen_user(const char __user *str, long count)
 	if (unlikely(count <= 0))
 		return 0;
 
+	str = untagged_addr(str);
+
 	max_addr = user_addr_max();
 	src_addr = (unsigned long)str;
 	if (likely(src_addr < max_addr)) {
-- 
2.20.0.rc2.403.gdbc3b29805-goog


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
