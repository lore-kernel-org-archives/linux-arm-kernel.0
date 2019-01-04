Return-Path: <SRS0=E6Hv=PM=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52AADC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 17:51:25 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2ADA6218CD
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 17:51:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="ZMT/yBNC";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cIQDFnbb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2ADA6218CD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=OMN7vOg+R1qirVy5O3nXR2NAGyqAjjEPR3o2k2Aju/c=; b=ZMT/yBNCaO5CDj
	W/0alQqlrDLcdpR62JptT/ewMXalP+K0lD2bYRcjI1P3rdsaQH8UGmY2rztrPIIlqZrzG6nfTPVfN
	4mUjclFRA6CmCDtqpRaNgfy6n2lV62OS6X7vMfvBRmCZ9mp8TI2TmJvEW7fZXBphLq6vfupGZqYMh
	983NVZXe8Nqb4HNEiYz+uYmytEVGJINgSXuzxZZM7n61Ehr5ZsVoEtiKLTkFWfTe94N1VVV4Y3RqC
	IsAbZ5z+tSXAT3S5DsPxt4VoQaDZ9/FJsauzKvanm8E/RknO87x2D+QyYT9rwPX42d5mpSny0UUuu
	Cijx159WhjBTSkEvniZA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gfTco-0006ok-Vq; Fri, 04 Jan 2019 17:51:15 +0000
Received: from mail-pg1-x542.google.com ([2607:f8b0:4864:20::542])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gfTbU-0004D4-41
 for linux-arm-kernel@lists.infradead.org; Fri, 04 Jan 2019 17:50:03 +0000
Received: by mail-pg1-x542.google.com with SMTP id y4so17766733pgc.12
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 04 Jan 2019 09:49:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=3VOwOJYTEi9UR4UgeiKLcvLz0osJ4eyuFQfv798N0kw=;
 b=cIQDFnbbZQ7zun0bPoYcKlx4CAsV3EdWh8sQLP0WqF9Y45of71SulNq2FVC8xni2F0
 NW7GmTzooeTKpkIuN/g2s879lKeRldJQNhRxB0FpP7j+m9mBmZSSyHklkczn+yfZI6Xz
 BWjQl6TtJNNh964Grs9JFAUqrD7oAmW5nRJ2vasVyDn0pnMm4PgKlkEXdSLibNVdsi8w
 9xQEhxC6V6KwlpXt+wbL7QbIigPIGkuTpl8zWtYUvmupl+q4L2ENNZE7OMPHDlWdDH+7
 Ekno1l0RTMm69qLLs6FPaiUl5Zamvg+3jST6R9lJMWCOY0AGyEIR4DZahVRmpH7z1jlw
 Ww+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=3VOwOJYTEi9UR4UgeiKLcvLz0osJ4eyuFQfv798N0kw=;
 b=dsU9ncwkW4wWKTZ0mShpHjuODVfLQuCzxOF8Vc+UIPNYbkQMJ3iHto9PjrqbwQomwF
 JmxqUSqFxz2LbtxLQV2oL1+PmuyQKj+ysL6xYtNgW3sdUmrEDeNy3EYFzZ5dWgCKTgGc
 0GD6fGWMizm6Eyrq/ZX0V/UmBydR52myTmF5SCo0PwI7DGX+d9Th9jY+FbnsC/RwsM4Z
 1gButU0dW+Cc+Ivpe1VO7kzpQnxCm5V8s7mMvDGOsK9BpkaCKk0XFw1Dv5Q4EXMzgA8K
 dkC5n/KNWwomzQ4RcfkpxMqHoU0YgcRDiht+sEAumL926SFlyLQCXD7FrC1nfGWmKk5N
 Ezow==
X-Gm-Message-State: AJcUukcKQuF5uqTxvm3LtGvz4+J9U+nQxXvxnRSxwrTovC2teDJekjND
 g6hybZJW4OhTtkU5ZfyjWns=
X-Google-Smtp-Source: ALg8bN63AGT6KHsPf4+9iTaT+C2aMgpdrT4E6ZaEu9GWtQHOwSDB5//W1Fa3tk9pOsUCFndg/m44ow==
X-Received: by 2002:a63:1904:: with SMTP id z4mr2364785pgl.135.1546624191241; 
 Fri, 04 Jan 2019 09:49:51 -0800 (PST)
Received: from squirtle.lan (c-24-22-235-96.hsd1.wa.comcast.net.
 [24.22.235.96])
 by smtp.gmail.com with ESMTPSA id i193sm100699632pgc.22.2019.01.04.09.49.49
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Fri, 04 Jan 2019 09:49:50 -0800 (PST)
From: Andrey Smirnov <andrew.smirnov@gmail.com>
To: linux-pci@vger.kernel.org
Subject: [PATCH v2 06/20] PCI: imx6: Remove PCIE_PHY_RX_ASIC_OUT* constants
Date: Fri,  4 Jan 2019 09:49:11 -0800
Message-Id: <20190104174925.17153-7-andrew.smirnov@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190104174925.17153-1-andrew.smirnov@gmail.com>
References: <20190104174925.17153-1-andrew.smirnov@gmail.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190104_094952_532111_B58D5FBB 
X-CRM114-Status: UNSURE (   9.81  )
X-CRM114-Notice: Please train this message.
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
Cc: "A.s. Dong" <aisheng.dong@nxp.com>,
 Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
 Richard Zhu <hongxing.zhu@nxp.com>, linux-arm-kernel@lists.infradead.org,
 Andrey Smirnov <andrew.smirnov@gmail.com>, linux-kernel@vger.kernel.org,
 Fabio Estevam <fabio.estevam@nxp.com>, linux-imx@nxp.com,
 Bjorn Helgaas <bhelgaas@google.com>, Leonard Crestez <leonard.crestez@nxp.com>,
 Chris Healy <cphealy@gmail.com>, Lucas Stach <l.stach@pengutronix.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Code using these constants was removed in commit a77c5422d758 ("PCI:
imx6: Remove broken Gen2 workaround"). No functional change intended.

Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: Fabio Estevam <fabio.estevam@nxp.com>
Cc: Chris Healy <cphealy@gmail.com>
Cc: Lucas Stach <l.stach@pengutronix.de>
Cc: Leonard Crestez <leonard.crestez@nxp.com>
Cc: "A.s. Dong" <aisheng.dong@nxp.com>
Cc: Richard Zhu <hongxing.zhu@nxp.com>
Cc: linux-imx@nxp.com
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org
Cc: linux-pci@vger.kernel.org
Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
---
 drivers/pci/controller/dwc/pci-imx6.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
index a7192b9e0e71..282b09076fea 100644
--- a/drivers/pci/controller/dwc/pci-imx6.c
+++ b/drivers/pci/controller/dwc/pci-imx6.c
@@ -123,9 +123,6 @@ struct imx6_pcie {
 #define  PCIE_PHY_MPLL_MULTIPLIER_MASK		0x7f
 #define  PCIE_PHY_MPLL_MULTIPLIER_OVRD		(0x1 << 9)
 
-#define PCIE_PHY_RX_ASIC_OUT 0x100D
-#define PCIE_PHY_RX_ASIC_OUT_VALID	(1 << 0)
-
 #define PHY_RX_OVRD_IN_LO 0x1005
 #define PHY_RX_OVRD_IN_LO_RX_DATA_EN (1 << 5)
 #define PHY_RX_OVRD_IN_LO_RX_PLL_EN (1 << 3)
-- 
2.20.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
