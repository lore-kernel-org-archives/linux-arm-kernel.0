Return-Path: <SRS0=3lKL=PX=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0ABF7C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 21:44:39 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C652B208E4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 21:44:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="QT+t7wbC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C652B208E4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=QCVZYAdw6Oq6FBzm2bz79ovYEFHX/1pksiAAVDqalBA=; b=QT+t7wbCNteMCg
	As+IzAedPqfQSGHv12UB9RaRbuitPacFGHWuM2UfIfge7wDNV2nP2LkX8R1m8+XKUGca6NRy5DTnL
	nehLCEFBNsD181sr7LZllLFVVMSMFSmyEcD1+F0QgQEiROepspHi30JHDxB9us1FUqBTtgnFSPJG/
	7RXWwJTmQblekdxvELi9/qgAdDjyoQmkQbEwdBeIENLh5UvZ+BYSJ031gBISRszLVl12QPnMkjgv+
	uHx+qnEAaUGLAxAE6Y8xGICXyIGY1725SKwyjGgjn9IR2p3bTBsZQwTs5BusuuSzpYqCsrv8zI8T5
	/FKhZV264ERapNkIQiAA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gjWVh-0006uH-2b; Tue, 15 Jan 2019 21:44:37 +0000
Received: from mail-oi1-f196.google.com ([209.85.167.196])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gjWVd-0006tr-9B
 for linux-arm-kernel@lists.infradead.org; Tue, 15 Jan 2019 21:44:34 +0000
Received: by mail-oi1-f196.google.com with SMTP id u18so3352970oie.10
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 15 Jan 2019 13:44:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=mG+3g7dC67QFwTzLNQhm9GSYPLaQN415iep9Kl6s7fU=;
 b=UkhZwbXR2MTnn59ahY70mlkKGAzXIjmsZv7NLO1jZtKNi+oNxHnXOzwLr0Mr5Ud+11
 f7HNjgoayAzClmxW9amyHfai2PiG4iF7pbt0umGxn+wpe4R3VEkeVfgEF+ElOsZ1Resb
 wOe56fU/h88yrhV7dUZB6FZEybnpZAVqlWzqESw+W/MmD8LQuAWu1icULkIa2LTpc1j5
 fK4vuYwsKBdZLaiIGZQXVNY8Ed3OPWq+6iOYpHIQBxdVBmQhceqj2rLdwgK6Qj1doIcR
 OrVp1g4JnhopWvaet4hCN5vgP6zR7Giv1f4FseT5inxDP78LGOft2GHDXDsIs0CeEdI4
 XztQ==
X-Gm-Message-State: AJcUuke5ilV52bltSwmM8jrjHs/qboe1NOIjTJJp9X2FmaOGf6AMyV+M
 gjyzcrdJ95Q4Zv4Hg5fIsw==
X-Google-Smtp-Source: ALg8bN74DptZQeygWunWIo10OaoEVL8ET9pArWfMu1JRWtnLpdnmYX34wqxtRTiajGdtEXEN4Gj0bg==
X-Received: by 2002:aca:220b:: with SMTP id b11mr2991559oic.87.1547588671995; 
 Tue, 15 Jan 2019 13:44:31 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net.
 [24.155.109.49])
 by smtp.gmail.com with ESMTPSA id m25sm1913647otq.32.2019.01.15.13.44.31
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Tue, 15 Jan 2019 13:44:31 -0800 (PST)
Date: Tue, 15 Jan 2019 15:44:29 -0600
From: Rob Herring <robh@kernel.org>
To: Miquel Raynal <miquel.raynal@bootlin.com>
Subject: Re: [PATCH v2 06/10] dt-bindings: phy: mvebu-utmi: add UTMI PHY
 bindings
Message-ID: <20190115214429.GA21758@bogus>
References: <20190111133133.24803-1-miquel.raynal@bootlin.com>
 <20190111133133.24803-7-miquel.raynal@bootlin.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190111133133.24803-7-miquel.raynal@bootlin.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190115_134433_325322_C2214192 
X-CRM114-Status: GOOD (  23.24  )
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

On Fri, Jan 11, 2019 at 02:31:29PM +0100, Miquel Raynal wrote:
> Add bindings for Marvell Armada 3700 USB2 UTMI+ PHY.
> 
> Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
> ---
>  .../bindings/phy/phy-mvebu-utmi.txt           | 37 +++++++++++++++++++
>  1 file changed, 37 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/phy/phy-mvebu-utmi.txt
> 
> diff --git a/Documentation/devicetree/bindings/phy/phy-mvebu-utmi.txt b/Documentation/devicetree/bindings/phy/phy-mvebu-utmi.txt
> new file mode 100644
> index 000000000000..4ade05ce5d51
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/phy/phy-mvebu-utmi.txt
> @@ -0,0 +1,37 @@
> +MVEBU A3700 UTMI PHY
> +--------------------
> +
> +USB2 UTMI+ PHY controllers can be found on the following Marvell MVEBU SoCs:
> +* Armada 3700
> +
> +On Armada 3700, there are two USB controllers, one is compatible with the USB2
> +and USB3 specifications and supports OTG. The other one is USB2 compliant and
> +only supports host mode. Both of these controllers come with a UTMI PHY.

This paragraph says the controllers are different, but are the PHYs 
different?

> +
> +Required Properties:
> +
> +- compatible: Should be one of:
> +	      * "marvell,a3700-utmi-host-phy" for the PHY connected to
> +	        the USB2 host-only controller.
> +	      * "marvell,a3700-utmi-otg-phy" for the PHY connected to
> +	        the USB3 and USB2 OTG capable controller.
> +- reg: PHY IP register range.
> +- marvell,usb-misc-reg: handle on the "USB miscellaneous registers" shared
> +			region covering registers related to both the host
> +			controller and the PHY.
> +- #phy-cells: Standard property (Documentation: phy-bindings.txt) Should be 0.
> +
> +
> +Example:
> +
> +	usb2_utmi_host_phy: phy@5f000 {
> +		compatible = "marvell,armada-3700-utmi-host-phy";
> +		reg = <0x5f000 0x800>;
> +		marvell,usb-misc-reg = <&usb2_syscon>;
> +		#phy-cells = <0>;
> +	};
> +
> +	usb2_syscon: system-controller@5f800 {
> +		compatible = "syscon", "simple-mfd";

This is not valid because there's not a specific compatible string and 
'simple-mfd' implies there are child nodes.

> +		reg = <0x5f800 0x800>;
> +	};
> -- 
> 2.19.1
> 

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
