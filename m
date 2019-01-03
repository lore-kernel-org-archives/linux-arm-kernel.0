Return-Path: <SRS0=5A9c=PL=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 162A1C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 14:17:11 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D30E32073D
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 14:17:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="GAclHNA7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D30E32073D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Date:To:From:Subject:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=5ACRiMEBH4GoT0/RlkHe9drD7HfguX01dBNr6oiBu2s=; b=GAclHNA7BrQ9Ro
	gMMhinLHr8OrkKbwnUk5AbsuWYEzZGGC6feq6LWKB3ojXcBFXQB90kGXFNrno+wveois7Nzc9BCJo
	aZrvWaeJ037Qyt/KYMssWgjhhoG8tR8sKE8rYFRQaajwPJEWpKek2jt94ShJ4FdgId2bg6uabO12l
	B2OSuHmYAL+4wNoWXujAgL1IE8U1PPe6EfSJQCWLdjpDnhrUa8o0FMnjIBmtFpBxwaDh1dxLDLF0z
	HzD3bbQYiFtKk9mCtEwH59uROiCxGWvPTFplJiUW4e0YLctetDUH3Qj682FrrX9XgMHHF3Fxvz6XW
	SvC27jfQG/KaaPX6XNIg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gf3nx-0001AF-37; Thu, 03 Jan 2019 14:17:01 +0000
Received: from mailgw02.mediatek.com ([216.200.240.185])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gf3ng-0000x2-Te; Thu, 03 Jan 2019 14:16:46 +0000
X-UUID: 6c46bd2b72224df8abd03ba684c409bf-20190103
X-UUID: 6c46bd2b72224df8abd03ba684c409bf-20190103
Received: from mtkcas66.mediatek.inc [(172.29.193.44)] by mailgw02.mediatek.com
 (envelope-from <henryc.chen@mediatek.com>)
 (musrelay.mediatek.com ESMTP with TLS)
 with ESMTP id 1877979991; Thu, 03 Jan 2019 06:16:42 -0800
Received: from MTKMBS01N1.mediatek.inc (172.21.101.68) by
 MTKMBS62N1.mediatek.inc (172.29.193.41) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Thu, 3 Jan 2019 06:16:41 -0800
Received: from mtkcas09.mediatek.inc (172.21.101.178) by
 mtkmbs01n1.mediatek.inc (172.21.101.68) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Thu, 3 Jan 2019 22:16:34 +0800
Received: from [172.21.77.4] (172.21.77.4) by mtkcas09.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Thu, 3 Jan 2019 22:16:34 +0800
Message-ID: <1546524994.6818.56.camel@mtksdaap41>
Subject: Re: [RFC RESEND PATCH 4/7] arm64: dts: mt8183: add performance
 state support of scpsys
From: Henry Chen <henryc.chen@mediatek.com>
To: Viresh Kumar <viresh.kumar@linaro.org>
Date: Thu, 3 Jan 2019 22:16:34 +0800
In-Reply-To: <20190103044727.i34ak7vw6qfircvq@vireshk-i7>
References: <1546438198-1677-1-git-send-email-henryc.chen@mediatek.com>
 <1546438198-1677-5-git-send-email-henryc.chen@mediatek.com>
 <20190103044727.i34ak7vw6qfircvq@vireshk-i7>
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
X-MTK: N
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190103_061644_959787_030F2C9C 
X-CRM114-Status: GOOD (  14.46  )
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
Cc: Mark Rutland <mark.rutland@arm.com>, James Liao <jamesjj.liao@mediatek.com>,
 Ulf Hansson <ulf.hansson@linaro.org>, Kees Cook <keescook@chromium.org>,
 Weiyi Lu <weiyi.lu@mediatek.com>, linux-pm@vger.kernel.org,
 Stephen Boyd <sboyd@kernel.org>, Viresh Kumar <vireshk@kernel.org>,
 linux-kernel@vger.kernel.org, Fan Chen <fan.chen@mediatek.com>,
 devicetree@vger.kernel.org, Rob
 Herring <robh+dt@kernel.org>, linux-mediatek@lists.infradead.org,
 Matthias Brugger <matthias.bgg@gmail.com>,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Thu, 2019-01-03 at 10:17 +0530, Viresh Kumar wrote:
> On 02-01-19, 22:09, Henry Chen wrote:
> > Add support for performance state of scpsys on mt8183 platform.
> > 
> > Signed-off-by: Henry Chen <henryc.chen@mediatek.com>
> > ---
> >  arch/arm64/boot/dts/mediatek/mt8183.dtsi | 21 +++++++++++++++++++++
> >  1 file changed, 21 insertions(+)
> > 
> > diff --git a/arch/arm64/boot/dts/mediatek/mt8183.dtsi b/arch/arm64/boot/dts/mediatek/mt8183.dtsi
> > index 47926a7..e396410 100644
> > --- a/arch/arm64/boot/dts/mediatek/mt8183.dtsi
> > +++ b/arch/arm64/boot/dts/mediatek/mt8183.dtsi
> > @@ -9,6 +9,7 @@
> >  #include <dt-bindings/interrupt-controller/irq.h>
> >  #include <dt-bindings/interrupt-controller/arm-gic.h>
> >  #include <dt-bindings/power/mt8183-power.h>
> > +#include <dt-bindings/soc/mtk,dvfsrc.h>
> >  
> >  / {
> >  	compatible = "mediatek,mt8183";
> > @@ -243,6 +244,26 @@
> >  			      "vpu-3", "vpu-4", "vpu-5";
> >  		infracfg = <&infracfg>;
> >  		smi_comm = <&smi_common>;
> > +		operating-points-v2 = <&dvfsrc_opp_table>;
> > +		dvfsrc_opp_table: opp-table {
> > +			compatible = "operating-points-v2-mtk-level";
> > +
> > +			dvfsrc_vol_min: opp1 {
> > +				mtk,level = <MT8183_DVFSRC_LEVEL_1>;
> > +			};
> > +
> > +			dvfsrc_freq_medium: opp2 {
> > +				mtk,level = <MT8183_DVFSRC_LEVEL_2>;
> > +			};
> > +
> > +			dvfsrc_freq_max: opp3 {
> > +				mtk,level = <MT8183_DVFSRC_LEVEL_3>;
> > +			};
> > +
> > +			dvfsrc_vol_max: opp4 {
> > +				mtk,level = <MT8183_DVFSRC_LEVEL_4>;
> > +			};
> > +		};
> >  	};
> 
> I don't see a patch which makes use of this OPP table using the required-opps
> thing. Where is that ?
> 

Those user drivers of mt8183(e.g. camera, video decoder,...etc) are
still preparing, so I send this RFC series to check if it is feasible
first then they can apply the interface and send for review later.

Henry 



_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
