Return-Path: <SRS0=ULCN=QZ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02B66C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 04:56:03 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C05B9218D8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 04:56:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="VM/yBzB8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C05B9218D8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Date:To:From:Subject:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=npAqkVEuI+3mbu1xZbnxEsLLvGtKRBXSFrYwYa+FwUY=; b=VM/yBzB8NhxFV2
	+Q2dJP4u4sqoAbqmNNevfIBkitPisyeu629Gr7424AW2rWBxgxdD8RWuFpjISMv2cjv2HgCkPXAi7
	msCF1IEsuK5DE0Le9u+2NNkRd8PHg6LRbDfh35DI+qP3vtEezQaqjS0P+XoRCcv0DUiKV6Y88mEzj
	phwSQ1G0/nyyxxliSkFKG/LHqPXeADGI2kG8PFIEjyAe0oK5nSl/6n5VGkjk1z1zyIkg4JHAsc08W
	S10HJxym9/Am0weIKQRckzRznpC8eKbOX/TNu3IjLuN2yBtSS/s+ty0F2cPQXmcu5EQnWz49reNof
	3sJe6qushmkEeH5GRdSg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gvayC-0003CM-FZ; Mon, 18 Feb 2019 04:55:56 +0000
Received: from mailgw02.mediatek.com ([216.200.240.185])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gvay9-0003Bu-B4; Mon, 18 Feb 2019 04:55:55 +0000
X-UUID: fc20c91a49354196810f3e99cee41db8-20190217
X-UUID: fc20c91a49354196810f3e99cee41db8-20190217
Received: from mtkcas66.mediatek.inc [(172.29.193.44)] by mailgw02.mediatek.com
 (envelope-from <henryc.chen@mediatek.com>)
 (musrelay.mediatek.com ESMTP with TLS)
 with ESMTP id 411665437; Sun, 17 Feb 2019 20:55:48 -0800
Received: from MTKMBS01N1.mediatek.inc (172.21.101.68) by
 MTKMBS62DR.mediatek.inc (172.29.94.18) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Sun, 17 Feb 2019 20:55:46 -0800
Received: from mtkcas09.mediatek.inc (172.21.101.178) by
 mtkmbs01n1.mediatek.inc (172.21.101.68) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Mon, 18 Feb 2019 12:55:32 +0800
Received: from [172.21.77.4] (172.21.77.4) by mtkcas09.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Mon, 18 Feb 2019 12:55:32 +0800
Message-ID: <1550465732.32365.6.camel@mtksdaap41>
Subject: Re: [RFC RESEND PATCH 1/7] dt-bindings: soc: Add DVFSRC driver
 bindings
From: Henry Chen <henryc.chen@mediatek.com>
To: Rob Herring <robh@kernel.org>
Date: Mon, 18 Feb 2019 12:55:32 +0800
In-Reply-To: <20190111160918.GA20480@bogus>
References: <1546438198-1677-1-git-send-email-henryc.chen@mediatek.com>
 <1546438198-1677-2-git-send-email-henryc.chen@mediatek.com>
 <20190111160918.GA20480@bogus>
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
X-MTK: N
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190217_205553_385283_6867918C 
X-CRM114-Status: GOOD (  26.41  )
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
 Ulf Hansson <ulf.hansson@linaro.org>, Kees
 Cook <keescook@chromium.org>, Weiyi Lu <weiyi.lu@mediatek.com>,
 linux-pm@vger.kernel.org, Stephen Boyd <sboyd@kernel.org>,
 Viresh Kumar <vireshk@kernel.org>, linux-kernel@vger.kernel.org,
 Fan Chen <fan.chen@mediatek.com>, devicetree@vger.kernel.org,
 linux-mediatek@lists.infradead.org, Matthias Brugger <matthias.bgg@gmail.com>,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi Rob,

Sorry for late reply. I missed this mail before.

