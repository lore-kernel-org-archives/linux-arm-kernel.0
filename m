Return-Path: <SRS0=e5Gl=O3=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EFC3C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 02:42:50 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D269F2145D
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 02:42:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="nzkV9Q8k"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D269F2145D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=F1omAMipOZcQSCicqV2zsKxPl3TJSHz+Ao9aCx95tso=; b=nzkV9Q8kDJsupD
	kE4zQBsEO0y/V8Srj5J6HEaHxYri8EqzqmKrGehv2sO2IDP4w/FpOTdjkzRFlK3l6ViCwJrDWK4QC
	Me8YVOKNrRP4agEzePHpHCyPHmuwDq8WNwBg9r8iyhth4DS3BWhbAIYGiUrPtmRaTAPz1GfMM1B1y
	9ROL5TD8g7RemCZV54u/W1vdmXP2QpGOtGgu6CumK0NcF8WByUTH+vuhFphflO2oUVxuARB+p7kuC
	j0+iO+VhjfSIlw/Zf8Duxx88K0xX/1/KeIvNG8KLU8A09gV95pSs2EfDzZbGTSPq+he2RzOnMWIfz
	ouy0J7Rc/KHrM+bsR5ZQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gZ5LK-0002ff-ES; Tue, 18 Dec 2018 02:42:46 +0000
Received: from [210.61.82.184] (helo=mailgw02.mediatek.com)
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gZ5LF-0002de-W4; Tue, 18 Dec 2018 02:42:43 +0000
X-UUID: a1acedb5118c4b418507959ec5ccd0cf-20181218
X-UUID: a1acedb5118c4b418507959ec5ccd0cf-20181218
Received: from mtkmrs01.mediatek.inc [(172.21.131.159)] by
 mailgw02.mediatek.com (envelope-from <biao.huang@mediatek.com>)
 (mhqrelay.mediatek.com ESMTP with TLS)
 with ESMTP id 156738609; Tue, 18 Dec 2018 10:42:27 +0800
Received: from mtkcas09.mediatek.inc (172.21.101.178) by
 mtkmbs01n1.mediatek.inc (172.21.101.68) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Tue, 18 Dec 2018 10:42:26 +0800
Received: from localhost.localdomain (10.17.3.153) by mtkcas09.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Tue, 18 Dec 2018 10:42:25 +0800
From: Biao Huang <biao.huang@mediatek.com>
To: <davem@davemloft.net>, <robh+dt@kernel.org>
Subject: [PATCH 0/2] add ethernet binding and modify ethernet driver for mt2712
Date: Tue, 18 Dec 2018 10:42:15 +0800
Message-ID: <1545100937-16093-1-git-send-email-biao.huang@mediatek.com>
X-Mailer: git-send-email 1.7.9.5
MIME-Version: 1.0
X-MTK: N
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181217_184242_159870_1EEC0DC5 
X-CRM114-Status: UNSURE (   7.75  )
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

This new series is the result of discussion in:
http://lkml.org/lkml/2018/12/13/1007
http://lkml.org/lkml/2018/12/14/53

1. ethernet binding file move to this series.
2. remove fine tune property in device tree
3. remove fine tune flow in ethernet driver
4. set rgmii timing according to the value in device tree,
and don't care whether phy insert internal delay  or not.

Biao Huang (2):
  dt-binding: mediatek-dwmac: add binding document for MediaTek MT2712
    DWMAC
  net-next: stmmac: dwmac-mediatek: remove fine-tune property

 .../devicetree/bindings/net/mediatek-dwmac.txt     |   78 ++++++++++++++++++++
 .../net/ethernet/stmicro/stmmac/dwmac-mediatek.c   |   71 ++++++------------
 2 files changed, 102 insertions(+), 47 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/net/mediatek-dwmac.txt

-- 
1.7.9.5


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
