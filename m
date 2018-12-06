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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52BDCC04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 07:46:27 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0CF4B20892
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 07:46:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="L1qaFzeG";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E25F0M4z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0CF4B20892
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=bKiI1gRg/ZaWhoQPLlpDJaugZ5Sc6lORpOcyS93PQzU=; b=L1qaFzeG7//3Iu
	dBG/rtSZKFyA4HH1P0Ekf8Wga0il9H6OnI77qbAg4ftQoyPmJoogD3Ta/HzC/few5xvFqc9B/nFoE
	Nzp3031ET3PoiP5ILxFclNfud1VyS6rZc6RVO9xgarCnBBT+mOVfZWRdc/ss4Ow3DvT/DjmIHD8Yt
	acAOm0J5ZJ3DCsXzi+CMe6mDons63sVjC+gnJK2XEd7fV70vPvcP1yDP8uLg8P2F+UJ482oynd9pp
	jiKal6Oo53FDV4NP7Pye6fZKg81LnV6pZ8/Z+RnFydc8OGgDYjnUgUQseDmn+xMYhbGLxAuWTQVIK
	I/cRlBFL5AxSUoo+J2FQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gUoMW-0005lQ-Re; Thu, 06 Dec 2018 07:46:20 +0000
Received: from mail-pf1-x442.google.com ([2607:f8b0:4864:20::442])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gUoMT-0005kv-EQ
 for linux-arm-kernel@lists.infradead.org; Thu, 06 Dec 2018 07:46:18 +0000
Received: by mail-pf1-x442.google.com with SMTP id c72so11370283pfc.6
 for <linux-arm-kernel@lists.infradead.org>;
 Wed, 05 Dec 2018 23:46:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=FWUNuBobrQGS8tPzC7mZOSiomc02hqs3O+/8VlJOcu4=;
 b=E25F0M4zMsqLFvdU+s7GP8/PEb4WgujJde7XOmYvDnAzcNeb0QdcJa3zdYQyJB7vvn
 QjKY3mDFt9+S9Z2m6F6HjFJXtzm30yxFlCB8rJiU/PKLy+h4Gu9PoGnaOee0jE1+cKMS
 ljM04Ivxsgo7ybjTNiApj/vOVvGckj8NSRPh5vsbN1Lo2VN5NsBGIwDH8xOK9MQj37mG
 rQfVJkadSpGveaLiM58cQ6Bkt3N4EzVhbmCa5Hf2DMhRiPbJ2O/RCD7wPOcyxYA5hbdw
 HNl5b2XeTdPW8kxXQgoh1jpni9NvHF/PFhdrIjgg3oo+2jj2Bl5xZ/qqZsIXfAh4KmKj
 9U8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=FWUNuBobrQGS8tPzC7mZOSiomc02hqs3O+/8VlJOcu4=;
 b=FwPAT3wtXmHJW7d9dDsoo/nPzAClkOwXtwgSojlAAQam7GFoJxjIydsOl/QVGefSxy
 aiMqlTr551ROiN35/+4BHHNNksDhE6YKuKdWiMKqnRGcwSjgkHU6Mv01LqBXAESe1i+f
 b1VSe8HePTSoVa/RQTWa91hZq/bYfXQWGH4r/6Zx77iIk2I3+350CDMmMxhbr5WE/MaH
 sjzvK3G2Wws4BjXwd6dPs8b+PX9/Y+xr5bdZe9qp/o+x07xua4HwMm9xVm+5DTnloNm0
 LT7YeEvzrEV/goYubwtUMP563py0WSq7Ts53kdZhAouAoR6gy9WC/fpvsacbbWyfwbx0
 4lYg==
X-Gm-Message-State: AA+aEWYFPPbTvfZxxjlGCRvtc0IgKczBPxeEfAVmj2E3IMJRk62uLdyW
 aSAHL5I7aR1adF1QrpeFxWw=
X-Google-Smtp-Source: AFSGD/UQefWq+hnPci7nzwdxqF0q9fBq2vntcT00HEgmLc4u3kL9oimYNMvYqzuEide+WDsdtdqxtw==
X-Received: by 2002:a62:e30d:: with SMTP id g13mr27285081pfh.151.1544082366337; 
 Wed, 05 Dec 2018 23:46:06 -0800 (PST)
Received: from squirtle.lan (c-24-22-235-96.hsd1.wa.comcast.net.
 [24.22.235.96])
 by smtp.gmail.com with ESMTPSA id l11sm29198232pff.65.2018.12.05.23.46.04
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Wed, 05 Dec 2018 23:46:05 -0800 (PST)
From: Andrey Smirnov <andrew.smirnov@gmail.com>
To: linux-pci@vger.kernel.org
Subject: [PATCH] PCI: controller: dwc: Make PCI_IMX6 depend on PCIEPORTBUS
Date: Wed,  5 Dec 2018 23:45:55 -0800
Message-Id: <20181206074555.19579-1-andrew.smirnov@gmail.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181205_234617_507804_9ED3E0B2 
X-CRM114-Status: GOOD (  10.19  )
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
 linux-imx@nxp.com, bhelgaas@google.com,
 Leonard Crestez <leonard.crestez@nxp.com>, cphealy@gmail.com,
 l.stach@pengutronix.de
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Building a kernel with CONFIG_PCI_IMX6=y, but CONFIG_PCIEPORTBUS=n
produces a system where built-in PCIE bridge (16c3:abcd) isn't bound
to pcieport driver. This, in turn, results in a PCIE bus that is
capable of enumerating attached PCIE device, but lacks functional
interrupt support.

Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
---

Assuming this is a reasonable dependency, shold this be done to more
than just i.MX6 driver?

 drivers/pci/controller/dwc/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/pci/controller/dwc/Kconfig b/drivers/pci/controller/dwc/Kconfig
index 2b139acccf32..44ededbeab85 100644
--- a/drivers/pci/controller/dwc/Kconfig
+++ b/drivers/pci/controller/dwc/Kconfig
@@ -92,6 +92,7 @@ config PCI_IMX6
 	bool "Freescale i.MX6 PCIe controller"
 	depends on SOC_IMX8MQ || SOC_IMX6Q || (ARM && COMPILE_TEST)
 	depends on PCI_MSI_IRQ_DOMAIN
+	depends on PCIEPORTBUS
 	select PCIE_DW_HOST
 
 config PCIE_SPEAR13XX
-- 
2.19.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
