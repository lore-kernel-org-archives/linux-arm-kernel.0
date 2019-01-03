Return-Path: <SRS0=5A9c=PL=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 902DBC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 22:14:31 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5EB44217F5
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 22:14:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="WGI1rFJ7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5EB44217F5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=lqkKZJ0iNZ0jwIGSiPEB/s40CgBf8ktQbFOJlQBS/wY=; b=WGI1rFJ7FGeQg5
	kK2QWDDWN0rQ8BnZhcRws8zA0pWv2gIV+34j+B4RTtWlI0zAsqugn7IsvPWEaEGONTfFHYC9q7yPt
	aP0qa6v7x45vEBcOrZsL+LzukrHacHsPQ2dSOc+FBhMkF/vPlVs+K2QXS/wDFI5lc+EXFT4F7s25S
	QGUwyfnoRK3a5rN3bQ7kTQBAI0WYkT7E0an8CESqTp/SK4QfpaO4KlgbHlSMWkxuPsWpRjddCk2Cp
	BPI+S8rsjeq7nHOVwvSB0EQSu/q25BHpwsm3qXd3AnhoE0QUsqQk/P8ctvWA60Mb+bHTJiFShXQrE
	ASK2mCKLtvpK8VFZGX/g==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gfBG0-0001VI-8I; Thu, 03 Jan 2019 22:14:28 +0000
Received: from mail-io1-f65.google.com ([209.85.166.65])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gfBFw-0001UZ-RI; Thu, 03 Jan 2019 22:14:26 +0000
Received: by mail-io1-f65.google.com with SMTP id g8so16841475iok.4;
 Thu, 03 Jan 2019 14:14:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=ovSnMbD1E39AJ/98MPK0U0qQKO0yuxyA6BNQxBzrVXQ=;
 b=F1vxvzhQ7TY3T9aedUx9nQzC9bJVH5lr1qZusR74k8ws0iyKfq9ofU48KEIhVNrfza
 AwXE487NDFzNedCb511DpUQtv2ihKDt6c11acboxLt5+ifWwD3vumAK7UzdRlcuY1GK9
 yzIHBHYF7phcq9aqG7fqzCHgzeoK2OWYJ7FXrANzWC+zBRPKcsM2ODTKKh6jW6nU24Ga
 ZfcySg/kLc4CUcFbO0j5ovsko/IXOpVMiJ81Tx3OCkfSSizv51876vNgNv4RmovbnhhQ
 RHFFhdPn7Ia0iqUbDtmfo3UtHj0Chls7YcUbeQio8x3LIES3uEGbpWMaV4gKtWLJVa6j
 xihQ==
X-Gm-Message-State: AJcUukd226J50Ppkqtm+7rMUhWHSAau33yy/SdF2E5SXEHT+/Qr41z1O
 U5jbwKmchJqhjrbp9RnBGg==
X-Google-Smtp-Source: ALg8bN6UaXH4R6ckBYLcvfX6DnJ1RXML5ytsgkTANta6ZlKq+7VpsiRE3dpzLybX55GIuYt54w4iXA==
X-Received: by 2002:a6b:600b:: with SMTP id r11mr37145144iog.259.1546553662285; 
 Thu, 03 Jan 2019 14:14:22 -0800 (PST)
Received: from localhost ([24.51.61.172])
 by smtp.gmail.com with ESMTPSA id t6sm26742728ioc.87.2019.01.03.14.14.20
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Thu, 03 Jan 2019 14:14:21 -0800 (PST)
Date: Thu, 3 Jan 2019 16:14:14 -0600
From: Rob Herring <robh@kernel.org>
To: min.guo@mediatek.com
Subject: Re: [PATCH 1/4] dt-bindings: usb: musb: Add support for MediaTek
 musb controller
