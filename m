Return-Path: <SRS0=B2vk=P6=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC0AEC282C3
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 09:36:34 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9B720218D9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 09:36:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="VSTLgPKi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9B720218D9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Date:To:From:Subject:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=2o8u6sZs23Vx61n8JhzNn8S81GQ445O6LmlIJpBiLzY=; b=VSTLgPKiecnyTH
	Xt+xPkkFDJBLzNz2iRySl+g4evIOkNC4xNRmxfWzN4hUV+pIENPJYOCEZzlQvYKc7CunaCWdsfEwd
	EhLAssxW6sfVFCcV1JLmWiXdLtHTvOqOiWeasTSU4ijDKUTtnE6o7IQWYTMe7KfKWX7W/go+spv9o
	NekhKWPZRV1yRCQyxez+hOalciLnbVdrkLe+WlUWRQcSw7PSnpzFoK86rjfhwRk92tlmVan+IUsj0
	KpsqGrQbZcXaYi7vsOwUEfT3mz0nINZ/NRwELWKsaYvhNjsUeDtgV4fhy4n+Y1ETiy92YcxHo40Wn
	UATap+0tyiaW2uR8TLKA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1glsTu-0000xT-4t; Tue, 22 Jan 2019 09:36:30 +0000
Received: from mailgw02.mediatek.com ([216.200.240.185])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1glsTp-0000wO-SJ; Tue, 22 Jan 2019 09:36:28 +0000
X-UUID: fcb1b7d915d447e1aff5719dd0aaf52c-20190122
X-UUID: fcb1b7d915d447e1aff5719dd0aaf52c-20190122
Received: from mtkcas67.mediatek.inc [(172.29.193.45)] by mailgw02.mediatek.com
 (envelope-from <min.guo@mediatek.com>)
 (musrelay.mediatek.com ESMTP with TLS)
 with ESMTP id 198403713; Tue, 22 Jan 2019 01:36:17 -0800
Received: from MTKMBS31N2.mediatek.inc (172.27.4.87) by
 MTKMBS62DR.mediatek.inc (172.29.94.18) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Tue, 22 Jan 2019 01:36:15 -0800
Received: from MTKCAS32.mediatek.inc (172.27.4.184) by MTKMBS31N2.mediatek.inc
 (172.27.4.87) with Microsoft SMTP Server (TLS) id 15.0.1395.4;
 Tue, 22 Jan 2019 17:36:13 +0800
Received: from [10.17.3.153] (10.17.3.153) by MTKCAS32.mediatek.inc
 (172.27.4.170) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Tue, 22 Jan 2019 17:36:13 +0800
Message-ID: <1548149773.4433.284.camel@mhfsdcap03>
Subject: Re: [PATCH v4 1/6] dt-bindings: usb: musb: Add support for MediaTek
 musb controller
From: Min Guo <min.guo@mediatek.com>
To: Rob Herring <robh@kernel.org>, Bin Liu <b-liu@ti.com>
Date: Tue, 22 Jan 2019 17:36:13 +0800
In-Reply-To: <20190121151417.GA19238@bogus>
References: <1548073351-13739-1-git-send-email-min.guo@mediatek.com>
 <1548073351-13739-2-git-send-email-min.guo@mediatek.com>
 <20190121151417.GA19238@bogus>
X-Mailer: Evolution 3.2.3-0ubuntu6 
MIME-Version: 1.0
X-MTK: N
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190122_013625_921477_02B3D79F 
X-CRM114-Status: GOOD (  26.81  )
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
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi Bin,

Sorry to bother you again, I encounter a problem about the extcon
property.

I don't find a common driver describing the usb-connector. Is
there any driver that I can refer to, specially the way to switch MUSB
controller between host and device mode? 
If it needs to implement by myself, is it possible to emulate an
usb-connector driver by extcon-usb-gpio, and also use the notifier
mechanism or can you give me some advices?


Hi Rob,

