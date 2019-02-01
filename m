Return-Path: <SRS0=JyYb=QI=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3869C282D8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 05:11:37 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ADF7620857
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 05:11:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="ZmZPeGBG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ADF7620857
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Date:To:From:Subject:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=SeBy44Jq/QmwWr6WaPTfNZyaOWIfuMVWH1D1khXIMrM=; b=ZmZPeGBG50y9D2
	AlzP9scMHUtMdhNxKoj5e0RFxvH2zncSDcOdudEFnH2HqvMbUXGz8cSYXYj/8VmuMgJiqLF2ghiqZ
	avLeX68vsHqzIfXFs0+uBkyBZ+s37a64xM8xs6N2YxVkE+VspdDTQ+Kg53V8QMQCFy4iLYHUDeQyu
	+TI7JmO2Oo92LAwWX//y89DvAvyrIMcYZ27IG1PY5X04S4gvXC/wkdL6zfmwTGy5G3VcI9eeOePXh
	uqeOX+B3xPBpaASxRRziH9S3lpDkhANuPzGA7w3eCiM/pKMmkJP55tew36UCaV3tgd1QjV9Rg/Gve
	u6Ac2OUWD0fROyHnxeYw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gpR71-0004tE-Uo; Fri, 01 Feb 2019 05:11:35 +0000
Received: from mailgw01.mediatek.com ([216.200.240.184])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gpR6x-0004rj-MV; Fri, 01 Feb 2019 05:11:33 +0000
X-UUID: c015922b732240ccbe7e77804ec01eab-20190131
X-UUID: c015922b732240ccbe7e77804ec01eab-20190131
Received: from mtkcas68.mediatek.inc [(172.29.94.19)] by mailgw01.mediatek.com
 (envelope-from <erin.lo@mediatek.com>)
 (musrelay.mediatek.com ESMTP with TLS)
 with ESMTP id 625011758; Thu, 31 Jan 2019 21:11:10 -0800
Received: from mtkmbs03n1.mediatek.inc (172.21.101.181) by
 MTKMBS62N2.mediatek.inc (172.29.193.42) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Thu, 31 Jan 2019 21:11:09 -0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs03n1.mediatek.inc (172.21.101.181) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Fri, 1 Feb 2019 13:11:07 +0800
Received: from [172.21.77.4] (172.21.77.4) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Fri, 1 Feb 2019 13:11:06 +0800
Message-ID: <1548997866.26127.4.camel@mtksdaap41>
Subject: Re: [PATCH v6 6/6] arm64: dts: Add Mediatek SoC MT8183 and
 evaluation board dts and Makefile
From: Erin Lo <erin.lo@mediatek.com>
To: Rob Herring <robh@kernel.org>
Date: Fri, 1 Feb 2019 13:11:06 +0800
In-Reply-To: <1548992018.11367.8.camel@mtksdaap41>
References: <1548317240-44682-1-git-send-email-erin.lo@mediatek.com>
 <1548317240-44682-7-git-send-email-erin.lo@mediatek.com>
 <20190130162204.GA1521@bogus> <1548902050.23230.4.camel@mtksdaap41>
 <CAL_JsqL1vQCgbb2yLL2E4KTDZve1vus5bDX75HGiOu14X26q7w@mail.gmail.com>
 <1548992018.11367.8.camel@mtksdaap41>
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
X-MTK: N
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190131_211131_743748_191D8990 
X-CRM114-Status: GOOD (  17.82  )
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
Cc: Mark Rutland <mark.rutland@arm.com>, Ben Ho <Ben.Ho@mediatek.com>, Mars
 Cheng <mars.cheng@mediatek.com>, Mengqi Zhang <Mengqi.Zhang@mediatek.com>,
 linux-clk <linux-clk@vger.kernel.org>,
 Hsin-Hsiung Wang <hsin-hsiung.wang@mediatek.com>,
 Weiyi Lu <weiyi.lu@mediatek.com>, Seiya Wang <seiya.wang@mediatek.com>,
 "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>,
 Yingjoe Chen <yingjoe.chen@mediatek.com>, devicetree@vger.kernel.org,
 Jason Cooper <jason@lakedaemon.net>, Marc Zyngier <marc.zyngier@arm.com>,
 "moderated list:ARM/Mediatek SoC support" <linux-mediatek@lists.infradead.org>,
 Matthias Brugger <matthias.bgg@gmail.com>,
 Thomas Gleixner <tglx@linutronix.de>, Eddie Huang <eddie.huang@mediatek.com>,
 "moderated list:ARM/FREESCALE IMX / MXC ARM
 ARCHITECTURE" <linux-arm-kernel@lists.infradead.org>,
 srv_heupstream <srv_heupstream@mediatek.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Stephen Boyd <sboyd@codeaurora.org>, linux-kernel@vger.kernel.org,
 Zhiyong Tao <Zhiyong.Tao@mediatek.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Add back more people since mail server issue

