Return-Path: <SRS0=Ql45=PY=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A5A6C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 21:05:50 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 45E9520652
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 21:05:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="KD9CLn5A"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 45E9520652
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=7VuD0J29CzEbJRd2c9QqHiIkPKiT9nFy/swj/2I+sR0=; b=KD9CLn5A9sbbA4
	FdE0OLEAj/1VexN8V5xzDy+ggWiPj6hxQylcftLteCZcUSUZeODQwY5hFWV4Wet4AnQqiW7NuYiU1
	WkXB8nhx4A9JtIfsBgwPeTJQVJSjabyLuxkwPmnzo5iAJ920LOZZoulITlt20u8NsOAe0ChcLQFwh
	VyryNPN2oHFh/5jOdAocF6J70hVJHQXdEweSQwLMRNRCwN7cHEZENCdDUhHzM/iRPMb+WXVGCVXdP
	yvkOOJ3NocPZza+6SWbaYYJHd4H8TYsPSgJhTsAr73AMbRgJUH4iGbTNnJc2FXy0qzFHoNpGE1tyz
	RNDzIcl271Rf9ZEkQgBg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gjsNg-00051m-BO; Wed, 16 Jan 2019 21:05:48 +0000
Received: from mail-ot1-f65.google.com ([209.85.210.65])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gjsNc-00051F-Gd
 for linux-arm-kernel@lists.infradead.org; Wed, 16 Jan 2019 21:05:46 +0000
Received: by mail-ot1-f65.google.com with SMTP id a11so9064160otr.10
 for <linux-arm-kernel@lists.infradead.org>;
 Wed, 16 Jan 2019 13:05:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=eRdyxLt1vpkm3EFtONPfz+Lt0pva/R7wx6UAphEcuiE=;
 b=YEa0oDTSyNQnZp8UuDVGiPkymQGZlHSr1v3umNZGvIYdr7zzhgf8xg7P7WyhqnaHvc
 EJghMxNtIjsJSAYeUU8YbM/OdXQi3j1T13tYYljOzrTHXgdgCaZD4zobClZ0vbUlBmBn
 SYysx5Lerm93OWYTJLUpO3Q+urdllWUq9CCIqdpj0WKVd3rXKLXyo2pLZzOgqQ9i2r1D
 Jn6GXr2TnwiHXmroa4XqFN+tR8v1+59hFDVJpwaknIl1+mZF1JqLfSX0YHyKJQ4p98EW
 ga2Xw6nBbutNNDKNtvZi6mvA0F6baPkIso4EJLrxyoSNz6zzhrpubCaldx6HWRCe5h/d
 dEYg==
X-Gm-Message-State: AJcUukfXmNvSh5aLR4NUwJxXsJ2jzLCRwVaiy2Y8jeE43AAgE3ZKyiSI
 dK4yrKYwrMnrPC1d+05v3w==
X-Google-Smtp-Source: ALg8bN4B3/7iswQ80wkw5wXlsIAq38aP0pReWafQlYu0FIZyj4s/4pOMM7LTFUlnxnV2fgDVHYizrQ==
X-Received: by 2002:a9d:4546:: with SMTP id p6mr6830813oti.24.1547672742655;
 Wed, 16 Jan 2019 13:05:42 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net.
 [24.155.109.49])
 by smtp.gmail.com with ESMTPSA id c78sm4376497oig.30.2019.01.16.13.05.41
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Wed, 16 Jan 2019 13:05:41 -0800 (PST)
Date: Wed, 16 Jan 2019 15:05:41 -0600
From: Rob Herring <robh@kernel.org>
To: Miquel Raynal <miquel.raynal@bootlin.com>
Subject: Re: [PATCH v2 06/10] dt-bindings: phy: mvebu-utmi: add UTMI PHY
 bindings
Message-ID: <20190116210541.GA7924@bogus>
References: <20190111133133.24803-1-miquel.raynal@bootlin.com>
 <20190111133133.24803-7-miquel.raynal@bootlin.com>
 <20190115214429.GA21758@bogus> <20190116142021.41faac8b@xps13>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190116142021.41faac8b@xps13>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190116_130544_555708_91429D68 
