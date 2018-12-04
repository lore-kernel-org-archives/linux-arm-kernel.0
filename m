Return-Path: <SRS0=gVCq=ON=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 565E8C04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 19:12:57 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2135D2082B
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 19:12:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="FidC18x2";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="AL5otzb+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2135D2082B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=2zpE4YGAqrj3kua/ZzC3ShEkaqyUlI18puaYYn+aKm0=; b=FidC18x2puINMT
	ykMPPGYeoxoJDQve99WuexuKLkRCDjnSvbrXf3T633/cRIQPKVQalOIM/Tp6fsfIFkTJqVDjqovkV
	5yWEiaB8bAwnrFg2S4yjUWbBtujVBpark3hh07yeJMkPT14TZ0/e+Wc/9Sahb1QIjX4bPj22epfQt
	rb+sYvQW+hE0jhcE3RhRgw0gRgHWQqMlPtR5lE4Ib1bm9yFt+IqqPj/BbFZ2uiGVmZCfSjSAs427k
	yzn9LKJGM+EaOcTTN2G7TqS61JSiWYXoblmjwu/Vq0nEkA4EWOGKkEg+/FDdt1Ykri37cwQd6XrBB
	frZFwXLHp0/BVoINIsbg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gUG7m-00079W-P6; Tue, 04 Dec 2018 19:12:50 +0000
Received: from mail-lj1-x241.google.com ([2a00:1450:4864:20::241])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gUG7j-000790-Uk
 for linux-arm-kernel@lists.infradead.org; Tue, 04 Dec 2018 19:12:49 +0000
Received: by mail-lj1-x241.google.com with SMTP id g11-v6so15985042ljk.3
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 04 Dec 2018 11:12:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=//4FO27EOO8cJvGZSWp42VAK+MHOwE9eX7iULiXx+NQ=;
 b=AL5otzb+xOXtn4QEnKRppU81XMGlj6grJ+JkKUIvawxYMmV8SR/cJtdLQYLgVwV3dJ
 yQEjxbd+5i+yTM+xUkJLWV6PqYTe455r9rIUGZ4oRB6F+CRAgdDNlTFfU4kXUUEBcSwl
 C417mNp+NmnXAlV2NN1/5/EadWCXxSHatXGG0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=//4FO27EOO8cJvGZSWp42VAK+MHOwE9eX7iULiXx+NQ=;
 b=QKQ+Ow9IpvKnTsGATfdOnVV0e5KVQvyTlD6/vVjAHT+CNHj7gk8wW6poPTpO1Y8ITo
 n01wnylJRI2OnUY//BYXM8qnp0hcSFN3oW86+igwRVYEua3gEvcRXxi7I8Qaf+k1YpN5
 N3DqmfLwamOoMpeVU6aOhuKTLNLJPaKqUkhP9TQ7XNZj2qXdPmNmqCz3AnqXt7ID3Rms
 T8kUGs22buSMlfcqr5ncqPulFHRcEd4t0zqBIs/9uJETTfOQZvVk3lB/bO17gZN5uH1d
 WeOhz9bAvyCs9UtA7r2PbuxhlFhmtHYb10BQNc28TJIYEiFe5e9/+qXT6FSZpNFIAtBq
 Kv1w==
X-Gm-Message-State: AA+aEWZ57XBn25eWiI987ALgjg6p7dcath3T930WIDyrwnB784Ii3spQ
 Sth6gxef4pO3C3OByD5VstgNLg==
X-Google-Smtp-Source: AFSGD/VcbdFiqs7e1PfxY8flJnZ2mo69hCTifzV9KM01NitR/eCV/NC+U5QrkyOD7Rq/GcgJvgXv/g==
X-Received: by 2002:a2e:9556:: with SMTP id
 t22-v6mr14969452ljh.36.1543950755121; 
 Tue, 04 Dec 2018 11:12:35 -0800 (PST)
Received: from localhost (c-732171d5.07-21-73746f28.bbcust.telenor.se.
 [213.113.33.115])
 by smtp.gmail.com with ESMTPSA id o26sm3316312lfl.18.2018.12.04.11.12.33
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Tue, 04 Dec 2018 11:12:34 -0800 (PST)
From: Anders Roxell <anders.roxell@linaro.org>
To: rostedt@goodmis.org, mingo@redhat.com, catalin.marinas@arm.com,
 will.deacon@arm.com
Subject: [PATCH] tracing: add cond_resched to ftrace_replace_code()
Date: Tue,  4 Dec 2018 20:12:28 +0100
Message-Id: <20181204191229.6851-1-anders.roxell@linaro.org>
X-Mailer: git-send-email 2.19.2
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181204_111248_000674_B91C7D3F 
X-CRM114-Status: GOOD (  12.61  )
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
index c375e33239f7..582e3441e318 100644
--- a/kernel/trace/ftrace.c
+++ b/kernel/trace/ftrace.c
@@ -2419,11 +2419,14 @@ void __weak ftrace_replace_code(int enable)
 {
 	struct dyn_ftrace *rec;
 	struct ftrace_page *pg;
+	bool schedulable;
 	int failed;
 
 	if (unlikely(ftrace_disabled))
 		return;
 
+	schedulable = !irqs_disabled() && !preempt_count();
+
 	do_for_each_ftrace_rec(pg, rec) {
 
 		if (rec->flags & FTRACE_FL_DISABLED)
@@ -2435,6 +2438,13 @@ void __weak ftrace_replace_code(int enable)
 			/* Stop processing */
 			return;
 		}
+		/*
+		 * Some archs calls this function with interrupts or preemption
+		 * disabled. Howeve, other archs don't and this can cause a
+		 * tremendous unneeded latency.
+		 */
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