On Mon, 2019-01-21 at 09:14 -0600, Rob Herring wrote:
> On Mon, Jan 21, 2019 at 08:22:26PM +0800, min.guo@mediatek.com wrote:
> > From: Min Guo <min.guo@mediatek.com>
> > 
> > This adds support for MediaTek musb controller in
> > host, peripheral and otg mode.
> > 
> > Signed-off-by: Min Guo <min.guo@mediatek.com>
> > ---
> > changes in v4:
> > suggested by Sergei:
> > 1. String alignment
> > 
> > changes in v3:
> > 1. no changes
> > 
> > changes in v2:
> > suggested by Bin:
> > 1. Modify DRC to DRD
> > suggested by Rob:
> > 2. Drop the "<soc-model>-musb" in compatible
> 
> This is not what I said. I gave you the exact text to put.

Sorry to misunderstood your meaning last time,  I will modify it in next
patch.
	compatible: should be one of "mediatek,mt2701-musb"...,followed by
"mediatek,mtk-musb"

> > 3. Remove phy-names
> > 4. Add space after comma in clock-names
> > ---
> >  .../devicetree/bindings/usb/mediatek,musb.txt      | 43 ++++++++++++++++++++++
> >  1 file changed, 43 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/usb/mediatek,musb.txt
> > 
> > diff --git a/Documentation/devicetree/bindings/usb/mediatek,musb.txt b/Documentation/devicetree/bindings/usb/mediatek,musb.txt
> > new file mode 100644
> > index 0000000..4305770
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/usb/mediatek,musb.txt
> > @@ -0,0 +1,43 @@
> > +MediaTek musb DRD/OTG controller
> > +-------------------------------------------
> > +
> > +Required properties:
> > + - compatible      : should be "mediatek,mtk-musb"
> > + - reg             : specifies physical base address and size of
> > +                     the registers
> > + - interrupts      : interrupt used by musb controller
> > + - interrupt-names : must be "mc"
> > + - phys            : PHY specifier for the OTG phy
> > + - dr_mode         : should be one of "host", "peripheral" or "otg",
> > +                     refer to usb/generic.txt
> > + - clocks          : a list of phandle + clock-specifier pairs, one for
> > +                     each entry in clock-names
> > + - clock-names     : must contain "main", "mcu", "univpll"
> > +                     for clocks of controller
> > +
> > +Optional properties:
> > + - extcon          : external connector for VBUS and ID pin changes detection,
> > +                     needed when supports dual-role mode
> 
> Again, do not use extcon in new bindings.

Thanks, ok.

> > + - vbus-supply     : reference to the VBUS regulator, needed when supports
> > +                     dual-role mode
> > + - power-domains   : a phandle to USB power domain node to control USB's
> > +                     MTCMOS
> > +
> > +Example:
> > +
> > +usb2: usb@11200000 {
> > +	compatible = "mediatek,mt2701-musb",
> > +		     "mediatek,mtk-musb";
> > +	reg = <0 0x11200000 0 0x1000>;
> > +	interrupts = <GIC_SPI 32 IRQ_TYPE_LEVEL_LOW>;
> > +	interrupt-names = "mc";
> > +	phys = <&u2port2 PHY_TYPE_USB2>;
> > +	vbus-supply = <&usb_vbus>;
> > +	extcon = <&extcon_usb>;
> > +	dr_mode = "otg";
> > +	clocks = <&pericfg CLK_PERI_USB0>,
> > +		 <&pericfg CLK_PERI_USB0_MCU>,
> > +		 <&pericfg CLK_PERI_USB_SLV>;
> > +	clock-names = "main","mcu","univpll";
> > +	power-domains = <&scpsys MT2701_POWER_DOMAIN_IFR_MSC>;
> > +};
> > -- 
> > 1.9.1
> > 
> > 
> > _______________________________________________
> > linux-arm-kernel mailing list
> > linux-arm-kernel@lists.infradead.org
> > http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

Regards,
Min.


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
