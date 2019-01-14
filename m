Return-Path: <SRS0=baBj=PW=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16741C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 13:43:42 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CB77A206B7
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 13:43:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="TkbAL11q";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="mx/B6vsF";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ti.com header.i=@ti.com header.b="oQwcW9+v"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CB77A206B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=8E/3SiGpFWbQfS7gG+VYGm8KyVBKClU+nHjLt71iXOQ=; b=TkbAL11qmt0s4x
	t3ARBO9fM9DPA+G2G489zwfkjIBdbiWPxNQdk9wUGsvPwONBfHFHnOtfOkPb7C+aDge0echra5ZrB
	akbRJM4yM0npuaYrXx85Us8dBWWEeUi4GxllfEHYAyPP1CR0rS0mNmVXck1H6xHrZOqpn2tNdF464
	/Db0htbexOg7HzSPqVH9rhEiJYBy1KDlB1BwdbUPUM+3NqAu2INlSuU86MD1yZY2A3X+eUD5ZLJ14
	5+s4wAvEqSphLzapO3IVo8hjkKyeSZJC+zQIOT00j2s1etaow50ils1wUuBi0eEzzL/CgicnqRjCA
	SQXumDILkluBrQo89PEw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gj2We-0006fw-5P; Mon, 14 Jan 2019 13:43:36 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gj2WE-00065o-Ew
 for linux-arm-kernel@bombadil.infradead.org; Mon, 14 Jan 2019 13:43:10 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:CC:To:From:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=GogJmhPjCHQln5mVKUVQZbQ+wSVFSwsYqqaCZro7fL4=; b=mx/B6vsFP0CVMH4WcMh2Ixky3
 e0ZS348h0mwRs3bz7TubcAeZIyoGRYLOLJIT0/l+56TK48n/kVRMwJEFTgjs/3tc/eJsTPTzre3Uv
 S80/OkM+Mk6RJgA9+TCfBm/MuQfWe1omP8tSJKHY1YJPuUrZDC5nWY85l1Hj3ffusMd7vAmWIaN3C
 5HhdJ2Q2DMR+Mk6IjM56IxnKiGnA7mw3mvPi2X7uGUXUgeL+4jzaZPZxJ8+jdYNF4Gsw6NUhwxVM9
 tTbADLj/JWnBaemf8Wn+YZqBWL0ArZ1nKDyRxfOQ7Iu9GkAE3v3G+laQgIJFb6n1E0LYqaEhQfrnH
 R6+X89EJg==;
Received: from fllv0016.ext.ti.com ([198.47.19.142])
 by casper.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gj2Fk-0000mk-53
 for linux-arm-kernel@lists.infradead.org; Mon, 14 Jan 2019 13:26:10 +0000
Received: from fllv0035.itg.ti.com ([10.64.41.0])
 by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id x0EDPs7b098170;
 Mon, 14 Jan 2019 07:25:54 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1547472354;
 bh=GogJmhPjCHQln5mVKUVQZbQ+wSVFSwsYqqaCZro7fL4=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=oQwcW9+vGGXoQFzkFFMkyS+/zrvRPAh6e8C6iKuoM321++ugdV9tsIdhwMx4bUefT
 q2c6YRMMK5tmUormImD1GnWa5OSED4Q1P9ROShpg0uhaRBPXB2zI1b+ETJyqCPIlw0
 eOOzcDA/5QjxHbYmskQxV04UEJWa8F7ohOM13sac=
Received: from DLEE109.ent.ti.com (dlee109.ent.ti.com [157.170.170.41])
 by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x0EDPsSB088982
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Mon, 14 Jan 2019 07:25:54 -0600
Received: from DLEE100.ent.ti.com (157.170.170.30) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Mon, 14
 Jan 2019 07:25:54 -0600
Received: from dlep32.itg.ti.com (157.170.170.100) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Mon, 14 Jan 2019 07:25:54 -0600
Received: from a0393678ub.india.ti.com (ileax41-snat.itg.ti.com
 [10.172.224.153])
 by dlep32.itg.ti.com (8.14.3/8.13.8) with ESMTP id x0EDOoWY028516;
 Mon, 14 Jan 2019 07:25:49 -0600
From: Kishon Vijay Abraham I <kishon@ti.com>
To: Gustavo Pimentel <gustavo.pimentel@synopsys.com>, Rob Herring
 <robh+dt@kernel.org>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Subject: [PATCH 12/24] PCI: keystone: Prevent ARM32 specific code to be
 compiled for ARM64
Date: Mon, 14 Jan 2019 18:54:12 +0530
Message-ID: <20190114132424.6445-13-kishon@ti.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190114132424.6445-1-kishon@ti.com>
References: <20190114132424.6445-1-kishon@ti.com>
MIME-Version: 1.0
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190114_132608_417338_6C3100FB 
X-CRM114-Status: GOOD (  10.96  )
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

hook_fault_code is an ARM32 specific API for hooking into data abort.
Since pci-keystone.c will be used for AM65X platforms which is an
ARM64 platform, allow hook_fault_code to be compiled only for ARM32.

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 drivers/pci/controller/dwc/pci-keystone.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/pci/controller/dwc/pci-keystone.c b/drivers/pci/controller/dwc/pci-keystone.c
index d1ecf826dfe8..9d7cedd96505 100644
--- a/drivers/pci/controller/dwc/pci-keystone.c
+++ b/drivers/pci/controller/dwc/pci-keystone.c
@@ -693,6 +693,7 @@ static int ks_pcie_config_legacy_irq(struct keystone_pcie *ks_pcie)
 	return ret;
 }
 
+#ifdef CONFIG_ARM
 /*
  * When a PCI device does not exist during config cycles, keystone host gets a
  * bus error instead of returning 0xffffffff. This handler always returns 0
@@ -712,6 +713,7 @@ static int ks_pcie_fault(unsigned long addr, unsigned int fsr,
 
 	return 0;
 }
+#endif
 
 static int __init ks_pcie_init_id(struct keystone_pcie *ks_pcie)
 {
@@ -761,12 +763,14 @@ static int __init ks_pcie_host_init(struct pcie_port *pp)
 	if (ret < 0)
 		return ret;
 
+#ifdef CONFIG_ARM
 	/*
 	 * PCIe access errors that result into OCP errors are caught by ARM as
 	 * "External aborts"
 	 */
 	hook_fault_code(17, ks_pcie_fault, SIGBUS, 0,
 			"Asynchronous external abort");
+#endif
 
 	ks_pcie_start_link(pci);
 	dw_pcie_wait_for_link(pci);
-- 
2.17.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
