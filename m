Return-Path: <SRS0=iy7m=RA=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 979AEC43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 01:37:11 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 670FC21019
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 01:37:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="gqLLnS1y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 670FC21019
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Date:To:From:Subject:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=nYgxXRt6ekzLlh/lypPPhDe6kgOkv/i57CbxahUl7QA=; b=gqLLnS1yPhiEV6
	n2WI0X9ou3K/cJ/m2lrepDlKMJWpba8u6xQvkRyR/sxUz0aZgYqi6U7JJv5Wu2dhfE0UBwyhDnyvM
	bgH5l3fJPVTMk5lSB5f4gGDi67owLTw/ia3CoSHyl9ks/aZXzGceHCFSp5TAnUfPweszfZvhmf+iB
	rjl22iMpjCJudfjoV5meJlPMhvMweunwy4tar+MTAzLk0+C3F/YQG4mj19WGexsttoHq33xybObIt
	Xc2GvexDYlO69Mp1e0tT3mafG3X5RG5OqcLXi+qLk+zzzGI6fmCDpFjRSrJFRl+/+7TfQVtgcr26T
	rKLzkQzK/hPcMHAKwhbw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gy5CZ-0002NI-Lj; Mon, 25 Feb 2019 01:37:03 +0000
Received: from mailgw02.mediatek.com ([216.200.240.185])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gy5CV-0002Lr-1i; Mon, 25 Feb 2019 01:37:00 +0000
X-UUID: 358b68cd4f184f5ab651b1ddc3c2e8c5-20190224
X-UUID: 358b68cd4f184f5ab651b1ddc3c2e8c5-20190224
Received: from mtkcas67.mediatek.inc [(172.29.193.45)] by mailgw02.mediatek.com
 (envelope-from <min.guo@mediatek.com>)
 (musrelay.mediatek.com ESMTP with TLS)
 with ESMTP id 1781849231; Sun, 24 Feb 2019 17:36:49 -0800
Received: from MTKMBS31N2.mediatek.inc (172.27.4.87) by
 MTKMBS62N2.mediatek.inc (172.29.193.42) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Sun, 24 Feb 2019 17:36:47 -0800
Received: from MTKCAS36.mediatek.inc (172.27.4.186) by MTKMBS31N2.mediatek.inc
 (172.27.4.87) with Microsoft SMTP Server (TLS) id 15.0.1395.4;
 Mon, 25 Feb 2019 09:36:44 +0800
Received: from [10.17.3.153] (172.27.4.253) by MTKCAS36.mediatek.inc
 (172.27.4.170) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Mon, 25 Feb 2019 09:36:44 +0800
Message-ID: <1551058604.12020.34.camel@mhfsdcap03>
Subject: Re: [PATCH v5 1/6] dt-bindings: usb: musb: Add support for MediaTek
 musb controller
From: Min Guo <min.guo@mediatek.com>
To: Rob Herring <robh@kernel.org>
Date: Mon, 25 Feb 2019 09:36:44 +0800
In-Reply-To: <20190222164923.GA26413@bogus>
References: <1550561795-31132-1-git-send-email-min.guo@mediatek.com>
 <1550561795-31132-2-git-send-email-min.guo@mediatek.com>
 <20190222164923.GA26413@bogus>
X-Mailer: Evolution 3.2.3-0ubuntu6 
MIME-Version: 1.0
X-MTK: N
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190224_173659_097481_F074E2B5 
X-CRM114-Status: GOOD (  25.96  )
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
 hdegoede@redhat.com, tony@atomide.com,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-usb@vger.kernel.org,
 linux-kernel@vger.kernel.org, Matthias Brugger <matthias.bgg@gmail.com>,
 Alan Stern <stern@rowland.harvard.edu>, chunfeng.yun@mediatek.com,
 linux-mediatek@lists.infradead.org, Bin Liu <b-liu@ti.com>,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi Rob,
