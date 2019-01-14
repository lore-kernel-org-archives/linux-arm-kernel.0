Return-Path: <SRS0=baBj=PW=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6FD9C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 13:25:15 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B02EF20659
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 13:25:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="vAKcosl1";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ti.com header.i=@ti.com header.b="wZ+nNZnA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B02EF20659
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=ay593boQKT8/C2XREP0k1uV0LvwliFL+nmjdfB0VZVU=; b=vAKcosl10oGAEX
	+Cslbvs00BIgaJjzywdWMsvIUCSoaqfVBlB7ZGQ/6rMO0DldLg8J3icwKOJs3Q9/yjW1e1deHsmXr
	yNEJpPlWYMsDASURqvNPvTakdzp2GYh4uFq3GS4PwvIvbVJCO4p4cxYK24KJyPaKrcjeI4ZC9qpbg
	Ppjq/o8TKtWc+J3lHW3UVfWFgvpKwEBABM4xO7OkZ09m4JWGeuRsJ9ywdazepsSWOL/hFutYoMwwj
	q7IzRnNxwu2Q6THRUrsMWG+HUJBGTyOh039tJYVx3qznsHBqp6K+hGlupCBZiHFjwv5xWGHMsjWC9
	NV4AAljZ2KssZxEqZdiA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gj2Ep-0003EN-Tb; Mon, 14 Jan 2019 13:25:11 +0000
Received: from lelv0142.ext.ti.com ([198.47.23.249])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gj2Em-0002rn-6H
 for linux-arm-kernel@lists.infradead.org; Mon, 14 Jan 2019 13:25:10 +0000
Received: from lelv0265.itg.ti.com ([10.180.67.224])
 by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id x0EDOuS2041042;
 Mon, 14 Jan 2019 07:24:56 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1547472296;
 bh=Pe22Tq67JuwkZ4HI9R0wNt+HBA7RzmUCpXtDqdHv2bw=;
 h=From:To:CC:Subject:Date;
 b=wZ+nNZnAR1w7wSCItLPm6pcHNjNv+3scvGAoPAJRswnv8FsgFpIMbnDuaFhQvN0jf
 3xeNwczfp8wq62qWW4WN0NjbfcJDRYaaenLhO3S/Pm3qmJmSNCgL+bbRYOjmhYD51X
 jkY3xmccSNQQfwt6sMvianNMNB6CGC5bMsz7eQy8=
Received: from DFLE113.ent.ti.com (dfle113.ent.ti.com [10.64.6.34])
 by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x0EDOupT093509
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Mon, 14 Jan 2019 07:24:56 -0600
Received: from DFLE104.ent.ti.com (10.64.6.25) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Mon, 14
 Jan 2019 07:24:56 -0600
Received: from dlep32.itg.ti.com (157.170.170.100) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Mon, 14 Jan 2019 07:24:55 -0600
Received: from a0393678ub.india.ti.com (ileax41-snat.itg.ti.com
 [10.172.224.153])
 by dlep32.itg.ti.com (8.14.3/8.13.8) with ESMTP id x0EDOoWM028516;
 Mon, 14 Jan 2019 07:24:51 -0600
From: Kishon Vijay Abraham I <kishon@ti.com>
To: Gustavo Pimentel <gustavo.pimentel@synopsys.com>, Rob Herring
 <robh+dt@kernel.org>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Subject: [PATCH 00/24] Add support for PCIe RC and EP mode in TI's AM654 SoC
Date: Mon, 14 Jan 2019 18:54:00 +0530
Message-ID: <20190114132424.6445-1-kishon@ti.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190114_052508_341353_0F7B978F 
X-CRM114-Status: GOOD (  16.52  )
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

Add PCIe RC support for TI's AM654 SoC. The PCIe controller in AM654
uses Synopsys core revision 4.90a and uses the same TI wrapper as used
in keystone2 with certain modification. Hence AM654 will use the same
pci wrapper driver pci-keystone.c

