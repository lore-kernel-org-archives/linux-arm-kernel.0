Return-Path: <SRS0=b3e6=Q4=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB8D1C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 16:02:52 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 89B0C2083E
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 16:02:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="EvOsV+ok";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="uj39mhEx";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="HyUxa4ko"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 89B0C2083E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=prGcoYKQLZy7G1ogaht7x9Q5sgWx0uZLdtgnxUyE9hw=; b=EvOsV+okB1WvBM
	DMNS9sKk1F6vn7NdPHUAtZi/nsB5Qsaw/jyxpHulm4Awhwauzj/fv+1lKX4LPNV+NhFXB2jvOdQ54
	8XlgN36fBC1ILgnSeiOWQ/o/qFhkq1iux7uhlozbyJgexHsbjV6Tu4DlGtmv7dVm++yIT5X8j7UIj
	pPCjyaQXbiLld+ztxK1Ue1ai3c6rJ6rpmD4AeYDXKQnXAy/Y0H9MdQsrO0SayQhNeaqOh9Jl6syzu
	l+imKHDPS7b0vWs83ZMMqra/KSXKwwQKAeT9JyrhUmAOZZIT1Oi2Akknv7aFGORJolet0/lcowczP
	YOlYhaDo/7oR3U6JRBBw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gwqo8-00016h-5C; Thu, 21 Feb 2019 16:02:44 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gwqnp-0000Kw-60
 for linux-arm-kernel@bombadil.infradead.org; Thu, 21 Feb 2019 16:02:25 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
 Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=TR9y9p4XuG21sRwnQp+UPGznCUiWWNyC0irrLHYfFJ8=; b=uj39mhEx9iPBZy1cYyUuO2+/hI
 XCRjnJ+oOuQihsi1hjOt6aD/ehO8wZdyqzvdAuN2+MdLdSJySYhlPZp2jGqdLxNyOJFj6xBKdSlqb
 mJonC95uJB0rf+ihpN0ERwEtrOJcy/Y2YGVFiqwf2db9T7hVTzN8QRhjvN6x/q7BSk+tQHlyDttIl
 x4ug+i6EjhV4eRjM8UBG3Q7zm6ddxyoDj8qAbB7URrPKYXJIr4Cl3V7XrunStsR5GO79QEr/xTJyE
 hBhx+BV46l2g0uTZ9bXjMVTBOXqyrGq0VE3YJV6XQAhoUPo5FkHaz02AupioMan0D/DCISrXCSSrY
 VVsNgH6w==;
Received: from mail-lj1-x241.google.com ([2a00:1450:4864:20::241])
 by casper.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gwqYJ-0006sq-8e
 for linux-arm-kernel@lists.infradead.org; Thu, 21 Feb 2019 15:46:24 +0000
Received: by mail-lj1-x241.google.com with SMTP id d14so13227979ljl.9
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 21 Feb 2019 07:46:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=TR9y9p4XuG21sRwnQp+UPGznCUiWWNyC0irrLHYfFJ8=;
 b=HyUxa4koWJFV+WqP6/RKk7GykhBNMLAt/Ch3VMJyU0i9GCHMVloU0azKlGiFkmmotR
 3CMMkz+E0BTxP7Z1I2c3LGZ1+0owBqB1HQlDVNQdRZghezzAZTb2GNjNASHfUmuBS6vQ
 D4CzDdaHfNNVjidoQueEA3mgswKS25HNXO9C894s8B+o0KMz0MINo5ZpOCVxjVbBZ0qW
 6EZ7py1YKlFmgVI09gXgG41giMpKeE3ejg+1XB1YygPKFNDUrMXatRUZuzkM5xS2+n5/
 AJA1Ru+cgovg1g30Y2GP2khk9AVDZeu74U3uHYa12ZwsEheP+j7Y+kVuqc+01JpFGBvZ
 /KZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=TR9y9p4XuG21sRwnQp+UPGznCUiWWNyC0irrLHYfFJ8=;
 b=ETjICweUmfRx8rugrdV6VvbA3P0mTi0EE/G8IDrWuulkRsbZU+vvke852ZVwSi8gD1
 MhIe3HMLI/tyWlMUDXZQsh01YSnenT88hi2yql+VLHenEO6bYvNyS8J+Fxa6ftKM7/vC
 /7w3+iz0eFNozy7mfljOlfTtNG/mYQYVT0BgqSVBH4u7/ekBUg+VhNB5lO3FrdfOUkbO
 fKwe7hRdxil8fEPN2cXl46qm3JJZfdplkeO0gCJJxnoW2Vtpk7w02PwmuSLPznIREyaa
 aIRKq+GNi0c0QK8e1+ANpD6WFGin0pVG+VRUJeQJNRzCSSqd+IwkYWqLIJZYObv3nrax
 /Hyg==
