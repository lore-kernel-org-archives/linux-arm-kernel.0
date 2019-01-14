Return-Path: <SRS0=baBj=PW=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E933C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 11:19:39 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 02F1720656
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 11:19:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="VqXe9r20";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ti.com header.i=@ti.com header.b="P7XFzsI5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 02F1720656
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=QE2/FwlRRK8pSVYenfkTl1jheLjXNEzzlcJ9QHBl/vQ=; b=VqXe9r20YMTZFm
	v+J66e0B7IKwqMHFo4qsMFAJKtMW/V3++YdDsDbOIoXzBYy2vU2wTefvBVR4P4bOVDhY+7rF9jTds
	BCRJoLF0Lcu/djREOGTo70BtFxL5jYPn61/BC/YRLyheSrdAz2SJMv5Wc4AmNTpuE0LiOGY/CKg1y
	HpZreK6f7I/yQrUk3Dxhrvy9ZAgF0szx56Ljed458pQX+IKh4oGmR932BJnHD7h0CVQazYYxKC4yk
	ejnB1n6AmP4LZK1akngnjgyFVUZ1ZgUFSaCb2ul334XiERnNeZgy8gH9ByDG7pfUPD8DZ8N6g5dnX
	27J43jhx/lBDSBKwrqIw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gj0HG-0003K2-Ja; Mon, 14 Jan 2019 11:19:34 +0000
Received: from fllv0016.ext.ti.com ([198.47.19.142])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gj0EG-0000Jk-Ep; Mon, 14 Jan 2019 11:16:54 +0000
Received: from lelv0266.itg.ti.com ([10.180.67.225])
 by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id x0EBGMva065556;
 Mon, 14 Jan 2019 05:16:22 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1547464582;
 bh=9uy7oBAgopBKXmOWf1Xu6i0EmqFED+atLS7+JVzPan8=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=P7XFzsI5AoIR5lwIf7kdytlIcvYG00NuEKVT4PSzp9QW8AhQvxBUBmmb2XZYz8W8b
 GKgjjaaZ/1uHaeqpM/3tdbWaQwPnmby9LN5zD/X6UYTmmxqapNrzQcC+UYaDcXkRbv
 Im82/pbFYLEuc3n10X216xnTWvR7ImNq0PACzjiM=
Received: from DFLE103.ent.ti.com (dfle103.ent.ti.com [10.64.6.24])
 by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x0EBGMVu024049
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Mon, 14 Jan 2019 05:16:22 -0600
Received: from DFLE115.ent.ti.com (10.64.6.36) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Mon, 14
 Jan 2019 05:16:21 -0600
Received: from dflp32.itg.ti.com (10.64.6.15) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Mon, 14 Jan 2019 05:16:21 -0600
Received: from a0393678ub.india.ti.com (ileax41-snat.itg.ti.com
 [10.172.224.153])
 by dflp32.itg.ti.com (8.14.3/8.13.8) with ESMTP id x0EBFd1c011560;
 Mon, 14 Jan 2019 05:16:18 -0600
From: Kishon Vijay Abraham I <kishon@ti.com>
To: Kishon Vijay Abraham I <kishon@ti.com>, Lorenzo Pieralisi
 <lorenzo.pieralisi@arm.com>, Gustavo Pimentel
 <gustavo.pimentel@synopsys.com>, Alan Douglas <adouglas@cadence.com>, Shawn
 Lin <shawn.lin@rock-chips.com>, Heiko Stuebner <heiko@sntech.de>
Subject: [PATCH v2 10/15] PCI: pci-epf-test: Do not allocate next BARs memory
 if current BAR is 64Bit
Date: Mon, 14 Jan 2019 16:45:08 +0530
Message-ID: <20190114111513.21618-11-kishon@ti.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190114111513.21618-1-kishon@ti.com>
References: <20190114111513.21618-1-kishon@ti.com>
MIME-Version: 1.0
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190114_031629_624096_4F9979AB 
X-CRM114-Status: GOOD (  17.05  )
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

It's useless to allocate memory for next BAR if the current BAR is a
64Bit BAR. Stop allocating memory for the next BAR, if the current
BARs flag indicates this is a 64Bit BAR.

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 drivers/pci/endpoint/functions/pci-epf-test.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/pci/endpoint/functions/pci-epf-test.c b/drivers/pci/endpoint/functions/pci-epf-test.c
index 44cc31343a80..ade296180383 100644
--- a/drivers/pci/endpoint/functions/pci-epf-test.c
+++ b/drivers/pci/endpoint/functions/pci-epf-test.c
@@ -429,6 +429,7 @@ static int pci_epf_test_alloc_space(struct pci_epf *epf)
 {
 	struct pci_epf_test *epf_test = epf_get_drvdata(epf);
 	struct device *dev = &epf->dev;
+	struct pci_epf_bar *epf_bar;
 	void *base;
 	int bar;
 	enum pci_barno test_reg_bar = epf_test->test_reg_bar;
@@ -442,6 +443,7 @@ static int pci_epf_test_alloc_space(struct pci_epf *epf)
 	epf_test->reg[test_reg_bar] = base;
 
 	for (bar = BAR_0; bar <= BAR_5; bar++) {
+		epf_bar = &epf->bar[bar];
 		if (bar == test_reg_bar)
 			continue;
 		base = pci_epf_alloc_space(epf, bar_size[bar], bar);
@@ -449,6 +451,8 @@ static int pci_epf_test_alloc_space(struct pci_epf *epf)
 			dev_err(dev, "Failed to allocate space for BAR%d\n",
 				bar);
 		epf_test->reg[bar] = base;
+		if (epf_bar->flags & PCI_BASE_ADDRESS_MEM_TYPE_64)
+			bar++;
 	}
 
 	return 0;
-- 
2.17.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
