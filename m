Return-Path: <SRS0=AWyS=OJ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D614C04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 15:10:01 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2C48020867
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 15:10:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="m6XZerLx";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="WNS16U3T"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2C48020867
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=Myj9RWllSTJvHgOJXB1/Jnc6EAaNg1iJhm5rvnMa8Iw=; b=m6XZerLx+8fX66
	fQZq9YJ+MpxfTWPPFnbICeaMK7EEns3CqlAifrBYNYM5/ELX06HjkIeuTDYPhigFrZ0QPmArkEkn2
	QTF8DavVOqA6Y6Gg31ZdhMu+XWtyFLooPMA1BkMbwV82TwwlEfjy5FyP9ciHvuZWb8KENsRJ9Sm6b
	FdTwFWaKP2HUSpadLrHyGbkYBbvTfdflG5ZQDtQziNpEEsDVmyVZ6Gm+Z8lpv37LcOBq5p8ygEYYU
	9ZhCuJTJVHXS2Kn3YN7MEiG4VYhO4vOcI5VMFvnGR7sUcQSGZlPLmiL/4rtCD1V8/Ugy6KCsao50Y
	su9Hw4hyPuf8OWjo7pvA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gSkQZ-0001ub-Um; Fri, 30 Nov 2018 15:09:59 +0000
Received: from mail-lj1-x244.google.com ([2a00:1450:4864:20::244])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gSkQT-0001rB-Dq
 for linux-arm-kernel@lists.infradead.org; Fri, 30 Nov 2018 15:09:57 +0000
Received: by mail-lj1-x244.google.com with SMTP id c19-v6so5280871lja.5
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 30 Nov 2018 07:09:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=85KCfW3nCq0jcrH/zFnUuLUEVTX2XkKXX7xHs/xruHs=;
 b=WNS16U3TAIi5WGm5/3zTJ2oj/8f7Bw4KwTRN0E//6gsK3l1u34sRnv6d5ZG5z5zWQ7
 PcZ0kyC6Szpe2UqHpD/LQk4EH5yKVxrozSKWpPRqkjoH8OkCZzyBcQSUUm/zNktPBV3V
 MTh5lTnssACP+mGsV8MK2EJAH5IBj+JFqmSg0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=85KCfW3nCq0jcrH/zFnUuLUEVTX2XkKXX7xHs/xruHs=;
 b=qxKrRSwVa2JeVasJq40YVgLc6kDkKl93ZbJ37kRCwKxGJdH+gLrXpOzbae6x162X6d
 1RwmsY8AIhJG2dn3YmYHQh2VDpzwlzs0txg8LSkmm02DhquGbTCRvQ7W1Dsy4Qy+ivRy
 sLFuo2m2eIheKTNA117GY+OemHY3PS1LjLjQZ5uRb19r9eZ2yoXgbwnfRqrKf+I4xRYO
 NN1jasiKHgkccXxTBBtUO51BQ0ClO5HTvE9ACod4dDjhrt44o/qsN6n9XNIml9QmpHIb
 JiQ8Xtq0oMhnqv5h11ohjyNuPvNQ3h1AE4SN/lwKSsC/Sb3Bpvxp+1KSvFAsFZxnctqB
 5h0w==
X-Gm-Message-State: AA+aEWZmnJ2HYjUc4ciZzl7eaQfVN/qAWi3ptKb2WqSbtW7T4EqvN027
 yERZQAkVZiy710ZLkndou5P5DQ==
X-Google-Smtp-Source: AFSGD/XiXiNiOaeLEUQYh09lGs4UYroBPv8sdQvKtrB54ACrUz6h8+MIjRencTE8CpHxNyL66BEz1A==
X-Received: by 2002:a2e:9ad0:: with SMTP id
 p16-v6mr4448681ljj.102.1543590581488; 
 Fri, 30 Nov 2018 07:09:41 -0800 (PST)
Received: from localhost (c-732171d5.07-21-73746f28.bbcust.telenor.se.
 [213.113.33.115])
 by smtp.gmail.com with ESMTPSA id m13-v6sm858237ljg.56.2018.11.30.07.09.40
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Fri, 30 Nov 2018 07:09:40 -0800 (PST)
From: Anders Roxell <anders.roxell@linaro.org>
To: rostedt@goodmis.org,
	mingo@redhat.com
Subject: [PATCH 2/3] tracing: instruct KCOV not to track tracing files
Date: Fri, 30 Nov 2018 16:09:35 +0100
Message-Id: <20181130150935.27493-1-anders.roxell@linaro.org>
X-Mailer: git-send-email 2.19.2
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181130_070953_528177_6E1F4987 
X-CRM114-Status: UNSURE (   9.48  )
X-CRM114-Notice: Please train this message.
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
Cc: Anders Roxell <anders.roxell@linaro.org>, keescook@chromium.org,
 Arnd Bergmann <arnd@arndb.de>, catalin.marinas@arm.com, will.deacon@arm.com,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

When we have KCOV enabled and running ftrace startup tests we end up in
a softlockup. Kcov and ftrace tracing each other makes it really slow:

[  275.141388] Testing tracer wakeup_dl:  PASSED
[  304.738345] Testing tracer function_graph:
[  716.236822] watchdog: BUG: soft lockup - CPU#0 stuck for 21s! [ksoftirqd/0:9]

Rework so that we don't let KCOV look at tracing files. Could probably
be more selective here, but in in general letting KCOV and ftrace check
each isn't the best idea.

Co-developed-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
---
 kernel/trace/Makefile | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/kernel/trace/Makefile b/kernel/trace/Makefile
index f81dadbc7c4a..c7c73b976103 100644
--- a/kernel/trace/Makefile
+++ b/kernel/trace/Makefile
@@ -6,6 +6,11 @@ ifdef CONFIG_FUNCTION_TRACER
 ORIG_CFLAGS := $(KBUILD_CFLAGS)
 KBUILD_CFLAGS = $(subst $(CC_FLAGS_FTRACE),,$(ORIG_CFLAGS))
 
+# If instrumentation of this dir is enabled, the function tracer gets really
+# slow. Probably could be more selective here, but note that files related
+# to tracing.shouldn't be traced anyway.
+KCOV_INSTRUMENT		:= n
+
 ifdef CONFIG_FTRACE_SELFTEST
 # selftest needs instrumentation
 CFLAGS_trace_selftest_dynamic.o = $(CC_FLAGS_FTRACE)
-- 
2.19.2


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
