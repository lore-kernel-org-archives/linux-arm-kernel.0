Return-Path: <SRS0=baBj=PW=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C720EC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 11:16:06 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8FE5420656
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 11:16:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="e2NGDFQW";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ti.com header.i=@ti.com header.b="EBie1+GM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8FE5420656
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=eF0g6UttY+96XlRKSAGiw8ng3Zbx7H+tRIFhmXjBVek=; b=e2NGDFQWLLI6vA
	A2oAUIRH/m6AWVvG8ZYkP42Nmr3jAp1Gsh8BDwJk2StnHu8UMHmnDOdGkNXW4bGSSwB+zr8AQuQKv
	aGA5Vq4lh5Uux5zPt1Ze8t8VLbfT43N7ZVxgwWY4H8IF3MaVtDMzqNtCFUjY2mZknMijYFAzQcyoV
	eZO5UdyRteX2AD7SbLsZK8+KejcisO2CROIj43dZgJDxVCDYAcg9llvOCpXKCDXh6793Qa4GyYN/F
	3ThG6QEyvBgPFX+UsoLANVgoHYHZ6WWtsxxw/xtC0g2OxDiBH+nw7nzYQWeNxOMtcNGWvB9cYjsVI
	HPouP7zxWebZNbiiwPtg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gj0Dp-0008HL-Or; Mon, 14 Jan 2019 11:16:01 +0000
Received: from lelv0142.ext.ti.com ([198.47.23.249])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gj0Dl-0008CW-D0; Mon, 14 Jan 2019 11:15:59 +0000
Received: from lelv0266.itg.ti.com ([10.180.67.225])
 by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id x0EBFiPr003493;
 Mon, 14 Jan 2019 05:15:44 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1547464544;
 bh=kLFHj4SNhOT+xMkxBI11CYXblcxbKAAnFAdH+K5G6Pc=;
 h=From:To:CC:Subject:Date;
 b=EBie1+GMKLiveP2DtVf3fbQrtP/s6BZCzo1XPrGHqraiAEX2ApHGZmlMlzVZzfbJK
 40E3oEiB6hgB1D1GG/43bLVtV7ImUQw2p4YkgArQI1e8G3/AQn+S2ePW1r0/tFfSPu
 s0MQAoQNrbZ8qbjMouAAcsmS3rssI//AHPoQJEq8=
Received: from DLEE105.ent.ti.com (dlee105.ent.ti.com [157.170.170.35])
 by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x0EBFivY023472
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Mon, 14 Jan 2019 05:15:44 -0600
Received: from DLEE104.ent.ti.com (157.170.170.34) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Mon, 14
 Jan 2019 05:15:43 -0600
Received: from dflp32.itg.ti.com (10.64.6.15) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Mon, 14 Jan 2019 05:15:43 -0600
Received: from a0393678ub.india.ti.com (ileax41-snat.itg.ti.com
 [10.172.224.153])
 by dflp32.itg.ti.com (8.14.3/8.13.8) with ESMTP id x0EBFd1S011560;
 Mon, 14 Jan 2019 05:15:40 -0600
From: Kishon Vijay Abraham I <kishon@ti.com>
To: Kishon Vijay Abraham I <kishon@ti.com>, Lorenzo Pieralisi
 <lorenzo.pieralisi@arm.com>, Gustavo Pimentel
 <gustavo.pimentel@synopsys.com>, Alan Douglas <adouglas@cadence.com>, Shawn
 Lin <shawn.lin@rock-chips.com>, Heiko Stuebner <heiko@sntech.de>
Subject: [PATCH v2 00/15] PCI: endpoint: Cleanup EPC features
Date: Mon, 14 Jan 2019 16:44:58 +0530
Message-ID: <20190114111513.21618-1-kishon@ti.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190114_031557_576370_853241A9 
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
Cc: Jingoo Han <jingoohan1@gmail.com>, linux-kernel@vger.kernel.org,
 linux-rockchip@lists.infradead.org, linux-pci@vger.kernel.org,
 Bjorn Helgaas <bhelgaas@google.com>, linux-omap@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi Lorenzo,

The Endpoint controller driver uses features member in 'struct pci_epc'
to advertise the list of supported features to the endpoint function
driver.

There are a few shortcomings with this approach.
  *) Certain endpoint controllers support fixed size BAR (e.g. TI's
     AM654 uses Designware configuration with fixed size BAR). The
     size of each BARs cannot be passed to the endpoint function
     driver.
  *) Too many macros for handling EPC features.
     (EPC_FEATURE_NO_LINKUP_NOTIFIER, EPC_FEATURE_BAR_MASK,
      EPC_FEATURE_MSIX_AVAILABLE, EPC_FEATURE_SET_BAR,
      EPC_FEATURE_GET_BAR)
  *) Endpoint controllers are directly modifying struct pci_epc
     members. (I have plans to move struct pci_epc to
     drivers/pci/endpoint so that pci_epc members are referenced
     only by endpoint core).

To overcome the above shortcomings, introduced pci_epc_get_features()
API, pci_epc_features structure and a ->get_features() callback.

Also added a patch to set BAR flags in pci_epf_alloc_space and
remove it from pci-epf-test function driver.

Changes from v1:
*) Fixed helper function to return '0' (or BAR_0) for any incorrect
   values in reserved BAR.
*) Do not set_bar or alloc space for BARs if the BARs are reserved
*) Fix incorrect check of epc_features in pci_epf_test_bind

Tested on TI's DRA7xx platform and AM654 platform. Support for PCIe
in AM654 platform will be posted shortly.

Kishon Vijay Abraham I (15):
  PCI: endpoint: Add new pci_epc_ops to get EPC features
  PCI: dwc: Add ->get_features() callback function in dw_pcie_ep_ops
  PCI: designware-plat: Populate ->get_features() dw_pcie_ep_ops
  PCI: pci-dra7xx: Populate ->get_features() dw_pcie_ep_ops
  PCI: rockchip: Populate ->get_features() dw_pcie_ep_ops
  PCI: cadence: Populate ->get_features() cdns_pcie_epc_ops
  PCI: endpoint: Add helper to get first unreserved BAR
  PCI: endpoint: Fix pci_epf_alloc_space to set correct MEM TYPE flags
  PCI: pci-epf-test: Remove setting epf_bar flags in function driver
  PCI: pci-epf-test: Do not allocate next BARs memory if current BAR is
    64Bit
  PCI: pci-epf-test: Use pci_epc_get_features to get EPC features
  PCI: cadence: Remove pci_epf_linkup from Cadence EP driver
  PCI: rockchip: Remove pci_epf_linkup from Rockchip EP driver
  PCI: designware-plat: Remove setting epc->features in Designware plat
    EP driver
  PCI: endpoint: Remove features member in struct pci_epc

 drivers/pci/controller/dwc/pci-dra7xx.c       | 13 +++
 .../pci/controller/dwc/pcie-designware-ep.c   | 12 +++
 .../pci/controller/dwc/pcie-designware-plat.c | 17 +++-
 drivers/pci/controller/dwc/pcie-designware.h  |  1 +
 drivers/pci/controller/pcie-cadence-ep.c      | 25 ++---
 drivers/pci/controller/pcie-rockchip-ep.c     | 16 +++-
 drivers/pci/endpoint/functions/pci-epf-test.c | 93 ++++++++++++-------
 drivers/pci/endpoint/pci-epc-core.c           | 53 +++++++++++
 drivers/pci/endpoint/pci-epf-core.c           |  4 +-
 include/linux/pci-epc.h                       | 31 +++++--
 10 files changed, 201 insertions(+), 64 deletions(-)

-- 
2.17.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
