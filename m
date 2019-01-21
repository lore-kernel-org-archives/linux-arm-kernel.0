Return-Path: <SRS0=flTa=P5=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35E99C31681
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 17:49:49 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 08AA120879
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 17:49:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="EHstI6Xh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 08AA120879
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=6cPoyrNZlnmrE/TI/2MX3RDZTSsGVePAFwCWN6dqgjQ=; b=EHstI6XhN79m++
	dlC7ETBbpjMV5FDgt5xr5Kvvgjk8woPoIOzlm6fsswVglGm90up+CXgJLtv0B9rlRbQtm4QQNSiSP
	lKk8nZtqx6wccEyewp3EU+L4hfv8+qkZ/WePAWNtGYr66KAVS0fM//AH218EqpZyws1cJcmjiXJML
	S9Y+zvRTRLXRKQ7mU9uCaV4SCjBjwiHjRb4dC5HukBoi+LV1O6SabGosFNN6GN+cTUWa2F1Orqj9X
	sBp7hbavnU7kHkYgPedn/qrJgHs0lRxcGTjlTGNgpkXmpwXbsZ/F7oVtX8SGtyVIYUSeYySL+jiEJ
	UkfauwhC/m2Q7BIUQl3w==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gldhc-0001IF-G9; Mon, 21 Jan 2019 17:49:40 +0000
Received: from mail-oi1-f195.google.com ([209.85.167.195])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gldhY-0001HH-C0
 for linux-arm-kernel@lists.infradead.org; Mon, 21 Jan 2019 17:49:38 +0000
Received: by mail-oi1-f195.google.com with SMTP id y1so15172081oie.12
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 21 Jan 2019 09:49:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=6aJ+EQfnstD82yyDJ3WZnLVa3wGpul+raVaGTSHBFMM=;
 b=r9A7Gj9UAhAms7Z7rCgSYIPOeevMVGkmsjkH9VmwPlXSUsAnmUockmv4pTGjnhnNVL
 lOKKwEw1EsuA77iZBXPi4i+pFkvaqBkiJ/dvhkQ12uDn/ACMlR0R0pC41Vjcl7eBkNuW
 bzBm9yIkoCCqVNPbZHI/7XH575Ogo6/zDVJlCNbXzxmJiEaWGlxo00bvHiMRBZ4uS+zY
 pd7Ci44lTvvCyiyODXtYAlVYAc5ZsvcGbuvHzLxTrNGFfg10QyP7ukZMb+4AryjSvJFA
 X+kXT4QDcz6Fp1s6JEmcKeZyBug31IYhGDYq5QOPKBnL45p33T394sDFtfxseDKUDVVt
 Hhgw==
X-Gm-Message-State: AJcUukcU1oRDo3wooNIIvSTSbiNPTda/F+A8nJNsGed5KnlKFbaQ6XOn
 iEHjet1ulV1Yq23+WuoD7g==
X-Google-Smtp-Source: ALg8bN7j2dYFg6CqgfFPp1Nh165waPZOCRIiZbI98KOEBH/Zp6IaDsw3wUHRDD6+vzlKFDRxFnv7Dg==
X-Received: by 2002:a05:6808:493:: with SMTP id
 z19mr2745049oid.46.1548092975393; 
 Mon, 21 Jan 2019 09:49:35 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net.
 [24.155.109.49])
 by smtp.gmail.com with ESMTPSA id l6sm5764665otf.56.2019.01.21.09.49.34
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Mon, 21 Jan 2019 09:49:34 -0800 (PST)
Date: Mon, 21 Jan 2019 11:49:34 -0600
From: Rob Herring <robh@kernel.org>
To: "Wiebe, Wladislav (Nokia - DE/Ulm)" <wladislav.wiebe@nokia.com>
Subject: Re: [PATCH 1/2] dt-bindings: edac: ARM Cortex A15 L2 asynchronous
 error detection
