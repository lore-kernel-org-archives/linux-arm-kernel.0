Return-Path: <SRS0=2lwk=Q5=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4902DC43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 12:54:29 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1049C2075C
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 12:54:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="LSjIIh++";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="FaiH8DNH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1049C2075C
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=uHdK5nR2s+Qc23sK72VgGM9gIcL8/Y9A4oSs1tdXjo4=; b=LSjIIh++HZ7KBa
	4Z2S0T8WT6JGc6zzH/za6QNLR58fDRpw4f7ENJkWiHX9ulW/jMHpF7hN74ua82cbktztThGjh4Uno
	yRAc7G14C0TxWMuaRHY9nm9dzuB1Dw+HPeIlbDhFkAsMYW8Rwn2rJN+iU5TGV7H/YM+M3ZfmJx/e8
	786L+HURAYETxPNA8BwANuj0l8BEaCYBMqvURq+ND057RAGoyRzUjtkcYTuZ7yqPiqiHbdn1NK78R
	6GLsHLjPcODQ+RoAxUF1xE2hYV20vukP3ooVoBD2GTNDLG2lZJjgU2BwzpTmjOKPmZqZpoJanuDVB
	DFnW7FXKRv1XEHkbP6gw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gxALN-0007rz-DW; Fri, 22 Feb 2019 12:54:21 +0000
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gxAKf-00074G-NF
 for linux-arm-kernel@lists.infradead.org; Fri, 22 Feb 2019 12:53:39 +0000
Received: by mail-wm1-x342.google.com with SMTP id x7so1868607wmj.0
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 22 Feb 2019 04:53:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=PKTXMuuFJ0ycWRkeXV5y91b1obeaiELoxpNU31S68XA=;
 b=FaiH8DNHehCmj69FkdBo6mXbqqulK/U8NyRCwUPqCoCXisYnu5gQCGM5mMgF2o+r5C
 Q895ILkegF7YVy2vFzwoQsyu3DHKrS7Js60oUmj3EHAuQ3lDC4dMnGfkMJZ62pMapL+k
 xytmFOkCQHvp0gNluVOkEqXFJhXzhLYBgN2pDRZLIp1yIz0MZnbqLpN529eBLDmuCQ7L
 aRGgYK5N5Bf8jKNgpzLn0LgSmAlL7MWKlzzgbhspTRp7qG3c5svcptnL3y0tn8I+xiVR
 fsnSCnDs4Y6Ma8rGFmML1DTnS0qu8iSEQz/qlVoGNtR0rlFccPGC+6s/xVUFiGjh1uzO
 Tj3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=PKTXMuuFJ0ycWRkeXV5y91b1obeaiELoxpNU31S68XA=;
 b=DuMoCnqSHGNZt6r9MDdnYg8uly4cf/7FFuK0iDSawaDRvyUzFGAAgPtYYzxwS1LNkX
 CrvZr6v5RHELud8IGlirh3+g1DJt3KpWEf8FLO2JtGrSJK+2AwkzmVSNDtnO2WkwkIFG
 mBkbA88yoANagY2xxAokHu+fTHIgNHwrNm4FAsEXSERaJB8ZZgCR2Mjk30dr+oLkMOGa
 UoOSciQscI4zLdRzHgSJQj5TXNIW6ExezKNVfmjHYbiC9h7BRa/aVS3VuG8FfCkzuBoU
 nDoberqnz6kb3gCpBPvgd/6ShFtODKQ6o3j7lIVW2/pHZ1mYKUkC7udR6tM6Z41XfZLh
 ByDg==
X-Gm-Message-State: AHQUAuaeqRFv1YlQI2dLtdvx0xaQ6q3/nfna/7tXUAlAhGFdSr8uA6Kp
 QoLT1pPBwvG9xXwmOywzeOZgng==
X-Google-Smtp-Source: AHgI3IaT3TA/4v9Ai1qhl8SBylCTupXNiKIcUjrbtqaeD8Hyvt8HixWPqJY4f8llGtC/USwzdYOlYQ==
X-Received: by 2002:a7b:c115:: with SMTP id w21mr2545389wmi.104.1550840015942; 
 Fri, 22 Feb 2019 04:53:35 -0800 (PST)
Received: from andreyknvl0.muc.corp.google.com
 ([2a00:79e0:15:13:8ce:d7fa:9f4c:492])
 by smtp.gmail.com with ESMTPSA id o14sm808209wrp.34.2019.02.22.04.53.33
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 22 Feb 2019 04:53:34 -0800 (PST)
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
Subject: [PATCH v10 03/12] lib, arm64: untag user pointers in strn*_user
Date: Fri, 22 Feb 2019 13:53:15 +0100
Message-Id: <dd3921be1d264efda649740a94d38872206de122.1550839937.git.andreyknvl@google.com>
X-Mailer: git-send-email 2.21.0.rc0.258.g878e2cd30e-goog
In-Reply-To: <cover.1550839937.git.andreyknvl@google.com>
References: <cover.1550839937.git.andreyknvl@google.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190222_045337_760227_4EA241B5 
X-CRM114-Status: GOOD (  12.03  )
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
index 58eacd41526c..c6adfad39016 100644
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
index 1c1a1b0e38a5..26a6a2a1a963 100644
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
2.21.0.rc0.258.g878e2cd30e-goog


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
