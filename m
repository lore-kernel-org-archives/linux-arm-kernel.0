Return-Path: <SRS0=AchV=O4=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39E9FC43444
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 12:43:37 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 091C221479
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 12:43:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Jkmcetsj";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ti.com header.i=@ti.com header.b="g0Fi3ZKS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 091C221479
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=L1AJ40zUDkHCbisUYSZNrJClxZg6smfV9ecsB7hkqlM=; b=JkmcetsjJB3FZi
	zS1wTadb4c2g79O7v1WsiIzarom4qx74z8Ceal6gfAyriDWhKMEmBNHOyAPjk7NsvGuINvRyLrDUs
	e0+WMZXCQRYl+43K23dEW7KOQFmMJgCKy00S2uYbpDhR7DEVpsVnwOtgP0U2GbBqriGJubrZiliZq
	9pOhufkmMFa1BkAiTLNZ4SR5uR1at0dHBOanKJPAUE9F0LWscpQl7fZaTXp0SQSxugWRK9MR1zQdU
	/Iko6h3gZK4FpHMieEJPI3dU7Oyn7BbR73pyJfOcVb+9KvuRgbgeNRabVgAGIolP8nPMXnGfqXuYS
	aXbATWbjZ/y19xwfiyJA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gZbCF-0008Rq-28; Wed, 19 Dec 2018 12:43:31 +0000
Received: from fllv0016.ext.ti.com ([198.47.19.142])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gZbBT-0007mK-4C
 for linux-arm-kernel@lists.infradead.org; Wed, 19 Dec 2018 12:42:46 +0000
Received: from fllv0034.itg.ti.com ([10.64.40.246])
 by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id wBJCgRoW098469;
 Wed, 19 Dec 2018 06:42:27 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1545223347;
 bh=ntB2uFsyMBHZPCpgx4HnKiiswphQJGAQnVKIDyF6dCA=;
 h=From:To:CC:Subject:Date;
 b=g0Fi3ZKSbg9hTomM+QU0puxk7uTq2SHgltNo+iXMWbgmkZmDOfebDtBb3N8gBqCSO
 e3JqiQ/pjGvxXR6yenXjxlGFxOFZmtfHsW5tYkTxrJQh2YljuJawhoSVivINH5lchF
 fKw6e+fYt1sH2tnM4budtB6zURWE+Gcp5CWYLN0Q=
Received: from DFLE102.ent.ti.com (dfle102.ent.ti.com [10.64.6.23])
 by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id wBJCgReL051505
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Wed, 19 Dec 2018 06:42:27 -0600
Received: from DFLE110.ent.ti.com (10.64.6.31) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Wed, 19
 Dec 2018 06:42:27 -0600
Received: from dlep32.itg.ti.com (157.170.170.100) by DFLE110.ent.ti.com
 (10.64.6.31) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Wed, 19 Dec 2018 06:42:27 -0600
Received: from a0393678ub.india.ti.com (ileax41-snat.itg.ti.com
 [10.172.224.153])
 by dlep32.itg.ti.com (8.14.3/8.13.8) with ESMTP id wBJCgNZj003940;
 Wed, 19 Dec 2018 06:42:24 -0600
From: Kishon Vijay Abraham I <kishon@ti.com>
To: Murali Karicheri <m-karicheri2@ti.com>, Lorenzo Pieralisi
 <lorenzo.pieralisi@arm.com>, Gustavo Pimentel
 <gustavo.pimentel@synopsys.com>, Marc Zyngier <marc.zyngier@arm.com>
Subject: [PATCH 00/10] PCI: DWC/Keystone: MSI configuration cleanup
Date: Wed, 19 Dec 2018 18:11:57 +0530
Message-ID: <20181219124207.13479-1-kishon@ti.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181219_044243_251787_BC012B09 
X-CRM114-Status: GOOD (  17.29  )
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
 kishon@ti.com, linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

This series tries to address the comments discussed in [1] w.r.t
removing Keystone specific callbacks defined in dw_pcie_host_ops.

This series also tries to cleanup the Keystone interrupt handling
part.

This series is created on top of
git://git.kernel.org/pub/scm/linux/kernel/git/lpieralisi/pci.git
pci/dwc-msi

Tested on K2G (had to use out of tree SERDES patches). Also tested on
dra7xx to make sure there are no regressions.

[1] ->  https://patchwork.kernel.org/patch/10681587/

Kishon Vijay Abraham I (10):
  PCI: keystone: Cleanup interrupt related macros
  PCI: keystone: Use "dummy_irq_chip" instead of new irqchip for legacy
    interrupt handling
  PCI: keystone: Modify legacy_irq_handler to check the IRQ_STATUS of
    INTA/B/C/D
  PCI: keystone: Add separate functions for configuring MSI and legacy
    interrupt
  PCI: keystone: Use hwirq to get the IRQ number offset
  PCI: keystone: Cleanup ks_pcie_msi_irq_handler and
    ks_pcie_legacy_irq_handler
  PCI: dwc: Add support to use non default msi_irq_chip
  PCI: keystone: Use Keystone specific msi_irq_chip
  PCI: dwc: Remove Keystone specific dw_pcie_host_ops
  PCI: dwc: Do not write to MSI control registers if the platform
    doesn't use it

 drivers/pci/controller/dwc/pci-keystone.c     | 430 +++++++++---------
 .../pci/controller/dwc/pcie-designware-host.c |  74 ++-
 drivers/pci/controller/dwc/pcie-designware.h  |   6 +-
 3 files changed, 258 insertions(+), 252 deletions(-)

-- 
2.17.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
