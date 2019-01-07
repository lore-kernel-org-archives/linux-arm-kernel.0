Return-Path: <SRS0=txfi=PP=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05786C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 07:00:09 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C5121206C0
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 07:00:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="GXj17AFb";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="oJx9LG3U";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ti.com header.i=@ti.com header.b="tjvX4ev0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C5121206C0
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=c4/LPGoiK04B3JC7GlNWMo+9kll7PBYaQa8lawHBsrU=; b=GXj17AFbDFx5Nf
	5X9hiLULTdcAXuAqtbmADBAO3bQM0uVqcZ7l7QmfxL0blaOTtnGhAmfjftQuP4kDL9jE7wcrL7ndi
	lDBMCCYo4NIwrWUCZKphGOJ7DPXWVnZWOJ3WINAnTE9t1Sc9zq47MV1SaQM5htaYhEugJS/QdFuyC
	S7s/24lSKQ73jSMoniOahMfEBugOa52RltAfYrRsnbHfaR7ejODFgr9Ml+957ePelH73yHnqt7foX
	6QUVKKiHS66/Ga/9C6qsjCLTw0OwxAfmDX4uipOk5oaEaYr7udlXacSpg8kBs4HkfeGV/9ib8OCN9
	JVJZPKflS1Pjhmm/UB8w==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1ggOtF-0003Bg-30; Mon, 07 Jan 2019 07:00:01 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1ggOsn-0002P6-QN; Mon, 07 Jan 2019 06:59:33 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:CC:To:From:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=DS7GtGkD91osbAa6RekCVW+2i6NQKOGWzWvT8VJgdzc=; b=oJx9LG3UitBgLDGuWwY5XZER8
 anY67WsUy4w+h57qnY0fz4cFwnX50GEVJT4siccnCSh0RKg4oEIUQ099/NDx9Yib5wvlA5ILFi331
 YyjkErVr84jIxsS8mZRIq3A0yeJjQTtdKtNCpmc8FysAttFei4WEMViDmeQMEtDvw74raDXWpMnwO
 pA6xFxNWWb3qD2FMKHLzLMtI0AFRBJSXMrlkVqGNLUO5KjJktOvtU5aAxjwUPfPcZR3y/DUAiyC9p
 NUN7GJ4ejKmkx+OpwjaMQswJu7ICzvvntm52yspSIKsv4fPJn9nJY0n+eAwMoOL+bVvnXHf6PjFIw
 B0qfYPFag==;
Received: from fllv0016.ext.ti.com ([198.47.19.142])
 by casper.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1ggOdM-0004Px-KO; Mon, 07 Jan 2019 06:43:38 +0000
Received: from lelv0265.itg.ti.com ([10.180.67.224])
 by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id x076hQNj021727;
 Mon, 7 Jan 2019 00:43:26 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1546843406;
 bh=DS7GtGkD91osbAa6RekCVW+2i6NQKOGWzWvT8VJgdzc=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=tjvX4ev0+qVhU5xdcbfSfB7Zao9BgkuQzB3XiQF/o4jMMF2A2/y+PLla4nnBW/Rov
 IpGsNA0l4LHQULVRP2gnysMk9SUOLzMcvruyZwzl2EKerQ75Sx+D44kViyHIu0K4sG
 gPe0fGm1OALtS8h1BZ8rE7d9hw5PEzBmGmkjUBjM=
Received: from DFLE105.ent.ti.com (dfle105.ent.ti.com [10.64.6.26])
 by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x076hQow049058
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Mon, 7 Jan 2019 00:43:26 -0600
Received: from DFLE106.ent.ti.com (10.64.6.27) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Mon, 7
 Jan 2019 00:43:26 -0600
Received: from dflp32.itg.ti.com (10.64.6.15) by DFLE106.ent.ti.com
 (10.64.6.27) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Mon, 7 Jan 2019 00:43:26 -0600
Received: from a0393678ub.india.ti.com (ileax41-snat.itg.ti.com
 [10.172.224.153])
 by dflp32.itg.ti.com (8.14.3/8.13.8) with ESMTP id x076gfo6002672;
 Mon, 7 Jan 2019 00:43:22 -0600
From: Kishon Vijay Abraham I <kishon@ti.com>
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Bjorn Helgaas
 <bhelgaas@google.com>, Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
 Alan Douglas <adouglas@cadence.com>, Shawn Lin <shawn.lin@rock-chips.com>
Subject: [PATCH 09/15] PCI: pci-epf-test: Remove setting epf_bar flags in
 function driver
Date: Mon, 7 Jan 2019 12:11:42 +0530
Message-ID: <20190107064148.10152-10-kishon@ti.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190107064148.10152-1-kishon@ti.com>
References: <20190107064148.10152-1-kishon@ti.com>
MIME-Version: 1.0
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190107_064336_915650_70BF9488 
X-CRM114-Status: UNSURE (   8.76  )
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

Now that pci_epf_alloc_space() sets BAR MEM TYPE flags as 64Bit or
32Bit based on size, remove setting it in function driver.

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 drivers/pci/endpoint/functions/pci-epf-test.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/pci/endpoint/functions/pci-epf-test.c b/drivers/pci/endpoint/functions/pci-epf-test.c
index 3e86fa3c7da3..44cc31343a80 100644
--- a/drivers/pci/endpoint/functions/pci-epf-test.c
+++ b/drivers/pci/endpoint/functions/pci-epf-test.c
@@ -406,10 +406,6 @@ static int pci_epf_test_set_bar(struct pci_epf *epf)
 	for (bar = BAR_0; bar <= BAR_5; bar++) {
 		epf_bar = &epf->bar[bar];
 
-		epf_bar->flags |= upper_32_bits(epf_bar->size) ?
-			PCI_BASE_ADDRESS_MEM_TYPE_64 :
-			PCI_BASE_ADDRESS_MEM_TYPE_32;
-
 		ret = pci_epc_set_bar(epc, epf->func_no, epf_bar);
 		if (ret) {
 			pci_epf_free_space(epf, epf_test->reg[bar], bar);
-- 
2.17.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