Message-ID: <20190121174934.GA20608@bogus>
References: <AM6PR0702MB3799A0BC3B07541CDBC4027EFA8A0@AM6PR0702MB3799.eurprd07.prod.outlook.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <AM6PR0702MB3799A0BC3B07541CDBC4027EFA8A0@AM6PR0702MB3799.eurprd07.prod.outlook.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190121_094936_417116_AEFB0B91 
X-CRM114-Status: GOOD (  18.80  )
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
Cc: "mark.rutland@arm.com" <mark.rutland@arm.com>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "arnd@arndb.de" <arnd@arndb.de>,
 "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "bp@alien8.de" <bp@alien8.de>,
 "mchehab+samsung@kernel.org" <mchehab+samsung@kernel.org>, "Sverdlin,
 Alexander \(Nokia - DE/Ulm\)" <alexander.sverdlin@nokia.com>,
 "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
 "mchehab@kernel.org" <mchehab@kernel.org>,
 "davem@davemloft.net" <davem@davemloft.net>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
 "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Tue, Jan 08, 2019 at 08:10:39AM +0000, Wiebe, Wladislav (Nokia - DE/Ulm) wrote:
> Add property description + example for using the
> Cortex A15 L2 asynchronous error detection driver.
> 
> Signed-off-by: Wladislav Wiebe <wladislav.wiebe@nokia.com>
> ---
>  .../bindings/edac/cortex_a15_l2_async_edac.txt     | 22 ++++++++++++++++++++++
>  MAINTAINERS                                        |  7 +++++++
>  2 files changed, 29 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/edac/cortex_a15_l2_async_edac.txt
> 
> diff --git a/Documentation/devicetree/bindings/edac/cortex_a15_l2_async_edac.txt b/Documentation/devicetree/bindings/edac/cortex_a15_l2_async_edac.txt
> new file mode 100644
> index 000000000000..9ad8c2497e70
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/edac/cortex_a15_l2_async_edac.txt
> @@ -0,0 +1,22 @@
> +* ARM Cortex A15 L2 internal asynchronous error detection driver
> +
> +Support for L2 internal asynchronous error detection caused by L2 RAM
> +double-bit ECC error or illegal writes to the Interrupt Controller
> +memory-map region on the Cortex A15.
> +
> +Required properties:
> +	- compatible: "arm,cortex-a15-l2-async-edac"

EDAC is a kernel name and shouldn't be in a binding (though, yes that 
is the directory name and there's examples to the contrary). How about 
just "arm,cortex-a15-l2-errirq"?

> +	- interrupts: INTERRIRQ per CPU cluster
> +
> +Example:
> +
> +cortex-a15-l2-async-edac {
> +	compatible = "arm,cortex-a15-l2-async-edac";
> +	interrupts = <0 182 4>,
> +		     <0 183 4>,
> +		     <0 184 4>,
> +		     <0 185 4>;
> +};
> +
> +Reference:
> +Cortex-A15 Technical Reference Manual, 7.7. Asynchronous errors
> diff --git a/MAINTAINERS b/MAINTAINERS
> index b755a89fa325..0796ad6e6490 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -1094,6 +1094,13 @@ F:	arch/arm/include/asm/arch_timer.h
>  F:	arch/arm64/include/asm/arch_timer.h
>  F:	drivers/clocksource/arm_arch_timer.c
>  
> +ARM CORTEX A15 L2 INTERNAL ASYNCHRONOUS ERROR DETECTION DRIVER
> +M:	Wladislav Wiebe <wladislav.wiebe@nokia.com>
> +L:	linux-edac@vger.kernel.org
> +L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
> +S:	Supported
> +F:	Documentation/devicetree/bindings/edac/cortex_a15_l2_async_edac.txt
> +
>  ARM INTEGRATOR, VERSATILE AND REALVIEW SUPPORT
>  M:	Linus Walleij <linus.walleij@linaro.org>
>  L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
> -- 
> 2.16.1
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