X-Gm-Message-State: AHQUAuZVfqvibNBYloLmHhHB57nCz3lnMhMngJLQVmc5Cyqwp6hLl4L7
 Oq2b99QjL40Icnj1YePhcr0aENhcb80=
X-Google-Smtp-Source: AHgI3IZuuy7CYURzsSfKTRQxtfri25ygBQoR/HukK6s6ag38lwLhNzZxKpqMV6f2u3hTeNW5heHKOw==
X-Received: by 2002:a2e:890b:: with SMTP id d11mr5090318lji.174.1550763981495; 
 Thu, 21 Feb 2019 07:46:21 -0800 (PST)
Received: from linux-2.local (c-ae7b71d5.014-348-6c756e10.bbcust.telenor.se.
 [213.113.123.174])
 by smtp.gmail.com with ESMTPSA id m73sm1316965lfa.65.2019.02.21.07.46.20
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Thu, 21 Feb 2019 07:46:20 -0800 (PST)
From: Linus Walleij <linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org, Imre Kaloz <kaloz@openwrt.org>,
 Krzysztof Halasa <khalasa@piap.pl>
Subject: [PATCH 29/30 v2] soc: ixp4xx: qmgr: Add DT probe code
Date: Thu, 21 Feb 2019 16:44:57 +0100
Message-Id: <20190221154458.23763-30-linus.walleij@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190221154458.23763-1-linus.walleij@linaro.org>
References: <20190221154458.23763-1-linus.walleij@linaro.org>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190221_154623_328432_29D861A0 
X-CRM114-Status: GOOD (  16.01  )
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
Cc: Linus Walleij <linus.walleij@linaro.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

This makes the queue manager driver able to probe from the device
tree. It only needs to get a memory resource and two interrupts
and the platform device provides these as resources, so all is
pretty simple.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/soc/ixp4xx/ixp4xx-qmgr.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/soc/ixp4xx/ixp4xx-qmgr.c b/drivers/soc/ixp4xx/ixp4xx-qmgr.c
index 64572f2d6ff0..13a8a13c9b01 100644
--- a/drivers/soc/ixp4xx/ixp4xx-qmgr.c
+++ b/drivers/soc/ixp4xx/ixp4xx-qmgr.c
@@ -450,9 +450,17 @@ static int ixp4xx_qmgr_remove(struct platform_device *pdev)
 	return 0;
 }
 
+static const struct of_device_id ixp4xx_qmgr_of_match[] = {
+	{
+		.compatible = "intel,ixp4xx-ahb-queue-manager",
+        },
+	{},
+};
+
 static struct platform_driver ixp4xx_qmgr_driver = {
 	.driver = {
 		.name           = "ixp4xx-qmgr",
+		.of_match_table = of_match_ptr(ixp4xx_qmgr_of_match),
 	},
 	.probe = ixp4xx_qmgr_probe,
 	.remove = ixp4xx_qmgr_remove,
-- 
2.20.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