This series was initially part of [1]. This series only includes patches
that has to be merged via Lorenzo's tree. The PHY patches and dt patches
will be sent separately.

This series is created over my keystone MSI cleanup series [2] and EPC
features series [3].

This series:
*) Cleanup pci-keystone driver so that both RC mode and EP mode of
   AM654 can be supported
*) Modify epc-core to support allocation of aligned buffers required for
   AM654
*) Fix ATU unroll identification
*) Add support for both host mode and device mode in AM654    

[1] -> https://lore.kernel.org/patchwork/cover/989487/
[2] -> https://www.mail-archive.com/linux-kernel@vger.kernel.org/msg1883081.html
[3] -> https://www.mail-archive.com/linux-kernel@vger.kernel.org/msg1899011.html

Kishon Vijay Abraham I (24):
  PCI: keystone: Add start_link/stop_link dw_pcie_ops
  PCI: keystone: Cleanup error_irq configuration
  dt-bindings: PCI: keystone: Add "reg-names" binding information
  PCI: keystone: Perform host initialization in a single function
  PCI: keystone: Use platform_get_resource_byname to get memory
    resources
  PCI: keystone: Move initializations to appropriate places
  dt-bindings: PCI: Add dt-binding to configure PCIe mode
  PCI: keystone: Explicitly set the PCIe mode
  dt-bindings: PCI: Document "atu" reg-names
  PCI: dwc: Enable iATU unroll for endpoint too
  PCI: dwc: Fix ATU identification for designware version >= 4.80
  PCI: keystone: Prevent ARM32 specific code to be compiled for ARM64
  dt-bindings: PCI: Add PCI RC dt binding documentation for AM654
  PCI: keystone: Add support for PCIe RC in AM654x Platforms
  PCI: keystone: Invoke phy_reset API before enabling PHY
  PCI: endpoint: Add support to allocate aligned buffers to be mapped in
    BARs
  PCI: dwc: Add const qualifier to struct dw_pcie_ep_ops
  PCI: dwc: Fix dw_pcie_ep_find_capability to return correct capability
    offset
  PCI: dwc: Add callbacks for accessing dbi2 address space
  PCI: keystone: Add support for PCIe EP in AM654x Platforms
  PCI: designware-ep: Configure RESBAR to advertise the smallest size
  PCI: designware-ep: Use aligned ATU window for raising MSI interrupts
  misc: pci_endpoint_test: Add support to test PCI EP in AM654x
  misc: pci_endpoint_test: Fix test_reg_bar to be updated in
    pci_endpoint_test

 .../bindings/pci/designware-pcie.txt          |   7 +-
 .../devicetree/bindings/pci/pci-keystone.txt  |  14 +-
 drivers/misc/pci_endpoint_test.c              |  17 +
 drivers/pci/controller/dwc/Kconfig            |  25 +-
 drivers/pci/controller/dwc/pci-dra7xx.c       |   2 +-
 drivers/pci/controller/dwc/pci-keystone.c     | 505 ++++++++++++++----
 drivers/pci/controller/dwc/pcie-artpec6.c     |   2 +-
 .../pci/controller/dwc/pcie-designware-ep.c   |  55 +-
 .../pci/controller/dwc/pcie-designware-host.c |  19 -
 .../pci/controller/dwc/pcie-designware-plat.c |   2 +-
 drivers/pci/controller/dwc/pcie-designware.c  |  52 ++
 drivers/pci/controller/dwc/pcie-designware.h  |  15 +-
 drivers/pci/endpoint/functions/pci-epf-test.c |   5 +-
 drivers/pci/endpoint/pci-epf-core.c           |  10 +-
 include/linux/pci-epc.h                       |   2 +
 include/linux/pci-epf.h                       |   3 +-
 16 files changed, 587 insertions(+), 148 deletions(-)

-- 
2.17.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
