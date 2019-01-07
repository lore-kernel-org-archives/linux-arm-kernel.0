Return-Path: <SRS0=txfi=PP=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A5F6C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 06:44:07 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EAF422087F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 06:44:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="GZH7IOT8";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ti.com header.i=@ti.com header.b="s4cGbFeT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EAF422087F
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=ie58I16eOni/wlQ9T/XRE2+/DdSuvQiaQsG5huNBFOc=; b=GZH7IOT84dDb5G
	e5U5/Wg2c1gNxDIELBgrf+Zwj+clry6f0dYkKrXLoylnMTCt5ccFB5PyWuFnvz+OF2BX4L6ug8pl1
	WiEvWDFiU72MO+fXH95lHDjvMDHFffQmV336bV1E40FLmLiAOf79pd5EZ6jHGWGlgGAD8Gs6cMHI+
	2ancdUG5A1ItAjOfXrsIKUUxHYxEy+DP+lXphNK+SRIAqnlOJz/1lSL/9iGRQApBGG1nSwt5LPZSE
	7wrMlDxiOvZmHtRcgotMtBo020NrG5gAhcZfM0gLO748Mm1bs6rzz/xDOPQmW1BUaqqptBL8CPStB
	9gxoOYNN653PUnIFj1xw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1ggOdn-0003i6-Ss; Mon, 07 Jan 2019 06:44:03 +0000
Received: from fllv0015.ext.ti.com ([198.47.19.141])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1ggOcx-0002gL-Bj; Mon, 07 Jan 2019 06:43:18 +0000
Received: from lelv0266.itg.ti.com ([10.180.67.225])
 by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id x076h5fY058891;
 Mon, 7 Jan 2019 00:43:05 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1546843385;
 bh=TmIM90if+baASLKYtEih7oqZRQj9lMMND6SlULCYPWw=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=s4cGbFeTxcmy/RknkLx+VUGLIvRawQJSvkSLFiTGAhUuZYcyABTOXSx8LdfaIpVXE
 f7fh4+y7fM+H063V63R4/fo0rckjdfqU84ClIb0dOjynSKCngBEPoLBxObLOvuwQBQ
 FBsFYhg9nYUsqHcqj/JjmuBIlUIvxCAI+W3ef24M=
Received: from DFLE106.ent.ti.com (dfle106.ent.ti.com [10.64.6.27])
 by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x076h5XC071098
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Mon, 7 Jan 2019 00:43:05 -0600
Received: from DFLE115.ent.ti.com (10.64.6.36) by DFLE106.ent.ti.com
 (10.64.6.27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Mon, 7
 Jan 2019 00:43:05 -0600
Received: from dflp32.itg.ti.com (10.64.6.15) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Mon, 7 Jan 2019 00:43:04 -0600
Received: from a0393678ub.india.ti.com (ileax41-snat.itg.ti.com
 [10.172.224.153])
 by dflp32.itg.ti.com (8.14.3/8.13.8) with ESMTP id x076gfo1002672;
 Mon, 7 Jan 2019 00:43:01 -0600
From: Kishon Vijay Abraham I <kishon@ti.com>
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Bjorn Helgaas
 <bhelgaas@google.com>, Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
 Alan Douglas <adouglas@cadence.com>, Shawn Lin <shawn.lin@rock-chips.com>
Subject: [PATCH 04/15] PCI: pci-dra7xx: Populate ->get_features()
 dw_pcie_ep_ops
Date: Mon, 7 Jan 2019 12:11:37 +0530
Message-ID: <20190107064148.10152-5-kishon@ti.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190107064148.10152-1-kishon@ti.com>
References: <20190107064148.10152-1-kishon@ti.com>
MIME-Version: 1.0
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190106_224311_889570_B2CBB27A 
X-CRM114-Status: GOOD (  16.22  )
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
Cc: Heiko Stuebner <heiko@sntech.de>, Jingoo Han <jingoohan1@gmail.com>,
 linux-kernel@vger.kernel.org, kishon@ti.com,
 linux-rockchip@lists.infradead.org, Jia-Ju Bai <baijiaju1990@gmail.com>,
 Cyrille Pitchen <cyrille.pitchen@free-electrons.com>,
 linux-pci@vger.kernel.org, linux-omap@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Populate ->get_features() dw_pcie_ep_ops to return the EPC features
supported by DRA7xx PCIe endpoint controller.

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 drivers/pci/controller/dwc/pci-dra7xx.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/pci/controller/dwc/pci-dra7xx.c b/drivers/pci/controller/dwc/pci-dra7xx.c
index a32d6dde7a57..15620cfa617b 100644
--- a/drivers/pci/controller/dwc/pci-dra7xx.c
+++ b/drivers/pci/controller/dwc/pci-dra7xx.c
@@ -389,9 +389,22 @@ static int dra7xx_pcie_raise_irq(struct dw_pcie_ep *ep, u8 func_no,
 	return 0;
 }
 
+static const struct pci_epc_features dra7xx_pcie_epc_features = {
+	.linkup_notifier = true,
+	.msi_capable = true,
+	.msix_capable = false,
+};
+
+static const struct pci_epc_features*
+dra7xx_pcie_get_features(struct dw_pcie_ep *ep)
+{
+	return &dra7xx_pcie_epc_features;
+}
+
 static struct dw_pcie_ep_ops pcie_ep_ops = {
 	.ep_init = dra7xx_pcie_ep_init,
 	.raise_irq = dra7xx_pcie_raise_irq,
+	.get_features = dra7xx_pcie_get_features,
 };
 
 static int __init dra7xx_add_pcie_ep(struct dra7xx_pcie *dra7xx,
-- 
2.17.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
