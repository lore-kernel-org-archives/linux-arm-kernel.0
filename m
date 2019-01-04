Return-Path: <SRS0=E6Hv=PM=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06626C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 03:32:50 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C1C552070B
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 03:32:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="okcAsDgC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C1C552070B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Date:To:From:Subject:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=HIqBUlwJD3ixHLJyuldGKsOSvVEl/gS3ip2CX6U5Te4=; b=okcAsDgC5tst0a
	REMZfK0nQK0l+Lrpb4cJRliu9ClIsne24Wm4iUP20tp+dZl8m9XlqcNrhHNi7vRKEsp1524COOszg
	Y4c70hQqrnx+FSXY2VquYEN9o7pQ/uG6UWHGFAqs3BZbgNgn6kz0zF6pbuEEdV0VsF6gzN6aR2Xra
	zG1qe/NvFq76SOuic4rOsM8Sk2l/UNiUgg9atT1TVegbTxeTsJEWCeyPXJ7aoukOw2+IdPG6BP2Zy
	8xZUjfGZ6Zl+CZZ6rfwJMbszwcH57t/ykGmhT80Q0NXD2fk603yvrv707o0XSIwKGzigVN7i9/6kO
	DRX9ewEV12q1LJdo5CxQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gfGE3-0002Jv-3V; Fri, 04 Jan 2019 03:32:47 +0000
Received: from mailgw01.mediatek.com ([216.200.240.184])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gfGDy-0002J7-8z; Fri, 04 Jan 2019 03:32:44 +0000
X-UUID: 27459f85c9a74ae492243eec2978d786-20190103
X-UUID: 27459f85c9a74ae492243eec2978d786-20190103
Received: from mtkcas67.mediatek.inc [(172.29.193.45)] by mailgw01.mediatek.com
 (envelope-from <yunfei.dong@mediatek.com>)
 (musrelay.mediatek.com ESMTP with TLS)
 with ESMTP id 1306686075; Thu, 03 Jan 2019 19:32:37 -0800
Received: from mtkmbs08n2.mediatek.inc (172.21.101.56) by
 MTKMBS62DR.mediatek.inc (172.29.94.18) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Thu, 3 Jan 2019 19:32:35 -0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs08n2.mediatek.inc (172.21.101.56) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Fri, 4 Jan 2019 11:32:27 +0800
Received: from [10.17.3.153] (10.17.3.153) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Fri, 4 Jan 2019 11:32:27 +0800
Message-ID: <1546572747.12334.3.camel@mhfsdcap03>
Subject: Re: [PATCH 1/3] media: dt-bindings: media: Fix MTK document for vcodec
From: yunfei.dong <yunfei.dong@mediatek.com>
To: Rob Herring <robh@kernel.org>
Date: Fri, 4 Jan 2019 11:32:27 +0800
In-Reply-To: <20190103231722.GA22018@bogus>
References: <1545978785-31375-1-git-send-email-yunfei.dong@mediatek.com>
 <20190103231722.GA22018@bogus>
X-Mailer: Evolution 3.2.3-0ubuntu6 
MIME-Version: 1.0
X-TM-SNTS-SMTP: EFEA410DE7EBB00DC50E0C09612480869DE336CA69B2A267293D367BABCB28032000:8
X-MTK: N
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190103_193242_326399_BE46BA0D 
X-CRM114-Status: GOOD (  12.24  )
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
Cc: Mark Rutland <mark.rutland@arm.com>,
 Andrew-CT Chen <andrew-ct.chen@mediatek.com>,
 Tiffany Lin <tiffany.lin@mediatek.com>, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org,
 Qianqian Yan <qianqian.yan@mediatek.com>,
 Matthias Brugger <matthias.bgg@gmail.com>,
 Mauro Carvalho Chehab <mchehab@kernel.org>,
 linux-arm-kernel@lists.infradead.org, linux-media@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi Rob,

Thanks for your advice, I already sent the second patch.

Change note:
1: modify the subject for 0001*
2: modify the description for 0003

Best Regards,
Yunfei Dong


On Thu, 2019-01-03 at 17:17 -0600, Rob Herring wrote:
> On Fri, Dec 28, 2018 at 02:33:03PM +0800, Yunfei Dong wrote:
> > Fix MTK binding document for MT8173 dtsi changed in order
> > to use standard CCF interface.
> > MT8173 SoC from Mediatek.
> 
> A better subject would be "add 'assigned-clocks' to vcodec examples".
> 
> > 
> > Signed-off-by: Yunfei Dong <yunfei.dong@mediatek.com>
> > Signed-off-by: Qianqian Yan <qianqian.yan@mediatek.com>
> > ---
> >  .../devicetree/bindings/media/mediatek-vcodec.txt   | 13 +++++++++++++
> >  1 file changed, 13 insertions(+)
> > 
> > diff --git a/Documentation/devicetree/bindings/media/mediatek-vcodec.txt b/Documentation/devicetree/bindings/media/mediatek-vcodec.txt
> > index 2a615d84a682..b6b5dde6abd8 100644
> > --- a/Documentation/devicetree/bindings/media/mediatek-vcodec.txt
> > +++ b/Documentation/devicetree/bindings/media/mediatek-vcodec.txt
> > @@ -66,6 +66,15 @@ vcodec_dec: vcodec@16000000 {
> >                    "vencpll",
> >                    "venc_lt_sel",
> >                    "vdec_bus_clk_src";
> > +    assigned-clocks = <&topckgen CLK_TOP_VENC_LT_SEL>,
> > +                      <&topckgen CLK_TOP_CCI400_SEL>,
> > +                      <&topckgen CLK_TOP_VDEC_SEL>,
> > +                      <&apmixedsys CLK_APMIXED_VCODECPLL>,
> > +                      <&apmixedsys CLK_APMIXED_VENCPLL>;
> > +    assigned-clock-parents = <&topckgen CLK_TOP_VCODECPLL_370P5>,
> > +                             <&topckgen CLK_TOP_UNIVPLL_D2>,
> > +                             <&topckgen CLK_TOP_VCODECPLL>;
> > +    assigned-clock-rates = <0>, <0>, <0>, <1482000000>, <800000000>;
> >    };
> >  
> >    vcodec_enc: vcodec@18002000 {
> > @@ -105,4 +114,8 @@ vcodec_dec: vcodec@16000000 {
> >                    "venc_sel",
> >                    "venc_lt_sel_src",
> >                    "venc_lt_sel";
> > +    assigned-clocks = <&topckgen CLK_TOP_VENC_SEL>,
> > +                      <&topckgen CLK_TOP_VENC_LT_SEL>;
> > +    assigned-clock-parents = <&topckgen CLK_TOP_VENCPLL_D2>,
> > +                             <&topckgen CLK_TOP_UNIVPLL1_D2>;
> >    };
> > -- 
> > 2.19.1
> > 



_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
