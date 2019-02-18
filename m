Return-Path: <SRS0=ULCN=QZ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABB39C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 13:10:38 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 73C29217F9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 13:10:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="tcbQJLqA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 73C29217F9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=holtmann.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:References:Message-Id:Date:
	In-Reply-To:From:Subject:Mime-Version:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=z0Fr9rdslmZNTOWInLGvTL0V3KMf8UTLDTCZ9y0hSg4=; b=tcbQJLqAgfmDNL
	BiiwS4ZB12XrMxX4aGUt92aPb6S3p9t30tl5IwthASry3IkYob6Smfd07Fe2FnW3Eu9qXgdi/zrXW
	Pjmkynq1t7iFtY/qZkG7HBeeJrYfoHVkvWViG162cxpvU8skS25KAO4cyaQ9f752nTjPd7rsSfduI
	yR/zg5rUVYGYFCow5ArMUX5LmXEo1RHtdAyEya84F1UOAp+DiweCDnAHWPy70n0QKYmp40h1r9G+q
	g2CvGHJmpxgt3WX/ooeTBlfTcPzCVDWt06mAUjG5sE4sH1DAAoW5CpscUcDzAuiDSuWjg7KCYd6Lo
	Fe8lmDDEdv4GmcdEzPtA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gvigt-0000w7-CD; Mon, 18 Feb 2019 13:10:35 +0000
Received: from coyote.holtmann.net ([212.227.132.17] helo=mail.holtmann.org)
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gvigp-0000ve-Bu; Mon, 18 Feb 2019 13:10:33 +0000
Received: from marcel-macpro.fritz.box (p4FF9F361.dip0.t-ipconnect.de
 [79.249.243.97])
 by mail.holtmann.org (Postfix) with ESMTPSA id 8E053CF2C7;
 Mon, 18 Feb 2019 14:18:22 +0100 (CET)
Mime-Version: 1.0 (Mac OS X Mail 12.2 \(3445.102.3\))
Subject: Re: [PATCH 0/6]Bluetooth: mediatek: add support for MediaTek MT7663U
 and MT7668U UART devices
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <cover.1550184473.git.sean.wang@mediatek.com>
Date: Mon, 18 Feb 2019 14:10:29 +0100
Message-Id: <B7EBA86E-B6C2-4301-BA01-004EA83A50A9@holtmann.org>
References: <cover.1550184473.git.sean.wang@mediatek.com>
To: Sean Wang <sean.wang@mediatek.com>
X-Mailer: Apple Mail (2.3445.102.3)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190218_051031_555105_B50FBBD5 
X-CRM114-Status: GOOD (  12.18  )
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

> This adds the support of enabling MT7668U and MT7663U UART based Bluetooth
> function running on the top of btmtkuart driver.
> 
> We are through several patches to reach the goal and also wish applied
> the same flow in MediaTek btusb [1] for the transport independence.
> Once [1] and the series is being merged and then in next step I will
> consider to add a btmtk.c to hold these independent operations among
> various transport reused by MediaTek UART, USB and SDIO-based Bluetooth.
> 
> Firstly,
> in patch 1/6 to update the dt-binding document for the kind of devices.
> in patch 2/6, 3/6 to fix the common error issues in the current code.
> in Patch 4/6, 5/6 to add the general flow which MT7622 and even MT7663U and
> MT7668U USB devices also utilize.
> 
> Finally, in patch 6/6 to add the specific setups for MediaTek UART-based
> Bluetooth and enable MT7663U and MT7668U device.
> 
> [1] http://lists.infradead.org/pipermail/linux-mediatek/2019-January/017074.html 
> 
> Sean Wang (6):
>  dt-bindings: net: bluetooth: add support for MediaTek MT7663U and
>    MT7668U UART devices
>  Bluetooth: mediatek: trivial typo fix
>  Bluetooth: mediatek: fix up an error path to restore bdev->tx_state
>  Bluetooth: mediatek: pass a pointer to mtk_hci_wmt_sync
>  Bluetooth: mediatek: update the common setup between MT7622 and other
>    devices
>  Bluetooth: mediatek: add support for MediaTek MT7663U and MT7668U UART
>    devices
> 
> .../bindings/net/mediatek-bluetooth.txt       |  64 +++
> drivers/bluetooth/btmtkuart.c                 | 538 ++++++++++++++++--
> 2 files changed, 569 insertions(+), 33 deletions(-)

please re-send 1/6 and 6/6 when the DT changes are ACKed by Rob.

Regards

Marcel


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
