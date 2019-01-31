Return-Path: <SRS0=sKCI=QH=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CDE2C282D7
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 02:34:24 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2562320B1F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 02:34:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="kNFvQZn9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2562320B1F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Date:To:From:Subject:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=4vuA1ej3kqGxhoNKmWmzm8yRyn5S/KMgdCcg50Gf0nE=; b=kNFvQZn9GD3KwE
	p9QUX5TAGTBBhbPzOPc9ka5rXaU7m6IknT8QrjIEZ56Oi9TeI/OWL28xbYd+wEFMueWOhUIpJhgDC
	JYqF+c8XHGWA5QHx1lOC6UUqz2AuqndACWP41UXQsEvjT2nRzE6DnzuHOMMCa9g5D1gyJDPqxikNs
	a55Iof52CRnj/PZk3uTfjRlQcb0deP4eE4RcE5Wh1lJueuM6rES968gfcAD2Y6XUYLkpIpglWdCHA
	PtpwF0wi7KHIdp1CqPMG0KrIDLstcIdIV2l216+TJ1ENHT2jRQHHnlVEk6nwCx1Yp7M3vi6wziVq4
	qRoEGaeCyco+Qdh+tq7w==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gp2BK-0008C7-3D; Thu, 31 Jan 2019 02:34:22 +0000
Received: from mailgw02.mediatek.com ([216.200.240.185])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gp2BG-0008BN-28; Thu, 31 Jan 2019 02:34:19 +0000
X-UUID: b85c90f6745c4de882f32a589e15b102-20190130
X-UUID: b85c90f6745c4de882f32a589e15b102-20190130
Received: from mtkcas66.mediatek.inc [(172.29.193.44)] by mailgw02.mediatek.com
 (envelope-from <erin.lo@mediatek.com>)
 (musrelay.mediatek.com ESMTP with TLS)
 with ESMTP id 1379432377; Wed, 30 Jan 2019 18:34:14 -0800
Received: from mtkmbs08n2.mediatek.inc (172.21.101.56) by
 MTKMBS62DR.mediatek.inc (172.29.94.18) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Wed, 30 Jan 2019 18:34:13 -0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs08n2.mediatek.inc (172.21.101.56) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Thu, 31 Jan 2019 10:34:10 +0800
Received: from [172.21.77.4] (172.21.77.4) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Thu, 31 Jan 2019 10:34:10 +0800
Message-ID: <1548902050.23230.4.camel@mtksdaap41>
Subject: Re: [PATCH v6 6/6] arm64: dts: Add Mediatek SoC MT8183 and
 evaluation board dts and Makefile
From: Erin Lo <erin.lo@mediatek.com>
To: Rob Herring <robh@kernel.org>
Date: Thu, 31 Jan 2019 10:34:10 +0800
In-Reply-To: <20190130162204.GA1521@bogus>
References: <1548317240-44682-1-git-send-email-erin.lo@mediatek.com>
 <1548317240-44682-7-git-send-email-erin.lo@mediatek.com>
 <20190130162204.GA1521@bogus>
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
X-TM-SNTS-SMTP: 14330CE4A278BEFC08A742B7265A20949BB9CE8105936BB5CFA505010BB319132000:8
X-MTK: N
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190130_183418_105591_21C42D50 
X-CRM114-Status: GOOD (  14.22  )
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
 mars.cheng@mediatek.com, Mengqi Zhang <Mengqi.Zhang@mediatek.com>,
 linux-clk@vger.kernel.org, Hsin-Hsiung Wang <hsin-hsiung.wang@mediatek.com>,
 Weiyi Lu <weiyi.lu@mediatek.com>, Marc Zyngier <marc.zyngier@arm.com>,
 linux-serial@vger.kernel.org, yingjoe.chen@mediatek.com,
 devicetree@vger.kernel.org, Jason Cooper <jason@lakedaemon.net>, Seiya
 Wang <seiya.wang@mediatek.com>, linux-mediatek@lists.infradead.org,
 Matthias Brugger <matthias.bgg@gmail.com>,
 Thomas Gleixner <tglx@linutronix.de>, eddie.huang@mediatek.com,
 linux-arm-kernel@lists.infradead.org,
 srv_heupstream <srv_heupstream@mediatek.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Stephen Boyd <sboyd@codeaurora.org>, linux-kernel@vger.kernel.org,
 Zhiyong Tao <zhiyong.tao@mediatek.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Wed, 2019-01-30 at 10:22 -0600, Rob Herring wrote:
> On Thu, Jan 24, 2019 at 04:07:20PM +0800, Erin Lo wrote:
> > From: Ben Ho <Ben.Ho@mediatek.com>
> > 
> > Add basic chip support for Mediatek 8183, include
> > pinctrl file, uart node with correct uart clocks, pwrap device
> > 
> > Add clock controller nodes, include topckgen, infracfg,
> > apmixedsys and subsystem.
> > 
> > Signed-off-by: Ben Ho <Ben.Ho@mediatek.com>
> > Signed-off-by: Erin Lo <erin.lo@mediatek.com>
> > Signed-off-by: Seiya Wang <seiya.wang@mediatek.com>
> > Signed-off-by: Zhiyong Tao <zhiyong.tao@mediatek.com>
> > Signed-off-by: Weiyi Lu <weiyi.lu@mediatek.com>
> > Signed-off-by: Mengqi Zhang <Mengqi.Zhang@mediatek.com>
> > Signed-off-by: Hsin-Hsiung Wang <hsin-hsiung.wang@mediatek.com>
> > Signed-off-by: Eddie Huang <eddie.huang@mediatek.com>
> > ---
> 
> 
> > +	sysirq: intpol-controller@c530a80 {
> 
> interrupt-controller@...

I will modify it in next version.
> 
> 
> Place all the MMIO peripherals under one or more simple-bus nodes.
> 
> Rob
> 

Do you mean need to add simple-bus like this?

+   soc: soc {
+                #address-cells = <0x1>;
+                #size-cells = <0x1>;
+                ranges = <0 0 0 0xffffffff>;
+                compatible = "simple-bus";

	        soc_data: soc_data@08000000 {
	                compatible = "mediatek,mt8183-efuse",
	                             "mediatek,efuse";
	                reg = <0 0x08000000 0 0x0010>;
	                #address-cells = <1>;
	                #size-cells = <1>;
	                status = "disabled";
	        };

	        gic: interrupt-controller@0c000000 {
	                compatible = "arm,gic-v3";
	                #interrupt-cells = <4>;
	
Best Regards,
Erin

> _______________________________________________
> Linux-mediatek mailing list
> Linux-mediatek@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-mediatek



_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
