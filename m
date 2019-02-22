Return-Path: <SRS0=2lwk=Q5=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CE8FC43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 16:49:37 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D9AAB20700
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 16:49:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="WEqPYXFl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D9AAB20700
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=4M+B/Kv6ls3hTRPsJODBW1EfNJVsFwdjk5gdvvzXCS0=; b=WEqPYXFlxJNCgv
	1aPuErodznpjPiY7vxa7rGFMkkYJmz+r0HkZZbrd7hmIiyx03uE+JyH7KJ87yEIzXZYvMCRkLZQ/t
	Fk8ZIPgfziLndAko+0+Ymo4vXkBKhHsjfHOXUDgwgVFqP13QnIJJWx/h8wtQOgMWSIZN2YBP/7mwJ
	WAWWxIjH3c9b5I/UBk6Vvu16DGKrr8OGCs7RELJXe9/n2TQ1aAgJlh1vKgHMwSlSUlx0SGjgHc2Gg
	l9TlHaftIpyOerYV39W95Ol64+XQ7HaKrwL1iIb7b3oZXmWkuO9F762PqaRAcdKU8ZONmWEPdHZK0
	xqTmx8iwg1b7UKviq3Og==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gxE0w-0002lT-TS; Fri, 22 Feb 2019 16:49:30 +0000
Received: from mail-ot1-f65.google.com ([209.85.210.65])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gxE0s-0002kw-AN; Fri, 22 Feb 2019 16:49:28 +0000
Received: by mail-ot1-f65.google.com with SMTP id i5so2371850oto.9;
 Fri, 22 Feb 2019 08:49:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=nInQa3zpTbobzahcniRHckH6ZQbSax0wZ5W2+6AK304=;
 b=tEH8W6CvOKKp7mSBEuKCozojSSC5h2p5A2INPRmQhf2NESDVTXlYa+sGyNauTAhLwa
 /tDxmPEw4oNYtPiw2BqS7XJtdX5Ovjv/gedSBt1ASBdjLqsf3j+AXsi21XnInzCVXBE8
 gP9xwgZupBCODGHdxPJ/qwR4bU53zfTKTVkTnsXdwAFl3Y9Kj1bsF6gFG8QKHsuSq/kn
 s6nGSqLSoQ5nVz7VM8e74uxHdWU5coHrUZX84f+3DhZ1aQlHx6h90qtMyRo/hZRQN28/
 H92+OZvtV8WNrD1f0GCAd2BbuOXoUwjKhvfBPr9nxZE0wnJ7ji+PerDug6RyQPNkcMOd
 mkDA==
X-Gm-Message-State: AHQUAuYy3EdCF00v8r8EXJ+rE3EZssUJq2J3sQU5qsznKDGsg7KOL5OJ
 fh0LrXWP0IcYkCNVbJs4UQ==
X-Google-Smtp-Source: AHgI3IZwsSonHxCqImx6181/oMIhgphzQELpQJrUWz9v8CkWgH0W82mWpsAf8QjiPWVI9Ol9QIJlYA==
X-Received: by 2002:a9d:6082:: with SMTP id m2mr3197472otj.209.1550854165178; 
 Fri, 22 Feb 2019 08:49:25 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net.
 [24.155.109.49])
 by smtp.gmail.com with ESMTPSA id h205sm755452oib.11.2019.02.22.08.49.23
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Fri, 22 Feb 2019 08:49:24 -0800 (PST)
Date: Fri, 22 Feb 2019 10:49:23 -0600
From: Rob Herring <robh@kernel.org>
To: min.guo@mediatek.com
Subject: Re: [PATCH v5 1/6] dt-bindings: usb: musb: Add support for MediaTek
 musb controller
Message-ID: <20190222164923.GA26413@bogus>
References: <1550561795-31132-1-git-send-email-min.guo@mediatek.com>
 <1550561795-31132-2-git-send-email-min.guo@mediatek.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1550561795-31132-2-git-send-email-min.guo@mediatek.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190222_084926_352575_6AAD0091 
X-CRM114-Status: GOOD (  22.69  )
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

