Return-Path: <SRS0=sCCJ=QS=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B19EC169C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 05:20:32 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3CC1720855
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 05:20:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="ITjRO6I0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3CC1720855
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Date:To:From:Subject:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=MfJtahk3CsX17WSEQ4dVA6XCGtEWW6bXZigRrVQZBjs=; b=ITjRO6I0/bgs7p
	Vn7yt1oqypt6fa+tAzf5YheCXggb0K+d7YvWwvng4UnVLF45M0q0uuqs05juOLgt2hyjlalD+DY5t
	N8oRAOVESq22BEq8R2ZUKTZHvT+zJX43qaXmjoIrrn3vUeZF7oxsrfzEkMCGw5tLMHyuRSdbwkAq8
	o8SXeqLVB4PYPPOiD4rJ3SuDGgKbnKPsEDhU+gjhL+I1Ly5QwrY7au2+QBnWrhoeYvGebCb0piSun
	RTdciV7el9VgzEKflwGawEaKCDTsTwtYnvWGa4Ow7RI+ulVYsMvG/HPjSxu1Jb3p3rXfCUL2rN1Pp
	ZkGfSU4tAZJfiIp4XF6Q==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gt410-0006cU-Fq; Mon, 11 Feb 2019 05:20:22 +0000
Received: from mailgw01.mediatek.com ([216.200.240.184])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gt40w-0006by-AL; Mon, 11 Feb 2019 05:20:20 +0000
X-UUID: b25bc29d0d394bdf8fcd76cb13ee6d59-20190210
X-UUID: b25bc29d0d394bdf8fcd76cb13ee6d59-20190210
Received: from mtkcas66.mediatek.inc [(172.29.193.44)] by mailgw01.mediatek.com
 (envelope-from <seiya.wang@mediatek.com>)
 (musrelay.mediatek.com ESMTP with TLS)
 with ESMTP id 1278377819; Sun, 10 Feb 2019 21:20:06 -0800
Received: from mtkmbs03n1.mediatek.inc (172.21.101.181) by
 MTKMBS62N2.mediatek.inc (172.29.193.42) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Sun, 10 Feb 2019 21:20:05 -0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs03n1.mediatek.inc (172.21.101.181) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Mon, 11 Feb 2019 13:20:03 +0800
Received: from [172.21.84.99] (172.21.84.99) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Mon, 11 Feb 2019 13:20:03 +0800
Message-ID: <1549862403.22817.11.camel@mtksdccf07>
Subject: Re: [PATCH v1 1/1] arm64: dts: mt8173: add pmu nodes for mt8173
From: Seiya Wang <seiya.wang@mediatek.com>
To: Matthias Brugger <matthias.bgg@gmail.com>
Date: Mon, 11 Feb 2019 13:20:03 +0800
In-Reply-To: <38a56fc1-09fa-a35a-fcef-e265f1608b83@gmail.com>
References: <20190109082143.26468-1-seiya.wang@mediatek.com>
 <38a56fc1-09fa-a35a-fcef-e265f1608b83@gmail.com>
X-Mailer: Evolution 3.2.3-0ubuntu6 
MIME-Version: 1.0
X-MTK: N
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190210_212018_365620_58D60E7A 
X-CRM114-Status: GOOD (  15.68  )
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
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org,
 srv_heupstream@mediatek.com, linux-kernel@vger.kernel.org,
 Rob Herring <robh+dt@kernel.org>, linux-mediatek@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Fri, 2019-02-08 at 16:04 +0100, Matthias Brugger wrote:
> 
> On 09/01/2019 09:21, Seiya Wang wrote:
> > This patch adds the device nodes of ARM Performance Monitor Uint
> > for mt8173.
> > 
> > Signed-off-by: Seiya Wang <seiya.wang@mediatek.com>
> > ---
> >  arch/arm64/boot/dts/mediatek/mt8173.dtsi | 14 ++++++++++++++
> >  1 file changed, 14 insertions(+)
> > 
> > diff --git a/arch/arm64/boot/dts/mediatek/mt8173.dtsi b/arch/arm64/boot/dts/mediatek/mt8173.dtsi
> > index 412ffd4d426b..44374c506a1c 100644
> > --- a/arch/arm64/boot/dts/mediatek/mt8173.dtsi
> > +++ b/arch/arm64/boot/dts/mediatek/mt8173.dtsi
> > @@ -216,6 +216,20 @@
> >  		};
> >  	};
> >  
> > +	pmu_a53 {
> > +		compatible = "arm,cortex-a53-pmu";
> > +		interrupts = <GIC_SPI 8 IRQ_TYPE_LEVEL_LOW>,
> > +			     <GIC_SPI 9 IRQ_TYPE_LEVEL_LOW>;
> > +		interrupt-affinity = <&cpu0>, <&cpu1>;
> > +	};
> > +
> > +	pmu_a72 {
> > +		compatible = "arm,cortex-a72-pmu";
> > +		interrupts = <GIC_SPI 12 IRQ_TYPE_LEVEL_LOW>,
> > +			     <GIC_SPI 13 IRQ_TYPE_LEVEL_LOW>;
> > +		interrupt-affinity = <&cpu2>, <&cpu3>;
> > +	};
> 
> There is no a72 but a a57 CPU present.
> Typo?
> 
> Regards,
> Matthias

MT8173 is actually using a72, not a57.
I will submit another patch for fixing it.

Thanks.

> > +
> >  	psci {
> >  		compatible = "arm,psci-1.0", "arm,psci-0.2", "arm,psci";
> >  		method = "smc";
> > 



_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
