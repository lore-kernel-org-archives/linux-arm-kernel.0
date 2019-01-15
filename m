Return-Path: <SRS0=3lKL=PX=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2B28C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 07:45:25 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9A16120578
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 07:45:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="CWeSuIFV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9A16120578
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Date:To:From:Subject:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=cvYMKYP8wrYoJPE0kDK/pFsemDl6+6OpU3Y5SX89GWQ=; b=CWeSuIFVSqoE5X
	b3d3GAVZGaXZBy8DJ19iyFfjBLELS9Xr8kryllDwGO1VntNa8tW+4zi69uCHTOhspnkDhQohys4DF
	S4VJvOFKleNphVazlPWsfR73Eleq33gQrRyd7GCrv2KES2ywCqzCkkALcD/1dgDLVJ0DXgScTiipG
	VZNV/PRU7A5lizmCn9S1CU5lX9sBOS+i/HeEzKz7EnE255H9HiO45qMGUeSrd/uthuhfayAit4FlQ
	qL/8p8kW+4t67OyyqksIfP9jCWOvvYGrjfRKPhDHh+cuZht5CsZaS2O7lQamHv4o7roRBJpSGXl1V
	kUAmV1CQj4h06TNMOUsA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gjJPX-0001nj-Gb; Tue, 15 Jan 2019 07:45:23 +0000
Received: from mailgw01.mediatek.com ([216.200.240.184])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gjJPI-00017b-Pj; Tue, 15 Jan 2019 07:45:10 +0000
X-UUID: b5d230ebf8ae43c7b110c99975969c53-20190114
X-UUID: b5d230ebf8ae43c7b110c99975969c53-20190114
Received: from mtkcas66.mediatek.inc [(172.29.193.44)] by mailgw01.mediatek.com
 (envelope-from <guochun.mao@mediatek.com>)
 (musrelay.mediatek.com ESMTP with TLS)
 with ESMTP id 413462872; Mon, 14 Jan 2019 23:45:02 -0800
Received: from MTKMBS31DR.mediatek.inc (172.27.6.102) by
 MTKMBS62DR.mediatek.inc (172.29.94.18) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Mon, 14 Jan 2019 23:45:00 -0800
Received: from MTKCAS36.mediatek.inc (172.27.4.186) by MTKMBS31DR.mediatek.inc
 (172.27.6.102) with Microsoft SMTP Server (TLS) id 15.0.1395.4;
 Tue, 15 Jan 2019 15:44:58 +0800
Received: from [10.17.3.153] (10.17.3.153) by MTKCAS36.mediatek.inc
 (172.27.4.170) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Tue, 15 Jan 2019 15:44:57 +0800
Message-ID: <1547538297.10234.4.camel@mhfsdcap03>
Subject: Re: [PATCH v1 2/3] mtd: spi-nor: mtk-quadspi: add SNOR_HWCAPS_READ
 for capcity setting
From: Guochun Mao <guochun.mao@mediatek.com>
To: <Tudor.Ambarus@microchip.com>
Date: Tue, 15 Jan 2019 15:44:57 +0800
In-Reply-To: <8afdb25c-894b-0a89-b7a8-b754fb4ba905@microchip.com>
References: <67e650ca4fcaaddbbc98bf4e1cbe04647c990dc3.1547442452.git.ryder.lee@mediatek.com>
 <54bb8a9d517e2ee35018d78457c6aa6a4970e644.1547442452.git.ryder.lee@mediatek.com>
 <8afdb25c-894b-0a89-b7a8-b754fb4ba905@microchip.com>
X-Mailer: Evolution 3.2.3-0ubuntu6 
MIME-Version: 1.0
X-MTK: N
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190114_234508_844014_74A9C873 
X-CRM114-Status: GOOD (  19.49  )
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
 boris.brezillon@bootlin.com, weijie.gao@mediatek.com,
 linux-kernel@vger.kernel.org, marek.vasut@gmail.com, robh+dt@kernel.org,
 linux-mtd@lists.infradead.org, linux-mediatek@lists.infradead.org,
 computersforpeace@gmail.com, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Tue, 2019-01-15 at 06:59 +0000, Tudor.Ambarus@microchip.com wrote:
> Hi, Ryder,
> 
> On 01/14/2019 07:12 AM, Ryder Lee wrote:
> > From: Guochun Mao <guochun.mao@mediatek.com>
> > 
> > SNOR_HWCAPS_READ is a basic read mode for both flash and controller,
> > it should be supported, so add the capcity for mtk-quadspi.
> 
> Since I couldn't find a datasheet for mt8173, I tend to share your assumption -
> SNOR_HWCAPS_READ should be supported by this controller. However, it's always
> better to test it and not rely on assumptions. You can test it by forcing the
> mask to have just SNOR_HWCAPS_READ | SNOR_HWCAPS_PP set. Or you already tested it?

Our IPs all support SNOR_HWCAPS_READ, Ryedr and I have test it.

> 
> You have a typo in capcity. Maybe substitute it with capability or "add this
> flag to spi_nor_hwcaps mask"

Ok, we'll correct it next version.

Thanks.
Guochun
> 
> > 
> > Signed-off-by: Guochun Mao <guochun.mao@mediatek.com>
> 
> You should add your SoB tag, because you are sending a patch that is not yours.
> 
> Cheers,
> ta
> 
> > ---
> > Changes since v1: none. 
> > ---
> >  drivers/mtd/spi-nor/mtk-quadspi.c | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/mtd/spi-nor/mtk-quadspi.c b/drivers/mtd/spi-nor/mtk-quadspi.c
> > index 5442993..d9eed68 100644
> > --- a/drivers/mtd/spi-nor/mtk-quadspi.c
> > +++ b/drivers/mtd/spi-nor/mtk-quadspi.c
> > @@ -431,7 +431,8 @@ static int mtk_nor_init(struct mtk_nor *mtk_nor,
> >  			struct device_node *flash_node)
> >  {
> >  	const struct spi_nor_hwcaps hwcaps = {
> > -		.mask = SNOR_HWCAPS_READ_FAST |
> > +		.mask = SNOR_HWCAPS_READ |
> > +			SNOR_HWCAPS_READ_FAST |
> >  			SNOR_HWCAPS_READ_1_1_2 |
> >  			SNOR_HWCAPS_PP,
> >  	};
> > 



_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
