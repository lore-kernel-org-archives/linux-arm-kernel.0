Return-Path: <SRS0=DN+v=OP=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72A13C04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 07:36:24 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3F3AB21479
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 07:36:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="r0p9DW9E";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UjnFXN8n"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3F3AB21479
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=ICK7ze1rKidGFNbyVcb2e+XrdrKfg7q4rlyMiMyOZpQ=; b=r0p9DW9ESbzNU2
	z54kMr3nD1n94mpKH6X2EKCWDK6T/08cdRE/cRvBQxooEN4KayPI4FFYJmhQLxYCboBX5FyKdag8x
	Ua2pPRfQ2mel5x/4E9enAkHi+WFJOVUuruBGZhFFifNO5Y35WqI9oj65AkupMr2Ivo9TqOp872Key
	Gnp3NaR+LB8x/cc3NPT0e1eO3DTML5k/0Wcd4U1N3ooDSrv+yuURhU4wvsv+bBsk1K4bgsAD7teFI
	QXpKGqK8ZVqUKG53Wj2YBHiy9C9g0g16iWsdB7RK1zPEo19Pc1SCY4L44gHM7aFEBa9Fcktk7TGaT
	FZO6k0VmM2BirxtzZlEQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gUoCr-0000k9-VK; Thu, 06 Dec 2018 07:36:21 +0000
Received: from mail-pl1-x641.google.com ([2607:f8b0:4864:20::641])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gUoCd-0000Ws-2x
 for linux-arm-kernel@lists.infradead.org; Thu, 06 Dec 2018 07:36:11 +0000
Received: by mail-pl1-x641.google.com with SMTP id k8so11371042pls.11
 for <linux-arm-kernel@lists.infradead.org>;
 Wed, 05 Dec 2018 23:35:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=xhmO+XhPFCrEZH1UNrvz+XUznHtfpXBiia+w2KZHgv4=;
 b=UjnFXN8nfAq1misbRlHq/onwF2OICWLCOF51zSdfis73UyQ+GToJqPdY0fv+WbHQxa
 2p3+AHCDec0Scn9g4V/i3DevTv4+hCIIUlbIUbjjs5xgIyY3x3iUT2RMyV2TKlzDYMGJ
 b9rBEpgcLq5bkCks3rkLJFdC2H96alSVB5SxIm75f49vcIrZf653iC72QLLtyu01h45k
 mwW8lZihqWaIHi/HvmOcbKhQFmXFu6oAQYQck/DtSraaN0eK6LAY894B0Oujd5XC9DKw
 P5KAu/+nm30iwGDZcsnNO6fjAJtBCkbTT3pQbjo+XYAjfEdYeqcE1mtJ7omsIOElJHtt
 fy4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=xhmO+XhPFCrEZH1UNrvz+XUznHtfpXBiia+w2KZHgv4=;
 b=LhLU/ZLFqEzHZO9cRYsOhrhd4ZN/CtJqWlMh8laDtbzK0NLG55d4DjOKxJ+ofazA7T
 XmYL5fMPRpFjCSbV+N/4ODLVcUJ9ojYgND5StweuLg9vrz4MYhN3cYyTfiiZ3x8K0Jxu
 azceQzKTGAakZig6jMZj+B8qSp/CMW7CoI+ZNHfbRVb6sL9pGvk8C8LCuNSgO6mHbtxx
 LV35xM8nOuknyrf1NYE5ME8ZjqcnxgNavCPmZJ1X7dyYUUoV9NNAYjJoy9AQ1m2hrTic
 lo7EvCLZf60+LiiOFGS//QO1VQKLkv4gSFOr4Cvba10/vJZDW5s2wKNpdIiaTONGkokZ
 BDdw==
X-Gm-Message-State: AA+aEWY0WHNPwdS1xwBFawolGjnMLbQRF2E6JQ1O5tjpZ+G827qcMCtO
 9yGrB4G8tZvwp1x8C7vZloiyia2m
X-Google-Smtp-Source: AFSGD/XwXi34Srl8/oY5Xn5iOrn3FO3++GlIOQegmwiONK7Hhbc3+2QRpbcHgmEGMCBHOCBtDO2+jQ==
X-Received: by 2002:a17:902:a710:: with SMTP id
 w16mr26670156plq.95.1544081755408; 
 Wed, 05 Dec 2018 23:35:55 -0800 (PST)
Received: from squirtle.lan (c-24-22-235-96.hsd1.wa.comcast.net.
 [24.22.235.96])
 by smtp.gmail.com with ESMTPSA id v15sm33035894pfn.94.2018.12.05.23.35.53
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Wed, 05 Dec 2018 23:35:54 -0800 (PST)
From: Andrey Smirnov <andrew.smirnov@gmail.com>
To: linux-pci@vger.kernel.org
Subject: [PATCH v2 1/3] PCI: imx: No-op imx6_setup_phy_mpll() on i.MX7D
Date: Wed,  5 Dec 2018 23:35:43 -0800
Message-Id: <20181206073545.10967-2-andrew.smirnov@gmail.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181206073545.10967-1-andrew.smirnov@gmail.com>
References: <20181206073545.10967-1-andrew.smirnov@gmail.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181205_233607_122468_7E67CDA8 
X-CRM114-Status: GOOD (  12.85  )
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
 Fabio Estevam <fabio.estevam@nxp.com>, linux-imx@nxp.com, bhelgaas@google.com,
 Leonard Crestez <leonard.crestez@nxp.com>, cphealy@gmail.com,
 l.stach@pengutronix.de
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

PCIE PHY IP block on i.MX7D differs from the one used on i.MX6 family,
so none of the code in current implementation of imx6_setup_phy_mpll()
is applicable.

Cc: bhelgaas@google.com
Cc: Fabio Estevam <fabio.estevam@nxp.com>
Cc: cphealy@gmail.com
Cc: l.stach@pengutronix.de
Cc: Leonard Crestez <leonard.crestez@nxp.com>
Cc: "A.s. Dong" <aisheng.dong@nxp.com>
Cc: Richard Zhu <hongxing.zhu@nxp.com>
Cc: linux-imx@nxp.com
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org
Cc: linux-pci@vger.kernel.org
Tested-by: Trent Piepho <tpiepho@impinj.com>
Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
---
 drivers/pci/controller/dwc/pci-imx6.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
index 2cbef2d7c207..c140f7987598 100644
--- a/drivers/pci/controller/dwc/pci-imx6.c
+++ b/drivers/pci/controller/dwc/pci-imx6.c
@@ -525,6 +525,9 @@ static int imx6_setup_phy_mpll(struct imx6_pcie *imx6_pcie)
 	int mult, div;
 	u32 val;
 
+	if (imx6_pcie->variant == IMX7D)
+		return 0;
+
 	switch (phy_rate) {
 	case 125000000:
 		/*
-- 
2.19.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
