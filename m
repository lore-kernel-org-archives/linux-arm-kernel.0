Return-Path: <SRS0=txfi=PP=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF33FC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 06:59:36 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B0333206C0
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 06:59:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="BpNtefAe";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="stD0uFhV";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ti.com header.i=@ti.com header.b="nniCUJBv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B0333206C0
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Z9rgXLQKcEIwELGorlTM5nLF8nw4lbHPB51TGO+nU28=; b=BpNtefAeIeTGRE
	88jckVoGWryPqKRzJVHBU+U54JtnIdHV9NdBEKCAA1Fvyvy1v+mvUOWPSY+ZsOMN/Z7WDOxPfWf6b
	x6gfxMm5YC8D6X1/3ok5OXvdlBCSJzo+sRWctXKdsgTRbRzRJ6wiVmoEp/77B0gscQf9Z/rqhtrox
	19XBEmcxQrzzPfj6Gxu8Fn6sMB76mKXP0K6BoLqljt+qIydDf/owmTCGbGjCOX1TF4i22K7ytcUMs
	b3/MelAgTdwt39j0tPfzSXu/Zkzlw0I6BNFDfnJ245fmuXcMqdNh/PJWewcIS1YH0eLTTIRCJdHHD
	zoA+IDBno9Q7SAujp2kw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1ggOsk-0002Zf-Pw; Mon, 07 Jan 2019 06:59:30 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1ggOsj-0002PD-2u; Mon, 07 Jan 2019 06:59:29 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:CC:To:From:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=hINSWO+j0rnQzGXlYYmcVdxAz+2sDdsG0d8LALea1i4=; b=stD0uFhVKlD8rsxBRP15/17aI
 qpbFy8tn2LoQADLRV/GSazBc95o+9AJiQw8q1JTUCisz82dvo1JSAxF7SkC2zsaGfBwVAt9bQyPW9
 oeYqUpfdja6kEBQFD0Si/cnTGQmeNlb+a36zDrgs/sfYRpH7XC1Hdx8zWvcoral1HzkGe2qrTlSrJ
 Yc7Kq4BrU3aHfEmECaWu41WvOhMqgccE2SjIRpuPMTPALYUBiQAv+jxJe2yaEx63Ypjds/+4oRY71
 u5OK7xLelr2e2c6csq1sK/QZwuyAQ1JW+UXhNrvJfDUaQC32yqg7CiIiAwFq4eJTKYppDT1/m/0Uf
 ldKXyE/6Q==;
Received: from fllv0016.ext.ti.com ([198.47.19.142])
 by casper.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1ggOdj-0004SA-W7; Mon, 07 Jan 2019 06:44:01 +0000
Received: from lelv0266.itg.ti.com ([10.180.67.225])
 by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id x076hqdv021825;
 Mon, 7 Jan 2019 00:43:52 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1546843432;
 bh=hINSWO+j0rnQzGXlYYmcVdxAz+2sDdsG0d8LALea1i4=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=nniCUJBvEVBJFmbm+Imj/1XZcd98HetidQUV8VJAtd1Ip6qIKbYak0xCpLH48OkRo
 HvIITVDCq41KlmmkKwK1T8DA5bUEktUYdp7KYmmfYuJ5D0Wx242JUIlGIJ0oHclGUh
 QsScUts3AvasiX0xUb+Ko0kjpSGLNVhBVhJg1M2I=
Received: from DLEE101.ent.ti.com (dlee101.ent.ti.com [157.170.170.31])
 by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x076hqhN071741
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Mon, 7 Jan 2019 00:43:52 -0600
Received: from DLEE104.ent.ti.com (157.170.170.34) by DLEE101.ent.ti.com
 (157.170.170.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Mon, 7
 Jan 2019 00:43:51 -0600
Received: from dflp32.itg.ti.com (10.64.6.15) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Mon, 7 Jan 2019 00:43:51 -0600
Received: from a0393678ub.india.ti.com (ileax41-snat.itg.ti.com
 [10.172.224.153])
 by dflp32.itg.ti.com (8.14.3/8.13.8) with ESMTP id x076gfoC002672;
 Mon, 7 Jan 2019 00:43:48 -0600
From: Kishon Vijay Abraham I <kishon@ti.com>
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Bjorn Helgaas
 <bhelgaas@google.com>, Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
 Alan Douglas <adouglas@cadence.com>, Shawn Lin <shawn.lin@rock-chips.com>
Subject: [PATCH 15/15] PCI: endpoint: Remove features member in struct pci_epc
Date: Mon, 7 Jan 2019 12:11:48 +0530
Message-ID: <20190107064148.10152-16-kishon@ti.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190107064148.10152-1-kishon@ti.com>
References: <20190107064148.10152-1-kishon@ti.com>
MIME-Version: 1.0
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190107_064400_273253_4EFCAC7C 
X-CRM114-Status: UNSURE (   8.58  )
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

Since EPC features are now implemented using pci_epc_features and
all the EPC drivers are moved to using pci_epc_features, remove
features member in struct pci_epc and all the helper macros for
configuring the features.

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 include/linux/pci-epc.h | 9 ---------
 1 file changed, 9 deletions(-)

diff --git a/include/linux/pci-epc.h b/include/linux/pci-epc.h
index dc3513a2f88a..4870ad5a6ca2 100644
--- a/include/linux/pci-epc.h
+++ b/include/linux/pci-epc.h
@@ -99,7 +99,6 @@ struct pci_epc {
 	struct config_group		*group;
 	/* spinlock to protect against concurrent access of EP controller */
 	spinlock_t			lock;
-	unsigned int			features;
 };
 
 /**
@@ -120,14 +119,6 @@ struct pci_epc_features {
 	u64	bar_fixed_size[BAR_5 + 1];
 };
 
-#define EPC_FEATURE_NO_LINKUP_NOTIFIER		BIT(0)
-#define EPC_FEATURE_BAR_MASK			(BIT(1) | BIT(2) | BIT(3))
-#define EPC_FEATURE_MSIX_AVAILABLE		BIT(4)
-#define EPC_FEATURE_SET_BAR(features, bar)	\
-		(features |= (EPC_FEATURE_BAR_MASK & (bar << 1)))
-#define EPC_FEATURE_GET_BAR(features)		\
-		((features & EPC_FEATURE_BAR_MASK) >> 1)
-
 #define to_pci_epc(device) container_of((device), struct pci_epc, dev)
 
 #define pci_epc_create(dev, ops)    \
-- 
2.17.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
