Return-Path: <SRS0=FIMe=QE=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 523A9C282C8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 09:53:02 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0059621736
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 09:53:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="rwS2amkU";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="EkiZP7FW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0059621736
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=ArULS/YS/r9j84SfagIsyW41ll4O8LanxU9ZgYDrr6k=; b=rwS2amkUMsI/S3
	A+q1oqq3jyO//Xe1aeimhX/5ro3mXj7JCsVj+VJ9Q0B7ufeGxIWoQpP5mOYYICS5y/Vmwhx1Ie+8r
	NFP6PxQIOzrb7u8pfLuJwZEsFHQt0/tRLPk3EI9+RfZZy8pjmOx+E4P6nDZismU21K3R3w+dKcoJP
	bnRSxKMZfWi9WL62QDNaGsDWWLTPyMbBneLDZJtZ6ybkHroAzXz83M0vMP2CyUQ/DkLdJ6AJz789R
	Ng8dN+0ulITakQZpVXbRlATnsZgUnPn8CNC2e2QdPVGDNtz6qDgIt2U9EugdUCzmX3+YtwmwKlWtH
	xwFdlww8lwkNsptH+pPg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1go3b4-0000hH-Ui; Mon, 28 Jan 2019 09:52:55 +0000
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1go3aZ-0000Cs-ML
 for linux-arm-kernel@lists.infradead.org; Mon, 28 Jan 2019 09:52:25 +0000
Received: by mail-wr1-x442.google.com with SMTP id v13so17228134wrw.5
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 28 Jan 2019 01:52:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=+Zg9cyWmyqHF4r/UJngOsnfqHjmhh14L3ADETmf6l18=;
 b=EkiZP7FWBzLqJipKqCdVmvVmwScGDrAvBcw0QQ3WAl6h3vHSHaWbsfA+1ZQB0HsgCo
 9ZpAH5KOmYYjquH9baA1VUyWauq1cXNejTbo2tJN81t3wrfZphTpg5Fzi/BwanwxjP5r
 2MPkXhrmcB9Nq76p5VORVUhNbQT66lZSRFHvFuNFdYQOqST1ny7OjnvNszbJvmhbD25Q
 3eVf1ZcjKYX2Etgfpp9GEErnTcVn5dJbuXCr4m+d8eyMO6cJ3g7S6rhgDz/+W4LzHRkn
 NhoqdN80JDkGalCtbC/FtQR5ZlshN6NEetqn8Ch42A1xYUcytetkyKphEP/jWG+FS00O
 GK8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=+Zg9cyWmyqHF4r/UJngOsnfqHjmhh14L3ADETmf6l18=;
 b=WwKL0KPVK2wvtjv82VfYN2Qd464SZBQRPxI+VlJ8Pv7AjmkHp5Ex6nooyYd8o6smyC
 bYy6g9w51ISVVUukjZfQE6RVgKrstnfEh/kdgRcKBiHT01t9fDBEnT1M/Nz6RyJlasoh
 12RqL7UYK75EACgGSWOngb3QvZRUJWaZ/YBwIE5YFmPaaU5D114obmz6Xprg56DTC/pr
 cM5qYmksZ7+4Zj17cUmHrDd0Cjn9pvl0ua6ykETP7k47QRB3KtTZYnkvernhofNTw686
 7FfpsGoCOzEJFa6SujHeImu9BMm7CesiZI1f61QsgKnFrQaFuWY55WrPCdG/Rztsqtkt
 9OpQ==
X-Gm-Message-State: AJcUukfOvnbEp/8dq34Hq9VhD56rPifd6VKI+ToEIIMfZ1vLJg4eCnmU
 Dh3q/oiqk1co31s3AaSPQa3QjQ==
X-Google-Smtp-Source: ALg8bN7gxnHLKe7d5QwFKuj0giVmw3WnKRu3i+hErDeqCevywcRS7Y7hYtglxtCN2oReJheG9sfW3w==
X-Received: by 2002:adf:aa9c:: with SMTP id h28mr20674938wrc.216.1548669142430; 
 Mon, 28 Jan 2019 01:52:22 -0800 (PST)
Received: from xps.home ([2a00:23c4:f7a1:ce00:5105:4b7b:c922:7c6])
 by smtp.gmail.com with ESMTPSA id y34sm302696099wrd.68.2019.01.28.01.52.21
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 28 Jan 2019 01:52:21 -0800 (PST)
From: Carlo Caione <ccaione@baylibre.com>
To: shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
 fabio.estevam@nxp.com, linux-imx@nxp.com, robh+dt@kernel.org,
 mark.rutland@arm.com, linux-arm-kernel@lists.infradead.org,
 devicetree@vger.kernel.org
Subject: [PATCH v2 2/2] arm64: dts: imx8mq-evk: Add fsl,magic-packet property
Date: Mon, 28 Jan 2019 09:52:12 +0000
Message-Id: <20190128095212.14681-3-ccaione@baylibre.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190128095212.14681-1-ccaione@baylibre.com>
References: <20190128095212.14681-1-ccaione@baylibre.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190128_015223_776528_2FD8BB06 
X-CRM114-Status: GOOD (  10.34  )
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
Cc: Carlo Caione <ccaione@baylibre.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Add the fsl,magic-packet property in the fec nome.

Signed-off-by: Carlo Caione <ccaione@baylibre.com>
---
 arch/arm64/boot/dts/freescale/imx8mq-evk.dts | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8mq-evk.dts b/arch/arm64/boot/dts/freescale/imx8mq-evk.dts
index 2641f777d0bb..02f6da92957f 100644
--- a/arch/arm64/boot/dts/freescale/imx8mq-evk.dts
+++ b/arch/arm64/boot/dts/freescale/imx8mq-evk.dts
@@ -38,6 +38,7 @@
 	pinctrl-0 = <&pinctrl_fec1>;
 	phy-mode = "rgmii-id";
 	phy-handle = <&ethphy0>;
+	fsl,magic-packet;
 	status = "okay";
 
 	mdio {
-- 
2.19.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
