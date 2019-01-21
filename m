Return-Path: <SRS0=flTa=P5=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39787C282EC
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 08:01:45 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0CFC521738
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 08:01:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="rDCvklPR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0CFC521738
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=tJ5EdD0iVQ43naRkC6Zd7qDcLqL0DOIgIpSv5cO0poA=; b=rDCvklPRrmVLAV
	BhJiimn0+XpQbX608CfABQ943BpqpXAFaWM54kjT1CdzLKIMwaRtf+Ta+gGqsRbx1r3DsHj5U9Tl9
	Uj+RIhZdvQVAND4jHbTQnLQb/RQR+850eUnoUcvApkSmA2f7zd4UWMMKk8B9nkvcaou4UO9gBoIgu
	Irg6vg9Ky61F3tSklkpwCSPUyIaLCNfa1HVbSt5oAFpcKGVA/rLTIgygomEVM2Yn8z8muyE2eHOYO
	nk8BEHdIjw5zyHzw0WAH4WNCK2wde9MAHmsNlsoWYupsREUaWTVw81FUkT2iGcc3AYMcY778koNgU
	gdRR7nhSEniIUpY9nM0A==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1glUWb-0002Gh-RR; Mon, 21 Jan 2019 08:01:41 +0000
Received: from mailgw02.mediatek.com ([216.200.240.185])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1glUVj-0001Tx-6i; Mon, 21 Jan 2019 08:00:53 +0000
X-UUID: b9dbcbdb69eb4d74b823a2d2bd10f7dd-20190121
X-UUID: b9dbcbdb69eb4d74b823a2d2bd10f7dd-20190121
Received: from mtkcas67.mediatek.inc [(172.29.193.45)] by mailgw02.mediatek.com
 (envelope-from <qii.wang@mediatek.com>)
 (musrelay.mediatek.com ESMTP with TLS)
 with ESMTP id 438688200; Mon, 21 Jan 2019 00:00:41 -0800
Received: from mtkmbs03n1.mediatek.inc (172.21.101.181) by
 MTKMBS62N1.mediatek.inc (172.29.193.41) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Mon, 21 Jan 2019 00:00:40 -0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs03n1.mediatek.inc (172.21.101.181) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Mon, 21 Jan 2019 16:00:38 +0800
Received: from localhost.localdomain (10.17.3.153) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Mon, 21 Jan 2019 16:00:37 +0800
From: qii wang <qii.wang@mediatek.com>
To: <wsa@the-dreams.de>
Subject: [PATCH v3 0/6] add i2c support for mt7629 and mt8183
Date: Mon, 21 Jan 2019 15:59:28 +0800
Message-ID: <1548057574-8061-1-git-send-email-qii.wang@mediatek.com>
X-Mailer: git-send-email 1.7.9.5
MIME-Version: 1.0
X-MTK: N
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190121_000047_262414_9E2F7400 
X-CRM114-Status: UNSURE (   7.08  )
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
Cc: devicetree@vger.kernel.org, ryder.lee@mediatek.com, qii.wang@mediatek.com,
 srv_heupstream@mediatek.com, leilk.liu@mediatek.com, xinping.qian@mediatek.com,
 linux-kernel@vger.kernel.org, liguo.zhang@mediatek.com,
 linux-mediatek@lists.infradead.org, linux-i2c@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

This series are based on 5.0-rc1 and provide six patches to support
mt7629 and mt8183 IC.

Main changes compared to v2:
--update commit message
--add Reviewed-by from Rob Herring, Nicolas and Sean

Main changes compared to v1:
--remove useless dt-binding for mt7629
--split a patch into two(2/6 3/6)
--muti-user feature was dropped

qii wang (6):
  dt-bindings: i2c: Add Mediatek MT7629 i2c binding
  i2c: mediatek: speeds is replaced by macros definitions
  i2c: mediatek: remove completion_done()
  i2c: mediatek: Add offsets array for new i2c registers
  dt-bindings: i2c: Add Mediatek MT8183 i2c binding
  i2c: mediatek: Add i2c support for MediaTek MT8183

 Documentation/devicetree/bindings/i2c/i2c-mtk.txt |    7 +-
 drivers/i2c/busses/i2c-mt65xx.c                   |  288 ++++++++++++++++-----
 2 files changed, 227 insertions(+), 68 deletions(-)

-- 
1.7.9.5


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
