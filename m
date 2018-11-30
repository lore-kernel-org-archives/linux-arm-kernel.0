Return-Path: <SRS0=AWyS=OJ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A678CC04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 18:44:13 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 760F420868
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 18:44:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="f+pyC+FX";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="C9iAkn/e"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 760F420868
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=rpz1y5suuu/O6r2uanmLbZqf1Ic/wiy7lg84s4j7cBU=; b=f+pyC+FXQxe3K0s+woD3LeIXlz
	3MCimKjZYkhtVglrXdfLJiACv8ZzbvTJ9vaal/NLUn+wSIJVmHbBYlbsh/xcHUOvMYNm2Zp2BBGfv
	wopPC89pUxorsXre2B36b/p0DRId1Ohvw0XLrbnYwA7GP+HUb7YLb1zm4cgC5ZdmYqpIhQGG71I6S
	p2tc07gFaqibxNml0ST1kybCpB2/8dYsB8RDGOGB9vjGNYRd4jWPgq6ebTppoFzUNPwUq9jsN8sge
	YPljPHR6wxxvsYQCJru9OZMbKPnWeNUpNUoH2vTKVB4NhKglW/1vJLEjZuwSG+aWYbO4OMox/0yw5
	IUcOzjug==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gSnln-0000kx-7q; Fri, 30 Nov 2018 18:44:07 +0000
Received: from mail-pg1-x542.google.com ([2607:f8b0:4864:20::542])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gSnl4-00008g-H9
 for linux-arm-kernel@lists.infradead.org; Fri, 30 Nov 2018 18:43:24 +0000
Received: by mail-pg1-x542.google.com with SMTP id y4so2848297pgc.12
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 30 Nov 2018 10:43:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=a54bpJWkTONWX4xBh3sap+Bcri1qS8QIiPLNgbLvU28=;
 b=C9iAkn/eQ81AquoFVcDRP4BXRSDPvwi5lVom0WpXgdndGwCZmQdUQsc0LJ39BK7HH0
 kCT8HZiFlMoI5S4CO9wUbiQmU+YZDXl22GevrHwzuI5arIPYrQvWzJxP3iPajaMdBtt3
 B7ETOxXhQlqkn/G+DbDeFP7LSMBZC/Fqh/uNw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=a54bpJWkTONWX4xBh3sap+Bcri1qS8QIiPLNgbLvU28=;
 b=lq3jdIbyC9ZZwDNSXspueQ6PjkIzInKBRJSmlr7tOmEISEqlE5COzmi2V/QZEXpo3D
 yaxkeFWPxTHud0k8/P3X40hknZK+wJ8BIOH6Y94Q1ON2HiGj38crJ8vzfmhgI7H1yrZd
 /JAzV7v/eKkEQpLVTIAXdJTq5ENw+dzl75oWpi2gpUXG0BIhMI38DsRmme7ktt/+G1bn
 Fe6IPUy7hR4jobw/GhViVjzgbzfJI1hbOt45hxw02mVkn0YYONkjHNJ3pOvNZ67E//uL
 XDhkQK9ESt4D3SJj6DGSmljhxWQjJkOdACXPZMTHZqdECBJLEdVsoUmTKrI2J/blfxp6
 bmkg==
X-Gm-Message-State: AA+aEWZfxSYOYKBKKqXa+7hLLQdrIu6CFKa54cyWo2La5liHwJXgUnCV
 mBL0YO5usw7862KiYzBnP8bzaw==
X-Google-Smtp-Source: AFSGD/UZy7zWwm4JsDtF8rlBsET0+PI69OZOzPIlytWx/XBEcg/oYw6hn5webSmFz8TovtjTTzOxzw==
X-Received: by 2002:a62:1541:: with SMTP id 62mr6721900pfv.230.1543603391929; 
 Fri, 30 Nov 2018 10:43:11 -0800 (PST)
Received: from xps15.cg.shawcable.net (S0106002369de4dac.cg.shawcable.net.
 [68.147.8.254])
 by smtp.gmail.com with ESMTPSA id l184sm12743147pfc.112.2018.11.30.10.43.11
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
 Fri, 30 Nov 2018 10:43:11 -0800 (PST)
From: Mathieu Poirier <mathieu.poirier@linaro.org>
To: gregkh@linuxfoundation.org
Subject: [PATCH 3/6] coresight: etf: Release CLAIM tag after disabling the HW
Date: Fri, 30 Nov 2018 11:43:04 -0700
Message-Id: <1543603387-32645-4-git-send-email-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1543603387-32645-1-git-send-email-mathieu.poirier@linaro.org>
References: <1543603387-32645-1-git-send-email-mathieu.poirier@linaro.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181130_104322_570861_46A9D361 
X-CRM114-Status: GOOD (  14.57  )
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
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

This patch rectifies the sequence of events in function
tmc_etb_disable_hw() by disabling the HW first and then releasing the
CLAIM tag.  Otherwise we could be corrupting the configuration done by an
external agent that would have claimed the device after we have released
it.

Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
Reviewed-by: Suzuki K Poulose <suzuki.poulose@arm.com>
---
 drivers/hwtracing/coresight/coresight-tmc-etf.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hwtracing/coresight/coresight-tmc-etf.c b/drivers/hwtracing/coresight/coresight-tmc-etf.c
index 5864ac55e275..a5f053f2db2c 100644
--- a/drivers/hwtracing/coresight/coresight-tmc-etf.c
+++ b/drivers/hwtracing/coresight/coresight-tmc-etf.c
@@ -86,8 +86,8 @@ static void __tmc_etb_disable_hw(struct tmc_drvdata *drvdata)
 
 static void tmc_etb_disable_hw(struct tmc_drvdata *drvdata)
 {
-	coresight_disclaim_device(drvdata->base);
 	__tmc_etb_disable_hw(drvdata);
+	coresight_disclaim_device(drvdata->base);
 }
 
 static void __tmc_etf_enable_hw(struct tmc_drvdata *drvdata)
-- 
2.7.4


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
