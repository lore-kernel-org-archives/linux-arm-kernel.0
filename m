Return-Path: <SRS0=0Bxu=Q3=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79A46C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 01:59:58 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 45D362146F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 01:59:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="pMkMtdS4";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h8fHUax9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 45D362146F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=vBoQGyUJfdwOvZIGoQV+O1NE/kVthx4qqYQFYUneJIU=; b=pMkMtdS4ZA90v+
	tFBIYf+Zs6HrpnyHAr/e2w1OvIhNh7uE8+8rztcoUXuDpHVdSxYT99CiEpbzmMqmELxPcK2VuqnpO
	/S/IqO6hvx25LozU8YNGnqPA7N6F8SwLGF665rT6NorQ3aW/rfjY7xKSGlQDgXb8Zw6ZWfbXv1XJv
	Jqlwllfnf/K1RwsvhCDRJA8U/IM8jrpvdCtJrZVOxx0A6kH9eKKNfBN1ZNh/7yOVjbcIG3kIZsXfW
	QDrWpFM7kv6O78Sc36xilccGh2wpbTdSnJgRxCY0grXcMU0Axsxmb7GIXCf6s9dZF31iTdGbq7tN8
	Y3DOmrLyOH55D7bQCgbQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gwHAv-0004Zn-St; Wed, 20 Feb 2019 01:59:54 +0000
Received: from mail-pl1-x644.google.com ([2607:f8b0:4864:20::644])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gwHAI-0003nU-9s
 for linux-arm-kernel@lists.infradead.org; Wed, 20 Feb 2019 01:59:15 +0000
Received: by mail-pl1-x644.google.com with SMTP id k2so2007320plt.3
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 19 Feb 2019 17:59:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=YOuL4YXz7ChPC3PYLWY4+mNLE7+8TCzSgAykkg2Dg0w=;
 b=h8fHUax9u++ZM38dFa2WI6ce9IsvFZvhAbSqHkv/qXlo9Yd4Y0H5gkJdvaK4kJvUf5
 5UbOWkxqrEr3V9QqTTTY+jbTItSlKcg2OV8PNTWjXiOriJIai1FcqX4rF5ykXJhjG0yA
 QGmt4MYV/QT8yOmAqVP9BIkdCaTHJraaBcEkA8lSFMYKHkSlyJYHz0EdqMRiHZXplNr+
 GHI8N32pmVLCtQiVA1r1/2pM01rlGSYgx6O5BBKJ4aeqJlLzYZ4Ed+tjq4AeNbWrSM59
 Be4gQYRwTbcVJeX/4Kiqyt+pSIv0aLZJr8PfriQPaOznsPALjNwmxLEb5fg6lzewl2jr
 t+ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=YOuL4YXz7ChPC3PYLWY4+mNLE7+8TCzSgAykkg2Dg0w=;
 b=YBtQsFEqR/dP4zk4v4sFxzefrbvx+YH0v3ruI40rOxBhh5J8hJ/1NT6JiyfNhSQ8A2
 Vkay/foZNQ1TePd12rn526eaWGZkb8+pKm/JjpJf6Mp3egFhuYzB/8dsGi3w7YRsKym9
 0lCaoZYGF7MbJBNck3mky0a/5d8wur4BUyV90pnZvUPAsRo1g7vbkBMlCX3sLqoxd+9N
 cUpcq9uN9YpwgiKbsaRjiDbjHW+7pWEttjp3EFbsRH7wJjaOJ30wcf5UE6gh8eYGF+tn
 4FsR7qWoBw6fDYFQ09sk0W4jjmQ9ghcWPL/8vOCI+grquP8Hx1pGuovuOBbR4Cao6aax
 1X3w==
X-Gm-Message-State: AHQUAua0DQO0lI4yrMMPujst+4QxLGCOAN3OHawznNbCghxh3SNWZFGn
 48AJ2oqSyMyi05ftakzLyvQ=
