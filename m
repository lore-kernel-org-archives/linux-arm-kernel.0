Return-Path: <SRS0=b3e6=Q4=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C74ABC00319
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 10:18:39 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 955C421734
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 10:18:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="A6v006PW";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ti.com header.i=@ti.com header.b="kY1oPhmc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 955C421734
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=CThPtQD/rEWm7ElwtRDtZLbjvrBPgNYjUcTLdL6/ovs=; b=A6v006PWBYss8d
	R1b+/v6OPWUatNQjNyCz+IvRUxzmGpf2l47zIu3CYHnhQghSrQTT/Y+I0XDCr+Z8ZZDGOWeyBesHa
	oFup0kEnuq76f+5qZvVdnQCJf1ym2HDw7kQV33Pcz+BfOflBHRBrv2+kqPOsoYOKreqoLj57kR7dm
	VpnT4slKFO5IihIKq2z29a8VUXUThnBG+GC6i8h9dsEsSdyiRbc/ZxCcfb67zAGmq7nnsh2wz2GTS
	ofT05JMHs2gD7+UjMyr8zDFTRCxsBa1tQC4pI++OWKHGixlGrH/sbFI+/sH6hZTLrMe6IJnEFw0me
	aBcKAST491bSeim4eAcw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gwlR7-0003K8-K6; Thu, 21 Feb 2019 10:18:37 +0000
Received: from fllv0016.ext.ti.com ([198.47.19.142])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gwlR3-0003JS-7T
 for linux-arm-kernel@lists.infradead.org; Thu, 21 Feb 2019 10:18:35 +0000
Received: from lelv0265.itg.ti.com ([10.180.67.224])
 by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id x1LAIR21053057;
 Thu, 21 Feb 2019 04:18:27 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1550744307;
 bh=XY0f+fTB98q/vGndB90XrPK0wznd+QHF7jVR6uOp1Ls=;
 h=From:To:CC:Subject:Date;
 b=kY1oPhmcpsThndV6BEjaQ3rU523QrDPkvrHlgi145y0fGLbRX79tdsxp1cjGYjzSg
 Skcvdlor2g0OZuEF9pEQQMiBfQr9YI2Ncyt1QH3VLSMt/VmZvKzZh+tmOdnhMlNmhd
 MHEHha+UXiQ7pg9k1bXJIvFSYBeGTUvUVtIIAIH0=
Received: from DLEE103.ent.ti.com (dlee103.ent.ti.com [157.170.170.33])
 by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x1LAIR8C052436
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Thu, 21 Feb 2019 04:18:27 -0600
Received: from DLEE109.ent.ti.com (157.170.170.41) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Thu, 21
 Feb 2019 04:18:27 -0600
Received: from dlep32.itg.ti.com (157.170.170.100) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Thu, 21 Feb 2019 04:18:27 -0600
Received: from a0393678ub.india.ti.com (ileax41-snat.itg.ti.com
 [10.172.224.153])
 by dlep32.itg.ti.com (8.14.3/8.13.8) with ESMTP id x1LAIORF022198;
 Thu, 21 Feb 2019 04:18:24 -0600
From: Kishon Vijay Abraham I <kishon@ti.com>
To: Murali Karicheri <m-karicheri2@ti.com>, Lorenzo Pieralisi
 <lorenzo.pieralisi@arm.com>
Subject: [PATCH v4 0/9] PCI: DWC/Keystone: MSI configuration cleanup
Date: Thu, 21 Feb 2019 15:45:09 +0530
Message-ID: <20190221101518.22604-1-kishon@ti.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190221_021833_346898_CA53F11C 
X-CRM114-Status: GOOD (  15.63  )
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
Cc: Jingoo Han <jingoohan1@gmail.com>, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org, Kishon Vijay Abraham I <kishon@ti.com>,
 Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
 Bjorn Helgaas <bhelgaas@google.com>, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

This series tries to address the comments discussed in [1] w.r.t
removing Keystone specific callbacks defined in dw_pcie_host_ops.

This series also tries to cleanup the Keystone interrupt handling
part.

Changes from v3:
*) Uses hierarchy IRQ domain for legacy interrupts since there is 1:1
   mapping between legacy interrupt and GIC IRQ.
   (MSI still depends on the order of IRQs populated in dt).

Changes from v2:
*) Removed patch that modifies ks_pcie_legacy_irq_handler() to check the
   IRQ_STATUS of INTA/B/C/D. Lorenzo's comment to create a matrix
   LinuxIRQ x INTx will be added in AM654x PCIe support series
*) ks_pcie_legacy_irq_handler() is made to use hwirq to get IRQ offset
   instead of virq.
*) default msi_irq_chip is assigned in dw_pcie_host_init() once keystone
   assigns its msi_irq_chip
*) Fixed other minor comments from Lorenzo and Bjorn

Changes from v1:
*) Removed "PCI: keystone: Use "dummy_irq_chip" instead of new irqchip
for legacy interrupt handling" from the patch series. It should be
handled differently.

*) Added Gustavo's ACKed by and fixed a commit message.

[1] -> https://patchwork.kernel.org/patch/10681587/

Kishon Vijay Abraham I (9):
  PCI: keystone: Cleanup interrupt related macros
  PCI: keystone: Add separate functions for configuring MSI and legacy
    interrupt
  PCI: keystone: Convert to using hierarchy domain for legacy interrupts
  PCI: keystone: Use hwirq to get the MSI IRQ number offset
  PCI: keystone: Cleanup ks_pcie_msi_irq_handler
  PCI: dwc: Add support to use non default msi_irq_chip
  PCI: keystone: Use Keystone specific msi_irq_chip
  PCI: dwc: Remove Keystone specific dw_pcie_host_ops
  PCI: dwc: Do not write to MSI control registers if the platform
    doesn't use it

 drivers/pci/controller/dwc/pci-keystone.c     | 520 ++++++++++--------
 .../pci/controller/dwc/pcie-designware-host.c |  78 +--
 drivers/pci/controller/dwc/pcie-designware.h  |   6 +-
 3 files changed, 326 insertions(+), 278 deletions(-)

-- 
2.17.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
