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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31304C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 17:50:18 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 02DFF21872
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 17:50:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="r0e+vIHK";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nemLFnIa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 02DFF21872
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=8P5fcltGfKKMdnkLy9JrpQEI5mL0giTBGXm6H96BERQ=; b=r0e+vIHKAxH/XH
	KGoz2gNUFTCXeGDoFRkqf0gILZLsObjKgGoOM4Ct1kFB42NEOJQy39eMNQIowfLJqikFRPQeXMvTP
	YB+nmN6zIpiezPGeHg8JpXWkHo4ecYpudMDr5zGK1B2rh7xcpLkmyCliGVD6w5WnXsNvrWXhgeZbX
	MjkC9Wv+muwCM8BzwViD/dDziy6Pww+4gJ7X7RMDAp4XYI8vowbarMeUp7f0JbIolfyhUtPp9xbBf
	+AwSMG6dFQYTpGpAz8TwieuOVu/oWCvJa9oKgQUHManSWXsbGEVcFzydFdGGHZ7CjptQSmtprLEJw
	u8yeyRSzpDVmGbbiMnnQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gfTbq-00057n-W4; Fri, 04 Jan 2019 17:50:15 +0000
Received: from mail-pf1-x442.google.com ([2607:f8b0:4864:20::442])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gfTbO-00046L-9A
 for linux-arm-kernel@lists.infradead.org; Fri, 04 Jan 2019 17:49:48 +0000
Received: by mail-pf1-x442.google.com with SMTP id b85so18629486pfc.3
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 04 Jan 2019 09:49:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=KJzDYEASCtJoBvSDPXwzAPQP14rP9PAwK4xPdCOMwW0=;
 b=nemLFnIamffqdBky0GXQXY3CwxeEZ6YWQvEdffEfXhg1yhDLxnXlcalOt573u1sphT
 MQA2tC0oNIURJ61ez6iZL53jSASIHY5+LzZb90k4qAmV4XRPeyI/P5VXpBL0QiKy6CWi
 ueaQzXxxy0vHwwxqoZXYOjkhInhi70mODbn0ZiLqifwqLK61gAA/ee3HcRfIKCBNnoAa
 EABmaBKKY+l00GJLewcwRGIIO4t5/9fCCwcbrrWvzAIZcZBCXpU6sOgTCp+XXZKJA3LS
 kU44lTNF6hmLVyGYszi9bl4yiX97Sr2l9Shz7uJinixiBQMWR/OkHqhDmvbdw5e9io5M
 MA+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=KJzDYEASCtJoBvSDPXwzAPQP14rP9PAwK4xPdCOMwW0=;
 b=TeVnGU65rRYM7qHI/oQ9CUZjKo9Y3Jc1w7w0/Ty7kt6THalJ3Wa+Z0yxnCNn4GbN9l
 /IsBODfmdCPUFbivkowSiIC+lsRkBOwryLKJEt4yQ/bvuNmOb5lc2KDFK8Xl3cjNJFDN
 3CCg7SOZrXAOvNNHFSdtXCzw7AjH5Rph9n5kSIiVtg5yf89XDhK75+QLw8skeE9BCRlp
 Rf1Itld/3nRU9G377IuYJgoXU9awLMeYHVoA6E1kTZskWxUWa4UKceMy36rV16Xa4BxT
 DWa6n2jeHaktMrXWksDxuVzzY3rYivqSqZ/Ya9Oo5lmalO0INvKuwLSwLfCW88W9fjg3
 561w==
X-Gm-Message-State: AJcUuke4jiks7N8yhIUiaQx2bF22GJIRb4XIQcrp0/jvUd2sP8Z04/sU
 kzy3QODRdc2fLQMbVFmoTZY=
X-Google-Smtp-Source: ALg8bN62Z/ONTKavQulh6umuVA7rLaQLdKNV4XVr/H5+FtFegah5dPfF4bl9v0EW0vr/zUZ1sJ9Pfg==
X-Received: by 2002:a63:9b11:: with SMTP id r17mr2459416pgd.416.1546624185485; 
 Fri, 04 Jan 2019 09:49:45 -0800 (PST)
Received: from squirtle.lan (c-24-22-235-96.hsd1.wa.comcast.net.
 [24.22.235.96])
 by smtp.gmail.com with ESMTPSA id i193sm100699632pgc.22.2019.01.04.09.49.43
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Fri, 04 Jan 2019 09:49:44 -0800 (PST)
From: Andrey Smirnov <andrew.smirnov@gmail.com>
To: linux-pci@vger.kernel.org
Subject: [PATCH v2 03/20] PCI: imx6: Return -ETIMEOUT from
 imx6_pcie_wait_for_speed_change()
Date: Fri,  4 Jan 2019 09:49:08 -0800
Message-Id: <20190104174925.17153-4-andrew.smirnov@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190104174925.17153-1-andrew.smirnov@gmail.com>
References: <20190104174925.17153-1-andrew.smirnov@gmail.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190104_094946_797125_8CA356CF 
X-CRM114-Status: GOOD (  13.15  )
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

Change error code from EINVAL to ETIMEDOUT in
imx6_pcie_wait_for_speed_change() since that error code seems more
appropriate.

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
 drivers/pci/controller/dwc/pci-imx6.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
index 491a93a02c80..a81edfac9974 100644
--- a/drivers/pci/controller/dwc/pci-imx6.c
+++ b/drivers/pci/controller/dwc/pci-imx6.c
@@ -698,7 +698,7 @@ static int imx6_pcie_wait_for_speed_change(struct imx6_pcie *imx6_pcie)
 	}
 
 	dev_err(dev, "Speed change timeout\n");
-	return -EINVAL;
+	return -ETIMEDOUT;
 }
 
 static void imx6_pcie_ltssm_enable(struct device *dev)
-- 
2.20.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
