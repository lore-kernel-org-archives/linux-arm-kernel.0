Return-Path: <SRS0=baBj=PW=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C64CC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 14:11:34 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0BFE720657
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 14:11:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="GYhoNSNF";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="YNnqtuHN";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ti.com header.i=@ti.com header.b="UexewYwf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0BFE720657
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=smBXniiOrKbcegnR0pQ0XQ/jkN3944w1KKBkRYRQVLA=; b=GYhoNSNFyPLNZt
	pycFK0AMjDOBCKAwZZY63Pv3LqBK66huMQN0YvIsJ3SqxYnspMheYE9tR7i07/aWMiJThtlulDry6
	csrbgQQ76RMqoNXsa3g1RBo0mADnWwust4GvNpg4ZJiAjf7PZhRN6UE9kJwmGPSWMMCIYaWFVWk0E
	uhEjT/tMGGKKX/CtGnmq24lZiLN2CDRI9bu7vhq3zfeLbapNEhbFGP1mMdyCwIay0rBIE6nDrjDW8
	bkj6/tekcVxlvXtD/3QAlu61epXZUDnpCr+myeraQiDtQ02lnc3ivlfB7EEIH1Zs4m9rb7A2uDGCK
	AuZ9lpLubxHPU7k0sObg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gj2xd-0001Ej-MG; Mon, 14 Jan 2019 14:11:29 +0000
Received: from merlin.infradead.org ([2001:8b0:10b:1231::1])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gj2wx-0000Zz-Ro
 for linux-arm-kernel@bombadil.infradead.org; Mon, 14 Jan 2019 14:10:47 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=merlin.20170209; h=Content-Type:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:CC:To:From:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=5utE+jodqQLD4g3Pt/AHbdOGuOmz2jyxoVSY0CpmSSw=; b=YNnqtuHNJ5Q1VJO1Ga/gwX5x0
 5F7PDdoTq6cTgngc7RqtcliGGHkFaROsIuHto3PWhGiUUnTcA35zxToua360+Z0VROh9wcdb2HO6c
 i/uJEAGct0AOvfHfyL2MjL9hK4fNb5B2svXpTybJQetjefa5tVYeMJOR+Tpv0Z7Z+OK43T+P60Zn4
 lYgrPakhBZIBC7G+94BUmW/3Nv7wDjmsHeUJdhBQ2H+y48RsiAkC/nl9KpyTZsK30Q4dK0gZSt/Ev
 i/aueAPEvGy9cS23nj0SFvQPEE8rDArjQ4fOgXWN1ZZ1v3FUXEECJ3ahOkcqklZozyYWcAsRIjwaY
 1uCVOqQGw==;
Received: from fllv0015.ext.ti.com ([198.47.19.141])
 by merlin.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gj2Fd-0005Cq-Sr
 for linux-arm-kernel@lists.infradead.org; Mon, 14 Jan 2019 13:26:02 +0000
Received: from fllv0034.itg.ti.com ([10.64.40.246])
 by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id x0EDPnhR106834;
 Mon, 14 Jan 2019 07:25:49 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1547472349;
 bh=5utE+jodqQLD4g3Pt/AHbdOGuOmz2jyxoVSY0CpmSSw=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=UexewYwfuHEcVRAYewKVPjpC+xxXDwqrCAqKCw2vcqt+sYJbM3lXDUeDwjzaBiHj4
 xHIARdb88JXKBTTT7SDOg9wTmLF064a9xEsmWqcc19strsqiLYZN2GzkuEVrSz87fi
 WeLKtMV7pt4he7NC1pcJ+oJAsAa8fQetoWk7xtaY=
Received: from DLEE109.ent.ti.com (dlee109.ent.ti.com [157.170.170.41])
 by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x0EDPnqL056742
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Mon, 14 Jan 2019 07:25:49 -0600
Received: from DLEE110.ent.ti.com (157.170.170.21) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Mon, 14
 Jan 2019 07:25:49 -0600