On Fri, 2019-02-22 at 10:49 -0600, Rob Herring wrote:
> On Tue, Feb 19, 2019 at 03:36:30PM +0800, min.guo@mediatek.com wrote:
> > From: Min Guo <min.guo@mediatek.com>
> > 
> > This adds support for MediaTek musb controller in
> > host, peripheral and otg mode.
> > 
> > Signed-off-by: Min Guo <min.guo@mediatek.com>
> > ---
> > changes in v5:
> > suggested by Rob:
> > 1. Modify compatible as 
> > - compatible : should be one of:
> >                "mediatek,mt-2701"
> >                ...
> >                followed by "mediatek,mtk-musb"
> > 2. Add usb connector child node
> > 
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
> > 3. Remove phy-names
> > 4. Add space after comma in clock-names
> > ---
> >  .../devicetree/bindings/usb/mediatek,musb.txt      | 54 ++++++++++++++++++++++
> >  1 file changed, 54 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/usb/mediatek,musb.txt
> > 
> > diff --git a/Documentation/devicetree/bindings/usb/mediatek,musb.txt b/Documentation/devicetree/bindings/usb/mediatek,musb.txt
> > new file mode 100644
> > index 0000000..0632e6e
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/usb/mediatek,musb.txt
> > @@ -0,0 +1,54 @@
> > +MediaTek musb DRD/OTG controller
> > +-------------------------------------------
> > +
> > +Required properties:
> > + - compatible      : should be one of:
> > +                     "mediatek,mt-2701"
> 
> That looks like a top-level SoC compatible and doesn't match the 
> example.
"mediatek,mt-2701" is an example, just to describe a specific SOC.
May I modify compatibel like:
compatible : should be "mediatek,mtk-musb"

> > +                     ...
> > +                     followed by "mediatek,mtk-musb"
> > + - reg             : specifies physical base address and size of
> > +                     the registers
> > + - interrupts      : interrupt used by musb controller
> > + - interrupt-names : must be "mc"
> 
> Not much point in a name when there is only 1.
The MUSB core driver has two interrupts, one is for MAC, another for
DMA, but on MTK platform, there is only a MAC interrupt, musb core
driver uses platform_get_irq_byname(pdev, "mc") to get this interrupt
number.

> > + - phys            : PHY specifier for the OTG phy
> > + - dr_mode         : should be one of "host", "peripheral" or "otg",
> > +                     refer to usb/generic.txt
> > + - clocks          : a list of phandle + clock-specifier pairs, one for
> > +                     each entry in clock-names
> > + - clock-names     : must contain "main", "mcu", "univpll"
> > +                     for clocks of controller
> > +
> > +Optional properties:
> > + - power-domains   : a phandle to USB power domain node to control USB's
> > +                     MTCMOS
> > +
> > +Required child nodes:
> > + usb connector node as defined in bindings/connector/usb-connector.txt
> > + - extcon          : for VBUS and ID pin changes detection, needed when
> > +                     supports dual-role mode
> > + - vbus-supply     : reference to the VBUS regulator, needed when supports
> > +                     dual-role mode
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
> > +	dr_mode = "otg";
> > +	clocks = <&pericfg CLK_PERI_USB0>,
> > +		 <&pericfg CLK_PERI_USB0_MCU>,
> > +		 <&pericfg CLK_PERI_USB_SLV>;
> > +	clock-names = "main","mcu","univpll";
> > +	power-domains = <&scpsys MT2701_POWER_DOMAIN_IFR_MSC>;
> > +	usb_con: connector{
> > +		compatible = "usb-b-connector";
> > +		label = "micro-USB";
> > +		type = "micro";
> > +		extcon = <&extcon_usb>;
> 
> The connector node should replace 'extcon'. Add what you need here 
> directly (e.g. id-gpios). What you add needs to be defined in 
> usb-connector.txt.
OK.

> > +		vbus-supply = <&usb_vbus>;
> > +	};
> > +};
> > -- 
> > 1.9.1
> > 

Regards,
Min.




_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
