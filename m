Return-Path: <SRS0=niBm=QV=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5BF0C10F04
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 23:20:22 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 85B1F2229F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 23:20:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="n9ivylnp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 85B1F2229F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=z2ue24Ij+71Q5hQLz8TL5nAhwx2KZRV/9Up5JhSmvM0=; b=n9ivylnpsLMmOZ
	KxwRS2vyUr8qXTQaugLdhEnOJ8N49O0GDmnyKZCdnfdiLveGd7W+M3DZP7UnpJ1LVEyxj4cNW82PO
	mcXLtAnnBUzKZQi3Xq5OnZRQAYW1s/jFzc5EN5JznbmCoDaHxQ9rrAYG4Jmv564Spl0K92YL8heVn
	oy6Z0waA8OToHE8l3pAVgEJkoY6HEGxXZvQA061pANgPuln2rlJcEXQOS8kSVtPQUDkJyySfjPF1B
	9/EkJpN3/PH8nTa404mAe0grjs+ag0OYHqTaeFmWrpIy/5wqASwze92YeVvIn+gOCzuAIR87GCZG2
	TilHsQ7IQctjz+TwwWnQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1guQIi-0000gN-Sp; Thu, 14 Feb 2019 23:20:16 +0000
Received: from mailgw02.mediatek.com ([216.200.240.185])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1guQIX-0007nR-4S; Thu, 14 Feb 2019 23:20:06 +0000
X-UUID: f4941e55d40d437798ff069f4fc22a2e-20190214
X-UUID: f4941e55d40d437798ff069f4fc22a2e-20190214
Received: from mtkcas67.mediatek.inc [(172.29.193.45)] by mailgw02.mediatek.com
 (envelope-from <sean.wang@mediatek.com>)
 (musrelay.mediatek.com ESMTP with TLS)
 with ESMTP id 1774992370; Thu, 14 Feb 2019 15:19:57 -0800
Received: from MTKMBS01N1.mediatek.inc (172.21.101.68) by
 MTKMBS62N1.mediatek.inc (172.29.193.41) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Thu, 14 Feb 2019 15:19:56 -0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs01n1.mediatek.inc (172.21.101.68) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Fri, 15 Feb 2019 07:19:42 +0800
Received: from mtkswgap22.mediatek.inc (172.21.77.33) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via
 Frontend Transport; Fri, 15 Feb 2019 07:19:41 +0800
From: <sean.wang@mediatek.com>
To: <robh+dt@kernel.org>, <mark.rutland@arm.com>, <marcel@holtmann.org>,
 <johan.hedberg@gmail.com>
Subject: [PATCH 0/6]Bluetooth: mediatek: add support for MediaTek MT7663U and
 MT7668U UART devices
Date: Fri, 15 Feb 2019 07:19:32 +0800
Message-ID: <cover.1550184473.git.sean.wang@mediatek.com>
X-Mailer: git-send-email 1.7.9.5
MIME-Version: 1.0
X-MTK: N
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190214_152005_210554_685D22D4 
X-CRM114-Status: UNSURE (   7.52  )
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
Cc: devicetree@vger.kernel.org, Sean Wang <sean.wang@mediatek.com>,
 linux-kernel@vger.kernel.org, linux-bluetooth@vger.kernel.org,
 linux-mediatek@lists.infradead.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

From: Sean Wang <sean.wang@mediatek.com>

This adds the support of enabling MT7668U and MT7663U UART based Bluetooth
function running on the top of btmtkuart driver.

We are through several patches to reach the goal and also wish applied
the same flow in MediaTek btusb [1] for the transport independence.
Once [1] and the series is being merged and then in next step I will
consider to add a btmtk.c to hold these independent operations among
various transport reused by MediaTek UART, USB and SDIO-based Bluetooth.

Firstly,
in patch 1/6 to update the dt-binding document for the kind of devices.
in patch 2/6, 3/6 to fix the common error issues in the current code.
in Patch 4/6, 5/6 to add the general flow which MT7622 and even MT7663U and
MT7668U USB devices also utilize.

Finally, in patch 6/6 to add the specific setups for MediaTek UART-based
Bluetooth and enable MT7663U and MT7668U device.

[1] http://lists.infradead.org/pipermail/linux-mediatek/2019-January/017074.html 

Sean Wang (6):
  dt-bindings: net: bluetooth: add support for MediaTek MT7663U and
    MT7668U UART devices
  Bluetooth: mediatek: trivial typo fix
  Bluetooth: mediatek: fix up an error path to restore bdev->tx_state
  Bluetooth: mediatek: pass a pointer to mtk_hci_wmt_sync
  Bluetooth: mediatek: update the common setup between MT7622 and other
    devices
  Bluetooth: mediatek: add support for MediaTek MT7663U and MT7668U UART
    devices

 .../bindings/net/mediatek-bluetooth.txt       |  64 +++
 drivers/bluetooth/btmtkuart.c                 | 538 ++++++++++++++++--
 2 files changed, 569 insertions(+), 33 deletions(-)

-- 
2.18.0


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
