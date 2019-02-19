Return-Path: <SRS0=g9E6=Q2=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	UNPARSEABLE_RELAY autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33A1BC43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 21:13:50 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0107E2147A
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 21:13:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="ZjC4ACfB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0107E2147A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Date:To:From:Subject:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=J+rfTWeks/TAM6Q0OSy+PTIcpGPOW7OH506mFwU/WXE=; b=ZjC4ACfBz8tioM
	5UT8s4JWhNAtBw5qFFeKt86e7N/NqoRA86niVXqSI299p3Ev/n+rS5zLexJO/j1JKhPX6hfaO9IKr
	Z6QNUJSYciWAIzLEVyDRHb+dYSy8bsd3diqt3pSJlaQmPnd4JXlc0CnpgCfOStbIUwCxto9wdZ/m2
	BXuwkurG+/BapxMByuVMzkv150ItwDpT6f9r/TdVLdI66UeO/OOXlL671I3du2a2Ldc4X11/VmhQz
	+K6XpLcMWUADLGQ2EJhDcYNKEprrUbhwAppy/ad9zZi24HolVivdnJ4qJSezJzv7fR4CgpYGSUjz9
	AJeII8jekekP0Igu4wSw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gwCi4-0003Gi-FY; Tue, 19 Feb 2019 21:13:48 +0000
Received: from mailgw01.mediatek.com ([216.200.240.184])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gwCi1-0003GF-Al; Tue, 19 Feb 2019 21:13:47 +0000
X-UUID: c474132f5c9b4773b67b22ee348fdb1b-20190219
X-UUID: c474132f5c9b4773b67b22ee348fdb1b-20190219
Received: from mtkcas67.mediatek.inc [(172.29.193.45)] by mailgw01.mediatek.com
 (envelope-from <sean.wang@mediatek.com>)
 (musrelay.mediatek.com ESMTP with TLS)
 with ESMTP id 289004711; Tue, 19 Feb 2019 13:13:38 -0800
Received: from mtkmbs03n2.mediatek.inc (172.21.101.182) by
 MTKMBS62N1.mediatek.inc (172.29.193.41) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Tue, 19 Feb 2019 13:13:37 -0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs03n2.mediatek.inc (172.21.101.182) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Wed, 20 Feb 2019 05:13:22 +0800
Received: from [172.21.77.33] (172.21.77.33) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Wed, 20 Feb 2019 05:13:22 +0800
Message-ID: <1550610802.8245.1.camel@mtkswgap22>
Subject: Re: [PATCH 0/6]Bluetooth: mediatek: add support for MediaTek
 MT7663U and MT7668U UART devices
From: Sean Wang <sean.wang@mediatek.com>
To: Marcel Holtmann <marcel@holtmann.org>
Date: Wed, 20 Feb 2019 05:13:22 +0800
In-Reply-To: <B7EBA86E-B6C2-4301-BA01-004EA83A50A9@holtmann.org>
References: <cover.1550184473.git.sean.wang@mediatek.com>
 <B7EBA86E-B6C2-4301-BA01-004EA83A50A9@holtmann.org>
X-Mailer: Evolution 3.2.3-0ubuntu6 
MIME-Version: 1.0
X-TM-SNTS-SMTP: 98A3CAF5D64E85FAF0BAE40E263515CF4456794E36B4038D6C812BCE94E377172000:8
X-MTK: N
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190219_131345_378787_62730528 
X-CRM114-Status: GOOD (  16.76  )
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

Hi Marcel,

I will follow it up. Thank for your help!

	Sean


On Mon, 2019-02-18 at 14:10 +0100, Marcel Holtmann wrote:
> Hi Sean,
> 
> > This adds the support of enabling MT7668U and MT7663U UART based Bluetooth
> > function running on the top of btmtkuart driver.
> > 
> > We are through several patches to reach the goal and also wish applied
> > the same flow in MediaTek btusb [1] for the transport independence.
> > Once [1] and the series is being merged and then in next step I will
> > consider to add a btmtk.c to hold these independent operations among
> > various transport reused by MediaTek UART, USB and SDIO-based Bluetooth.
> > 
> > Firstly,
> > in patch 1/6 to update the dt-binding document for the kind of devices.
> > in patch 2/6, 3/6 to fix the common error issues in the current code.
> > in Patch 4/6, 5/6 to add the general flow which MT7622 and even MT7663U and
> > MT7668U USB devices also utilize.
> > 
> > Finally, in patch 6/6 to add the specific setups for MediaTek UART-based
> > Bluetooth and enable MT7663U and MT7668U device.
> > 
> > [1] http://lists.infradead.org/pipermail/linux-mediatek/2019-January/017074.html 
> > 
> > Sean Wang (6):
> >  dt-bindings: net: bluetooth: add support for MediaTek MT7663U and
> >    MT7668U UART devices
> >  Bluetooth: mediatek: trivial typo fix
> >  Bluetooth: mediatek: fix up an error path to restore bdev->tx_state
> >  Bluetooth: mediatek: pass a pointer to mtk_hci_wmt_sync
> >  Bluetooth: mediatek: update the common setup between MT7622 and other
> >    devices
> >  Bluetooth: mediatek: add support for MediaTek MT7663U and MT7668U UART
> >    devices
> > 
> > .../bindings/net/mediatek-bluetooth.txt       |  64 +++
> > drivers/bluetooth/btmtkuart.c                 | 538 ++++++++++++++++--
> > 2 files changed, 569 insertions(+), 33 deletions(-)
> 
> please re-send 1/6 and 6/6 when the DT changes are ACKed by Rob.
> 
> Regards
> 
> Marcel
> 



_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
