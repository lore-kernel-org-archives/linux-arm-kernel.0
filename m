Return-Path: <SRS0=niBm=QV=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	UNPARSEABLE_RELAY autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F2D7C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 08:30:47 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D0FD82229F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 08:30:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="mIDcJQ0Y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D0FD82229F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Date:To:From:Subject:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=KgvvVe4og2OzvC3kpxiGRotu69ZKqUkkVJQarugr1mQ=; b=mIDcJQ0Yg7IN+1
	7o3nlCu1jvSWrIWd1ay33QoA/iYG1n+8gUbIn1tOmEw0FFlmiOTlkN2iCGwanmNN1sjwfmufMSyMY
	7b521f8yg9hogaifOR8m4BTuKYPaa29Phi+XG4nxjCBoWY7JVoEm+QZoneqgu7XGedeGpK+itP+Yd
	Yo9Q0Uc3tdEhexD3j1r7HXa+HU7QaJvl+7wje8Pg1yJf3EKVs16xEL88pnus2zqug94Bse63lc1Tx
	DLaI0BqelpfJ/tA2KY5gKLcp+QeDA72IYyXR+dlNY+4XZdmO3j9gh3IJLkBORXeSbSd8mstpoZDsF
	fEkVHJuy/eDDPiMSSNOw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1guCPn-0000tM-1V; Thu, 14 Feb 2019 08:30:39 +0000
Received: from mailgw02.mediatek.com ([216.200.240.185])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1guCPi-0000rq-VQ; Thu, 14 Feb 2019 08:30:36 +0000
X-UUID: 5a215f85fe214bd39f89e76f51c68835-20190214
X-UUID: 5a215f85fe214bd39f89e76f51c68835-20190214
Received: from mtkcas66.mediatek.inc [(172.29.193.44)] by mailgw02.mediatek.com
 (envelope-from <min.guo@mediatek.com>)
 (musrelay.mediatek.com ESMTP with TLS)
 with ESMTP id 1896081573; Thu, 14 Feb 2019 00:30:21 -0800
Received: from MTKMBS31N1.mediatek.inc (172.27.4.69) by
 MTKMBS62N1.mediatek.inc (172.29.193.41) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Thu, 14 Feb 2019 00:30:19 -0800
Received: from MTKCAS32.mediatek.inc (172.27.4.184) by MTKMBS31N1.mediatek.inc
 (172.27.4.69) with Microsoft SMTP Server (TLS) id 15.0.1395.4;
 Thu, 14 Feb 2019 16:30:17 +0800
Received: from [10.17.3.153] (10.17.3.153) by MTKCAS32.mediatek.inc
 (172.27.4.170) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Thu, 14 Feb 2019 16:30:16 +0800
Message-ID: <1550133016.12020.13.camel@mhfsdcap03>
Subject: Re: [PATCH v4 1/6] dt-bindings: usb: musb: Add support for MediaTek
 musb controller
From: Min Guo <min.guo@mediatek.com>
To: Rob Herring <robh@kernel.org>
Date: Thu, 14 Feb 2019 16:30:16 +0800
In-Reply-To: <1548382046.4433.304.camel@mhfsdcap03>
References: <1548073351-13739-1-git-send-email-min.guo@mediatek.com>
 <1548073351-13739-2-git-send-email-min.guo@mediatek.com>
 <20190121151417.GA19238@bogus> <1548149773.4433.284.camel@mhfsdcap03>
 <20190122143348.GF30080@uda0271908> <1548382046.4433.304.camel@mhfsdcap03>
X-Mailer: Evolution 3.2.3-0ubuntu6 
MIME-Version: 1.0
X-MTK: N
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190214_003035_022454_D70F1483 
X-CRM114-Status: GOOD (  19.71  )
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
 tony@atomide.com, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, hdegoede@redhat.com,
 chunfeng.yun@mediatek.com, Alan Stern <stern@rowland.harvard.edu>,
 Matthias Brugger <matthias.bgg@gmail.com>, linux-mediatek@lists.infradead.org,
 Bin Liu <b-liu@ti.com>, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi Rob,

Sorry to bother you again.
Can I describe usb-connector in usb node like this?

usb2: usb@11200000 {
   compatible = "mediatek,mt2701-musb";
                "mediatek,mtk-musb";
   reg = <0 0x11200000 0 0x1000>;
   ...
   usb_connector: musb_connector {
       compatible = "usb-b-connector";
       label = "micro-USB";
       type = "micro";
       extcon = <&extcon_usb>;
       vbus-supply = <&usb_vbus>;
   };
};

Regards,
Min.


On Fri, 2019-01-25 at 10:07 +0800, Min Guo wrote:
> Hi Bin,
> 
> Thanks for your help.
> 
> Hi Rob,
> 
> I find that Samsung describes the usb-connector attribute in DTS, and
> uses a private driver.
> And try to write DTS as following:
> 
> usb-connector node:
> musb_con: musb_connector{
>     compatible = "linux,extcon-usb-gpio","usb-b-connector";
>     lable = "micro-USB";
>     type = "micro";
>     id-gpio = <&pio 44 GPIO_ACTIVE_HIGH>
>     vbus-supply = <&usb_vbus>;
>     port {
>         usb_to_connector: endpoint {
>             remote-endpoint = <&connector_to_usb>;
>         };
>     };
> };
> 
> usb node:
> &usb2{
>     status = "okay";
>     port {
>         connector_to_usb: endpoint {
>             remote-endpoint = <&usb_to_connector>;
>         };
>     };
> }
> 
> Can I describe usb-connector like this? Or can you give me some advices?
> 
> Regards,
> Min.
> 
> On Tue, 2019-01-22 at 08:33 -0600, Bin Liu wrote:
> > Hi Min,
> > 
> > On Tue, Jan 22, 2019 at 05:36:13PM +0800, Min Guo wrote:
> > > Hi Bin,
> > > 
> > > Sorry to bother you again, I encounter a problem about the extcon
> > > property.
> > > 
> > > I don't find a common driver describing the usb-connector. Is
> > > there any driver that I can refer to, specially the way to switch MUSB
> > > controller between host and device mode? 
> > > If it needs to implement by myself, is it possible to emulate an
> > > usb-connector driver by extcon-usb-gpio, and also use the notifier
> > > mechanism or can you give me some advices?
> > 
> > I am afraid I am unable to help you on this. I wasn't really pay
> > attention when usb-connector was introduced and not sure how it can
> > replace extcon. Now after read usb-connector.txt, it seems the binding
> > only defines a/b/c-connector, but not ab-connector, and there is no
> > enough information (at least for me) explaining how VBUS and ID fix into
> > this usb-connector binding.
> > 
> > Maybe Rob can provide some hint.
> > 
> > Regards,
> > -Bin.
> 



_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
