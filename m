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
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB172C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 17:53:46 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9F2D021872
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 17:53:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Kqi+vPJX";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Bs3tzkr/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9F2D021872
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=dul4Y0xidthA9WYd4vzqgRjbt+vkANeBhJ9J9GRSSXE=; b=Kqi+vPJXYRlTly
	xqlfpKHpRgNw+OhAX6a3p6wwNfROyzP9+C3T3g15rVlGQhgw2CwNhjrO7/d23xUvIE/iz9fvEixwf
	BedXnGeeLP90cDdsIeNYBWxjCBxDkOBEHJzrHLBGf/Fg85+ZoE/3tuK99abTw9nfSzFSQUqr6ZP2g
	1fcGDxHk8tUhBYcQ0wioizUJaN7aG5cb4a0JpZhGcOr3DgX/L2mhhQ6DWQdROGvqnYi5SpbidmlEC
	dV01cXChCxm13T+a+gmaMkZ9go2bySfFSZB4wCGpWWaJOAHhcxY68+YBQbHPMYpk87HE4cRl0fIGR
	yMMXamEatG4C1BdJYYVw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gfTf8-0000uj-E8; Fri, 04 Jan 2019 17:53:38 +0000
Received: from mail-pl1-f194.google.com ([209.85.214.194])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gfTbt-0005JO-0N
 for linux-arm-kernel@lists.infradead.org; Fri, 04 Jan 2019 17:50:55 +0000
Received: by mail-pl1-f194.google.com with SMTP id t13so17718796ply.13
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 04 Jan 2019 09:50:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=UaA45DYiu1lBKpFMAL9ysyx77C82thANkIMXH/mfBAE=;
 b=Bs3tzkr/uZcCHPaZu2HC5rYTi8GL2xZCuXOZqzuKLivxSlZKMduu5g57xFjts444WS
 aLTTJjrYRcQxVpLNnfPQt6OAoisHm/NSpTJyfXH1d7PytSHs27GbyRNl8SujipOFhyjJ
 NnYUlQHLxMA8ZgnFhxlLbO/haYwJFygVbnASjw7l9I68RaR3h5MyZOhTAKG4USmh1gRP
 ygOOi61RG7LOGat1w7HY23N82Kqk/IV+4VnGyP6ZkLlIFadq7Wf6ag4EMlfirn8HPMh0
 XbJe22qc5MXA1xr4f2TLR+/SemO5mZu9d9crmelJJTrHpoYR2hGIJ+Z8fYPjnxrQrxpe
 mvPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=UaA45DYiu1lBKpFMAL9ysyx77C82thANkIMXH/mfBAE=;
 b=RHzvpoBHhGb+BUeIfcm6XxPIReKBPttQqJbOv/ytnCJSKHEPrffqTTXmN3p82yTwIj
 WX2nCm0o84rDX3b3WLn5LvnFyRv6XXQONaYwS66Hk6smhfedCuAJ7H7/TOjqsOwo+Wd+
 OTTnnaWDt5DZV38/j9G2RFSZnuoB7vA1Q+h0z2l3AFyyVD0de8gDEJfN54xEEQb+tkfE
 efQakBpmmLU0kLtd5spJD4jfrSPohIgQ+QaHrT2b1haO8E9qMiLwGK4GpOXdYF0r4vvI
 n50a5uobMxeCQbK2TdANBxm/53+QpqmpJ2qH+ZbUSTuDZfXjnM7OL0vN+ulfz6dCcjGj
 4olg==
X-Gm-Message-State: AJcUukfdx511cAIOmDI0nr2TW+RxnbiCjmo8RA/ojDWGAfLxpXlcsX7H
 RQwAlPQLR/L+V6YWxG0S6D4=
X-Google-Smtp-Source: ALg8bN6KeuZvj5+hH6fAqcxHS1bkhdDruLVrs8+ZmBPnURzylt69qWEgGUKtUB4UE4vpX1xHqF/LzA==
X-Received: by 2002:a17:902:981:: with SMTP id
 1mr50372962pln.142.1546624215901; 
 Fri, 04 Jan 2019 09:50:15 -0800 (PST)
Received: from squirtle.lan (c-24-22-235-96.hsd1.wa.comcast.net.
 [24.22.235.96])
 by smtp.gmail.com with ESMTPSA id i193sm100699632pgc.22.2019.01.04.09.50.14
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Fri, 04 Jan 2019 09:50:15 -0800 (PST)
From: Andrey Smirnov <andrew.smirnov@gmail.com>
To: linux-pci@vger.kernel.org
Subject: [PATCH v2 18/20] PCI: imx6: Remove magic numbers from
 imx6_pcie_establish_link()
Date: Fri,  4 Jan 2019 09:49:23 -0800
Message-Id: <20190104174925.17153-19-andrew.smirnov@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190104174925.17153-1-andrew.smirnov@gmail.com>
References: <20190104174925.17153-1-andrew.smirnov@gmail.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190104_095017_813499_2C60340C 
X-CRM114-Status: GOOD (  12.12  )
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

Explicitly define PCIE_RC_LCSR_LINK_SPEED and remove magic numbers
from imx6_pcie_establish_link(). No functional change intended.

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
 drivers/pci/controller/dwc/pci-imx6.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
index d8aef9da476f..f2aca339e9b7 100644
--- a/drivers/pci/controller/dwc/pci-imx6.c
+++ b/drivers/pci/controller/dwc/pci-imx6.c
@@ -96,6 +96,7 @@ struct imx6_pcie {
 #define PCIE_RC_LCR_MAX_LINK_SPEEDS_MASK	0xf
 
 #define PCIE_RC_LCSR				0x80
+#define PCIE_RC_LCSR_LINK_SPEED			GENMASK(19, 16)
 
 /* PCIe Port Logic registers (memory-mapped) */
 #define PL_OFFSET 0x700
@@ -766,8 +767,9 @@ static int imx6_pcie_establish_link(struct imx6_pcie *imx6_pcie)
 		dev_info(dev, "Link: Gen2 disabled\n");
 	}
 
-	tmp = dw_pcie_readl_dbi(pci, PCIE_RC_LCSR);
-	dev_info(dev, "Link up, Gen%i\n", (tmp >> 16) & 0xf);
+	tmp = FIELD_GET(PCIE_RC_LCSR_LINK_SPEED,
+			dw_pcie_readl_dbi(pci, PCIE_RC_LCSR));
+	dev_info(dev, "Link up, Gen%i\n", tmp);
 	return 0;
 
 err_reset_phy:
-- 
2.20.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
