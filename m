Return-Path: <SRS0=sKCI=QH=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C781C169C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 21:11:15 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4E5AC20823
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 21:11:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="facEVHcx";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="UqxItAaI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4E5AC20823
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=gSKPlZph0KpKe0j1njQaXagM0avytgZRL0UrNHMjJSg=; b=facEVHcxkYWN3Z
	9rWFCKMr33ImSojwSrmSBCFhd2YTqQvhQR1evzuHaYMmwhLUsN1/mIg5LjJdoxrBwRBn2YyfBgd56
	d4pzbEQJ2Yg6geZXFiDvJIn1F50vpqT7aWDculBaQK1K2Rw93hpGAc0s0tgsJUWWMWAre4TArE21K
	T0NLMKUT5wxegqX/Og7qfTafeZUVsAdTy7G4D6hOBqFoOLyGAWyIfsJStjLOd8kL461kMJXt7dPU2
	cOmSkDFDRyNVmS5GRLpy+t6aD6+cN/uvvrXxR6d33OqwKZqAI4ljgTVhaRI56krXAOE8iUrgdUHlh
	+1sTbvJm35/OHwFSdKwA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gpJc6-0005bQ-Dr; Thu, 31 Jan 2019 21:11:10 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gpJc1-0005ZS-6B; Thu, 31 Jan 2019 21:11:08 +0000
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com
 [209.85.160.169])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 106D7218FE;
 Thu, 31 Jan 2019 21:11:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1548969064;
 bh=M8TqggX6bJmJ42B5/Ac86mIBJxlJxaEp9Yx65IUnl8U=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
 b=UqxItAaI7MSxj+FZVAiVCib9bu/t22fkZjQjKx1vFQUhRW1rWTZSEQRTu+Aq5iw7f
 myirTh7MSstupMu63vcL/xxG9U14xtBmbFUIAgg6MS5K7zLogRlHqNx/T+46Ael+1c
 ly+itsWHBpSuB/wcuUnAzTYYl08GrTqDb6b0wxvM=
Received: by mail-qt1-f169.google.com with SMTP id n32so5095272qte.11;
 Thu, 31 Jan 2019 13:11:04 -0800 (PST)
X-Gm-Message-State: AJcUukdg819M1ilYbOTLR3DAtzAbpldrk+UfrD6edVDVdgprpTuRmM8d
 LxYL0C/gvHJFNUmNkEu4ISMi3cpzJhSu8FCQxA==
X-Google-Smtp-Source: ALg8bN5xVlARGZqxDOmh1ggNeMx4EYwm/oRtZilP3Y7NQRPyYLJpcipt+Yc17uKzBoZxttL2JbY8dRmIzIVwt62G9Hs=
X-Received: by 2002:aed:29a6:: with SMTP id o35mr34761543qtd.257.1548969063278; 
 Thu, 31 Jan 2019 13:11:03 -0800 (PST)
MIME-Version: 1.0
References: <1548317240-44682-1-git-send-email-erin.lo@mediatek.com>
 <1548317240-44682-7-git-send-email-erin.lo@mediatek.com>
 <20190130162204.GA1521@bogus> <1548902050.23230.4.camel@mtksdaap41>
In-Reply-To: <1548902050.23230.4.camel@mtksdaap41>
From: Rob Herring <robh@kernel.org>
Date: Thu, 31 Jan 2019 15:10:52 -0600
X-Gmail-Original-Message-ID: <CAL_JsqL1vQCgbb2yLL2E4KTDZve1vus5bDX75HGiOu14X26q7w@mail.gmail.com>
Message-ID: <CAL_JsqL1vQCgbb2yLL2E4KTDZve1vus5bDX75HGiOu14X26q7w@mail.gmail.com>
Subject: Re: [PATCH v6 6/6] arm64: dts: Add Mediatek SoC MT8183 and evaluation
 board dts and Makefile
