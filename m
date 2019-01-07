Return-Path: <SRS0=txfi=PP=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63B43C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 06:43:54 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1033620881
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 06:43:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Fv4gkkaE";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ti.com header.i=@ti.com header.b="mNkGRDzs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1033620881
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=PMweUPW6wil7D1xHOG106No7Uqxp1kHbLQrRDh/+VmY=; b=Fv4gkkaELNVTmq
	uOryg7Mn4OxNnDpF9rfmAAM3KCmOQNmww1tw9YfItQho8pXJn2im2r/pDhMemdd3cdRdjfv2bnfc5
	4tJbY2/poGfEJwLFENuA9K0FaLtQm+kFMHv+BsHhL95cE6AybGG//5nxKq1G9qaBC5DAYkdwcc7cN
	knWpINuM3BR3FYVPF022h21uX04u5unkMfWSMIWGzN7TVyhgMSbN3b0yw+UsW9MX66cSfdUAwS0YU
	aG6O/+B81nYaLRTtPlwcwddvXZEqfeYBw7MhjwQ+heoTrjGiXBxayL2wMDdFljdTkgNGrIzmeJLBP
	jqFEo0YuuG3rXrL+U+6A==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1ggOdY-0003QM-OP; Mon, 07 Jan 2019 06:43:48 +0000
Received: from lelv0143.ext.ti.com ([198.47.23.248])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1ggOcu-0002bP-59; Mon, 07 Jan 2019 06:43:17 +0000
Received: from lelv0265.itg.ti.com ([10.180.67.224])
 by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id x076gulx055152;
 Mon, 7 Jan 2019 00:42:56 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1546843376;
 bh=cErqiu0ARQGyKCvuDtnfQEI4ZlZ26OR+gjwxCf8dAg4=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=mNkGRDzsJSoQ8ZeDWejeSfoGil7FdYS/sbmTF5HMpMiq0JIwEEjfCLA8B/GQouHAb
 hvLC+qB8thQvP+dvoNtDwrv82N2tvcXWsqQcCU5nn+1NmHjBU3J1Jzz2aqtDfYj2C6
 XKVPlKuQfBJYdjOmOuFFNwMN95DTydqsAXv+27dk=
Received: from DLEE102.ent.ti.com (dlee102.ent.ti.com [157.170.170.32])
 by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x076guv2048373
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Mon, 7 Jan 2019 00:42:56 -0600
Received: from DLEE113.ent.ti.com (157.170.170.24) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Mon, 7
 Jan 2019 00:42:56 -0600
Received: from dflp32.itg.ti.com (10.64.6.15) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Mon, 7 Jan 2019 00:42:56 -0600
Received: from a0393678ub.india.ti.com (ileax41-snat.itg.ti.com
 [10.172.224.153])
 by dflp32.itg.ti.com (8.14.3/8.13.8) with ESMTP id x076gfnx002672;
 Mon, 7 Jan 2019 00:42:51 -0600
From: Kishon Vijay Abraham I <kishon@ti.com>
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Bjorn Helgaas
 <bhelgaas@google.com>, Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
 Alan Douglas <adouglas@cadence.com>, Shawn Lin <shawn.lin@rock-chips.com>
Subject: [PATCH 02/15] PCI: dwc: Add ->get_features() callback function in
 dw_pcie_ep_ops
Date: Mon, 7 Jan 2019 12:11:35 +0530
Message-ID: <20190107064148.10152-3-kishon@ti.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190107064148.10152-1-kishon@ti.com>
References: <20190107064148.10152-1-kishon@ti.com>
MIME-Version: 1.0
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190106_224308_962908_0D01EC82 
X-CRM114-Status: GOOD (  17.88  )
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

Each platform using Designware PCIe core can support different set of
endpoint features. Add a new callback function ->get_features() in
dw_pcie_ep_ops so that each platform using Designware PCIe core can
advertise its supported features to the endpoint function driver.

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 drivers/pci/controller/dwc/pcie-designware-ep.c | 12 ++++++++++++
 drivers/pci/controller/dwc/pcie-designware.h    |  1 +
 2 files changed, 13 insertions(+)

diff --git a/drivers/pci/controller/dwc/pcie-designware-ep.c b/drivers/pci/controller/dwc/pcie-designware-ep.c
index a543c45c7224..7a2925a16ab8 100644
--- a/drivers/pci/controller/dwc/pcie-designware-ep.c
+++ b/drivers/pci/controller/dwc/pcie-designware-ep.c
@@ -355,6 +355,17 @@ static int dw_pcie_ep_start(struct pci_epc *epc)
 	return pci->ops->start_link(pci);
 }
 
+static const struct pci_epc_features*
+dw_pcie_ep_get_features(struct pci_epc *epc, u8 func_no)
+{
+	struct dw_pcie_ep *ep = epc_get_drvdata(epc);
+
+	if (!ep->ops->get_features)
+		return NULL;
+
+	return ep->ops->get_features(ep);
+}
+
 static const struct pci_epc_ops epc_ops = {
 	.write_header		= dw_pcie_ep_write_header,
 	.set_bar		= dw_pcie_ep_set_bar,
@@ -368,6 +379,7 @@ static const struct pci_epc_ops epc_ops = {
 	.raise_irq		= dw_pcie_ep_raise_irq,
 	.start			= dw_pcie_ep_start,
 	.stop			= dw_pcie_ep_stop,
+	.get_features		= dw_pcie_ep_get_features,
 };
 
 int dw_pcie_ep_raise_legacy_irq(struct dw_pcie_ep *ep, u8 func_no)
diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
index 9943d8c68335..1f56e6ae34ff 100644
--- a/drivers/pci/controller/dwc/pcie-designware.h
+++ b/drivers/pci/controller/dwc/pcie-designware.h
@@ -192,6 +192,7 @@ struct dw_pcie_ep_ops {
 	void	(*ep_init)(struct dw_pcie_ep *ep);
 	int	(*raise_irq)(struct dw_pcie_ep *ep, u8 func_no,
 			     enum pci_epc_irq_type type, u16 interrupt_num);
+	const struct pci_epc_features* (*get_features)(struct dw_pcie_ep *ep);
 };
 
 struct dw_pcie_ep {
-- 
2.17.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
