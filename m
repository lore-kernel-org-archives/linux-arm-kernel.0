Return-Path: <SRS0=KsRD=PT=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86BAFC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 17:25:55 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5AC4B20652
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 17:25:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="nJmQPvIw";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="lWLplKMF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5AC4B20652
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=hsXdlcFVW8VY90V9uHSbI5jDr+jc39y0kgLD+8jaS9M=; b=nJmQPvIw20qVal
	ToJdjGwaXR5wQR0A5ayVh4hdPRh5+jz2kW1m3+9KX/FE0RFqrPU9MAQthg0cnIOhk8VLwVttHUcIw
	oVBmUCxbORjnYEUD3PDltlbPA09uSjqLrBBRVi9oTtEA+kPxxNiis2nXaDS9ddJdCcxqdPt80uLQG
	CzhgRbaaOx+E07v/OLwoszcfFiLSbnCCdzyaoVxZ6WARWY5RaKshtNwA5bFu7B4SjLPOd3Rwt6JIk
	Qt8uI5yurAJY7FOpvHQ+CzyvyuJf+Sc6dvyLMxZZnrBz5zyF9U/58vd6ZV1FtKdBU/TmnpO48x2se
	qL7X5hW6Ry6AGW3gINrA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gi0Z0-0005DZ-0Z; Fri, 11 Jan 2019 17:25:46 +0000
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gi0VK-0000M2-O8
 for linux-arm-kernel@lists.infradead.org; Fri, 11 Jan 2019 17:22:05 +0000
Received: by mail-wr1-x444.google.com with SMTP id j2so16082560wrw.1
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 11 Jan 2019 09:21:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=FVtO+nu/Gq60aTArb+P6QnW6Oh2zrZ3K6RvHVatJhiU=;
 b=lWLplKMF9uI3jzhYcYJFMJy6JUSIXtRhX/Cr8/whDeAozRjHgoQT7rtHAKX5qoWIFS
 YTgjaEpU4cvFVn6l8ONi6E4i3+K3GB+xDqqD1S4z7nE2oWTZ4jefhgmU6jabsjXlGNq7
 Lce7YdYUQahMvJlHYLuy/PM6Y8e7frFMSwLw5u3qiQmYEyXYXDkzhTcVBs83P83SY7v1
 0DuweP4DQ5M/x5Ml5eNuM8Zz76PjINa1m+PqGnaM9pgmpSEBQnVm2uG/IOMg82LG2RwM
 95E2t5mjWHwzI44Ag0LVCtOjzP91bRi+std4EYEvIrFMF8IaJOmyODtWrVuFV+2ns8m4
 XAjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=FVtO+nu/Gq60aTArb+P6QnW6Oh2zrZ3K6RvHVatJhiU=;
 b=LeH7mTXqWypvqJb0FTk+e+BxQXWZaU537QtnUC5vd3QJ9JqERenZgUY2+kiJ0OBBg8
 EpJdjoHqJgNj7jrQ6Qmt5dVDac85fGhFC3FuCg3Qy0TqNS7YHYyWzTXkAcLgqrijugej
 uRjbgnEKRvUfHIGt4/JlRkh29HR6XriUd/Dc1k6U1RJTxxVjVltUigwHa//zwr/SxY7A
 gwbOYJ/h6QcTziUwfwBGrysB1THlAlFIhnt5IMcpVJcIiQCBLIQ3cCImQGJBU30uHV33
 aTSCFGwZbDui4rVrZOarElL//jhrU28gkpRFR/A4LUTe90Mgo4O1khIDxakwczJ7yg5q
 uQcA==
X-Gm-Message-State: AJcUukdVQ+Ehy5VDKkAleRy7KswxpDgHE8gLC6xW4kooNh2S76JJaKZs
 UWsQ8Uct2sZpkjC6L7BFvNYunQkFAVo02A==
X-Google-Smtp-Source: ALg8bN41MhWv/0vAb1r3Fk+hc1+GCFAZZSQtxdUrX4tGf0TJuEk3MPrz84xgLcB20x1ylnnQC/TTNw==
X-Received: by 2002:adf:97d1:: with SMTP id t17mr14424684wrb.283.1547227317462; 
 Fri, 11 Jan 2019 09:21:57 -0800 (PST)
Received: from debian-brgl.home ([2a01:cb1d:af:5b00:6d6c:8493:1ab5:dad7])
 by smtp.gmail.com with ESMTPSA id o16sm78534408wrn.11.2019.01.11.09.21.56
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 11 Jan 2019 09:21:56 -0800 (PST)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@kernel.org>,
 Daniel Lezcano <daniel.lezcano@linaro.org>,
 Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH 06/17] ARM: davinci: dm355: WARN() if clk_get() fails
Date: Fri, 11 Jan 2019 18:21:23 +0100
Message-Id: <20190111172134.30147-7-brgl@bgdev.pl>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190111172134.30147-1-brgl@bgdev.pl>
References: <20190111172134.30147-1-brgl@bgdev.pl>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190111_092159_320601_3E9E5820 
X-CRM114-Status: GOOD (  12.76  )
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
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org,
 Bartosz Golaszewski <bgolaszewski@baylibre.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

Currently the timer code checks if the clock pointer passed to it is
good (!IS_ERR(clk)). The new clocksource driver expects the clock to
be functional and doesn't perform any checks so emit a warning if
clk_get() fails.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 arch/arm/mach-davinci/dm355.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/mach-davinci/dm355.c b/arch/arm/mach-davinci/dm355.c
index 4c6e0bef4509..07ad9d6c9cae 100644
--- a/arch/arm/mach-davinci/dm355.c
+++ b/arch/arm/mach-davinci/dm355.c
@@ -745,6 +745,7 @@ void __init dm355_init_time(void)
 	dm355_psc_init(NULL, psc);
 
 	clk = clk_get(NULL, "timer0");
+	WARN(IS_ERR(clk), "Unable to get the timer clock\n");
 
 	davinci_timer_init(clk);
 }
-- 
2.19.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
