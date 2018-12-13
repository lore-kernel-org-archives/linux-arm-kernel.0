Return-Path: <SRS0=qRPW=OW=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2D00C67839
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 01:57:00 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 71B5120873
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 01:57:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Z1Jg/+pb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 71B5120873
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=OAfzC0k/jEMGqgN4BuKE6bKJQqDObGwJ8/RfrqQqBYE=; b=Z1Jg/+pbs64bLn
	UbraxIo0BsqfTUfp9GtY8AuiYXzlQtxbtuFDnMWSF5+1cMkKTUXJc8cWizRVQgSY2qTnH2pGSaecL
	GNpFem66qm1grBZF4V9NjcVpJszjLddAeXbZlJs4qOs0hSOYl1wNp0sK/TUbkWf2mCRpdp2ikuXMn
	NvwMso5US8xdwmf+AdHP2OxYVMTqdt3vXW7/7xwJEgwJrnUYURdFwBQppyX00TO/LWfF6w/eAD4mY
	99vTBNlg+UCIrjwBj+vHKmMoeKjolfagXJu36ArfTQiJBDJ7ZSM5dFI7cXMUFjdxsk2kn3u+3N5hG
	+lvqPnpxOTcsHeqhP+Bg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gXGFD-0007Br-GM; Thu, 13 Dec 2018 01:56:55 +0000
Received: from [210.61.82.183] (helo=mailgw01.mediatek.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gXGF8-000730-E2; Thu, 13 Dec 2018 01:56:52 +0000
X-UUID: 192c1a6bc2614d25a67a1d31e7aa1d37-20181213
X-UUID: 192c1a6bc2614d25a67a1d31e7aa1d37-20181213
Received: from mtkcas08.mediatek.inc [(172.21.101.126)] by
 mailgw01.mediatek.com (envelope-from <biao.huang@mediatek.com>)
 (mhqrelay.mediatek.com ESMTP with TLS)
 with ESMTP id 201098608; Thu, 13 Dec 2018 09:56:21 +0800
Received: from mtkcas09.mediatek.inc (172.21.101.178) by
 mtkmbs03n2.mediatek.inc (172.21.101.182) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Thu, 13 Dec 2018 09:56:18 +0800
Received: from localhost.localdomain (10.17.3.153) by mtkcas09.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Thu, 13 Dec 2018 09:56:18 +0800
From: Biao Huang <biao.huang@mediatek.com>
To: <davem@davemloft.net>, <robh+dt@kernel.org>
Subject: [v7, PATCH 0/2] add Ethernet driver support for mt2712
Date: Thu, 13 Dec 2018 09:56:11 +0800
Message-ID: <1544666173-5121-1-git-send-email-biao.huang@mediatek.com>
X-Mailer: git-send-email 1.7.9.5
MIME-Version: 1.0
X-TM-SNTS-SMTP: 1B3BF9241EFF1B532FC712984A240A2786CF3843E64C5FF44DA5311C4690719C2000:8
X-MTK: N
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181212_175650_595540_B0252993 
X-CRM114-Status: UNSURE (   6.72  )
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
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org, nelson.chang@mediatek.com,
 andrew@lunn.ch, biao.huang@mediatek.com, netdev@vger.kernel.org,
 liguo.zhang@mediatek.com, linux-kernel@vger.kernel.org, matthias.bgg@gmail.com,
 joabreu@synopsys.com, linux-mediatek@lists.infradead.org,
 honghui.zhang@mediatek.com, yt.shen@mediatek.com,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Changes in v7:
Add MODULE_LICENSE info in driver.

Biao Huang (2):
  net:stmmac: dwmac-mediatek: add support for mt2712
  dt-binding: mediatek-dwmac: add binding document for MediaTek MT2712
    DWMAC

 .../devicetree/bindings/net/mediatek-dwmac.txt     |   87 +++++
 drivers/net/ethernet/stmicro/stmmac/Kconfig        |    8 +
 drivers/net/ethernet/stmicro/stmmac/Makefile       |    1 +
 .../net/ethernet/stmicro/stmmac/dwmac-mediatek.c   |  413 ++++++++++++++++++++
 4 files changed, 509 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/net/mediatek-dwmac.txt
 create mode 100644 drivers/net/ethernet/stmicro/stmmac/dwmac-mediatek.c

-- 
1.7.9.5


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