X-CRM114-Status: GOOD (  29.33  )
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
Cc: Mark Rutland <mark.rutland@arm.com>, Andrew Lunn <andrew@lunn.ch>,
 Jason Cooper <jason@lakedaemon.net>, Mathias Nyman <mathias.nyman@intel.com>,
 devicetree@vger.kernel.org, Antoine Tenart <antoine.tenart@bootlin.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Gregory Clement <gregory.clement@bootlin.com>, linux-usb@vger.kernel.org,
 Kishon Vijay Abraham I <kishon@ti.com>, Nadav Haklai <nadavh@marvell.com>,
 Alan Stern <stern@rowland.harvard.edu>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 Maxime Chevallier <maxime.chevallier@bootlin.com>,
 linux-arm-kernel@lists.infradead.org,
 Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Wed, Jan 16, 2019 at 02:20:21PM +0100, Miquel Raynal wrote:
> Hi Rob,
> 
> Rob Herring <robh@kernel.org> wrote on Tue, 15 Jan 2019 15:44:29 -0600:
> 
> > On Fri, Jan 11, 2019 at 02:31:29PM +0100, Miquel Raynal wrote:
> > > Add bindings for Marvell Armada 3700 USB2 UTMI+ PHY.
> > > 
> > > Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
> > > ---
> > >  .../bindings/phy/phy-mvebu-utmi.txt           | 37 +++++++++++++++++++
> > >  1 file changed, 37 insertions(+)
> > >  create mode 100644 Documentation/devicetree/bindings/phy/phy-mvebu-utmi.txt
> > > 
> > > diff --git a/Documentation/devicetree/bindings/phy/phy-mvebu-utmi.txt b/Documentation/devicetree/bindings/phy/phy-mvebu-utmi.txt
> > > new file mode 100644
> > > index 000000000000..4ade05ce5d51
> > > --- /dev/null
> > > +++ b/Documentation/devicetree/bindings/phy/phy-mvebu-utmi.txt
> > > @@ -0,0 +1,37 @@
> > > +MVEBU A3700 UTMI PHY
> > > +--------------------
> > > +
> > > +USB2 UTMI+ PHY controllers can be found on the following Marvell MVEBU SoCs:
> > > +* Armada 3700
> > > +
> > > +On Armada 3700, there are two USB controllers, one is compatible with the USB2
> > > +and USB3 specifications and supports OTG. The other one is USB2 compliant and
> > > +only supports host mode. Both of these controllers come with a UTMI PHY.  
> > 
> > This paragraph says the controllers are different, but are the PHYs 
> > different?
> 
> Yes they are. I will make it appear clearly in the v3.
> 
> > 
> > > +
> > > +Required Properties:
> > > +
> > > +- compatible: Should be one of:
> > > +	      * "marvell,a3700-utmi-host-phy" for the PHY connected to
> > > +	        the USB2 host-only controller.
> > > +	      * "marvell,a3700-utmi-otg-phy" for the PHY connected to
> > > +	        the USB3 and USB2 OTG capable controller.
> > > +- reg: PHY IP register range.
> > > +- marvell,usb-misc-reg: handle on the "USB miscellaneous registers" shared
> > > +			region covering registers related to both the host
> > > +			controller and the PHY.
> > > +- #phy-cells: Standard property (Documentation: phy-bindings.txt) Should be 0.
> > > +
> > > +
> > > +Example:
> > > +
> > > +	usb2_utmi_host_phy: phy@5f000 {
> > > +		compatible = "marvell,armada-3700-utmi-host-phy";
> > > +		reg = <0x5f000 0x800>;
> > > +		marvell,usb-misc-reg = <&usb2_syscon>;
> > > +		#phy-cells = <0>;
> > > +	};
> > > +
> > > +	usb2_syscon: system-controller@5f800 {
> > > +		compatible = "syscon", "simple-mfd";  
> > 
> > This is not valid because there's not a specific compatible string and 
> > 'simple-mfd' implies there are child nodes.
> 
> What do you suggest? Is compatible = "syscon"; enough? 

No.

> This is just an
> area with a few registers that do not belong to any specific IP.

Must be some name for the registers in the datasheet?

> There
> are registers that are related to the control of the USB controller,
> and registers that are related to the PHY. It's quite challenging to
> find a meaningful specific compatible string. Is it mandatory to add
> one? If yes, would "marvell,armada-3700-usb-utmi-{host,otg}-misc" fit?

Yes, if there's not a name from the datasheet.

Rob

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
