Return-Path: <SRS0=6Gta=PZ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C24E0C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 12:41:35 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 919B820851
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 12:41:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="H5SH2a9v"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 919B820851
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Date:To:From:Subject:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=8FlbsaQNE40KAfOs25P9Te7LHJ41OXBO3uCu3AylzuA=; b=H5SH2a9vQMO1kJ
	zTsRoehAah0yB7W/RC3Y2UaYaMxHdVH34nQSX0W/wMT5KUzWPoZePqC1lzqYVzn5S2R20MMtLrBbt
	ii+ltD5vhzmjuMNy4GEPyOxFuUI0zsLlGe2RaroDMhSTUXlC0IJcHVxloCldin79wJSVQbzq6XWSo
	hx0aEzQ0bZJ4Lwt5P4UtNcVTnJVi8AXloqDwrLKHCh/l79Vx6d3KL9GMeiUSz0KX0SAewWCm4LxUC
	sNEgmnfm0ycuLRA4UxXMONbtomV4T7NBXZIvhcrVz1PkFOaynF5vLc9SOFeKWyujq4rX1o6jPHFQS
	cuPwuMn69zXUi4DSwhGw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gk6zG-0004cB-AD; Thu, 17 Jan 2019 12:41:34 +0000
Received: from mailgw01.mediatek.com ([216.200.240.184])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gk6zB-0004ah-AD; Thu, 17 Jan 2019 12:41:31 +0000
X-UUID: 326cabf272c24b73b46b4025c7825707-20190117
X-UUID: 326cabf272c24b73b46b4025c7825707-20190117
Received: from mtkcas68.mediatek.inc [(172.29.94.19)] by mailgw01.mediatek.com
 (envelope-from <min.guo@mediatek.com>)
 (musrelay.mediatek.com ESMTP with TLS)
 with ESMTP id 1328996133; Thu, 17 Jan 2019 04:41:21 -0800
Received: from MTKMBS31N2.mediatek.inc (172.27.4.87) by
 MTKMBS62N2.mediatek.inc (172.29.193.42) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Thu, 17 Jan 2019 04:41:19 -0800
Received: from MTKCAS32.mediatek.inc (172.27.4.184) by MTKMBS31N2.mediatek.inc
 (172.27.4.87) with Microsoft SMTP Server (TLS) id 15.0.1395.4;
 Thu, 17 Jan 2019 20:41:17 +0800
Received: from [10.17.3.153] (10.17.3.153) by MTKCAS32.mediatek.inc
 (172.27.4.170) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Thu, 17 Jan 2019 20:41:17 +0800
Message-ID: <1547728876.4433.237.camel@mhfsdcap03>
Subject: Re: [PATCH v3 1/4] dt-bindings: usb: musb: Add support for MediaTek
 musb controller
From: Min Guo <min.guo@mediatek.com>
To: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Date: Thu, 17 Jan 2019 20:41:16 +0800
In-Reply-To: <15fb900e-c665-8ebd-b2cc-54f47cc35734@cogentembedded.com>
References: <1547709348-17506-1-git-send-email-min.guo@mediatek.com>
 <1547709348-17506-2-git-send-email-min.guo@mediatek.com>
 <15fb900e-c665-8ebd-b2cc-54f47cc35734@cogentembedded.com>
X-Mailer: Evolution 3.2.3-0ubuntu6 
MIME-Version: 1.0
X-MTK: N
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190117_044129_361702_7EAB56D2 
X-CRM114-Status: GOOD (  18.82  )
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
 hdegoede@redhat.com, tony@atomide.com, Greg
 Kroah-Hartman <gregkh@linuxfoundation.org>, linux-usb@vger.kernel.org,
 linux-kernel@vger.kernel.org, chunfeng.yun@mediatek.com,
 Rob Herring <robh+dt@kernel.org>, Alan
 Stern <stern@rowland.harvard.edu>, Matthias Brugger <matthias.bgg@gmail.com>,
 linux-mediatek@lists.infradead.org, Bin Liu <b-liu@ti.com>,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hello!

On Thu, 2019-01-17 at 14:06 +0300, Sergei Shtylyov wrote:
> Hello!
> 
> On 01/17/2019 10:15 AM, min.guo@mediatek.com wrote:
> 
> > From: Min Guo <min.guo@mediatek.com>
> > 
> > This adds support for MediaTek musb controller in
> > host, peripheral and otg mode.
> > 
> > Signed-off-by: Min Guo <min.guo@mediatek.com>
> > ---
> >  .../devicetree/bindings/usb/mediatek,musb.txt      | 43 ++++++++++++++++++++++
> >  1 file changed, 43 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/usb/mediatek,musb.txt
> > 
> > diff --git a/Documentation/devicetree/bindings/usb/mediatek,musb.txt b/Documentation/devicetree/bindings/usb/mediatek,musb.txt
> > new file mode 100644
> > index 0000000..3e3f671
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/usb/mediatek,musb.txt
> > @@ -0,0 +1,43 @@
> > +MediaTek musb DRD/OTG controller
> > +-------------------------------------------
> > +
> > +Required properties:
> > + - compatible      : should be "mediatek,mtk-musb"
> > + - reg             : specifies physical base address and size of
> > +   the registers
> 
>    I'd indent it more to align with "specifies", else it looks weird.

Okay.

> > + - interrupts      : interrupt used by musb controller
> > + - interrupt-names : must be "mc"
> > + - phys            : PHY specifier for the OTG phy
> > + - dr_mode         : should be one of "host", "peripheral" or "otg",
> > +   refer to usb/generic.txt
> 
>   Same here...

Okay.

> > + - clocks          : a list of phandle + clock-specifier pairs, one for
> > +   each entry in clock-names
> 
>    Here...

Okay.

> > + - clock-names     : must contain "main", "mcu", "univpll"
> > +   for clocks of controller
> 
>   And here.

Okay.

> > +
> > +Optional properties:
> > + - extcon : external connector for VBUS and IDPIN changes detection,
> 
>    ID pin, maybe?

Okay.

> > +   needed when supports dual-role mode.
> > + - vbus-supply : reference to the VBUS regulator, needed when supports
> > +   dual-role mode.
> > + - power-domains   : a phandle to USB power domain node to control USB's
> > +   MTCMOS
> [...]
> 
> MBR, Sergei



_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
