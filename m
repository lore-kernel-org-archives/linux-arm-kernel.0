Return-Path: <SRS0=5+Aw=QR=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55B26C282CC
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun, 10 Feb 2019 22:51:35 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 232452146F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun, 10 Feb 2019 22:51:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="cTNdaepR";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=mathembedded-com.20150623.gappssmtp.com header.i=@mathembedded-com.20150623.gappssmtp.com header.b="GGLs5eMp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 232452146F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mathembedded.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:List-Subscribe:List-Help:
	List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:Subject:To:
	From:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=1BR+2ybR2AdthQT0iEgy12I8wDO1yMQ1GM4l1MtoNoI=; b=cTNdaepR5SuUQy
	iOWAlNyZCab4JnsFchfkcvFgPs9ytdLaHij4Dz3vQNOUllSYDUY3YrYJAf5BCzJxjR2z8QPN3j/4A
	NQC0BMvA2h0900Y33M7Yi1bIjNk2SBIXGY5Z4ibZcNNaYFF6Px1hbVcGICXzel7eE/0iQziboULMQ
	6Ij7uYsisaZQYqkFyGmxq9ABEqTOFD9EIwJoMrN4BQH0CHViTWWw9MVu0Nc0pegLDncd7mTGrq2Rr
	vUn/+Xr3qw8NngSCujEqSPbuhckOaipJlrKjPbj9l6k+9iByJDiCjYLQsqz1UNqSZGQLUKZ7OnDAO
	vCL4VG0D6laBYcRLp2Ow==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gsxwZ-0000pH-6V; Sun, 10 Feb 2019 22:51:23 +0000
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gsxwW-0000oI-AM
 for linux-arm-kernel@lists.infradead.org; Sun, 10 Feb 2019 22:51:21 +0000
Received: by mail-wm1-x344.google.com with SMTP id x10so8086565wmg.2
 for <linux-arm-kernel@lists.infradead.org>;
 Sun, 10 Feb 2019 14:51:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mathembedded-com.20150623.gappssmtp.com; s=20150623;
 h=from:to:subject:date:message-id;
 bh=Pi51Mueiz01jqmURtbglad6f6KeDug2dSwxXoF3nC+o=;
 b=GGLs5eMpymB8AgB2Gbk2l763hDFn+qpOAaeQC35PF76pG1YUs3lXj4SYM/7R8pR+YI
 pcP2Ve4OgpjAhK5ADJ9wUqTsRopHf8yAvO4/LLesq1Vmb+hfO/1rRKR0AXaEH0o8dwKJ
 sdjIwDOTHsd9cNA4tSWVUo7AiKWj+9iCjPPgziyZIgz550QZ1QpXQkZ6TPaxSIHnVfeR
 7pPzHgBbcRLGTFnURNpp3meu7CKM8bR3J2KM6dZKd1r44K0AH5z78tIF7sP/604Baea8
 jjNuYeTYIthO2WmKSj3PqYnkN+iRpt7IipOrlXnTp4NJe5sqv21I2BanrjZ7yyGfFexk
 TKzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id;
 bh=Pi51Mueiz01jqmURtbglad6f6KeDug2dSwxXoF3nC+o=;
 b=aw54tXv+BrttetQapxU5n8cFmbjBA+pzlBrwlcWDW/feh3y02qXhWU1lsqOd8k2rgR
 gqPQ6LLGmOm4c+iLCw/vOr6+mYsbuRoQspr4G9Pg6nZ+TzT1y4R+WxjaNqOVnAonYG33
 r21VWfRlETwjfbYFEh4eolBGey/Wyp9a88uqwHUfiun39J75oaATQoaEGbr2JKq7AFy4
 vC3saVWpM+8evOyQEs+ThQnS4fRrdpbBHNiRXA+3z8GCaWdp8MthVu8cX4paiTxO70oU
 U+kfFBR+j5WlsB6mv5Wx+TcYg44d+rBbVWOY7Yw6FMvDgZlkDnyLhaNwfhlYQQd84aso
 G/NA==
X-Gm-Message-State: AHQUAuYhzzQg0dgnVh0jW+yjpW/pw6sp8abd9RrpUGufseqB6wT1zokl
 j3VtzSb/uNC7850XdT6pxUlXjw==
X-Google-Smtp-Source: AHgI3IZMAXENriRqCnD09knJAHnUr2hVcIg8TPURsETLX9fU46ieXCFiVyIKMeaZwlCxnXJjyjuxFA==
X-Received: by 2002:a05:6000:10cf:: with SMTP id
 b15mr24877948wrx.301.1549839077853; 
 Sun, 10 Feb 2019 14:51:17 -0800 (PST)
Received: from localhost.localdomain
 (host86-176-243-198.range86-176.btcentralplus.com. [86.176.243.198])
 by smtp.gmail.com with ESMTPSA id c139sm3904325wmd.13.2019.02.10.14.51.16
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Sun, 10 Feb 2019 14:51:17 -0800 (PST)
From: Stuart Menefy <stuart.menefy@mathembedded.com>
To: linux-samsung-soc@vger.kernel.org,
 Daniel Lezcano <daniel.lezcano@linaro.org>,
 Thomas Gleixner <tglx@linutronix.de>, Kukjin Kim <kgene@kernel.org>,
 Krzysztof Kozlowski <krzk@kernel.org>, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
Subject: [PATCH 0/2] Subject: [PATCH 0/2] clocksource: exynos_mct: Clear timer
 interrupt when shutting down
Date: Sun, 10 Feb 2019 22:51:12 +0000
Message-Id: <20190210225114.20110-1-stuart.menefy@mathembedded.com>
X-Mailer: git-send-email 2.13.6
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190210_145120_399339_8A284ED7 
X-CRM114-Status: GOOD (  10.71  )
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

When debugging suspend problems on Exynos 5260, I had a large number
of debugging prints going to the serial port after interrupts
had been disabled but before the timer interrupt was shutdown. This
was long enough for a timer tick to occur, but as interrupts were
disabled the ISR didn't run, and so the interrupt wasn't cleared.
Later when the timer was shutdown the interrupt was left asserted and
so the wfi at the heart of the suspend code didn't wait, causing
the suspend to fail.

Currently the code which stops the timer when it is on one-shot mode
and the interrupt occurs is in exynos4_mct_tick_clear(), meaning if we
called this from the shutdown code exynos4_mct_tick_stop() could be
called twice. So first restructure the existing code, so the check for
one-shot mode and stopping the timer is moved to the ISR, leaving
exynos4_mct_tick_clear() just clearing the interrupt flag.

Once this has been done simply call exynos4_mct_tick_clear() from
set_state_shutdown().

Stuart Menefy (2):
  clocksource: exynos_mct: Move one-shot check from tick clear to ISR
  clocksource: exynos_mct: Clear timer interrupt when shutdown

 drivers/clocksource/exynos_mct.c | 23 ++++++++++++-----------
 1 file changed, 12 insertions(+), 11 deletions(-)

-- 
2.13.6


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
