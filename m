Return-Path: <SRS0=AchV=O4=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75967C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 17:16:15 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3EDD9218A6
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 17:16:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="gLBy804O"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3EDD9218A6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=gsTxrfaD4XjWUmJ0bPCy8ocSOO++zmL8vZZ6JKCtNfA=; b=gLBy804OLmRlzD
	/ZgxpUzEHc37e44PBGnITJl7Jd+7/PlUwxh9U/heGVBRb0bHVN99FvyVm/rCUaHCdKShdgOTWSpXL
	e7kcRYKO1eY33lCKs3IrhI1fw1nu4ajkR9PMiSdGh+oCfHGWV9EPD9J2tWp3G8TU+DK/g1c2yYsVL
	JS+2ReuVyG25EZL3m1pXY4ReqHZZa5OHYuOYNSSYaTBIrZT85qdhu/evZfJbkB3YiSl1fiULMJ1VD
	1aKDag2S1JEMMCPi3xj7NUriVPZ/DhucLLTfMNVMpeaaLyrt7UmtojBf/iUUMhCCt5NKW4o5LchTX
	sjK4oGjKafjDusXz24Tg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gZfS5-0007Fm-Qq; Wed, 19 Dec 2018 17:16:09 +0000
Received: from mail-oi1-f194.google.com ([209.85.167.194])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gZfS2-0007Eo-LE
 for linux-arm-kernel@lists.infradead.org; Wed, 19 Dec 2018 17:16:08 +0000
Received: by mail-oi1-f194.google.com with SMTP id x202so2188756oif.13
 for <linux-arm-kernel@lists.infradead.org>;
 Wed, 19 Dec 2018 09:15:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=38zg1ySHg8r8hcUFP3N/sjZMuc4d9iymHQ3Ww1VAzxA=;
 b=pUG01EinBfku3NgEdYdcGOidqDGQ/3WQM+HJCqlZTyAQTsVwCNF7vO05xM9RDwM03i
 cWq3RuFBVFe4IBLmqbKSjwwpB7oNXU7YAXwNudqhW3+LLnAA5O9nkXVL6SeH2YZjbhIW
 JT3pnYzza6jB65CV8rqDVE+d7U/PMqLVqtkjx9Skv2vZXRAy62j4QfRKcsvkkXkAi/Z8
 zHaWhHcWyrPXRliygslQLPFxXyy392UcN/7cjkjBCqUymVKKVt3rDgOHwtgMRN2fbxSM
 zRGc60aiDbTiqL8B9SmyH1Gau0Gwi3Uh7jsGazgSDVXeM8lToOXAu4zFjPAkf8FJMu75
 rlqQ==
X-Gm-Message-State: AA+aEWZTt4+USVyA0eGRcDQKOhhqQqm+YMlQ99n8qo3A08F2ILWRo0Pz
 LMBgi6U5qPv1BdBi2RV1GWPr1MA=
X-Google-Smtp-Source: AFSGD/Wd26Y+hZF7YjKOSsbt9p1CcYMaWM/e2a6ibBbZgH85dtrxX4PJ7b81j/6XvFhh5Y43mBjP0Q==
X-Received: by 2002:aca:a86:: with SMTP id k6mr1665337oiy.334.1545239755156;
 Wed, 19 Dec 2018 09:15:55 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net.
 [24.155.109.49])
 by smtp.gmail.com with ESMTPSA id e128sm9125798oia.5.2018.12.19.09.15.53
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Wed, 19 Dec 2018 09:15:54 -0800 (PST)
Date: Wed, 19 Dec 2018 11:15:53 -0600
From: Rob Herring <robh@kernel.org>
To: Jagan Teki <jagan@amarulasolutions.com>
Subject: Re: [PATCH 7/9] dt-bindings: input: touchscreen: goodix: Add GT5663
 compatible
Message-ID: <20181219171553.GA4469@bogus>
References: <20181203101547.16835-1-jagan@amarulasolutions.com>
 <20181203101547.16835-7-jagan@amarulasolutions.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20181203101547.16835-7-jagan@amarulasolutions.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181219_091606_696577_BA50C20C 
X-CRM114-Status: GOOD (  17.52  )
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
Cc: devicetree@vger.kernel.org, Maxime Ripard <maxime.ripard@bootlin.com>,
 linux-sunxi@googlegroups.com, Dmitry Torokhov <dmitry.torokhov@gmail.com>,
 linux-kernel@vger.kernel.org, Chen-Yu Tsai <wens@csie.org>,
 linux-input@vger.kernel.org, Lee Jones <lee.jones@linaro.org>,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Mon, Dec 03, 2018 at 03:45:45PM +0530, Jagan Teki wrote:
> GT5663 is capacitive touch controller with customized smart wakeup gestures,
> the existing goodix driver will work by phandle vcc-supply regulator.
> 
> So, document compatible and example node for the same.
> 
> Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
> ---
>  .../bindings/input/touchscreen/goodix.txt           | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/input/touchscreen/goodix.txt b/Documentation/devicetree/bindings/input/touchscreen/goodix.txt
> index 604766e347ce..1898d3dde8e1 100644
> --- a/Documentation/devicetree/bindings/input/touchscreen/goodix.txt
> +++ b/Documentation/devicetree/bindings/input/touchscreen/goodix.txt
> @@ -3,6 +3,7 @@ Device tree bindings for Goodix GT9xx series touchscreen controller
>  Required properties:
>  
>   - compatible		: Should be "goodix,gt1151"
> +				 or "goodix,gt5663"
>  				 or "goodix,gt911"
>  				 or "goodix,gt9110"
>  				 or "goodix,gt912"
> @@ -42,3 +43,15 @@ Example:
>  
>  		/* ... */
>  	};
> +
> +	touchscreen@5d {
> +		compatible = "goodix,gt5663";

Just a new compatible doesn't warrant a new example.

> +		reg = <0x5d>;
> +		vcc-supply = <&reg_ldo_io0>;
> +		interrupt-parent = <&pio>;
> +		interrupts = <7 4 IRQ_TYPE_EDGE_FALLING>;
> +		irq-gpios = <&pio 7 4 GPIO_ACTIVE_HIGH>;	/* CTP-INT: PH4 */
> +		reset-gpios = <&pio 7 8 GPIO_ACTIVE_HIGH>;	/* CTP-RST: PH8 */
> +		touchscreen-inverted-x;
> +		touchscreen-inverted-y;
> +	};
> -- 
> 2.18.0.321.gffc6fa0e3
> 

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