On Fri, 2019-01-11 at 10:09 -0600, Rob Herring wrote:
> On Wed, Jan 02, 2019 at 10:09:52PM +0800, Henry Chen wrote:
> > Document the binding for enabling DVFSRC on MediaTek SoC.
> > 
> > Signed-off-by: Henry Chen <henryc.chen@mediatek.com>
> > ---
> >  .../devicetree/bindings/soc/mediatek/dvfsrc.txt    | 26 ++++++++++++++++++++++
> >  include/dt-bindings/soc/mtk,dvfsrc.h               | 18 +++++++++++++++
> >  2 files changed, 44 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/soc/mediatek/dvfsrc.txt
> >  create mode 100644 include/dt-bindings/soc/mtk,dvfsrc.h
> > 
> > diff --git a/Documentation/devicetree/bindings/soc/mediatek/dvfsrc.txt b/Documentation/devicetree/bindings/soc/mediatek/dvfsrc.txt
> > new file mode 100644
> > index 0000000..402c885
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/soc/mediatek/dvfsrc.txt
> > @@ -0,0 +1,26 @@
> > +MediaTek DVFSRC Driver
> 
> Bindings are for h/w blocks, not drivers.
ok.
> 
> > +The Dynamic Voltage and Frequency Scaling Resource Collector (DVFSRC) is a
> > +HW module which is used to collect all the requests from both software and
> > +hardware and turn into the decision of minimum operating voltage and minimum
> > +DRAM frequency to fulfill those requests.
> 
> Seems like the OPP table should be a child of this instead of where you 
> currently have it?
Do you means the opp table that I put on scpsys likes below?
I think this opp table is used for mapping the performance state of
power domain, so I put it on scpsys device tree document.

		dvfsrc_opp_table: opp-table {
			compatible = "operating-points-v2-level";

			dvfsrc_vol_min: opp1 {
				opp,level = <MT8183_DVFSRC_LEVEL_1>;
			};

			dvfsrc_freq_medium: opp2 {
				opp,level = <MT8183_DVFSRC_LEVEL_2>;
			};

			dvfsrc_freq_max: opp3 {
				opp,level = <MT8183_DVFSRC_LEVEL_3>;
			};

			dvfsrc_vol_max: opp4 {
				opp,level = <MT8183_DVFSRC_LEVEL_4>;
			};
		};

> 
> > +
> > +Required Properties:
> > +- compatible: Should be one of the following
> > +	- "mediatek,mt8183-dvfsrc": For MT8183 SoC
> > +- reg: Address range of the DVFSRC unit
> > +- dram_type: Refer to <include/dt-bindings/soc/mtk,dvfsrc.h> for the
> > +	different dram type support.
> 
> This information should come from the DDR controller or memory nodes 
> probably. And we already have some properties related to DDR type.
Sorry, I don't know that before, could you give some hint or example for
that?

> 
> > +- clock-names: Must include the following entries:
> > +	"dvfsrc": DVFSRC module clock
> > +- clocks: Must contain an entry for each entry in clock-names.
> > +
> > +Example:
> > +
> > +	dvfsrc_top@10012000 {
> 
> Drop the '_top'. (Don't use '_' in node and property names)..
ok
> 
> > +		compatible = "mediatek,mt8183-dvfsrc";
> > +		reg = <0 0x10012000 0 0x1000>;
> > +		clocks = <&infracfg CLK_INFRA_DVFSRC>;
> > +		clock-names = "dvfsrc";
> > +		dram_type = <MT8183_DVFSRC_OPP_LP4>;
> > +	};
> > diff --git a/include/dt-bindings/soc/mtk,dvfsrc.h b/include/dt-bindings/soc/mtk,dvfsrc.h
> > new file mode 100644
> > index 0000000..60b3497
> > --- /dev/null
> > +++ b/include/dt-bindings/soc/mtk,dvfsrc.h
> > @@ -0,0 +1,18 @@
> > +/* SPDX-License-Identifier: GPL-2.0
> > + *
> > + * Copyright (c) 2018 MediaTek Inc.
> > + */
> > +
> > +#ifndef _DT_BINDINGS_POWER_MTK_DVFSRC_H
> > +#define _DT_BINDINGS_POWER_MTK_DVFSRC_H
> > +
> > +#define MT8183_DVFSRC_OPP_LP4	0
> > +#define MT8183_DVFSRC_OPP_LP4X	1
> > +#define MT8183_DVFSRC_OPP_LP3	2
> > +
> > +#define MT8183_DVFSRC_LEVEL_1	1
> > +#define MT8183_DVFSRC_LEVEL_2	2
> > +#define MT8183_DVFSRC_LEVEL_3	3
> > +#define MT8183_DVFSRC_LEVEL_4	4
> > +
> > +#endif /* _DT_BINDINGS_POWER_MTK_DVFSRC_H */
> > -- 
> > 1.9.1
> > 
> 
> _______________________________________________
> Linux-mediatek mailing list
> Linux-mediatek@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-mediatek



_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