To: Erin Lo <erin.lo@mediatek.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190131_131105_261319_D1DB30DD 
X-CRM114-Status: GOOD (  17.70  )
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
Cc: Mark Rutland <mark.rutland@arm.com>, Ben Ho <Ben.Ho@mediatek.com>,
 Mars Cheng <mars.cheng@mediatek.com>, Mengqi Zhang <Mengqi.Zhang@mediatek.com>,
 linux-clk <linux-clk@vger.kernel.org>,
 Hsin-Hsiung Wang <hsin-hsiung.wang@mediatek.com>,
 Weiyi Lu <weiyi.lu@mediatek.com>, Seiya Wang <seiya.wang@mediatek.com>,
 "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>,
 Yingjoe Chen <yingjoe.chen@mediatek.com>, devicetree@vger.kernel.org,
 Jason Cooper <jason@lakedaemon.net>, Marc Zyngier <marc.zyngier@arm.com>,
 "moderated list:ARM/Mediatek SoC support" <linux-mediatek@lists.infradead.org>,
 Matthias Brugger <matthias.bgg@gmail.com>,
 Thomas Gleixner <tglx@linutronix.de>, Eddie Huang <eddie.huang@mediatek.com>,
 "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE"
 <linux-arm-kernel@lists.infradead.org>,
 srv_heupstream <srv_heupstream@mediatek.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Stephen Boyd <sboyd@codeaurora.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Zhiyong Tao <zhiyong.tao@mediatek.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Wed, Jan 30, 2019 at 8:34 PM Erin Lo <erin.lo@mediatek.com> wrote:
>
> On Wed, 2019-01-30 at 10:22 -0600, Rob Herring wrote:
> > On Thu, Jan 24, 2019 at 04:07:20PM +0800, Erin Lo wrote:
> > > From: Ben Ho <Ben.Ho@mediatek.com>
> > >
> > > Add basic chip support for Mediatek 8183, include
> > > pinctrl file, uart node with correct uart clocks, pwrap device
> > >
> > > Add clock controller nodes, include topckgen, infracfg,
> > > apmixedsys and subsystem.
> > >
> > > Signed-off-by: Ben Ho <Ben.Ho@mediatek.com>
> > > Signed-off-by: Erin Lo <erin.lo@mediatek.com>
> > > Signed-off-by: Seiya Wang <seiya.wang@mediatek.com>
> > > Signed-off-by: Zhiyong Tao <zhiyong.tao@mediatek.com>
> > > Signed-off-by: Weiyi Lu <weiyi.lu@mediatek.com>
> > > Signed-off-by: Mengqi Zhang <Mengqi.Zhang@mediatek.com>
> > > Signed-off-by: Hsin-Hsiung Wang <hsin-hsiung.wang@mediatek.com>
> > > Signed-off-by: Eddie Huang <eddie.huang@mediatek.com>
> > > ---
> >
> >
> > > +   sysirq: intpol-controller@c530a80 {
> >
> > interrupt-controller@...
>
> I will modify it in next version.
> >
> >
> > Place all the MMIO peripherals under one or more simple-bus nodes.
> >
> > Rob
> >
>
> Do you mean need to add simple-bus like this?

Yes.

>
> +   soc: soc {
> +                #address-cells = <0x1>;
> +                #size-cells = <0x1>;
> +                ranges = <0 0 0 0xffffffff>;
> +                compatible = "simple-bus";
>
>                 soc_data: soc_data@08000000 {
>                         compatible = "mediatek,mt8183-efuse",
>                                      "mediatek,efuse";
>                         reg = <0 0x08000000 0 0x0010>;
>                         #address-cells = <1>;
>                         #size-cells = <1>;
>                         status = "disabled";
>                 };
>
>                 gic: interrupt-controller@0c000000 {
>                         compatible = "arm,gic-v3";
>                         #interrupt-cells = <4>;
>
> Best Regards,
> Erin
>
> > _______________________________________________
> > Linux-mediatek mailing list
> > Linux-mediatek@lists.infradead.org
> > http://lists.infradead.org/mailman/listinfo/linux-mediatek
>
>
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
