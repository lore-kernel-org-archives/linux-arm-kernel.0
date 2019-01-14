Return-Path: <SRS0=baBj=PW=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA1DFC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 13:29:14 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B96B620651
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 13:29:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="lFj34LYx";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ti.com header.i=@ti.com header.b="tk77drck"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B96B620651
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=dswZFeOKumaqdQ0ch4ASf1yASIRCtCEaSFjS3Us5lOw=; b=lFj34LYxLvHErM
	fbeerr6WgB+KKW86yKWbzJ7l36Jrl2k4Yp37uYB8eBG98UanADpC/JYt9U+jFsbOI+9r8BMrpwK5Q
	KJytJWzKHO1PKYM6hvA6EFDdP9XvvSOd4ys5PKu6OqzqMvbuw7cVQ1ve7ZTvOPrEl80eY+iIqpXVC
	ALW1PNfqiEixd6QdXI5kumSHHF+APVrk0D/6+HsGOqDEEfVmgrEcT+nLF3gsopqqlxljn0ADGko5N
	RyQFGopSniT0A5e1BzsARIRjy6YHAYMcyhMl08SVgAx83tva6QhakOKGdcrsywzIPSyo+YG5gJGyg
	6+gBuzAbZJZkun/+2YRw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gj2Ie-00076B-Mi; Mon, 14 Jan 2019 13:29:08 +0000
Received: from lelv0142.ext.ti.com ([198.47.23.249])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gj2GS-0004qd-Mx
 for linux-arm-kernel@lists.infradead.org; Mon, 14 Jan 2019 13:27:32 +0000
Received: from fllv0035.itg.ti.com ([10.64.41.0])
 by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id x0EDQh1v041581;
 Mon, 14 Jan 2019 07:26:43 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1547472403;
 bh=CF5ivThAeVhsXGcV5WpV6w68ilrQQqK8YE1SR4Z9I10=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=tk77drck6OKnLY9dkDBCKf0sySURytF9x0xxMOPFRCwcQZacNAStG107CmJDsQSmR
 r9+a5K2+EQ8KCsvpdbW4C/MY0hSXsdSyzqEbAPOAFj0g958OSBIGxdAPUCIUsSc3kt
 WtPG9Dy6s5YO1Q06AsX4zxT97WE4I625be1FHFCQ=
Received: from DFLE100.ent.ti.com (dfle100.ent.ti.com [10.64.6.21])
 by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x0EDQhtG089758
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Mon, 14 Jan 2019 07:26:43 -0600
Received: from DFLE113.ent.ti.com (10.64.6.34) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Mon, 14
 Jan 2019 07:26:42 -0600
Received: from dlep32.itg.ti.com (157.170.170.100) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Mon, 14 Jan 2019 07:26:42 -0600
Received: from a0393678ub.india.ti.com (ileax41-snat.itg.ti.com
 [10.172.224.153])
 by dlep32.itg.ti.com (8.14.3/8.13.8) with ESMTP id x0EDOoWi028516;
 Mon, 14 Jan 2019 07:26:38 -0600
From: Kishon Vijay Abraham I <kishon@ti.com>
To: Gustavo Pimentel <gustavo.pimentel@synopsys.com>, Rob Herring
 <robh+dt@kernel.org>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Subject: [PATCH 22/24] PCI: designware-ep: Use aligned ATU window for raising
 MSI interrupts
Date: Mon, 14 Jan 2019 18:54:22 +0530
Message-ID: <20190114132424.6445-23-kishon@ti.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190114132424.6445-1-kishon@ti.com>
References: <20190114132424.6445-1-kishon@ti.com>
MIME-Version: 1.0
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190114_052653_410841_6EA2F3CF 
X-CRM114-Status: GOOD (  18.06  )
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

Certain platforms like K2G reguires the outbound ATU window to be
aligned. The alignment size is already present in mem->page_size.
Use the alignment size present in mem->page_size to configre a
aligned ATU window. In order to raise an interrupt, CPU has to write
to address offset from the start of the window unlike before where
writes were always to the beginning of the ATU window.

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 drivers/pci/controller/dwc/pcie-designware-ep.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-designware-ep.c b/drivers/pci/controller/dwc/pcie-designware-ep.c
index 47cc06bac91f..f557e83bc34c 100644
--- a/drivers/pci/controller/dwc/pcie-designware-ep.c
+++ b/drivers/pci/controller/dwc/pcie-designware-ep.c
@@ -397,6 +397,7 @@ int dw_pcie_ep_raise_msi_irq(struct dw_pcie_ep *ep, u8 func_no,
 {
 	struct dw_pcie *pci = to_dw_pcie_from_ep(ep);
 	struct pci_epc *epc = ep->epc;
+	unsigned int aligned_offset;
 	u16 msg_ctrl, msg_data;
 	u32 msg_addr_lower, msg_addr_upper, reg;
 	u64 msg_addr;
@@ -422,13 +423,15 @@ int dw_pcie_ep_raise_msi_irq(struct dw_pcie_ep *ep, u8 func_no,
 		reg = ep->msi_cap + PCI_MSI_DATA_32;
 		msg_data = dw_pcie_readw_dbi(pci, reg);
 	}
-	msg_addr = ((u64) msg_addr_upper) << 32 | msg_addr_lower;
+	aligned_offset = msg_addr_lower & (epc->mem->page_size - 1);
+	msg_addr = ((u64)msg_addr_upper) << 32 |
+			(msg_addr_lower & ~aligned_offset);
 	ret = dw_pcie_ep_map_addr(epc, func_no, ep->msi_mem_phys, msg_addr,
 				  epc->mem->page_size);
 	if (ret)
 		return ret;
 
-	writel(msg_data | (interrupt_num - 1), ep->msi_mem);
+	writel(msg_data | (interrupt_num - 1), ep->msi_mem + aligned_offset);
 
 	dw_pcie_ep_unmap_addr(epc, func_no, ep->msi_mem_phys);
 
-- 
2.17.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
