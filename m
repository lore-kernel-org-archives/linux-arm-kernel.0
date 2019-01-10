Return-Path: <SRS0=vaNk=PS=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8ACE4C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 11:25:44 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 509FF214C6
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 11:25:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="LcjJV1i5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 509FF214C6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:In-Reply-To:
	Date:References:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=XVuEFDvplG0Pq1j6pC+KMzAVIxQ/oiMKfMItvjUYk0U=; b=LcjJV1i5kTfTeD
	/DeE09aOPjeBvx21HsrpqFbCrD8Cfh0z3/fHTR+Nvy2woeVZnveXqFd6Ij+sBbhAhNvqMSpa2PiBs
	V76OxVeS3YOYmNW8/iSYXaunvKfSmAzEeoZ+UFpQ1gStNuYyS6/QXXYuTrL6IC4nLts1shVceBctf
	9LjAjB/j9Rjg3xWUoU6YDPlzBsgv4gUzvz8qD93yAnEJaii4C6up2U1nCvykVAo8APlrQzS63tpmB
	EdHmJRqkiATYZieq/2ni5xNKOsSScHLRYrHUPapFmp+y+tK86/c/akaiMG3kk+fzOxImjMjCGSGmW
	561osH1ZtGK3hfJ2xfMw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1ghYSy-0003Pj-9h; Thu, 10 Jan 2019 11:25:40 +0000
Received: from mail.bootlin.com ([62.4.15.54])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1ghYSu-0003PD-TS
 for linux-arm-kernel@lists.infradead.org; Thu, 10 Jan 2019 11:25:38 +0000
Received: by mail.bootlin.com (Postfix, from userid 110)
 id 9A51B209D7; Thu, 10 Jan 2019 12:25:35 +0100 (CET)
Received: from localhost (alyon-652-1-61-72.w109-213.abo.wanadoo.fr
 [109.213.84.72])
 by mail.bootlin.com (Postfix) with ESMTPSA id 53F5A206DC;
 Thu, 10 Jan 2019 12:25:25 +0100 (CET)
From: Gregory CLEMENT <gregory.clement@bootlin.com>
To: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH] ARM: dts: kirkwood: Fix polarity of GPIO fan lines
References: <20190107230818.6020-1-linus.walleij@linaro.org>
Date: Thu, 10 Jan 2019 12:25:25 +0100
In-Reply-To: <20190107230818.6020-1-linus.walleij@linaro.org> (Linus Walleij's
 message of "Tue, 8 Jan 2019 00:08:18 +0100")
Message-ID: <87va2woiu2.fsf@FE-laptop>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190110_032537_096521_516FEE07 
X-CRM114-Status: GOOD (  15.16  )
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
Cc: Andrew Lunn <andrew@lunn.ch>, Jason Cooper <jason@lakedaemon.net>,
 Jamie Lentin <jm@lentin.co.uk>, linux-arm-kernel@lists.infradead.org,
 Julien D'Ascenzio <jdascenzio@posteo.net>, Guenter Roeck <linux@roeck-us.net>,
 Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi Linus,
 
 On mar., janv. 08 2019, Linus Walleij <linus.walleij@linaro.org> wrote:

> These two lines are active high, not active low. The bug was
> found when we changed the kernel to respect the polarity defined
> in the device tree.
>
> Fixes: 1b90e06b1429 ("ARM: kirkwood: Use devicetree to define DNS-32[05] fan")
> Cc: Jamie Lentin <jm@lentin.co.uk>
> Cc: Guenter Roeck <linux@roeck-us.net>
> Cc: Jason Cooper <jason@lakedaemon.net>
> Cc: Andrew Lunn <andrew@lunn.ch>
> Cc: Gregory Clement <gregory.clement@bootlin.com>
> Cc: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
> Cc: Julien D'Ascenzio <jdascenzio@posteo.net>
> Reported-by: Julien D'Ascenzio <jdascenzio@posteo.net>
> Tested-by: Julien D'Ascenzio <jdascenzio@posteo.net>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>

Applied on mvebu/fixes with tags from Andrew and Jamie

Thanks,

Gregory

> ---
>  arch/arm/boot/dts/kirkwood-dnskw.dtsi | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/arch/arm/boot/dts/kirkwood-dnskw.dtsi b/arch/arm/boot/dts/kirkwood-dnskw.dtsi
> index cbaf06f2f78e..eb917462b219 100644
> --- a/arch/arm/boot/dts/kirkwood-dnskw.dtsi
> +++ b/arch/arm/boot/dts/kirkwood-dnskw.dtsi
> @@ -36,8 +36,8 @@
>  		compatible = "gpio-fan";
>  		pinctrl-0 = <&pmx_fan_high_speed &pmx_fan_low_speed>;
>  		pinctrl-names = "default";
> -		gpios = <&gpio1 14 GPIO_ACTIVE_LOW
> -			 &gpio1 13 GPIO_ACTIVE_LOW>;
> +		gpios = <&gpio1 14 GPIO_ACTIVE_HIGH
> +			 &gpio1 13 GPIO_ACTIVE_HIGH>;
>  		gpio-fan,speed-map = <0    0
>  				      3000 1
>  				      6000 2>;
> -- 
> 2.19.2
>

-- 
Gregory Clement, Bootlin
Embedded Linux and Kernel engineering
http://bootlin.com

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
