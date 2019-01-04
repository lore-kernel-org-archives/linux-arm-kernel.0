Return-Path: <SRS0=E6Hv=PM=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF297C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 03:00:43 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BF3EF2184B
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 03:00:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="m8B4mO7V"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BF3EF2184B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Date:To:From:Subject:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=SbQKui7Mtj/uXd64aczOXeK2euTi316pC52C8h2jtGk=; b=m8B4mO7VK65u+2
	NKLvjRctOBRRo83jqXv0fV9BNFbmlIuKOSF2/9OZgOCD6my4Kjqh56FCxeMO3dtkVcb0HzzvXsFac
	Ewo8NpyRYmA9aWHcIDhnVN/FFZavWwarbM3PDJTNOus5XdODDCSXFceH8UplsRMvvpg9CPrqHe+3Y
	s5Jd5pMV7aiU4YCEdUmjGo2MngdXf+HJsBrPVhdA7djM40dATJwqRfR5Y7GrN1xsCVXxEDRzP8Ijv
	LFuQfI65DsE7afb/1aAEdaXN4RUvlly1+7DRXqn/bMLt49Dgmm7qiKt+p0Jb75+K5cDupuGphOy0x
	CBb2rM4d9nEKhTgnElZg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gfFip-0002aK-IQ; Fri, 04 Jan 2019 03:00:31 +0000
Received: from mailgw01.mediatek.com ([216.200.240.184])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gfFij-0002YT-5N; Fri, 04 Jan 2019 03:00:27 +0000
X-UUID: b72bcc1349d5406a9c1c499cab1e5e2a-20190103
X-UUID: b72bcc1349d5406a9c1c499cab1e5e2a-20190103
Received: from mtkcas68.mediatek.inc [(172.29.94.19)] by mailgw01.mediatek.com
 (envelope-from <min.guo@mediatek.com>)
 (musrelay.mediatek.com ESMTP with TLS)
 with ESMTP id 745304877; Thu, 03 Jan 2019 19:00:12 -0800
Received: from MTKMBS31N2.mediatek.inc (172.27.4.87) by
 MTKMBS62DR.mediatek.inc (172.29.94.18) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Thu, 3 Jan 2019 19:00:10 -0800
Received: from MTKCAS32.mediatek.inc (172.27.4.184) by MTKMBS31N2.mediatek.inc
 (172.27.4.87) with Microsoft SMTP Server (TLS) id 15.0.1395.4;
 Fri, 4 Jan 2019 11:00:08 +0800
Received: from [10.17.3.153] (10.17.3.153) by MTKCAS32.mediatek.inc
 (172.27.4.170) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Fri, 4 Jan 2019 11:00:07 +0800
Message-ID: <1546570807.585.31.camel@mhfsdcap03>
Subject: Re: [PATCH 1/4] dt-bindings: usb: musb: Add support for MediaTek
 musb controller
From: Min Guo <min.guo@mediatek.com>
To: Rob Herring <robh@kernel.org>
Date: Fri, 4 Jan 2019 11:00:07 +0800
In-Reply-To: <20190103221414.GA14639@bogus>
References: <1545896066-897-1-git-send-email-min.guo@mediatek.com>
 <1545896066-897-2-git-send-email-min.guo@mediatek.com>
 <20190103221414.GA14639@bogus>
X-Mailer: Evolution 3.2.3-0ubuntu6 
MIME-Version: 1.0
X-MTK: N
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190103_190025_205822_A355DCAF 
X-CRM114-Status: GOOD (  26.25  )
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
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-usb@vger.kernel.org,
 linux-kernel@vger.kernel.org, Matthias Brugger <matthias.bgg@gmail.com>,
 Alan Stern <stern@rowland.harvard.edu>, chunfeng.yun@mediatek.com,
 linux-mediatek@lists.infradead.org, Bin Liu <b-liu@ti.com>,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Thu, 2019-01-03 at 16:14 -0600, Rob Herring wrote:
