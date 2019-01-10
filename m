Return-Path: <SRS0=vaNk=PS=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75EC2C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 09:00:57 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 46A87214C6
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 09:00:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="SHL4X+cs";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="StTE4o0X"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 46A87214C6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	References:List-Owner; bh=SJEoS2+lsAurDH5i8opYlZAzjFOwIWAm5ESoFxs1lWQ=; b=SHL
	4X+cs3wXlIDQYyr+jxQW/0tvrJ1QVJcIX2TmKfCwA6BU6TTh1ulp04/gHyNDyPCt31HYKc9xTglq8
	xq6xsuq0OepQ++FhwT0I8Qtq0cOL+CsZuu9BsKMk7l7oWOP6d5iDgRkNq81X8WmLEEKtvII40fMEn
	5JGNRddsqS9b3/XdNT25yfVFFSvjfe7iPu12l1i/LbpTe16zZPTrkB5ATa+UyxCTm8+d0cCOh1d7R
	RzmH7gcyBEj2tvIt7MKEq6lhLQGeE6QrcNoLIhWxTPQ0tk45pbuJT4DG7URBeCnuyy4IJI/1kd7yH
	Et35kw0Tj6Rea5FH6Qan0NZthufQP5g==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1ghWCu-0001Jo-4i; Thu, 10 Jan 2019 09:00:56 +0000
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1ghWCm-0001Iy-Ih
 for linux-arm-kernel@lists.infradead.org; Thu, 10 Jan 2019 09:00:54 +0000
Received: by mail-wr1-x441.google.com with SMTP id x10so10383223wrs.8
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 10 Jan 2019 01:00:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id;
 bh=18XqnmtxO2ZjWnroEVY6EZhQhDEBrpPKdAHEWSzf+WU=;
 b=StTE4o0XcaXOhXmbEVctoZSfkYDxDJftLBtLSB+aOMwy6xCkH0BcV5DvLurqinEZ5d
 yotV4lgYIg217pLo1xVL3QfUFxxYzaI2ib4kkbGm7ufUkybttnVtZdjCnJemClaJw0EL
 5kheEW6GNU4boUXUB/G+HMnhl3E+Z2XB+REkc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id;
 bh=18XqnmtxO2ZjWnroEVY6EZhQhDEBrpPKdAHEWSzf+WU=;
 b=ADtfnvwQqTlRufBiMEK9EnEgQwXSxQIh5JFClP6lncQZltv8cOTINiIiTBs/E/tSmm
 yyJ/t2v/rjpPyeYDh47OjwuLY/MTqDq7VBdV7YlBLSc78GMOqKe25e/zRiR57zBnr6o9
 NLauzFlg/LEe79jglrTUxS1lCLxqRDei0iJKZYx29gu32zG4q30GHV1Cxx3/IwBcC1E/
 U+X9rVutfG7HSGg7MMrItSkNjA09YY3E9na94OamgofevER0zPkAWT4TKUeo2AVFysKA
 BFA4DpeXIeBTq3l5MYmV3t1xYJSTFWsBtkh1K/tORtMgMtXacupCpOHJl7BMbEJYmQvk
 Ky8Q==
X-Gm-Message-State: AJcUukfC2vmfSTxyPKYQlx7A2UGiyt7NEnslfeECrCRT/fpvtVQ42aeq
 k5eIglYBiJvaQ84YKhjtjwLsuw==
X-Google-Smtp-Source: ALg8bN4p1ZQuNVqDCrqwggX/aTkOENTsVdHD1g8Pgg5zQEoc+2qbWVw1fBTyboKuBWbZMFpNiZDfjw==
X-Received: by 2002:adf:f101:: with SMTP id r1mr8434701wro.32.1547110846578;
 Thu, 10 Jan 2019 01:00:46 -0800 (PST)
Received: from localhost.localdomain ([2a01:e0a:f:6020:e487:f4e5:a382:9ce9])
 by smtp.gmail.com with ESMTPSA id v1sm78383304wrw.90.2019.01.10.01.00.45
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
 Thu, 10 Jan 2019 01:00:45 -0800 (PST)
From: Vincent Guittot <vincent.guittot@linaro.org>
To: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org,
 rjw@rjwysocki.net, ulf.hansson@linaro.org, tony@atomide.com,
 ladis@linux-mips.org
Subject: [PATCH v2] PM/runtime: Fix autosuspend_delay on 32bits arch
Date: Thu, 10 Jan 2019 10:00:40 +0100
Message-Id: <1547110840-15396-1-git-send-email-vincent.guittot@linaro.org>
X-Mailer: git-send-email 2.7.4
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190110_010048_644858_DF5950C9 
X-CRM114-Status: GOOD (  14.01  )
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
Cc: Vincent Guittot <vincent.guittot@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Cast autosuspend_delay in u64 to make sure that the full computation of
expires or slack will be done in u64, even on 32bits arch.
Otherwise, any delay greater than 2^31 nsec can overflow if signed 32bits
is used when moving delay from msec to nsec

Fixes: 8234f6734c5d ("PM-runtime: Switch autosuspend over to using hrtimers")
Reported-by: Tony Lindgren <tony@atomide.com>
Tested-by: Tony Lindgren <tony@atomide.com>
Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
---

Change since v1:
- add u64 cast for slack computation

 drivers/base/power/runtime.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/base/power/runtime.c b/drivers/base/power/runtime.c
index 7062469..76d0676 100644
--- a/drivers/base/power/runtime.c
+++ b/drivers/base/power/runtime.c
@@ -141,7 +141,7 @@ u64 pm_runtime_autosuspend_expiration(struct device *dev)
 
 	last_busy = READ_ONCE(dev->power.last_busy);
 
-	expires = last_busy + autosuspend_delay * NSEC_PER_MSEC;
+	expires = last_busy + (u64)autosuspend_delay * NSEC_PER_MSEC;
 	if (expires <= now)
 		expires = 0;	/* Already expired. */
 
@@ -525,7 +525,7 @@ static int rpm_suspend(struct device *dev, int rpmflags)
 				 * We add a slack of 25% to gather wakeups
 				 * without sacrificing the granularity.
 				 */
-				u64 slack = READ_ONCE(dev->power.autosuspend_delay) *
+				u64 slack = (u64)READ_ONCE(dev->power.autosuspend_delay) *
 						    (NSEC_PER_MSEC >> 2);
 
 				dev->power.timer_expires = expires;
-- 
2.7.4


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
