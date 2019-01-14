Return-Path: <SRS0=baBj=PW=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4650AC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 13:36:11 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1925C206B7
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 13:36:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="j/oTlBrA";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ti.com header.i=@ti.com header.b="r+bkx6Le"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1925C206B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=2JDu4jk4anVijxDiMFEys7by6cQ58xFHikCgSk9E6jU=; b=j/oTlBrAo60iyC
	WQx0vC7RxSf6d4KIeuatKCbEkZLc7Kx3gqU6Fs/dEypl4LCELhnnG19a6U5ETvnlVfPVx6ovFtVz3
	Z/4cFtCWLCYLd5mfYLmPhVswZvCxv+/F2uw7nptTRsmvMc46f6FT/t3CUH0civjG66zp9g1hjMrrT
	5bGDX1lZ+FFbgitGLMXMFwl92G09N/JoRo3Kcb1FN876qLJ/xsJ+pTBzbgMVfrX7I4x5hCONXvVM8
	efUhSEgpdEQUrOUIiSF9mMm0BXN4RX9jgQLqWq8OSF7/rBG86TbKoHNNq7CqSLauvFK355Yo+/iS6
	0gsjc1N2JQpWLw1yKseA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gj2PF-0002NE-IY; Mon, 14 Jan 2019 13:35:57 +0000
Received: from fllv0016.ext.ti.com ([198.47.19.142])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gj2FM-0003mD-16
 for linux-arm-kernel@lists.infradead.org; Mon, 14 Jan 2019 13:26:17 +0000
Received: from fllv0035.itg.ti.com ([10.64.41.0])
 by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id x0EDPZg6098110;
 Mon, 14 Jan 2019 07:25:35 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1547472335;
 bh=tWr3enOfHY/N1zh//XsnGspmWYu0ckIGK/nsnUn+GzQ=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=r+bkx6LeW0pSvKeIOFzOA37U9B2R7sdKsI7CFyRpoUBLLGahmjzR8awEFLeUvIOMe
 s7gm/PgXpsrFbUePRYAk73vSDWqRTKkuLR3aVdYPtITHd26/G4eVaCsr7x97ZLUzs0
 Z/oATG0y6z8y9Ik+n+0TDAEm+6B98W0CLRw2bcAQ=
Received: from DFLE103.ent.ti.com (dfle103.ent.ti.com [10.64.6.24])
 by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x0EDPZr6088866
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Mon, 14 Jan 2019 07:25:35 -0600
Received: from DFLE107.ent.ti.com (10.64.6.28) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Mon, 14
 Jan 2019 07:25:34 -0600
Received: from dlep32.itg.ti.com (157.170.170.100) by DFLE107.ent.ti.com
 (10.64.6.28) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Mon, 14 Jan 2019 07:25:34 -0600
Received: from a0393678ub.india.ti.com (ileax41-snat.itg.ti.com
 [10.172.224.153])
 by dlep32.itg.ti.com (8.14.3/8.13.8) with ESMTP id x0EDOoWU028516;
 Mon, 14 Jan 2019 07:25:30 -0600
From: Kishon Vijay Abraham I <kishon@ti.com>
To: Gustavo Pimentel <gustavo.pimentel@synopsys.com>, Rob Herring
 <robh+dt@kernel.org>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Subject: [PATCH 08/24] PCI: keystone: Explicitly set the PCIe mode
Date: Mon, 14 Jan 2019 18:54:08 +0530
Message-ID: <20190114132424.6445-9-kishon@ti.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190114132424.6445-1-kishon@ti.com>
References: <20190114132424.6445-1-kishon@ti.com>
MIME-Version: 1.0
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190114_052544_506194_387DD5F2 
X-CRM114-Status: GOOD (  18.76  )
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
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org,
 Jesper Nilsson <jesper.nilsson@axis.com>, Arnd Bergmann <arnd@arndb.de>,
 Jingoo Han <jingoohan1@gmail.com>, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@axis.com,
 Kishon Vijay Abraham I <kishon@ti.com>, Murali Karicheri <m-karicheri2@ti.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Bjorn Helgaas <bhelgaas@google.com>, linux-omap@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Explicitly set the PCIe mode to BOOTCFG_DEVCFG instead of always
relying on the default values. This is required when EP mode has to
be explicitly written to BOOTCFG_DEVCFG register.

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 drivers/pci/controller/dwc/pci-keystone.c | 37 +++++++++++++++++++++++
 1 file changed, 37 insertions(+)

diff --git a/drivers/pci/controller/dwc/pci-keystone.c b/drivers/pci/controller/dwc/pci-keystone.c
index ce2f5c25f7a3..d1ecf826dfe8 100644
--- a/drivers/pci/controller/dwc/pci-keystone.c
+++ b/drivers/pci/controller/dwc/pci-keystone.c
@@ -79,6 +79,15 @@
 #define PCIE_RC_K2L			0xb00a
 #define PCIE_RC_K2G			0xb00b
 
+#define KS_PCIE_DEV_TYPE_MASK		(0x3 << 1)
+#define KS_PCIE_DEV_TYPE(mode)		((mode) << 1)
+
+#define EP				0x0
+#define LEG_EP				0x1
+#define RC				0x2
+
+#define KS_PCIE_SYSCLOCKOUTEN		BIT(0)
+
 #define to_keystone_pcie(x)		dev_get_drvdata((x)->dev)
 
 struct keystone_pcie {
@@ -859,6 +868,30 @@ static int ks_pcie_enable_phy(struct keystone_pcie *ks_pcie)
 	return ret;
 }
 
+static int ks_pcie_set_mode(struct device *dev)
+{
+	struct device_node *np = dev->of_node;
+	struct regmap *syscon;
+	u32 val;
+	u32 mask;
+	int ret = 0;
+
+	syscon = syscon_regmap_lookup_by_phandle(np, "ti,syscon-pcie-mode");
+	if (IS_ERR(syscon))
+		return 0;
+
+	mask = KS_PCIE_DEV_TYPE_MASK | KS_PCIE_SYSCLOCKOUTEN;
+	val = KS_PCIE_DEV_TYPE(RC) | KS_PCIE_SYSCLOCKOUTEN;
+
+	ret = regmap_update_bits(syscon, 0, mask, val);
+	if (ret) {
+		dev_err(dev, "failed to set pcie mode\n");
+		return ret;
+	}
+
+	return 0;
+}
+
 static int __init ks_pcie_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
@@ -971,6 +1004,10 @@ static int __init ks_pcie_probe(struct platform_device *pdev)
 		goto err_get_sync;
 	}
 
+	ret = ks_pcie_set_mode(dev);
+	if (ret < 0)
+		goto err_get_sync;
+
 	ret = ks_pcie_add_pcie_port(ks_pcie, pdev);
 	if (ret < 0)
 		goto err_get_sync;
-- 
2.17.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
