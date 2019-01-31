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
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE093C169C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 20:44:50 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6E6EA218AC
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 20:44:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="hoeUMb3X";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kUiXTl9F"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6E6EA218AC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=r/WiVKqWrvXKCIarATK3ZT7iIioVdlxnbvJCoLBR3kQ=; b=hoeUMb3X8IG5HU
	0mc2zPOb5IL+fLmwuJLQYOLUtlivOJAXdsAhk30SbiDgF3z6jdeqCeUVP4RtZZbIkjrm9eYRINY9K
	8txYkZzygHSvJl1GT1d9mNekFM7UzW2GZ9c0Z9l1spNtTNmxX2LNwUl9moe7l+DG3GQ8jITVxl6lU
	C51Cs/cU+4bk8BDR3bZ88ehf6sdQimiaQbPiz4gBApT/XvMu/WE0cBTrup4I+mwIyZNcmBzplrsS3
	bx0ta9twtYp9sKE63fnduWH3SPWUq4VWsyYfRsUMmL7aH17SBhE5RdrsOe73MRqIFPcYciPx4IAsF
	HUQOEu2dIrCH83tK2Eaw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gpJCV-0003j4-WC; Thu, 31 Jan 2019 20:44:44 +0000
Received: from mail-pf1-x444.google.com ([2607:f8b0:4864:20::444])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gpJBh-0002ya-1p
 for linux-arm-kernel@lists.infradead.org; Thu, 31 Jan 2019 20:43:57 +0000
Received: by mail-pf1-x444.google.com with SMTP id c73so1997657pfe.13
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 31 Jan 2019 12:43:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=c324b380hphqzikJSwYwP+iMI2K9W7f9e6HIiTYzB7k=;
 b=kUiXTl9Fc9q5qeFVMdQ4Z5t96hNHcW1LFh5NIpabJlBerfIqlKR9bdumgncRN2EIkh
 2YScR1sK5NGNQeKv9MLoSZp0ShiSu0Qgwhqv4q7BrWLwqAuldqy4hA1YAW1A0zhiSNVs
 g88UxqdtMsEn4XQrKgmzS3FrbDZWoS0CG5i9XcHDE83/ksONpRDeef7sKbJwGX/yBqpf
 FCCbPc/fhOq5ukT1U6uz0oD8mCA71Nxb9GhRmeUVM8EIzQxZz1wtHUUaUYeSQbBTT94E
 rpaKdAJ5HmAboBKcv9Ep09evF4cJ8zKEfc7EW2oUMzbHaSitXqcEUSCwMjjGkWFXTxBM
 wLYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=c324b380hphqzikJSwYwP+iMI2K9W7f9e6HIiTYzB7k=;
 b=aZYtLYLrBLW8pvdIq6nJYlpx8GvHFwwrGPInll5FFm7frcSmbYOz6xiNAqeVcMEwaW
 /8GbMcWPq8dlKQOMSSp1CFwx2e+1LRhJ0OVV5YiwqdRKEAQt2m21nBM0qMN3oeQ+2R6K
 OnKsmc5Qf7UWk1w+KglwKMDvjMUCY/apMdh3eeerVuoUMNcCwaHflPWxFNNATz6btBq+
 oWx+d2AbcTpkRqeQd2Lhuh864A14fDFfzIndEptb+71weDEESlHMxUI23Wd+6GQx5UCS
 Ny6vdlsWbKIohjYSmVYe0lbrLV8jqG+5sjFx+TRV5O6p0MDR1bQfLP1tJWpLM3L1tA2w
 XzBA==
X-Gm-Message-State: AJcUukd7xOR2b/4bCJpcHT1L8As4GqpsCz2zNuWJAel08yXmpWLDvqPz
 6wmeSj+hNsnc7ddlFBr+4e8=
X-Google-Smtp-Source: ALg8bN7lpv54ik/rydarrkBjlKm7Qrf7F0z9Zh7hmp8qFEbGwXLfLOa6BxZlGAikLH/z4st3gol/gA==
X-Received: by 2002:a63:fd0a:: with SMTP id d10mr33170876pgh.164.1548967431950; 
 Thu, 31 Jan 2019 12:43:51 -0800 (PST)
Received: from squirtle.lan (c-24-22-235-96.hsd1.wa.comcast.net.
 [24.22.235.96])
 by smtp.gmail.com with ESMTPSA id s190sm7272034pfb.103.2019.01.31.12.43.50
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Thu, 31 Jan 2019 12:43:51 -0800 (PST)
From: Andrey Smirnov <andrew.smirnov@gmail.com>
To: Shawn Guo <shawnguo@kernel.org>
Subject: [RFC 3/5] arm64: dts: imx8mq: Combine PCIE power domains
Date: Thu, 31 Jan 2019 12:43:31 -0800
Message-Id: <20190131204333.31846-4-andrew.smirnov@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190131204333.31846-1-andrew.smirnov@gmail.com>
References: <20190131204333.31846-1-andrew.smirnov@gmail.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190131_124353_277922_AC57522B 
X-CRM114-Status: GOOD (  12.67  )
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
 arch/arm64/boot/dts/freescale/imx8mq.dtsi | 21 ++++++++++++++++++++-
 1 file changed, 20 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/freescale/imx8mq.dtsi b/arch/arm64/boot/dts/freescale/imx8mq.dtsi
index 50436bd393ed..89babc531380 100644
--- a/arch/arm64/boot/dts/freescale/imx8mq.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mq.dtsi
@@ -273,9 +273,28 @@
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
+					 * PCIE1 and PCIE2. We create
+					 * a link between 1 and 10 and
+					 * use what was supposed to be
+					 * domain 1 as a shared PCIE
+					 * power domain powering both
+					 * PCIE1 and PCIE2 at the same
+					 * time
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
