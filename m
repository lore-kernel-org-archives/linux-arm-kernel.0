Return-Path: <SRS0=txfi=PP=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 618BEC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 06:45:53 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 137422085A
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 06:45:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="R/CboGAn";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="m85auXuT";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ti.com header.i=@ti.com header.b="XiWur7WD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 137422085A
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=CuvIHYeZd47+HUT213wdgZQ4lQeIcVYLxfOH4OPOKts=; b=R/CboGAn9PwWTi
	UuQV9Ma56yVPJWxYPwZOFbbRBEOQCbMDMbEW7EiuL9P08BjUVatj5CGzozRhX/my5yLVgCfX3xwMu
	j4qB18UTgfnU89k9xDI0RuAdFtk4vfOjktH/FnX404ZfOtIxUJE2a89y5DgJM12fNypobZiuQKIh6
	YVp4SRjSRNY0uFze67rDuylRixUuITju0EoJhseLvViFdYFxOsuKLvyB9VR++Kz6kHsTzM+1QiaNy
	3zB5QOcuhwYClzb7RDmneYeeHQG+nD8HOm7rkiBJK6s6tvJTRM2s5/6VQ8qgVO/p9crOBrxcB60du
	rZgYfFaxBIaBsIVWujEw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1ggOfV-0006hu-MK; Mon, 07 Jan 2019 06:45:49 +0000
Received: from merlin.infradead.org ([2001:8b0:10b:1231::1])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1ggOdh-0003VK-CR; Mon, 07 Jan 2019 06:43:57 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=merlin.20170209; h=Content-Type:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:CC:To:From:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=XoRGeo3vT25+3Bl/ejetLFYJrvBGa4ChLOy2A0kveqs=; b=m85auXuTDjq+mdh5WShuOeKI0
 +4RILYC7DkKxVU/5oDkQRE6xHjjTy16r5jmjsh67HIZdr+YS2U6NZSR3WjBhL0nDgxUI7MmTFDbcI
 Oilx/1euvStD3LRRh/Y+A8XpmuqNJIhQZ6psZmw49Fw4GE0Lx8RuUftAgT+FeYDBsVESnGtBcN5sw
 QryMQVqJmvPAjXpudkgDdUApQjr7JwJiQDKLLD4TEV0mjVW0P3mXEcb4aWTRDV97UoD4hc9BsCI1Y
 DU6IspZy9d45NdmBK5Y6X6l8m9BZa2Iir6ooDbUcElaQDDZDUrsy/5BJorBfq1iy8NpWEOeipwayd
 WGV0vnU1g==;
Received: from lelv0142.ext.ti.com ([198.47.23.249])
 by merlin.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1ggOda-0002Bf-Ex; Mon, 07 Jan 2019 06:43:51 +0000
Received: from fllv0035.itg.ti.com ([10.64.41.0])
 by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id x076hh6r079970;
 Mon, 7 Jan 2019 00:43:43 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1546843423;
 bh=XoRGeo3vT25+3Bl/ejetLFYJrvBGa4ChLOy2A0kveqs=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=XiWur7WDaQZIiey8EGxQN0w+n2AQGBjeDN5eWhhbpW4PjmMnjI2Fm1C9w7AabmkdX
 7nZnd2yeVgbNnHuhd3fUju3vIznMhj1mFzRsX2HqumwwWndvTLzz9vKAIsemPJb/9Y
 /+v5CGv42F55AZ8BbFXHIh58J9m7mOS/AlFoFwJY=
Received: from DFLE103.ent.ti.com (dfle103.ent.ti.com [10.64.6.24])
 by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x076hh55038785
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Mon, 7 Jan 2019 00:43:43 -0600
Received: from DFLE104.ent.ti.com (10.64.6.25) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Mon, 7
 Jan 2019 00:43:43 -0600
Received: from dflp32.itg.ti.com (10.64.6.15) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Mon, 7 Jan 2019 00:43:43 -0600
Received: from a0393678ub.india.ti.com (ileax41-snat.itg.ti.com
 [10.172.224.153])
 by dflp32.itg.ti.com (8.14.3/8.13.8) with ESMTP id x076gfoA002672;
 Mon, 7 Jan 2019 00:43:39 -0600
From: Kishon Vijay Abraham I <kishon@ti.com>
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Bjorn Helgaas
 <bhelgaas@google.com>, Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
 Alan Douglas <adouglas@cadence.com>, Shawn Lin <shawn.lin@rock-chips.com>
Subject: [PATCH 13/15] PCI: rockchip: Remove pci_epf_linkup from Rockchip EP
 driver
Date: Mon, 7 Jan 2019 12:11:46 +0530
Message-ID: <20190107064148.10152-14-kishon@ti.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190107064148.10152-1-kishon@ti.com>
References: <20190107064148.10152-1-kishon@ti.com>
MIME-Version: 1.0
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190107_014350_638815_41066317 
X-CRM114-Status: UNSURE (   8.66  )
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

pci_epf_linkup is intended to be invoked if the EPC supports linkup
notification. Now that pci-epf-test uses get_features callback, which
indicates Rockchip EP driver doesn't support linkup notification, remove
pci_epf_linkup from Rockchip EP driver.

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 drivers/pci/controller/pcie-rockchip-ep.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/pci/controller/pcie-rockchip-ep.c b/drivers/pci/controller/pcie-rockchip-ep.c
index 9b60ad323ac7..a5d799e2dff2 100644
--- a/drivers/pci/controller/pcie-rockchip-ep.c
+++ b/drivers/pci/controller/pcie-rockchip-ep.c
@@ -499,9 +499,6 @@ static int rockchip_pcie_ep_start(struct pci_epc *epc)
 
 	rockchip_pcie_write(rockchip, cfg, PCIE_CORE_PHY_FUNC_CFG);
 
-	list_for_each_entry(epf, &epc->pci_epf, list)
-		pci_epf_linkup(epf);
-
 	return 0;
 }
 
-- 
2.17.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