X-Google-Smtp-Source: AHgI3IaLDAe/iYVJgN7bjnYsa3JH0/RzZbsvfv6KYXlsVxMQlRj3J+jSAZgHt9bmjb04/5sBmiQoKg==
X-Received: by 2002:a17:902:5a8d:: with SMTP id
 r13mr34083249pli.190.1550627952429; 
 Tue, 19 Feb 2019 17:59:12 -0800 (PST)
Received: from squirtle.lan (c-24-22-235-96.hsd1.wa.comcast.net.
 [24.22.235.96])
 by smtp.gmail.com with ESMTPSA id h3sm2562525pgv.38.2019.02.19.17.59.11
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Tue, 19 Feb 2019 17:59:11 -0800 (PST)
From: Andrey Smirnov <andrew.smirnov@gmail.com>
To: Shawn Guo <shawnguo@kernel.org>
Subject: [PATCH v3 3/5] arm64: dts: imx8mq: Combine PCIE power domains
Date: Tue, 19 Feb 2019 17:58:55 -0800
Message-Id: <20190220015857.7136-4-andrew.smirnov@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190220015857.7136-1-andrew.smirnov@gmail.com>
References: <20190220015857.7136-1-andrew.smirnov@gmail.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190219_175914_342372_84C706E0 
X-CRM114-Status: GOOD (  12.57  )
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
Cc: "A.s. Dong" <aisheng.dong@nxp.com>, Richard Zhu <hongxing.zhu@nxp.com>,
 linux-arm-kernel@lists.infradead.org,
 Andrey Smirnov <andrew.smirnov@gmail.com>, linux-kernel@vger.kernel.org,
 linux-imx@nxp.com, Fabio Estevam <fabio.estevam@nxp.com>,
 Leonard Crestez <leonard.crestez@nxp.com>, Chris Healy <cphealy@gmail.com>,
 Lucas Stach <l.stach@pengutronix.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

According to NXP's FAE feedback and a comment in ATF firmware, PCIE1
and PCIE2 power domains can't really be used independently. Due to
shared reset line both power domains have to be turned on at the same
time. Account for that quirk by combining PCIE power domains into a
single 'pgc_pcie' power domain.

Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
Reviewed-by: Lucas Stach <l.stach@pengutronix.de>
Cc: Shawn Guo <shawnguo@kernel.org>
Cc: Fabio Estevam <fabio.estevam@nxp.com>
Cc: Chris Healy <cphealy@gmail.com>
Cc: Lucas Stach <l.stach@pengutronix.de>
Cc: Leonard Crestez <leonard.crestez@nxp.com>
Cc: "A.s. Dong" <aisheng.dong@nxp.com>
Cc: Richard Zhu <hongxing.zhu@nxp.com>
Cc: linux-imx@nxp.com
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org
---
 arch/arm64/boot/dts/freescale/imx8mq.dtsi | 18 +++++++++++++++++-
 1 file changed, 17 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/freescale/imx8mq.dtsi b/arch/arm64/boot/dts/freescale/imx8mq.dtsi
index 50436bd393ed..fca9b71de94f 100644
--- a/arch/arm64/boot/dts/freescale/imx8mq.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mq.dtsi
@@ -273,9 +273,25 @@
 						reg = <IMX8M_POWER_DOMAIN_MIPI>;
 					};
 
-					pgc_pcie1: power-domain@1 {
+					/*
+					 * As per comment in ATF source code:
+					 *
+					 * PCIE1 and PCIE2 share the
+					 * same reset signal, if we
+					 * power down PCIE2, PCIE1
+					 * will be held in reset too.
+					 *
+					 * So instead of creating two
+					 * separate power domains for
+					 * PCIE1 and PCIE2 we create a
+					 * link between both and use
+					 * it as a shared PCIE power
+					 * domain.
+					 */
+					pgc_pcie: power-domain@1 {
 						#power-domain-cells = <0>;
 						reg = <IMX8M_POWER_DOMAIN_PCIE1>;
+						power-domains = <&pgc_pcie2>;
 					};
 
 					pgc_otg1: power-domain@2 {
-- 
2.20.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
