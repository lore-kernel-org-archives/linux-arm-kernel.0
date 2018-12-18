Return-Path: <SRS0=e5Gl=O3=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F5A6C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 02:36:43 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E0A36214C6
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 02:36:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="ZFLTeklb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E0A36214C6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Date:To:From:Subject:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=kkulqsLU7hCuP6/wNktCD0Yixzwtrjo+YevokXq+ngA=; b=ZFLTeklbm83gAb
	Ht4pKQ1Cv5eMwq22lzdwjkGN/TRaIjXeD58Airkx9b40tuaqKCqd6BefC3I9tQo25NTszMzA4eGgt
	6ii4JdCzOQ4SmT8XakiTjgPt+SVKnOqjMRatEuXzFZRtC7NGvoYzH1+3jSrcfDlNU7728vApKhHaE
	t2h5SiYPyHc7Vot/xAOmLUoOYIxeVNWpr3Tg5f7zMjoT6BiFVHCvn57yDOZY2Gf2MwrlaHvtyvHZ5
	KVnaceTtGpPSjnI5QBWjXeTedIPWpu5drRib0mpiT9pWFSXv2qw7rrvop2GmbAx8LUj5049xIKnsx
	ZRv1r9NY3obo+8/pX6iw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gZ5FM-0008Sd-Ei; Tue, 18 Dec 2018 02:36:36 +0000
Received: from [1.203.163.78] (helo=mailgw01.mediatek.com)
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gZ5FJ-0008G5-25; Tue, 18 Dec 2018 02:36:34 +0000
X-UUID: 12d34f486d8a4aae9f0d0a9ed5da43f5-20181218
X-UUID: 12d34f486d8a4aae9f0d0a9ed5da43f5-20181218
Received: from mtkcas32.mediatek.inc [(172.27.4.250)] by mailgw01.mediatek.com
 (envelope-from <qii.wang@mediatek.com>)
 (mailgw01.mediatek.com ESMTP with TLS)
 with ESMTP id 1683043214; Tue, 18 Dec 2018 10:35:27 +0800
Received: from MTKCAS32.mediatek.inc (172.27.4.184) by MTKMBS31N2.mediatek.inc
 (172.27.4.87) with Microsoft SMTP Server (TLS) id 15.0.1395.4;
 Tue, 18 Dec 2018 10:35:25 +0800
Received: from [10.17.3.153] (10.17.3.153) by MTKCAS32.mediatek.inc
 (172.27.4.170) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Tue, 18 Dec 2018 10:35:25 +0800
Message-ID: <1545100525.11699.47.camel@mhfsdcap03>
Subject: Re: [PATCH 4/5] dt-bindings: i2c: Add Mediatek MT8183 i2c binding
From: Qii Wang <qii.wang@mediatek.com>
To: Wolfram Sang <wsa@the-dreams.de>
Date: Tue, 18 Dec 2018 10:35:25 +0800
In-Reply-To: <20181217230629.i7i3kbreurgt7u73@ninjato>
References: <1543843974-4054-1-git-send-email-qii.wang@mediatek.com>
 <1543843974-4054-5-git-send-email-qii.wang@mediatek.com>
 <20181211202931.xav4gzi7rzh2scgx@ninjato>
 <1544693547.11699.40.camel@mhfsdcap03>
 <20181217230629.i7i3kbreurgt7u73@ninjato>
X-Mailer: Evolution 3.2.3-0ubuntu6 
MIME-Version: 1.0
X-MTK: N
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181217_183633_311233_D2D87C52 
X-CRM114-Status: GOOD (  12.63  )
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
Cc: devicetree@vger.kernel.org, ryder.lee@mediatek.com,
 srv_heupstream@mediatek.com, leilk.liu@mediatek.com,
 linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org,
 linux-i2c@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Tue, 2018-12-18 at 00:06 +0100, Wolfram Sang wrote:
> > > What is "multi-user"? Why can't you add this offset to the reg-property
> > > directly?
> 
> ...
> 
> > MT8183 doesn't need to support muti-user according to the latest project
> > information, and I'll remove this feature from patches.
> 
> Okay. It will be dropped then, thanks for the heads up!
> 
> > > > +  - mediatek,share-i3c: i3c controller can share i2c function.
> > > 
> > > Please explain in more detail? Is this an I3C controller?
> > 
> > Yes, it is a i3c controller, and it is compatible with i2c. I only use
> > the feature of i2c, so I need a flag to do some extra settings.
> 
> Can't you derive this from the compatible? If it is
> "mediatek,mt8183-i2c", then you know you need these extra settings?
> 

Not all channels are i3c controllers in MT8183. only i3c controller need
some extra settings.



_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
