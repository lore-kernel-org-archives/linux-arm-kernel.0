Return-Path: <SRS0=gVCq=ON=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23C27C04EBF
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 19:41:20 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B11B62081C
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 19:41:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="MelBJE8i";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="OjEOaGAO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B11B62081C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=FUo9PTXRY3dwvfx+7S5h9xMBwJnCHldufNa4/7ttmpI=; b=MelBJE8iGdZXq7
	Qynv071KzAec6ZpsWm8a+uasV6A5tlKGse0q3S3ykhpm4irWrl3hg1jhEuR36dVwg7gnJThvy8AzP
	5lKNF98Tl6YN4A71QSOVVxbLxqGNlZ+zkY75ESMuwDWbyC6wZkq//pFHwjEdCuGlXts6CVV33jGVD
	IeldNHIYOBCGUhLP8rgIUjb0eCb39WSJkPA5/hca0WmSv4bqIyntsfUE/tAzZZXQIOAc1Ded+XrS7
	WKSFP9o/JTFhwHJWKLNNFvhEnFkYkq0dLBdGZwifyo3XyKU9bXBpcn1oRtzH1jXtTBdJOMHTUucw8
	Wp3ZDWNuxQkAfmmH2gEQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gUGZH-0001Ko-UR; Tue, 04 Dec 2018 19:41:15 +0000
Received: from mail-lf1-x141.google.com ([2a00:1450:4864:20::141])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gUGZ6-0000w2-Bh
 for linux-arm-kernel@lists.infradead.org; Tue, 04 Dec 2018 19:41:09 +0000
Received: by mail-lf1-x141.google.com with SMTP id b20so12861685lfa.12
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 04 Dec 2018 11:40:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=MJ2RoHnxkmKN1SVC9aFtGcbGzzZFAKHvy0LyoUhWX9E=;
 b=OjEOaGAOFkvDZNcY6d+glGYmOCDflfGVTlcSq7GeLuHN2n3uCFPDwIGkWqVm/tIcfP
 cQMhbLZcN/CQuT1vVh4F7zR+wNgo5NYyZyk+tf48SggDyKpRpD9wHEjVaKvtM7rm7Vig
 Wig9sYqCOseL68ELNr7naLr3FBy4R59c70Rnw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=MJ2RoHnxkmKN1SVC9aFtGcbGzzZFAKHvy0LyoUhWX9E=;
 b=St9bA2N6xYPMb4Qa6QWHsKCtS8ZJOFkYPBjfOUlL0PNYGxTcW7asOgYFhUCk65tEJi
 YvbzYgOoNMV1qZRgxt+vbVVbfHgdsmqxPD/A4W7KXq/rYiA8+GD6juriwpOeKPuIUyaN
 lzPhXPZyQcgqOZfRijP/GKX/qoKNg+45xvH5ZY3nAHkFQgvpfD53zTISDhDDadhXz9Rh
 WuiKxfqfnTLOvvzPLH9y7ra97us5mf/QIQ5cJO1gOyaCfRCz2+dDJ3Z1UzmccKV5o2Ji
 YO43V6OWfYbrY0/8iOBm/0HzTvCM5MUV4bBdBMD0d4rehziCQAiRt742LYJLJh7dO+4S
 Osqw==
X-Gm-Message-State: AA+aEWYPHklSLBnQh4fboZUltM9KyrgG0BtXP3JoWzVeYcOvt6K8YdyI
 D2FQuIBNslJ73DHbCfp8F02taw==
X-Google-Smtp-Source: AFSGD/Xx4VXmGc945omBmedemBhF6sDuPq8xHe5Usk1n+/+ssWVExT4AWpb5pXG2Ewp55V4iZUuZvA==
X-Received: by 2002:a19:c413:: with SMTP id u19mr12341607lff.100.1543952452174; 
 Tue, 04 Dec 2018 11:40:52 -0800 (PST)
Received: from localhost (c-732171d5.07-21-73746f28.bbcust.telenor.se.
 [213.113.33.115])
 by smtp.gmail.com with ESMTPSA id i75sm3187945lfb.58.2018.12.04.11.40.51
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Tue, 04 Dec 2018 11:40:51 -0800 (PST)
From: Anders Roxell <anders.roxell@linaro.org>
To: rostedt@goodmis.org, mingo@redhat.com, catalin.marinas@arm.com,
 will.deacon@arm.com
Subject: [PATCH v3] tracing: add cond_resched to ftrace_replace_code()
Date: Tue,  4 Dec 2018 20:40:44 +0100
Message-Id: <20181204194044.9506-1-anders.roxell@linaro.org>
X-Mailer: git-send-email 2.19.2
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181204_114105_184597_BDB4B3E1 
X-CRM114-Status: GOOD (  12.66  )
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
Cc: linux-arm-kernel@lists.infradead.org,
 Anders Roxell <anders.roxell@linaro.org>, keescook@chromium.org, arnd@arndb.de,
 linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

When running in qemu on an kernel built with allmodconfig and debug
options (in particular kcov and ubsan) enabled, ftrace_replace_code
function call take minutes. The ftrace selftest calls
ftrace_replace_code to look >40000 through
ftrace_make_call/ftrace_make_nop, and these end up calling
__aarch64_insn_write/aarch64_insn_patch_text_nosync.

Microseconds add up because this is called in a loop for each dyn_ftrace
record, and this triggers the softlockup watchdog unless we let it sleep
occasionally.

Rework so that we call cond_resched() if !irqs_disabled() && !preempt_count().

Suggested-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
---
 kernel/trace/ftrace.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
index c375e33239f7..7c9f49a5a1ab 100644
--- a/kernel/trace/ftrace.c
+++ b/kernel/trace/ftrace.c
@@ -2419,11 +2419,19 @@ void __weak ftrace_replace_code(int enable)
 {
 	struct dyn_ftrace *rec;
 	struct ftrace_page *pg;
+	bool schedulable;
 	int failed;
 
 	if (unlikely(ftrace_disabled))
 		return;
 
+	/*
+	 * Some archs call this function with interrupts or preemption
+	 * disabled. However, for other archs that can preempt, this can cause
+	 * an tremendous unneeded latency.
+	 */
+	schedulable = !irqs_disabled() && !preempt_count();
+
 	do_for_each_ftrace_rec(pg, rec) {
 
 		if (rec->flags & FTRACE_FL_DISABLED)
@@ -2435,6 +2443,8 @@ void __weak ftrace_replace_code(int enable)
 			/* Stop processing */
 			return;
 		}
+		if (schedulable)
+			cond_resched();
 	} while_for_each_ftrace_rec();
 }
 
-- 
2.19.2


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
