Return-Path: <SRS0=gVCq=ON=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 255C1C04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 19:30:52 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E8318206B7
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 19:30:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="EmTIw7G0";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Q/T928xt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E8318206B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=c5RNZz3dBurNUnCNfdIK7mh0JYvWGpDskItZILBayLE=; b=EmTIw7G07GRzHN
	kmNSoyDCNSEuFF8+FcA2P5Y5iH9ZNmtIDSVpuZuatBRAZicUi503QvM8n8YvS2XDRhED80byl4cVU
	6m+FMIA4KjNftPpDxzlp5Jrplz436UF/SrteS11S2Gpp2FvlLWwNjCSB7nzMd4r/QXY0HsptOMnvc
	JFafdklPyYab4lgVvwUvSxfD5CofETsVs/0RTR2610iWPa0OxsLF9Bb+H/7CAnu9v/nMwfWhbcuE7
	tvHi6y/6i2fIvXcRFQo8vB16VneTUU8mgtpkf6z0nCscasMi4XmzcZTXbqiHJmRbwirrsMq9zrNXN
	TsCrVxrNN3i8De+J6GNg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gUGP7-0003H8-Rg; Tue, 04 Dec 2018 19:30:45 +0000
Received: from mail-lj1-x242.google.com ([2a00:1450:4864:20::242])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gUGNk-0000Zo-So
 for linux-arm-kernel@lists.infradead.org; Tue, 04 Dec 2018 19:29:26 +0000
Received: by mail-lj1-x242.google.com with SMTP id c19-v6so16027594lja.5
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 04 Dec 2018 11:29:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=InkRDJb3bMIXWPs5c5/xqK+kSTer9bJK74SZfDVgZxo=;
 b=Q/T928xt76bOPzWNBRs8eIDvxhFDwvl8m/aCuQw/hFMVMHVkDqGOpLwXrS9DKPEtVF
 f8gY7A7z+GIWJpRz9IG107vWUKWbywnyObTWk35izIbagI8WIMIrAvfcOnWX2Yx2sSgE
 D7gI9mefs3fkYiggzx7ADfdojrQ2E3HmHC82k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=InkRDJb3bMIXWPs5c5/xqK+kSTer9bJK74SZfDVgZxo=;
 b=bEcR91nqQLsFoGMDOo11EuRdyTipjLnh1YK0z3+1xBrDz4YYZzYa+IkO0tszoIKiZj
 QVyqgXoi9wbQQjGEH8LR8OGNN7CWFechThbMkb19LKZAmxInA+lBzqXm4F49BqzclImN
 HkQziC44CdhFUyHFj9EcO7uSzIK2EgGrsA3wX6Tgc2TQVwpwHjz5C377YPqtQa1lU65w
 f3bE9qR5yMaxvM+sdg60pdeQUU0Ep2ZzYrlKa/BSvrOmk0cBB30JTQZTPKWDfVwPr/OP
 cTctx2q4Dd37VGvo0EDVfRZvA5lTm/KO1dIROXQYNskvcQA5M2JlV3K9QObpe2GOkF0C
 lgZg==
X-Gm-Message-State: AA+aEWb3aQyY/doyr9iNnng3WEHgbDrgjhFCDi5h0fjPz9dErBNwoiki
 SRYraGx7SzFIzplwg/B3AJ5yNg==
X-Google-Smtp-Source: AFSGD/WWz7qhKO7Ngy7zj4/C0F7tI8lp/upK4iu+SD8FPW1eO2uImdDob9s6GBjj7dcxIvr9hWE8mg==
X-Received: by 2002:a2e:83d7:: with SMTP id
 s23-v6mr3594602ljh.139.1543951748560; 
 Tue, 04 Dec 2018 11:29:08 -0800 (PST)
Received: from localhost (c-732171d5.07-21-73746f28.bbcust.telenor.se.
 [213.113.33.115])
 by smtp.gmail.com with ESMTPSA id f8sm3396773lfe.72.2018.12.04.11.29.07
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Tue, 04 Dec 2018 11:29:07 -0800 (PST)
From: Anders Roxell <anders.roxell@linaro.org>
To: rostedt@goodmis.org, mingo@redhat.com, catalin.marinas@arm.com,
 will.deacon@arm.com
Subject: [PATCH v2] tracing: add cond_resched to ftrace_replace_code()
Date: Tue,  4 Dec 2018 20:29:03 +0100
Message-Id: <20181204192903.8193-1-anders.roxell@linaro.org>
X-Mailer: git-send-email 2.19.2
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181204_112921_413808_A99F573C 
X-CRM114-Status: GOOD (  12.45  )
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
index c375e33239f7..7080eb464983 100644
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
+	 * Some archs calls this function with interrupts or preemption
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