On Fri, 2019-02-01 at 11:33 +0800, Erin Lo wrote:
> On Thu, 2019-01-31 at 15:10 -0600, Rob Herring wrote:
> > On Wed, Jan 30, 2019 at 8:34 PM Erin Lo <erin.lo@mediatek.com> wrote:
> > >
> > > On Wed, 2019-01-30 at 10:22 -0600, Rob Herring wrote:
> > > > On Thu, Jan 24, 2019 at 04:07:20PM +0800, Erin Lo wrote:
> > > > > From: Ben Ho <Ben.Ho@mediatek.com>
> > > > >
> > > > > Add basic chip support for Mediatek 8183, include
> > > > > pinctrl file, uart node with correct uart clocks, pwrap device
> > > > >
> > > > > Add clock controller nodes, include topckgen, infracfg,
> > > > > apmixedsys and subsystem.
> > > > >
> > > > > Signed-off-by: Ben Ho <Ben.Ho@mediatek.com>
> > > > > Signed-off-by: Erin Lo <erin.lo@mediatek.com>
> > > > > Signed-off-by: Seiya Wang <seiya.wang@mediatek.com>
> > > > > Signed-off-by: Zhiyong Tao <zhiyong.tao@mediatek.com>
> > > > > Signed-off-by: Weiyi Lu <weiyi.lu@mediatek.com>
> > > > > Signed-off-by: Mengqi Zhang <Mengqi.Zhang@mediatek.com>
> > > > > Signed-off-by: Hsin-Hsiung Wang <hsin-hsiung.wang@mediatek.com>
> > > > > Signed-off-by: Eddie Huang <eddie.huang@mediatek.com>
> > > > > ---
> > > >
> > > >
> > > > > +   sysirq: intpol-controller@c530a80 {
> > > >
> > > > interrupt-controller@...
> > >
> > > I will modify it in next version.
> > > >
> > > >
> > > > Place all the MMIO peripherals under one or more simple-bus nodes.
> > > >
> > > > Rob
> > > >
> > >
> > > Do you mean need to add simple-bus like this?
> > 
> > Yes.
> 
> We remove soc because Matthias suggested it in former MTK SoC maybe in
> 2015 year.
> 
> We will add it back by your comment.
> 
> Thank you. 
> 
> Best Regards,
> Erin

Hi, Matthias,
Do you have any comment here?
Thanks

Best Regards,
Erin
> > 
> > >
> > > +   soc: soc {
> > > +                #address-cells = <0x1>;
> > > +                #size-cells = <0x1>;
> > > +                ranges = <0 0 0 0xffffffff>;
> > > +                compatible = "simple-bus";
> > >
> > >                 soc_data: soc_data@08000000 {
> > >                         compatible = "mediatek,mt8183-efuse",
> > >                                      "mediatek,efuse";
> > >                         reg = <0 0x08000000 0 0x0010>;
> > >                         #address-cells = <1>;
> > >                         #size-cells = <1>;
> > >                         status = "disabled";
> > >                 };
> > >
> > >                 gic: interrupt-controller@0c000000 {
> > >                         compatible = "arm,gic-v3";
> > >                         #interrupt-cells = <4>;
> > >
> > > Best Regards,
> > > Erin
> > >
> > > > _______________________________________________
> > > > Linux-mediatek mailing list
> > > > Linux-mediatek@lists.infradead.org
> > > > http://lists.infradead.org/mailman/listinfo/linux-mediatek
> > >
> > >
> > >
> > > _______________________________________________
> > > linux-arm-kernel mailing list
> > > linux-arm-kernel@lists.infradead.org
> > > http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 



_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
