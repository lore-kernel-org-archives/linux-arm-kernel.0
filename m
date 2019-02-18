Return-Path: <SRS0=ULCN=QZ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FE0CC43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 13:09:39 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2DA652075C
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 13:09:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Davt0/PZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2DA652075C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=holtmann.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:References:Message-Id:Date:
	In-Reply-To:From:Subject:Mime-Version:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=AyHVxli6GYyJ+KNVZraykC4Axt2M3+63GyHXtRx1g+o=; b=Davt0/PZKp3bkn
	vqKwVThlrpValTpB62newvFSHDLw8zFY6gTRig42AJYMtH7s5HNhUQfZL6LgI0IkUELiT8y60NSFR
	3sLAvC+NQNM5nDv+OIi35QmETZPDNdaf6Eh3p8P2igtlUKBLgg/kO5zmSTpoYTSYQ5EXyaVwZfvG+
	JhXTIdOSbZ777qt72tiOf8koELwSkETiv725531i6ySfxZ9lX4Ij1/bPdtyQcqSANbMZEYzM1m1Su
	kxja+oblSkS/QAgfdMuHGIqcWRO6E/ilg6WgYz5xNUsT+HOXjEdeJ1CHmz26+rj4WDv53WL2gQteX
	EsRpneySEPEasbrzvWjg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gvifv-0007iu-UR; Mon, 18 Feb 2019 13:09:35 +0000
Received: from coyote.holtmann.net ([212.227.132.17] helo=mail.holtmann.org)
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gvifs-0007iZ-VE; Mon, 18 Feb 2019 13:09:34 +0000
Received: from marcel-macpro.fritz.box (p4FF9F361.dip0.t-ipconnect.de
 [79.249.243.97])
 by mail.holtmann.org (Postfix) with ESMTPSA id 45467CF2C7;
 Mon, 18 Feb 2019 14:17:25 +0100 (CET)
Mime-Version: 1.0 (Mac OS X Mail 12.2 \(3445.102.3\))
Subject: Re: [PATCH 5/6] Bluetooth: mediatek: update the common setup between
 MT7622 and other devices
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <9ea118140651636b3b868e28004d474ded4af5b6.1550184473.git.sean.wang@mediatek.com>
Date: Mon, 18 Feb 2019 14:09:31 +0100
Message-Id: <B862A902-56CD-4397-9326-BAB3CB71D60F@holtmann.org>
References: <cover.1550184473.git.sean.wang@mediatek.com>
 <9ea118140651636b3b868e28004d474ded4af5b6.1550184473.git.sean.wang@mediatek.com>
To: Sean Wang <sean.wang@mediatek.com>
X-Mailer: Apple Mail (2.3445.102.3)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190218_050933_156211_3B978833 
X-CRM114-Status: UNSURE (   8.82  )
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
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org,
 Johan Hedberg <johan.hedberg@gmail.com>, linux-kernel@vger.kernel.org,
 linux-bluetooth@vger.kernel.org, robh+dt@kernel.org,
 linux-mediatek@lists.infradead.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi Sean,

> Update the setup sequence on MT7622 to apply the same flow with MT7663U
> and MT7668U USB [1] as much as possible. These additional commands are
> required to parse the corresponding event to determine what current state
> the Bluetooth device is on and thus it's necessary to extend
> mtk_hci_wmt_sync to support the reading status in the same patch.
> 
> [1] http://lists.infradead.org/pipermail/linux-mediatek/2019-January/017074.html
> 
> Signed-off-by: Sean Wang <sean.wang@mediatek.com>
> ---
> drivers/bluetooth/btmtkuart.c | 204 +++++++++++++++++++++++++++++++---
> 1 file changed, 190 insertions(+), 14 deletions(-)

patch has been applied to bluetooth-next tree.

Regards

Marcel


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
