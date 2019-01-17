Return-Path: <SRS0=6Gta=PZ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AB12C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 11:06:31 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6987620851
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 11:06:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="iqzntMEn";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=cogentembedded-com.20150623.gappssmtp.com header.i=@cogentembedded-com.20150623.gappssmtp.com header.b="jndLnjtg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6987620851
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=cogentembedded.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:To:Subject:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=L4UvpV/UOIPHdCoGw4psxbEPrPwzRTtLmnbu1GZ37ow=; b=iqzntMEnGCPTFi
	niUCCvK1TLj7dO7CZhxH10rKneh0Q5X6VW35012hkZKJSo1zct6XAMHA2mnhTntVMzO6MWSrvvUhB
	bLG6RCNHdIsvdR0G7m3ItI7uroH3F2TjwmT92ABRhmNpvtj9yAEQy95/+jn4ovzfe8UMefA/ApNUd
	7/iGgNxQp36rjZGs04kn9PxyUmCIR8Wic8hOeWXmXzp7cwtT0w5g6AxPNf6aSVlkMGd3Bhyxjnlwi
	dpRW5OZfrkxrYwye30saEoXHILUS1h1nZSkk/TdXoDgKpARabSuQfhKhKxawooFKAxlkoLDmfCmAB
	IaKOD84AOvgjRVzPXZ1Q==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gk5VG-0003rP-7A; Thu, 17 Jan 2019 11:06:30 +0000
Received: from mail-lf1-x141.google.com ([2a00:1450:4864:20::141])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gk5VC-0003qi-Pe
 for linux-arm-kernel@lists.infradead.org; Thu, 17 Jan 2019 11:06:28 +0000
Received: by mail-lf1-x141.google.com with SMTP id a16so7457945lfg.3
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 17 Jan 2019 03:06:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cogentembedded-com.20150623.gappssmtp.com; s=20150623;
 h=subject:to:cc:references:from:organization:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=R5rlBaaxUUyySP7OfPdGYh4yQGBBV3PMnVzao62V3fQ=;
 b=jndLnjtgbFgGr/ihG+/Ifykc5QOMVV54MSp3ov911NS37p5w3W0Z8dRWQg8tPHv4SQ
 8NktgLPepB2X3yUwURtaW/8H5elgmuNTZpJXkFK0gDTmoOlxJOpZC/fAoY6CXZbAS5Kt
 BDVGAj69UJM2TKTqJDnzmitftaJfoxIQTmHL2Txh/fRfL9PdVenq5PvtPU670tZMqRg5
 c9vjK5h6f/3b/rkzJfb+TUv5I1r3Z01cZp1zmDsAfWvAd7Q4Fuwvrax2j/Vzcw5oCIPa
 OL1OvtvwiEG6JcVAasScLPqVoFXtbD+6LTbxwnrSohTFTFAfFRyjMJcR0SllcmFxKjnr
 nXLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:organization
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=R5rlBaaxUUyySP7OfPdGYh4yQGBBV3PMnVzao62V3fQ=;
 b=h0FX1hSMWJAtSwBrQT/1WHMm6IoVzpR0vq8qp28pGPpgX85l3RM4wBG7oj9D1yQiVs
 DT9DHVDFOShBt56iRCOEDEKCU9iXgYZc1Fi/GxX/6caB6BGaixL57LPNY/yd45y3kNw0
 VGWJtXMezBp1eH003T83zVKDweoBCUkX33J3eLfCLiJFMh21FTlO9G1TyRkEoI0DFQaw
 PQL7BwYTT+RFR56wXpq9/AktMauHMbKLLxFcFGr90x7XWod684tDUS5ISuCUsljDmNgE
 wY6y7dmUNU+kE1jHW4+bMl4YU9z8hcspemIGqXpnErpA9aaXWkZgpOlnlxPPmPEn2KXI
 hUJg==
X-Gm-Message-State: AJcUukcBw22QyXltjjuZZfyXuRypTXjJYbe5Zsx/lT8/5H8i2lBxBIAN
 AzHZELJT+H9G6KviwssYYoQGNw==
X-Google-Smtp-Source: ALg8bN6Uq2pO4WPxsF2zgnBv5Iwr9H5HJhQ9w/roWO9IdGXuKj/+uNTQZomvXMvJpVZfQ5xd21wCOA==
X-Received: by 2002:ac2:50c4:: with SMTP id h4mr9769670lfm.81.1547723184345;
 Thu, 17 Jan 2019 03:06:24 -0800 (PST)
Received: from wasted.cogentembedded.com ([31.173.80.120])
 by smtp.gmail.com with ESMTPSA id t22sm249592lfb.0.2019.01.17.03.06.17
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 17 Jan 2019 03:06:23 -0800 (PST)
Subject: Re: [PATCH v3 1/4] dt-bindings: usb: musb: Add support for MediaTek
 musb controller
To: min.guo@mediatek.com, Bin Liu <b-liu@ti.com>,
 Rob Herring <robh+dt@kernel.org>
References: <1547709348-17506-1-git-send-email-min.guo@mediatek.com>
 <1547709348-17506-2-git-send-email-min.guo@mediatek.com>
From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Organization: Cogent Embedded
Message-ID: <15fb900e-c665-8ebd-b2cc-54f47cc35734@cogentembedded.com>
Date: Thu, 17 Jan 2019 14:06:17 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <1547709348-17506-2-git-send-email-min.guo@mediatek.com>
Content-Language: en-MW
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190117_030627_014215_4166F1E3 
X-CRM114-Status: GOOD (  20.86  )
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
 linux-mediatek@lists.infradead.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hello!

On 01/17/2019 10:15 AM, min.guo@mediatek.com wrote:

> From: Min Guo <min.guo@mediatek.com>
> 
> This adds support for MediaTek musb controller in
> host, peripheral and otg mode.
> 
> Signed-off-by: Min Guo <min.guo@mediatek.com>
> ---
>  .../devicetree/bindings/usb/mediatek,musb.txt      | 43 ++++++++++++++++++++++
>  1 file changed, 43 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/usb/mediatek,musb.txt
> 
> diff --git a/Documentation/devicetree/bindings/usb/mediatek,musb.txt b/Documentation/devicetree/bindings/usb/mediatek,musb.txt
> new file mode 100644
> index 0000000..3e3f671
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/usb/mediatek,musb.txt
> @@ -0,0 +1,43 @@
> +MediaTek musb DRD/OTG controller
> +-------------------------------------------
> +
> +Required properties:
> + - compatible      : should be "mediatek,mtk-musb"
> + - reg             : specifies physical base address and size of
> +   the registers

   I'd indent it more to align with "specifies", else it looks weird.

> + - interrupts      : interrupt used by musb controller
> + - interrupt-names : must be "mc"
> + - phys            : PHY specifier for the OTG phy
> + - dr_mode         : should be one of "host", "peripheral" or "otg",
> +   refer to usb/generic.txt

  Same here...

> + - clocks          : a list of phandle + clock-specifier pairs, one for
> +   each entry in clock-names

   Here...

> + - clock-names     : must contain "main", "mcu", "univpll"
> +   for clocks of controller

  And here.

> +
> +Optional properties:
> + - extcon : external connector for VBUS and IDPIN changes detection,

   ID pin, maybe?

> +   needed when supports dual-role mode.
> + - vbus-supply : reference to the VBUS regulator, needed when supports
> +   dual-role mode.
> + - power-domains   : a phandle to USB power domain node to control USB's
> +   MTCMOS
[...]

MBR, Sergei

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
