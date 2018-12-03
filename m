Return-Path: <SRS0=0OAT=OM=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3948C04EB9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 09:19:55 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A1B8820834
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 09:19:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="iFG0TIKr";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="uxiizEiF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A1B8820834
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Mime-Version:References:In-Reply-To:
	Date:To:From:Subject:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=z+qV/t9+7kWjvKHbpW3QCuI6z058E5+I7p0o4HwJTv8=; b=iFG0TIKrXTI7d+
	vrJMgNt5yATff1s+gKRftMjWv5JK8rnJgwjeLFDiNAFOrKxOa8pNXdBo+Y8Qa/IgXlIqSULym6iqZ
	Q98ktjURJOZrKoA7872DFUYCqhvnkKITHhaE+MFwG7UgO08Dc/wrEU90YWSXjkbMP5oeykNA7rLEB
	paL0TxSUIo7xz7wph4dT0vwqGldyjYZbUDQMWrfqejknbKHTfKsgwQrx0ghBAokNMKOU/Grn/G0k4
	ulM3q1wDSXL/qcTgW0kn+R4yo+Uqzzh+VSG+owtU56jd8AJ/plBG3hENRlwvnqPEk6koCg6sctuiD
	u4hrGywAm2hvi0otACAA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gTkOI-0002jo-BP; Mon, 03 Dec 2018 09:19:46 +0000
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gTkOD-0002hL-5B
 for linux-arm-kernel@lists.infradead.org; Mon, 03 Dec 2018 09:19:42 +0000
Received: by mail-wr1-x443.google.com with SMTP id v13so11283709wrw.5
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 03 Dec 2018 01:19:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20150623.gappssmtp.com; s=20150623;
 h=message-id:subject:from:to:cc:date:in-reply-to:references
 :user-agent:mime-version:content-transfer-encoding;
 bh=+BnCJ5QVg9I98pcBwY5xi5gWUj5V8q8GaqKmWts3Hoo=;
 b=uxiizEiFZdN2JBo0WJit6A7VBK2FnJfOE5oSabXsIZKUBXUNX2SKJpVotcnDMXG0ix
 S9w/xvzbnt4KjB6leOMZEEQLHAJz9kRePGFkZ/f4wzVJqYWRWnwxgwtIgMWCkrNfz4rl
 OzuF4KdIHhdZO33FzOvjLhLb/6aW45+GvoiWQwZWIJ7p7twfH0O4haNljBCw6Dcv1ZyP
 897dEI7Vjw7cYPtLLc3mLTiUHdLyCzyLmOXci1nCFKccyZUnJbXCtm0F0Mep/0akKoMo
 Vcxuk0A8ST0ZRKS9namkwPZHJVSmp3GyXOCn4Bvs30kf5o6fTWGdmnYbt7Oo4FAZTAC9
 kF6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
 :references:user-agent:mime-version:content-transfer-encoding;
 bh=+BnCJ5QVg9I98pcBwY5xi5gWUj5V8q8GaqKmWts3Hoo=;
 b=hfj2XuwNG/o7sJ0YC+SHULIIPSWsgw6aLHnc/kBM3jCT0tPCpJFpJebiQaXLA1jlNW
 2cQUV7tu/y/nF7g/ZTyJY6Y3VeWRsRoKQNVgw6PI4XqBLbdi/f8ck51RDWU8jk9MHRKe
 CRTSDUdooFtmLa3Unk5LSjHnE8FbMuY+8B0YlTCGOS0B1BbEQ5ENOpZs+1xUrOitwwfv
 0/8OA0F3TRVaLWsUAZ+d0gAiZwTWfQHz5BEpVzBP8swxvO1SjuEPW4odRnzNNUQ9yJ9S
 5MbTfMvtl8rvkXVOICUIuhWmhCxN0PpuQ2KD1mNoYa1xqtjUnEoE81WXZdj4KbffjCUt
 al1w==
X-Gm-Message-State: AA+aEWYgYzjaN13sEF+ZS76zM1wUwWCSxJHtLHCQ4dWER+JQmp6cXip0
 JKS6SXnclc5Y+AoJHAuqjPXvsGxm7V0=
