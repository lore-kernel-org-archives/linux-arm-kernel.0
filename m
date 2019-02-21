Return-Path: <SRS0=b3e6=Q4=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3856EC43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 13:32:59 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 046C12084F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 13:32:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="qJ43mXCx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 046C12084F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Date:To:From:Subject:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=ZyTuEWDnLHPShbjHiPpyBK9hr0N7dAE482GAGc1rKc4=; b=qJ43mXCx6Y16C1
	IHGHDFK03ycug5Jp3b5K0k+9ezXSACfTD/zAPoZTiQKyDCYaBi+x7uVdrR3wHzPESoLsTvsILwcWu
	+BeVIEUtt5XPioryhpXcC8/uaC1hTTo1vWiHb1QAv+ydTA3Mm3NnoIQm1q2ZnMOIoad9zewnBO/qa
	IHduauZJW6feZQy0WnDO7hBXlgW0Dzm3asBhamo831Fof3KLJw66WYJVlF4vDhGcdwtetGAxBkNV6
	gQ9KhkHGHortab901El/1CJ/Wj/3ySr80pPIcwIiCIiTbZd7dQbrUeexJNdbZqk9uWfWABa+5WU3M
	ZmFBAc/nyAc0Iuu82DHw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gwoTA-0006vn-3l; Thu, 21 Feb 2019 13:32:56 +0000
Received: from mailgw01.mediatek.com ([216.200.240.184])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gwoT6-0006vK-3x; Thu, 21 Feb 2019 13:32:53 +0000
X-UUID: aaf543bb8116461d8d858be26eb7b125-20190221
X-UUID: aaf543bb8116461d8d858be26eb7b125-20190221
Received: from mtkcas66.mediatek.inc [(172.29.193.44)] by mailgw01.mediatek.com
 (envelope-from <qii.wang@mediatek.com>)
 (musrelay.mediatek.com ESMTP with TLS)
 with ESMTP id 2101121905; Thu, 21 Feb 2019 05:32:14 -0800
Received: from MTKMBS31DR.mediatek.inc (172.27.6.102) by
 MTKMBS62DR.mediatek.inc (172.29.94.18) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Thu, 21 Feb 2019 05:32:12 -0800
Received: from MTKCAS36.mediatek.inc (172.27.4.186) by MTKMBS31DR.mediatek.inc
 (172.27.6.102) with Microsoft SMTP Server (TLS) id 15.0.1395.4;
 Thu, 21 Feb 2019 21:32:10 +0800
Received: from [10.17.3.153] (10.17.3.153) by MTKCAS36.mediatek.inc
 (172.27.4.170) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Thu, 21 Feb 2019 21:32:09 +0800
Message-ID: <1550755929.30363.26.camel@mhfsdcap03>
Subject: Re: [PATCH v4 2/3] dt-bindings: i2c: Add Mediatek MT8183 i2c binding
From: Qii Wang <qii.wang@mediatek.com>
To: Matthias Brugger <matthias.bgg@gmail.com>
Date: Thu, 21 Feb 2019 21:32:09 +0800
In-Reply-To: <e9d544c8-576d-f52c-d805-90d695b7ed46@gmail.com>
References: <1550666030-30211-1-git-send-email-qii.wang@mediatek.com>
 <1550666030-30211-3-git-send-email-qii.wang@mediatek.com>
 <e9d544c8-576d-f52c-d805-90d695b7ed46@gmail.com>
X-Mailer: Evolution 3.2.3-0ubuntu6 
MIME-Version: 1.0
X-MTK: N
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190221_053252_159769_930C28BB 
X-CRM114-Status: GOOD (  16.78  )
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
Cc: linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
 srv_heupstream@mediatek.com, robh@kernel.org, leilk.liu@mediatek.com,
 wsa@the-dreams.de, linux-kernel@vger.kernel.org, liguo.zhang@mediatek.com,
 linux-mediatek@lists.infradead.org, linux-i2c@vger.kernel.org,
 xinping.qian@mediatek.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Wed, 2019-02-20 at 16:25 +0100, Matthias Brugger wrote:
> 
> On 20/02/2019 13:33, Qii Wang wrote:
> > Add MT8183 i2c binding to binding file. Compare to MT2712 i2c
> > controller, MT8183 has different registers, offsets, and clock.
> > 
> > Signed-off-by: Qii Wang <qii.wang@mediatek.com>
> > ---
> >  Documentation/devicetree/bindings/i2c/i2c-mtk.txt |    5 +++--
> >  1 file changed, 3 insertions(+), 2 deletions(-)
> > 
> > diff --git a/Documentation/devicetree/bindings/i2c/i2c-mtk.txt b/Documentation/devicetree/bindings/i2c/i2c-mtk.txt
> > index ee4c324..da2fa60 100644
> > --- a/Documentation/devicetree/bindings/i2c/i2c-mtk.txt
> > +++ b/Documentation/devicetree/bindings/i2c/i2c-mtk.txt
> > @@ -12,14 +12,15 @@ Required properties:
> >        "mediatek,mt7623-i2c", "mediatek,mt6577-i2c": for MediaTek MT7623
> >        "mediatek,mt7629-i2c", "mediatek,mt2712-i2c": for MediaTek MT7629
> >        "mediatek,mt8173-i2c": for MediaTek MT8173
> > +      "mediatek,mt8183-i2c": for MediaTek MT8183
> >    - reg: physical base address of the controller and dma base, length of memory
> >      mapped region.
> >    - interrupts: interrupt number to the cpu.
> >    - clock-div: the fixed value for frequency divider of clock source in i2c
> >      module. Each IC may be different.
> >    - clocks: clock name from clock manager
> > -  - clock-names: Must include "main" and "dma", if enable have-pmic need include
> > -    "pmic" extra.
> > +  - clock-names: Must include "main" and "dma", "arb" is optional, if enable
> > +    have-pmic need include "pmic" extra.
> 
> You have to mention that the arb clock is only necessary for mt8183.
> 

Arb clock is not only necessary for mt8183. When two i2c controllers are
internally connected to the same GPIO pins, the arb clock is needed to
ensure that the waveforms do not interfere with each other.
Maybe ""arb" is for multi-master" is better. Not all i2c controller have
multi-master.

> >  
> >  Optional properties:
> >    - clock-frequency: Frequency in Hz of the bus when transfer, the default value
> > 



_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
