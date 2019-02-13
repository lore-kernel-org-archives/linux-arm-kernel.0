Return-Path: <SRS0=x1Tr=QU=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 795F2C282C2
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 13:29:25 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 463842075D
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 13:29:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="DDmGvpZE";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ti.com header.i=@ti.com header.b="rZdhw+Eh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 463842075D
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=6GO0yjZ8cZ2Wx4VE84hXKGXFPeYfokwU2Qu5wCTxNpA=; b=DDmGvpZEU4zdt2
	NBO4jp7SE9pOSrqBIvpMKIyhj3/j2oJlWQg+5DBQH0nVHpTFbfwec/rYl8OiSb2VYn6ljCwqmAYOY
	BqETUYRyAmISs0QP8i1DewfsUuwpTYYGs1vIQUjZgmKIzI36vv925Ltd5/aJ1LBklcrts88BN/jEB
	Qt7q5Z6io9CQbVa+PlFm2g/Os5Gb3EmA3hUf9j08x+mD90Y1HnelgW+GG6Gfaa6XZDswHkp2aP58T
	GHFmeJeSgS8sxU/7pmq7X0oJZUcDICzypjYdpUifDLCRqrTsOHyOCuHkFJSbvABO9/qt0zLeDRxo6
	mbvUxSAOuoaUeQGZ+cyQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gtubI-0006Gd-V2; Wed, 13 Feb 2019 13:29:20 +0000
Received: from fllv0016.ext.ti.com ([198.47.19.142])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gtuZq-0004Y9-B5
 for linux-arm-kernel@lists.infradead.org; Wed, 13 Feb 2019 13:28:11 +0000
Received: from fllv0034.itg.ti.com ([10.64.40.246])
 by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id x1DDRkXX061180;
 Wed, 13 Feb 2019 07:27:46 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1550064466;
 bh=fAqNlTR7cMaMsca9ZKERwJ2A9RfxaY/X8QU7ZLjB4i0=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=rZdhw+EhPKyWX24qFCHvmoYFj/8rTffUYzZZZ8RVfWPdiq7Z3H9tTEvhUz+ujTkq9
 fnXjggg0x9AQwsWJvhuYrCcdIAjh13bq2SrYEpmxnO6z8bgo2ZhgogTiRsHe0YBE6+
 1BZ2Fa8LQX5EEHEArar78OuqyC6o97ngv9NVtgKo=
Received: from DLEE105.ent.ti.com (dlee105.ent.ti.com [157.170.170.35])
 by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x1DDRkCf025618
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Wed, 13 Feb 2019 07:27:46 -0600
Received: from DLEE100.ent.ti.com (157.170.170.30) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Wed, 13
 Feb 2019 07:27:46 -0600
Received: from dlep32.itg.ti.com (157.170.170.100) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Wed, 13 Feb 2019 07:27:45 -0600
Received: from a0393678ub.india.ti.com (ileax41-snat.itg.ti.com
 [10.172.224.153])
 by dlep32.itg.ti.com (8.14.3/8.13.8) with ESMTP id x1DDRGZj016688;
 Wed, 13 Feb 2019 07:27:43 -0600
From: Kishon Vijay Abraham I <kishon@ti.com>
To: Murali Karicheri <m-karicheri2@ti.com>, Lorenzo Pieralisi
 <lorenzo.pieralisi@arm.com>
Subject: [PATCH v3 9/9] PCI: dwc: Do not write to MSI control registers if the
 platform doesn't use it
Date: Wed, 13 Feb 2019 18:56:29 +0530
Message-ID: <20190213132629.24790-10-kishon@ti.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190213132629.24790-1-kishon@ti.com>
References: <20190213132629.24790-1-kishon@ti.com>
MIME-Version: 1.0
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190213_052751_203021_F77FD4F9 
X-CRM114-Status: GOOD (  18.41  )
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

Platforms which populate msi_host_init, has it's own MSI controller
logic. Writing to MSI control registers on platforms which doesn't use
Designware's MSI controller logic might have side effects. To
be safe, do not write to MSI control registers if the platform uses
it's own MSI controller logic instead of Designware's MSI controller
logic.

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 .../pci/controller/dwc/pcie-designware-host.c | 24 ++++++++++---------
 1 file changed, 13 insertions(+), 11 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
index 781735f06dea..2bc2fd582124 100644
--- a/drivers/pci/controller/dwc/pcie-designware-host.c
+++ b/drivers/pci/controller/dwc/pcie-designware-host.c
@@ -641,17 +641,19 @@ void dw_pcie_setup_rc(struct pcie_port *pp)
 
 	dw_pcie_setup(pci);
 
-	num_ctrls = pp->num_vectors / MAX_MSI_IRQS_PER_CTRL;
-
-	/* Initialize IRQ Status array */
-	for (ctrl = 0; ctrl < num_ctrls; ctrl++) {
-		dw_pcie_wr_own_conf(pp, PCIE_MSI_INTR0_MASK +
-					(ctrl * MSI_REG_CTRL_BLOCK_SIZE),
-				    4, ~0);
-		dw_pcie_wr_own_conf(pp, PCIE_MSI_INTR0_ENABLE +
-					(ctrl * MSI_REG_CTRL_BLOCK_SIZE),
-				    4, ~0);
-		pp->irq_status[ctrl] = 0;
+	if (!pp->ops->msi_host_init) {
+		num_ctrls = pp->num_vectors / MAX_MSI_IRQS_PER_CTRL;
+
+		/* Initialize IRQ Status array */
+		for (ctrl = 0; ctrl < num_ctrls; ctrl++) {
+			dw_pcie_wr_own_conf(pp, PCIE_MSI_INTR0_MASK +
+					    (ctrl * MSI_REG_CTRL_BLOCK_SIZE),
+					    4, ~0);
+			dw_pcie_wr_own_conf(pp, PCIE_MSI_INTR0_ENABLE +
+					    (ctrl * MSI_REG_CTRL_BLOCK_SIZE),
+					    4, ~0);
+			pp->irq_status[ctrl] = 0;
+		}
 	}
 
 	/* Setup RC BARs */
-- 
2.17.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