On Tue, Feb 19, 2019 at 03:36:30PM +0800, min.guo@mediatek.com wrote:
> From: Min Guo <min.guo@mediatek.com>
> 
> This adds support for MediaTek musb controller in
> host, peripheral and otg mode.
> 
> Signed-off-by: Min Guo <min.guo@mediatek.com>
> ---
> changes in v5:
> suggested by Rob:
> 1. Modify compatible as 
> - compatible : should be one of:
>                "mediatek,mt-2701"
>                ...
>                followed by "mediatek,mtk-musb"
> 2. Add usb connector child node
> 
> changes in v4:
> suggested by Sergei:
> 1. String alignment
> 
> changes in v3:
> 1. no changes
> 
> changes in v2:
> suggested by Bin:
> 1. Modify DRC to DRD
> suggested by Rob:
> 2. Drop the "<soc-model>-musb" in compatible
> 3. Remove phy-names
> 4. Add space after comma in clock-names
> ---
>  .../devicetree/bindings/usb/mediatek,musb.txt      | 54 ++++++++++++++++++++++
>  1 file changed, 54 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/usb/mediatek,musb.txt
> 
> diff --git a/Documentation/devicetree/bindings/usb/mediatek,musb.txt b/Documentation/devicetree/bindings/usb/mediatek,musb.txt
> new file mode 100644
> index 0000000..0632e6e
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/usb/mediatek,musb.txt
> @@ -0,0 +1,54 @@
> +MediaTek musb DRD/OTG controller
> +-------------------------------------------
> +
> +Required properties:
> + - compatible      : should be one of:
> +                     "mediatek,mt-2701"

That looks like a top-level SoC compatible and doesn't match the 
example.

> +                     ...
> +                     followed by "mediatek,mtk-musb"
> + - reg             : specifies physical base address and size of
> +                     the registers
> + - interrupts      : interrupt used by musb controller
> + - interrupt-names : must be "mc"

Not much point in a name when there is only 1.

> + - phys            : PHY specifier for the OTG phy
> + - dr_mode         : should be one of "host", "peripheral" or "otg",
> +                     refer to usb/generic.txt
> + - clocks          : a list of phandle + clock-specifier pairs, one for
> +                     each entry in clock-names
> + - clock-names     : must contain "main", "mcu", "univpll"
> +                     for clocks of controller
> +
> +Optional properties:
> + - power-domains   : a phandle to USB power domain node to control USB's
> +                     MTCMOS
> +
> +Required child nodes:
> + usb connector node as defined in bindings/connector/usb-connector.txt
> + - extcon          : for VBUS and ID pin changes detection, needed when
> +                     supports dual-role mode
> + - vbus-supply     : reference to the VBUS regulator, needed when supports
> +                     dual-role mode
> +
> +Example:
> +
> +usb2: usb@11200000 {
> +	compatible = "mediatek,mt2701-musb",
> +		     "mediatek,mtk-musb";
> +	reg = <0 0x11200000 0 0x1000>;
> +	interrupts = <GIC_SPI 32 IRQ_TYPE_LEVEL_LOW>;
> +	interrupt-names = "mc";
> +	phys = <&u2port2 PHY_TYPE_USB2>;
> +	dr_mode = "otg";
> +	clocks = <&pericfg CLK_PERI_USB0>,
> +		 <&pericfg CLK_PERI_USB0_MCU>,
> +		 <&pericfg CLK_PERI_USB_SLV>;
> +	clock-names = "main","mcu","univpll";
> +	power-domains = <&scpsys MT2701_POWER_DOMAIN_IFR_MSC>;
> +	usb_con: connector{
> +		compatible = "usb-b-connector";
> +		label = "micro-USB";
> +		type = "micro";
> +		extcon = <&extcon_usb>;

The connector node should replace 'extcon'. Add what you need here 
directly (e.g. id-gpios). What you add needs to be defined in 
usb-connector.txt.

> +		vbus-supply = <&usb_vbus>;
> +	};
> +};
> -- 
> 1.9.1
> 

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
