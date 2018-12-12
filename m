Return-Path: <SRS0=fRgi=OV=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDE80C04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 09:36:41 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 847A22084E
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 09:36:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="H/ZORmPj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 847A22084E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=kg+D26nVXW8cWoqDycfp4Zq4/BsU0TsiWjprtlH2a/U=; b=H/ZORmPjqO7VX4
	7sPtoUf9GdzTFwV3s/kQshN5PNqfws9FlgJUdecPKXX/5n/OyTOg0SEMyOwjwLSmYgM0CDOLp4dK9
	irHr5/CfVxaS8CUehgmM6JpMxXHj/gLGxiWD4PzFGybnQCWvP5dcAHxLt8WWQ0gVW7OyMvsLYupK8
	1b0+GRwO1Nyi6v6wU9wsAfVkph66Pb322YcJLeSw+QwRCHOzf5qTG9HE5QFdHv/5J4/pMIfCdz+sU
	QOSespK2LrkiCnevNQ+6qs3M9C1eO6luEkZOO2GwGb+IIxvY29EvogV9khZqU9nz4kwQM9kXBw7YG
	4qvZ5ZKVnwXUwXAfqYQQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gX0wQ-0003eh-JO; Wed, 12 Dec 2018 09:36:30 +0000
Received: from [210.61.82.183] (helo=mailgw01.mediatek.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gX0wN-0003c2-18; Wed, 12 Dec 2018 09:36:28 +0000
X-UUID: 24007c7db5544aa399e52006acc07eb5-20181212
X-UUID: 24007c7db5544aa399e52006acc07eb5-20181212
Received: from mtkcas08.mediatek.inc [(172.21.101.126)] by
 mailgw01.mediatek.com (envelope-from <biao.huang@mediatek.com>)
 (mhqrelay.mediatek.com ESMTP with TLS)
 with ESMTP id 532604860; Wed, 12 Dec 2018 17:35:57 +0800
Received: from mtkcas09.mediatek.inc (172.21.101.178) by
 mtkmbs01n2.mediatek.inc (172.21.101.79) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Wed, 12 Dec 2018 17:35:54 +0800
Received: from localhost.localdomain (10.17.3.153) by mtkcas09.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Wed, 12 Dec 2018 17:35:53 +0800
From: Biao Huang <biao.huang@mediatek.com>
To: <davem@davemloft.net>, <robh+dt@kernel.org>
Subject: [v6, PATCH 0/2] add Ethernet driver support for mt2712
Date: Wed, 12 Dec 2018 17:35:30 +0800
Message-ID: <1544607332-29921-1-git-send-email-biao.huang@mediatek.com>
X-Mailer: git-send-email 1.7.9.5
MIME-Version: 1.0
X-TM-SNTS-SMTP: 6591352EF4A2D8B84B96720AD430D40B02690301532B82060EB1480892F5AD312000:8
X-MTK: N
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181212_013627_198447_9E2DBEB8 
X-CRM114-Status: UNSURE (   7.76  )
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

Changes in v6:
 modifications according to comments from Rob/Andrew/Sean:
 1. use delay_ps instead of delay stage.
 2. add comments in driver to avoid confusion.
 2. rewrite set_delay function.
 3. modify binding document for properties: tx-delay-ps/rx-delay-ps/pericfg etc.

Biao Huang (2):
  net:stmmac: dwmac-mediatek: add support for mt2712
  dt-binding: mediatek-dwmac: add binding document for MediaTek MT2712
    DWMAC

 .../devicetree/bindings/net/mediatek-dwmac.txt     |   87 +++++
 drivers/net/ethernet/stmicro/stmmac/Kconfig        |    8 +
 drivers/net/ethernet/stmicro/stmmac/Makefile       |    1 +
 .../net/ethernet/stmicro/stmmac/dwmac-mediatek.c   |  408 ++++++++++++++++++++ 
 4 files changed, 504 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/net/mediatek-dwmac.txt
 create mode 100644 drivers/net/ethernet/stmicro/stmmac/dwmac-mediatek.c

--
1.7.9.5


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