X-Google-Smtp-Source: AFSGD/WM+fQGnzxJgnI+MLIoGQYgDRg+S+2o+SmT4aAmlqw4iRZBaAH/AgJ0/Tf1Q6z+xTNHHSpg1w==
X-Received: by 2002:a5d:5089:: with SMTP id a9mr13665052wrt.327.1543828769309; 
 Mon, 03 Dec 2018 01:19:29 -0800 (PST)
Received: from boomer.baylibre.com ([2a01:e34:eeb6:4690:106b:bae3:31ed:7561])
 by smtp.gmail.com with ESMTPSA id
 a12sm10578258wro.18.2018.12.03.01.19.27
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Mon, 03 Dec 2018 01:19:28 -0800 (PST)
Message-ID: <7a2f88d849ada782de6e27676518d0b9897e30e7.camel@baylibre.com>
Subject: Re: [PATCH 2/2] irqchip/meson-gpio: Add support for Meson-G12A SoC
From: Jerome Brunet <jbrunet@baylibre.com>
To: Xingyu Chen <xingyu.chen@amlogic.com>, Marc Zyngier
 <marc.zyngier@arm.com>,  Jason Cooper <jason@lakedaemon.net>, Thomas
 Gleixner <tglx@linutronix.de>, Kevin Hilman <khilman@baylibre.com>
Date: Mon, 03 Dec 2018 10:19:26 +0100
In-Reply-To: <20181203061324.36248-3-xingyu.chen@amlogic.com>
References: <20181203061324.36248-1-xingyu.chen@amlogic.com>
 <20181203061324.36248-3-xingyu.chen@amlogic.com>
User-Agent: Evolution 3.30.2 (3.30.2-2.fc29) 
Mime-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181203_011941_197477_75B4AF53 
X-CRM114-Status: GOOD (  17.74  )
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
Cc: Rob Herring <robh@kernel.org>, Jianxin Pan <jianxin.pan@amlogic.com>,
 linux-kernel@vger.kernel.org, Carlo Caione <carlo@caione.org>,
 linux-amlogic@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
 Heiner Kallweit <hkallweit1@gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Mon, 2018-12-03 at 14:13 +0800, Xingyu Chen wrote:
> The Meson-G12A SoC uses the same GPIO interrupt controller IP block as the
> other Meson SoCs, A totle of 100 pins can be spied on, which is the sum of:
> 
> - 223:100 undefined (no interrupt)
> - 99:97   3 pins on bank GPIOE
> - 96:77   20 pins on bank GPIOX
> - 76:61   16 pins on bank GPIOA
> - 60:53   8 pins on bank GPIOC
> - 52:37   16 pins on bank BOOT
> - 36:28   9 pins on bank GPIOH
> - 27:12   16 pins on bank GPIOZ
> - 11:0    12 pins in the AO domain
> 
> Signed-off-by: Xingyu Chen <xingyu.chen@amlogic.com>
> Signed-off-by: Jianxin Pan <jianxin.pan@amlogic.com>
> ---
>  drivers/irqchip/irq-meson-gpio.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/drivers/irqchip/irq-meson-gpio.c b/drivers/irqchip/irq-meson-
> gpio.c
> index 7b531fd075b8..971e8dea069a 100644
> --- a/drivers/irqchip/irq-meson-gpio.c
> +++ b/drivers/irqchip/irq-meson-gpio.c
> @@ -67,12 +67,17 @@ static const struct meson_gpio_irq_params axg_params = {
>  	.nr_hwirq = 100,
>  };
>  
> +static const struct meson_gpio_irq_params g12a_params = {
> +	.nr_hwirq = 100,
> +};
> +

Same comment as on i2c, the g12 seems compatible with the axg.
Is this patchset patchset really necessary ?

>  static const struct of_device_id meson_irq_gpio_matches[] = {
>  	{ .compatible = "amlogic,meson8-gpio-intc", .data = &meson8_params },
>  	{ .compatible = "amlogic,meson8b-gpio-intc", .data = &meson8b_params
> },
>  	{ .compatible = "amlogic,meson-gxbb-gpio-intc", .data = &gxbb_params
> },
>  	{ .compatible = "amlogic,meson-gxl-gpio-intc", .data = &gxl_params },
>  	{ .compatible = "amlogic,meson-axg-gpio-intc", .data = &axg_params },
> +	{ .compatible = "amlogic,meson-g12a-gpio-intc", .data = &g12a_params
> },
>  	{ }
>  };
>  



_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