Received: from dlep32.itg.ti.com (157.170.170.100) by DLEE110.ent.ti.com
 (157.170.170.21) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Mon, 14 Jan 2019 07:25:49 -0600
Received: from a0393678ub.india.ti.com (ileax41-snat.itg.ti.com
 [10.172.224.153])
 by dlep32.itg.ti.com (8.14.3/8.13.8) with ESMTP id x0EDOoWX028516;
 Mon, 14 Jan 2019 07:25:45 -0600
From: Kishon Vijay Abraham I <kishon@ti.com>
To: Gustavo Pimentel <gustavo.pimentel@synopsys.com>, Rob Herring
 <robh+dt@kernel.org>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Subject: [PATCH 11/24] PCI: dwc: Fix ATU identification for designware version
 >= 4.80
Date: Mon, 14 Jan 2019 18:54:11 +0530
Message-ID: <20190114132424.6445-12-kishon@ti.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190114132424.6445-1-kishon@ti.com>
References: <20190114132424.6445-1-kishon@ti.com>
MIME-Version: 1.0
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190114_082602_064142_D08541B4 
X-CRM114-Status: GOOD (  15.56  )
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

Synopsys designware version >= 4.80 uses a separate register space
for programming ATU. The current code identifies if there exists a
separate register space by accessing the register address of ATUs
in designware version < 4.80. Accessing this address results in
abort in the case of K2G.

Fix it here by adding "version" member to struct dw_pcie. This should
be set by platform specific drivers and designware core will use it
to identify if the platform has a separate ATU space. For platforms
which hasn't populated the version member, the old method of
identification will still be used.

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 drivers/pci/controller/dwc/pcie-designware.c | 14 ++++++++------
 drivers/pci/controller/dwc/pcie-designware.h |  1 +
 2 files changed, 9 insertions(+), 6 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-designware.c b/drivers/pci/controller/dwc/pcie-designware.c
index 78539452c265..37506aba22fe 100644
--- a/drivers/pci/controller/dwc/pcie-designware.c
+++ b/drivers/pci/controller/dwc/pcie-designware.c
@@ -358,13 +358,15 @@ void dw_pcie_setup(struct dw_pcie *pci)
 	struct device *dev = pci->dev;
 	struct device_node *np = dev->of_node;
 
-	/* Get iATU unroll support */
-	pci->iatu_unroll_enabled = dw_pcie_iatu_unroll_enabled(pci);
-	dev_dbg(pci->dev, "iATU unroll: %s\n",
-		pci->iatu_unroll_enabled ? "enabled" : "disabled");
+	if (pci->version >= 0x480A || (!pci->version &&
+				       dw_pcie_iatu_unroll_enabled(pci))) {
+		pci->iatu_unroll_enabled = true;
+		if (!pci->atu_base)
+			pci->atu_base = pci->dbi_base + DEFAULT_DBI_ATU_OFFSET;
+	}
+	dev_dbg(pci->dev, "iATU unroll: %s\n", pci->iatu_unroll_enabled ?
+		"enabled" : "disabled");
 
-	if (pci->iatu_unroll_enabled && !pci->atu_base)
-		pci->atu_base = pci->dbi_base + DEFAULT_DBI_ATU_OFFSET;
 
 	ret = of_property_read_u32(np, "num-lanes", &lanes);
 	if (ret)
diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
index ea4b215b605d..4ab2e3dbd6bb 100644
--- a/drivers/pci/controller/dwc/pcie-designware.h
+++ b/drivers/pci/controller/dwc/pcie-designware.h
@@ -231,6 +231,7 @@ struct dw_pcie {
 	struct pcie_port	pp;
 	struct dw_pcie_ep	ep;
 	const struct dw_pcie_ops *ops;
+	unsigned int		version;
 };
 
 #define to_dw_pcie_from_pp(port) container_of((port), struct dw_pcie, pp)
-- 
2.17.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