> On Thu, Dec 27, 2018 at 03:34:23PM +0800, min.guo@mediatek.com wrote:
> > From: Min Guo <min.guo@mediatek.com>
> > 
> > This adds support for MediaTek musb controller in
> > host, peripheral and otg mode
> > 
> > Signed-off-by: Min Guo <min.guo@mediatek.com>
> > ---
> >  .../devicetree/bindings/usb/mediatek,musb.txt      | 49 ++++++++++++++++++++++
> >  1 file changed, 49 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/usb/mediatek,musb.txt
> > 
> > diff --git a/Documentation/devicetree/bindings/usb/mediatek,musb.txt b/Documentation/devicetree/bindings/usb/mediatek,musb.txt
> > new file mode 100644
> > index 0000000..e899c9b
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/usb/mediatek,musb.txt
> > @@ -0,0 +1,49 @@
> > +MediaTek musb DRC/OTG controller
> > +-------------------------------------------
> > +
> > +Required properties:
> > + - compatible      : should be "mediatek,<soc-model>-musb",
> > +   "mediatek,mtk-musb", soc-model is the name of SoC, such as
> > +   mt2701, when using "mediatek,mtk-musb" compatible string, you
> > +   need SoC specific ones in addition, one of:
> > +   - "mediatek,mt2701-musb"
> 
> This isn't very clear. Just drop the <soc-model and enumerate the SoCs:
> 
> compatible: should be one of:
>     "mediatek,mt2701-musb"
>     ...
>   followed by "mediatek,mtk-musb"
I will modify it in the next patch.

> > + - reg             : specifies physical base address and size of
> > +   the registers
> > + - interrupts      : interrupt used by musb controller
> > + - interrupt-names : must be "mc"
> 
> -names is pointless when there is only one.
The MUSB core driver has two interrupts, one is for MAC, another for DMA,
but on MTK platform, there is only a MAC interrupt, here following the binding
of MUSB core driver.

> > + - phys            : PHY specifier for the OTG phy
> > + - phy-names       : should be "usb2-phy"
> 
> Same here.
I will modify it in the next patch.

> > + - dr_mode         : should be one of "host", "peripheral" or "otg",
> > +   refer to usb/generic.txt
> > + - clocks          : a list of phandle + clock-specifier pairs, one for
> > +   each entry in clock-names
> > + - clock-names     : must contain "main","mcu","univpll"
> 
> space needed after each comma.
I will modify it in the next patch.

> > +   for clocks of controller
> > +
> > +Optional properties:
> > + - extcon : external connector for VBUS and IDPIN changes detection,
> > +   needed when supports dual-role mode.
> 
> Don't use extcon for new bindings. The usb-connector binding should be 
> used instead.
This is used to detect the changes of the IDPIN and VBUS, the change
events are provided by other drivers, such as extcon-usb-gpio.c, and
then switch MUSB controller to host or device mode, but the
usb-connector can't detect these changes.

> > + - vbus-supply : reference to the VBUS regulator, needed when supports
> > +   dual-role mode.
> 
> The controller is powered from Vbus? Probably not. This belongs in the 
> connector or maybe the phy (if the phy is powered from Vbus).
The Vbus is used to provide 5V voltage to the connected device when the
controller works as host mode.

> > + - power-domains   : a phandle to USB power domain node to control USB's
> > +   MTCMOS
> > +
> > +Example:
> > +
> > +usb2: usb@11200000 {
> > +	compatible = "mediatek,mt2701-musb";
> > +		"mediatek,mtk-musb";
> > +	reg = <0 0x11200000 0 0x1000>;
> > +	interrupts = <GIC_SPI 32 IRQ_TYPE_LEVEL_LOW>;
> > +	interrupt-names = "mc";
> > +	phys = <&u2port2 PHY_TYPE_USB2>;
> > +	phy-names = "usb2-phy";
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



_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
