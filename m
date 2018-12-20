Return-Path: <SRS0=AHqO=O5=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC673C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 19:52:50 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 61017218D3
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 19:52:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="M4tj8LyP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 61017218D3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=W57ZgGvTIA5QXLV+iOECpnKKaD9+F44JsdfVMyXtZ3U=; b=M4tj8LyPE+lD8h
	j2hu3DDXrrRQgG6wPJUC2nda8Aaz+JSBc4kfbMmFiokNZ1xZp9ABZr5ZKUsJha2C1SxzTP+zo7CSO
	0Osrz5xII4MUAGOjq+tI5bNpYZvl5biYz9eTUnH2Z+RQgbHsbut7Zoj+RDczhtLRk5zurAEp/DTtF
	60PUy6tOyKX4gOAhLBURuJjzk/9iEfpXsYjTHfYpOtypMulj8pEmoKFQiJcmOLnvhY/yiiao/diTq
	LSY7e+wn+fG6xT/kcJxg1VkZzMWaBb8l9abB93T08q3DiH5xL+JDlx8M1gHBX4uHHzrCo4NhQ34yM
	iiIAZ/XIC8leim01JFGg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1ga4NA-0001MM-4W; Thu, 20 Dec 2018 19:52:44 +0000
Received: from mail-oi1-f193.google.com ([209.85.167.193])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1ga4N7-0001LB-7T; Thu, 20 Dec 2018 19:52:42 +0000
Received: by mail-oi1-f193.google.com with SMTP id y23so2900339oia.4;
 Thu, 20 Dec 2018 11:52:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=24BoR+RxY5BGrbZKEBLkjKqR1VsXUja9f0axGQKK+Nc=;
 b=DTQ375FZV8Ul/4nxlQBhiLESCSU2T2F/WsOxCS4NKxuFH15ufphJJFT7N0XXFW3ZE7
 LsGcfizxaqlHBAxMfQjfzxHAEhvHWZpfWvx3IxNBdtH5BSH50hZcIMgAgYrOqg6u6bCS
 c9B/azGY/SClbSXZGAaMcny6qJuvNfApURjATxuq5bwd5sPiGOEAsDqFH2lS18nk5Imz
 Z6TDtzYP9q4L0ayMMDOI7B46QZ5k6LkCOfx9yDtNqkkxhXghluHYg41kF9/74BxRQ9Bw
 8fex8EK/vEUesmGOwXubBm/faPgoJOA9lVCpRi+xsQCqTb9OYlfxieAunZzpfq7aju34
 2l2Q==
X-Gm-Message-State: AJcUukd+oPdSk6va+kUtvs9+t0PIAGXl3GMq2ocKOaSqmaAGiiayDL0D
 32T/Pfztb7udOlG3GaArQA==
X-Google-Smtp-Source: AFSGD/UCP0m+Wl3wBjVSkcHbNMxV2MlnqZtYM+FJISKW2QIPvuPW5PdJj1sX9T+Zo7pOQDpsao97QA==
X-Received: by 2002:a54:4088:: with SMTP id i8mr65490oii.324.1545335549842;
 Thu, 20 Dec 2018 11:52:29 -0800 (PST)
Received: from localhost ([2607:fb90:20d2:a5e2:49af:e73e:5a36:3b50])
 by smtp.gmail.com with ESMTPSA id c78sm16305114oig.30.2018.12.20.11.52.29
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Thu, 20 Dec 2018 11:52:29 -0800 (PST)
Date: Thu, 20 Dec 2018 13:52:28 -0600
From: Rob Herring <robh@kernel.org>
To: Maxime Jourdan <mjourdan@baylibre.com>
Subject: Re: [PATCH 1/2] dt-bindings: meson: add specific simplefb bindings
Message-ID: <20181220195228.GA17561@bogus>
References: <20181210090640.4495-1-mjourdan@baylibre.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20181210090640.4495-1-mjourdan@baylibre.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181220_115241_274127_F1D9574A 
X-CRM114-Status: GOOD (  17.69  )
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
Cc: devicetree@vger.kernel.org, Neil Armstrong <narmstrong@baylibre.com>,
 Kevin Hilman <khilman@baylibre.com>, linux-kernel@vger.kernel.org,
 linux-amlogic@lists.infradead.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Mon, Dec 10, 2018 at 10:06:39AM +0100, Maxime Jourdan wrote:
> Similar to simple-framebuffer-sunxi, we support different display pipelines
> that the firmware is free to choose from.
> 
> This documents the "amlogic,simple-framebuffer" compatible and the
> "amlogic,pipeline" extension.
> 
> Signed-off-by: Maxime Jourdan <mjourdan@baylibre.com>
> ---
>  .../display/simple-framebuffer-meson.txt      | 33 +++++++++++++++++++
>  1 file changed, 33 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/display/simple-framebuffer-meson.txt
> 
> diff --git a/Documentation/devicetree/bindings/display/simple-framebuffer-meson.txt b/Documentation/devicetree/bindings/display/simple-framebuffer-meson.txt
> new file mode 100644
> index 000000000000..122a5c005cd9
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/display/simple-framebuffer-meson.txt
> @@ -0,0 +1,33 @@
> +Meson specific Simple Framebuffer bindings
> +
> +This binding documents meson specific extensions to the simple-framebuffer
> +bindings. The meson simplefb u-boot code relies on the devicetree containing
> +pre-populated simplefb nodes.
> +
> +These extensions are intended so that u-boot can select the right node based
> +on which pipeline is being used. As such they are solely intended for
> +firmware / bootloader use, and the OS should ignore them.
> +
> +Required properties:
> +- compatible: "amlogic,simple-framebuffer"

And a fallback?

> +- amlogic,pipeline, one of:
> +  "vpu-cvbs"
> +  "vpu-hdmi"
> +
> +Example:
> +
> +chosen {
> +	#address-cells = <2>;
> +	#size-cells = <2>;
> +	ranges;
> +
> +	framebuffer@0 {

Without 'reg', you shouldn't have a unit-address.

> +		compatible = "amlogic,simple-framebuffer",
> +			     "simple-framebuffer";
> +		amlogic,pipeline = "vpu-hdmi";
> +		clocks = <&clkc CLKID_HDMI_PCLK>,
> +			 <&clkc CLKID_CLK81>,
> +			 <&clkc CLKID_GCLK_VENCI_INT0>;
> +		power-domains = <&pwrc_vpu>;
> +	};
> +};
> -- 
> 2.19.2
> 

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
