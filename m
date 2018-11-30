Return-Path: <SRS0=AWyS=OJ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D74CC64EB4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 15:10:32 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1E44820867
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 15:10:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="HeTAqF1o";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Hf7NYzds"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1E44820867
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=+q17sQuySDR/q4wYk2lSywRX1d1gJgx1lwQUjnY4cOU=; b=HeTAqF1o5e3f+R
	iTbJA8pYfOn1mu5HFqvJwb3mLK26PEuAy2KFoB6bf7NfDgtwkkpalF4qTCpwLstu1M/sqLijlMUZf
	zHlxiyx8A5sGa09k3Fl5D2+wJCckWKYHCS4dBvdpPomq9JjseyznQf3J7jmISUXDrLYx2+Ui1Hbhp
	c7biY1nz4w6sJY+/s4w8RQOqlTtMb0FpcEdTQgvWP7/r12aD+Z3X0vK9ygbRcAcYi6+WWivXDshFq
	GBngIYXvflUi5IHxVq0zZBTKhzx09KDcrkxvmA6sCS59n2DnDFna8M8UX8QUBUR71/zrJMQh00M1/
	5HOtUkfsrnJ6ydHmNGEQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gSkR2-0003UD-0G; Fri, 30 Nov 2018 15:10:28 +0000
Received: from mail-lj1-x244.google.com ([2a00:1450:4864:20::244])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gSkQq-00026x-MK
 for linux-arm-kernel@lists.infradead.org; Fri, 30 Nov 2018 15:10:19 +0000
Received: by mail-lj1-x244.google.com with SMTP id t9-v6so5271431ljh.6
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 30 Nov 2018 07:10:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=Sn6e2y3hrDqC5F6PRoRA5dBPL+JkfPGNchhGjAsqyhg=;
 b=Hf7NYzdsmIc6gAHEOJdgMn9FEKqpFUYVf1s5w8KySpDhefcB22MF6kW3XbmiACEez1
 HV2hfJXyGxMtTxhQ4QgB9N1w1TcnvBd2Cvid6LJkfE61lw8uF5dDOjj/MCu39gv5xWp+
 BFKA63Mww/JBddGUnzn5SLq7D9t7SFm1wdLnY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=Sn6e2y3hrDqC5F6PRoRA5dBPL+JkfPGNchhGjAsqyhg=;
 b=b7rc7DzCYzad2nKi8YQYkFCWhA3gnTqYvF9D8aZHDkl0Y1yWK3yLTYF0S5ZAXayplf
 01KE814J7UWKrBNiDa3omI5WQTTheligJpZBv594vAa6KBRUsqplXlwhNsDT/2IzfSJI
 nXIFtrOszIC/isRGU00xhNfyCBsKaWKY2OhrDWp8LuvH6wPAg2ceRHMJi5L9SS9lmW4N
 KzOVudzkDRsZuT/DsfgMdDV4VuuFiobvd7+iOT7LD1TeaJtnV3s22AU6614MY0YvYUf2
 uX/Dmq4txygVauRtk3xh5XVjPO+hTRDcvox10p8N8Ff1MV5turV3H88oyY4LQ3ojV5Vo
 JiCw==
X-Gm-Message-State: AA+aEWbu5Ry5wep0cgVYhwskiUVNGwGgBJDhURgR41oRexbbKgLf297L
 Zt7aQE8whq+CO45OLu8LXZaGeg==
X-Google-Smtp-Source: AFSGD/WJEpxEpyZY8TB/f9eIF5AJ1VuRqInkmOD8qy4TLDhGqq3K4SiweALxfqHhJNLP8p1a5+nn5w==
X-Received: by 2002:a2e:9017:: with SMTP id
 h23-v6mr3612440ljg.71.1543590604769; 
 Fri, 30 Nov 2018 07:10:04 -0800 (PST)
Received: from localhost (c-732171d5.07-21-73746f28.bbcust.telenor.se.
 [213.113.33.115])
 by smtp.gmail.com with ESMTPSA id a11sm865169lfb.68.2018.11.30.07.10.03
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Fri, 30 Nov 2018 07:10:04 -0800 (PST)
From: Anders Roxell <anders.roxell@linaro.org>
To: rostedt@goodmis.org, mingo@redhat.com, catalin.marinas@arm.com,
 will.deacon@arm.com
Subject: [PATCH 3/3] arm64: ftrace: add cond_resched() to func
 ftrace_make_(call|nop)
Date: Fri, 30 Nov 2018 16:09:56 +0100
Message-Id: <20181130150956.27620-1-anders.roxell@linaro.org>
X-Mailer: git-send-email 2.19.2
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181130_071017_134352_12D4EEE8 
X-CRM114-Status: GOOD (  11.70  )
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
Cc: Arnd Bergmann <arnd@arndb.de>, Anders Roxell <anders.roxell@linaro.org>,
 keescook@chromium.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Both of those functions end up calling ftrace_modify_code(), which is
expensive because it changes the page tables and flush caches.
Microseconds add up because this is called in a loop for each dyn_ftrace
record, and this triggers the softlockup watchdog unless we let it sleep
occasionally.
Rework so that we call cond_resched() before going into the
ftrace_modify_code() function.

Co-developed-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
---
 arch/arm64/kernel/ftrace.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm64/kernel/ftrace.c b/arch/arm64/kernel/ftrace.c
index de1a397d2d3f..9da38da58df7 100644
--- a/arch/arm64/kernel/ftrace.c
+++ b/arch/arm64/kernel/ftrace.c
@@ -130,6 +130,11 @@ int ftrace_make_call(struct dyn_ftrace *rec, unsigned long addr)
 	old = aarch64_insn_gen_nop();
 	new = aarch64_insn_gen_branch_imm(pc, addr, AARCH64_INSN_BRANCH_LINK);
 
+	/* This function can take a long time when sanitizers are enabled, so
+	 * lets make sure we allow RCU processing.
+	 */
+	cond_resched();
+
 	return ftrace_modify_code(pc, old, new, true);
 }
 
@@ -188,6 +193,11 @@ int ftrace_make_nop(struct module *mod, struct dyn_ftrace *rec,
 
 	new = aarch64_insn_gen_nop();
 
+	/* This function can take a long time when sanitizers are enabled, so
+	 * lets make sure we allow RCU processing.
+	 */
+	cond_resched();
+
 	return ftrace_modify_code(pc, old, new, validate);
 }
 
-- 
2.19.2


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