Message-ID: <20190103221414.GA14639@bogus>
References: <1545896066-897-1-git-send-email-min.guo@mediatek.com>
 <1545896066-897-2-git-send-email-min.guo@mediatek.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1545896066-897-2-git-send-email-min.guo@mediatek.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190103_141424_887228_3B96DAB4 
X-CRM114-Status: GOOD (  22.74  )
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

On Thu, Dec 27, 2018 at 03:34:23PM +0800, min.guo@mediatek.com wrote:
> From: Min Guo <min.guo@mediatek.com>
> 
> This adds support for MediaTek musb controller in
> host, peripheral and otg mode
> 
> Signed-off-by: Min Guo <min.guo@mediatek.com>
> ---
>  .../devicetree/bindings/usb/mediatek,musb.txt      | 49 ++++++++++++++++++++++
>  1 file changed, 49 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/usb/mediatek,musb.txt
> 
> diff --git a/Documentation/devicetree/bindings/usb/mediatek,musb.txt b/Documentation/devicetree/bindings/usb/mediatek,musb.txt
> new file mode 100644
> index 0000000..e899c9b
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/usb/mediatek,musb.txt
> @@ -0,0 +1,49 @@
> +MediaTek musb DRC/OTG controller
> +-------------------------------------------
> +
> +Required properties:
> + - compatible      : should be "mediatek,<soc-model>-musb",
> +   "mediatek,mtk-musb", soc-model is the name of SoC, such as
> +   mt2701, when using "mediatek,mtk-musb" compatible string, you
> +   need SoC specific ones in addition, one of:
> +   - "mediatek,mt2701-musb"

This isn't very clear. Just drop the <soc-model and enumerate the SoCs:

compatible: should be one of:
    "mediatek,mt2701-musb"
    ...
  followed by "mediatek,mtk-musb"

> + - reg             : specifies physical base address and size of
> +   the registers
> + - interrupts      : interrupt used by musb controller
> + - interrupt-names : must be "mc"

-names is pointless when there is only one.

> + - phys            : PHY specifier for the OTG phy
> + - phy-names       : should be "usb2-phy"

Same here.

> + - dr_mode         : should be one of "host", "peripheral" or "otg",
> +   refer to usb/generic.txt
> + - clocks          : a list of phandle + clock-specifier pairs, one for
> +   each entry in clock-names
> + - clock-names     : must contain "main","mcu","univpll"

space needed after each comma.

> +   for clocks of controller
> +
> +Optional properties:
> + - extcon : external connector for VBUS and IDPIN changes detection,
> +   needed when supports dual-role mode.

Don't use extcon for new bindings. The usb-connector binding should be 
used instead.

> + - vbus-supply : reference to the VBUS regulator, needed when supports
> +   dual-role mode.

The controller is powered from Vbus? Probably not. This belongs in the 
connector or maybe the phy (if the phy is powered from Vbus).

> + - power-domains   : a phandle to USB power domain node to control USB's
> +   MTCMOS
> +
> +Example:
> +
> +usb2: usb@11200000 {
> +	compatible = "mediatek,mt2701-musb";
> +		"mediatek,mtk-musb";
> +	reg = <0 0x11200000 0 0x1000>;
> +	interrupts = <GIC_SPI 32 IRQ_TYPE_LEVEL_LOW>;
> +	interrupt-names = "mc";
> +	phys = <&u2port2 PHY_TYPE_USB2>;
> +	phy-names = "usb2-phy";
> +	vbus-supply = <&usb_vbus>;
> +	extcon = <&extcon_usb>;
> +	dr_mode = "otg";
> +	clocks = <&pericfg CLK_PERI_USB0>,
> +		 <&pericfg CLK_PERI_USB0_MCU>,
> +		 <&pericfg CLK_PERI_USB_SLV>;
> +	clock-names = "main","mcu","univpll";
> +	power-domains = <&scpsys MT2701_POWER_DOMAIN_IFR_MSC>;
> +};
> -- 
> 1.9.1
> 

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
