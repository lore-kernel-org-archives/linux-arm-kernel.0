Return-Path: <SRS0=sKCI=QH=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99F08C282D9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 20:44:14 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6C4C0218AC
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 20:44:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="bsMym9dE";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="igbR74Ll"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6C4C0218AC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=RC+2M7qZYJb+ESts/+itxLc4HbOfhgjSVZPkJAfhgYQ=; b=bsMym9dEA+6koL
	/tWY27pwg7mDOuvkmIUnVtul9oQPdtlTi2pZTYqnIzW+WhAetZL02YXViOaXUdLsUoDbI26juoR7Y
	9XiJ0tigTUUHpuG0zbCbKDCjzyKPtHG/2d5H8Tbw6WPAiLXAZGGjs/6e/B7kb6uI85QBj2PlwnUN+
	/pQ1YWRbV8+EaJQ/Vwg1eT51jwEaxTNFMfAZezxMKjy1Aroq2s/4itk299DnHPvSKu9qZBKlLOCjY
	TQZL5q2G2/mkpETro3ec3kbt6mmB2ZX50y90hFKUSgm9h6jzRiJBQSWwki4+e/yXZs1jSR4U6o8+0
	29OF7Okmd8gjoqlZu2sg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gpJBz-0003EK-1j; Thu, 31 Jan 2019 20:44:11 +0000
Received: from mail-pf1-x430.google.com ([2607:f8b0:4864:20::430])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gpJBd-0002xg-EU
 for linux-arm-kernel@lists.infradead.org; Thu, 31 Jan 2019 20:43:52 +0000
Received: by mail-pf1-x430.google.com with SMTP id u6so2008105pfh.11
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 31 Jan 2019 12:43:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=uW/mc9bOKLDqIolIzjRAHEjOwO1/pc5BGZ9n7AiIB/k=;
 b=igbR74Ll36k9hJapneY4x8GEdbfRiQz/SgNPlTPin0BM8B4KPeU4+5li02utMqkIu3
 oSkp2ATgj25O0CLjNf2GQDCQw/DCi+yrM2PlzvmLLqKrdA3V/zDAh0X6Lu2frXTwTcgD
 JyLsk551YXDfuQt3aPYps5AVL2djnE92JJIjLzGKfEXBiqstz3tTs4NADRMj813iGw6z
 AZ6WRZaM05x7RndUrQFugB5db7qjSD9KvJn+fvJ7KJsOezBWWZqSX75AgEA+qmq4cuqu
 k1mkL29AKryUdjT6X7evFF2jFjy7ddkTdMT3gSEwI5ewxJvQToOhkPhGiCUSmftuuzc9
 fOXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=uW/mc9bOKLDqIolIzjRAHEjOwO1/pc5BGZ9n7AiIB/k=;
 b=Ho+qRN0ZSHuL8JmoZwMEna8rODdRTMpurw1GQiuBP4Ux2xqDFUbCs9MITOOQs6EirT
 KE6Qa6d65YBhrf10ZnIUkOuBFciSPRiIGdPseLIGaWvfCRyhf4sDl0FvijoC486qfm4K
 X9lPfB+ETVU3OkyHEtHl+7TAWeEPUXUMBo8go4LdeGL8WGRKT1erihQaY/OvYu0tBVA6
 vJzJik5OeQs8ElsQL6jeJXxrZwE7vtr4MxywEa/SW+O8rDQvxzdMRbYbTI7zgRRWkLJF
 S3fZaq/NAUbt/ZQ1ivCHBjed4HjEEZZi8oFjbh3qfz7xgUWA4khkG59m/YBYYPz4HIo7
 CqwA==
X-Gm-Message-State: AJcUukcAGhBEZZbUrEiwnCJUo7/Y7ahtbLpZO/gBGZvPqPXmc83QJKPN
 GvYaLL0t0XrgBB92NE1bZQs=
X-Google-Smtp-Source: ALg8bN5MsescGrlFVDgGDTpMCby83jwkb6jQgJzD2FiRB92MrDd89QABo9XsUhx3Eg/LLfPcQVuO5A==
X-Received: by 2002:a63:2b01:: with SMTP id r1mr32576932pgr.432.1548967428444; 
 Thu, 31 Jan 2019 12:43:48 -0800 (PST)
Received: from squirtle.lan (c-24-22-235-96.hsd1.wa.comcast.net.
 [24.22.235.96])
 by smtp.gmail.com with ESMTPSA id s190sm7272034pfb.103.2019.01.31.12.43.46
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Thu, 31 Jan 2019 12:43:47 -0800 (PST)
From: Andrey Smirnov <andrew.smirnov@gmail.com>
To: Shawn Guo <shawnguo@kernel.org>
Subject: [RFC 1/5] arm64: dts: imx8mq: Mark iomuxc_gpr as i.MX6Q compatible
Date: Thu, 31 Jan 2019 12:43:29 -0800
Message-Id: <20190131204333.31846-2-andrew.smirnov@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190131204333.31846-1-andrew.smirnov@gmail.com>
References: <20190131204333.31846-1-andrew.smirnov@gmail.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190131_124349_482307_E94D1CFA 
X-CRM114-Status: GOOD (  12.17  )
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

Mark iomuxc_gpr as compatible with "fsl,imx6q-iomuxc-gpr" in order for
to allow i.MX6 PCIe driver to use it.

Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
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
 arch/arm64/boot/dts/freescale/imx8mq.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/freescale/imx8mq.dtsi b/arch/arm64/boot/dts/freescale/imx8mq.dtsi
index 892063a7c26c..f6c37bf9cbce 100644
--- a/arch/arm64/boot/dts/freescale/imx8mq.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mq.dtsi
@@ -230,7 +230,7 @@
 			};
 
 			iomuxc_gpr: syscon@30340000 {
-				compatible = "fsl,imx8mq-iomuxc-gpr", "syscon";
+				compatible = "fsl,imx8mq-iomuxc-gpr", "fsl,imx6q-iomuxc-gpr", "syscon";
 				reg = <0x30340000 0x10000>;
 			};
 
-- 
2.20.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
