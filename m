Return-Path: <SRS0=0Bxu=Q3=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5336CC43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 01:59:52 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1D7A32146F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 01:59:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="OZ9GKZCb";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oNlZ3iJp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1D7A32146F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=IZL79TofjX2PW2of9cRkUK9LmkqCbike/i1WrecyQZM=; b=OZ9GKZCbkcaawP
	SmouFR+32kK3ILpSMVfSb3h3zCjFYXuKhzgzwJgWRQf2+phqFloN6c6M81naP1YviTG9re5paq7gk
	tso5GwC8lnYcyzMej0+Tld/cZNH66FWixCh8HUNdE9CaxF4L7ZuUMn/zqAuPTaPFY4gdRzHDx+6kB
	iKoTrUYzkW8b9TiYrWb5j01Lq/aIpI904Jah2PUC+Wu2UFdmbv262TUlstwtJd7Jxrst9gZZCIXhR
	zkr7J6KONOObXIC9HdFBdtaxcHIZqXP7/3cgDm3tA/rXHmdPukDvyv6Xjem0AOWrplREzg7mSVkNJ
	0qg6BV6Hi/3zYl68SFhQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gwHAn-0004Q4-Eo; Wed, 20 Feb 2019 01:59:45 +0000
Received: from mail-pl1-x642.google.com ([2607:f8b0:4864:20::642])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gwHAH-0003nQ-UN
 for linux-arm-kernel@lists.infradead.org; Wed, 20 Feb 2019 01:59:15 +0000
Received: by mail-pl1-x642.google.com with SMTP id c4so6323475pls.11
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 19 Feb 2019 17:59:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=WpWYHuHVnkwq1EMuW8Pn3claUxN8n48XRaznunYdNpA=;
 b=oNlZ3iJp4MsqiqJGNwAGIoJDMCsk1Wy4uql8QgYajEEu7v8hdH1GLqYtl7bCoCnu2o
 TFY19M2umiPqbGYesNAJ8gKq/XSx9fA249e7Oa3r97/NBEL0iXIDDLEhr/XuVf1xHXf1
 RBvkgljp0EHgVk5TmoKzT29QDwYV1gR90Z4Xc139zbCq8SpleZ/r9GWSDhLRU66v1WxK
 KZqALqB5GQneibPVd/P0jymXKP0y5BxGjgTvkrTKGY43PYqQwxXWz78kN6QopBzcCo7R
 FqoH+U4PjeT9mFDyjjP5+2yA55coE1CnrYHCRUAnH1rJ/W3iCEkjV45SiKCphhbkIpD4
 IEYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=WpWYHuHVnkwq1EMuW8Pn3claUxN8n48XRaznunYdNpA=;
 b=nae6SjgtWJT+v+WdIMtyrlwXo8OOAvn6dvVVVy0pt/UIGnPFF+Hrvh7JK3js9x1ZZq
 Q0KdsMOBExIM3oY+UvSFvpqnnNIRYTRwWRKmaizU4lNfy51icJ//2yii85qcrbhmQpRN
 xR49aSqxTH6vBLG1zMZXlPtEmSRI8mE8HImQ3yOAmwe3rQFcPaovDvsxPnnqx8SmcYgm
 0pqatGbrI8FpC+EIgpszkllyg2/0PKz25B097wxd2WahZ9IOmGwkrwoa6nO7a8o/Bnzx
 smf/Fmf0jBIoFOpzTIMXHX3SMXjMn8OGhlXvXkX/dsP/6oyhNN2LXmn7rpdrBYa70yjg
 5OOA==
X-Gm-Message-State: AHQUAua3EtnVWm10GGPJVW4HQJf3Dq9YhGBkhdgMoTZJZvOMq+ilFf/j
 kOBor8X+gZ0cVEiA6WRY3Vs=
X-Google-Smtp-Source: AHgI3IapSHX7UhEs9Q11gejspLG9vGBTyjlU44n3Xy6UfOyr9iBBo6gaqRBvYTT9OJqOujD+A8d31g==
X-Received: by 2002:a17:902:8f98:: with SMTP id
 z24mr33431989plo.40.1550627951200; 
 Tue, 19 Feb 2019 17:59:11 -0800 (PST)
Received: from squirtle.lan (c-24-22-235-96.hsd1.wa.comcast.net.
 [24.22.235.96])
 by smtp.gmail.com with ESMTPSA id h3sm2562525pgv.38.2019.02.19.17.59.09
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Tue, 19 Feb 2019 17:59:10 -0800 (PST)
From: Andrey Smirnov <andrew.smirnov@gmail.com>
To: Shawn Guo <shawnguo@kernel.org>
Subject: [PATCH v3 2/5] arm64: dts: imx8mq: Add a node for SRC IP block
Date: Tue, 19 Feb 2019 17:58:54 -0800
Message-Id: <20190220015857.7136-3-andrew.smirnov@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190220015857.7136-1-andrew.smirnov@gmail.com>
References: <20190220015857.7136-1-andrew.smirnov@gmail.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190219_175914_048571_80256C03 
X-CRM114-Status: GOOD (  10.89  )
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

Add a node for reset controller IP block found on i.MX8MQ.

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
 arch/arm64/boot/dts/freescale/imx8mq.dtsi | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8mq.dtsi b/arch/arm64/boot/dts/freescale/imx8mq.dtsi
index f6c37bf9cbce..50436bd393ed 100644
--- a/arch/arm64/boot/dts/freescale/imx8mq.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mq.dtsi
@@ -254,6 +254,12 @@
 				              "clk_ext3", "clk_ext4";
 			};
 
+			src: src@30390000 {
+				compatible = "fsl,imx8mq-src", "syscon";
+				reg = <0x30390000 0x10000>;
+				#reset-cells = <1>;
+			};
+
 			gpc: gpc@303a0000 {
 				compatible = "fsl,imx8mq-gpc";
 				reg = <0x303a0000 0x10000>;
-- 
2.20.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
