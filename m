Return-Path: <SRS0=cUnb=OQ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1132C07E85
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 21:22:51 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AA4B12082D
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 21:22:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="nMRGE6aF";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VU3A93J6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AA4B12082D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=XSuiw7zV77I7eg3XqYM/zWNjy5YS8ZsKBDxKu12gsJU=; b=nMRGE6aFbHHKNk
	SlvVLjkF5ZEU+FdDp7w04eMb5047zc5+CH/+QGbQWGxcpDAIvH30NPxyCE6XIuSZN/C7QcGDM01cp
	aRZW5MHMO2jo6APXeIftbYfg4OdlFhLUDcF3Gzd8+etHxpLK43E+zkeaaC33E8oM4RguQtPP0CN6l
	EVB3uOj5whq3qZHU2qjyGtl6AAiUWx45cwCGaz7xBd2f67UnClLs0WMH8a6hy6nknygCax2VFN6Z/
	w4Us5U7r5spouuoJHb40nJg1IYfbxicC8pBaC6AsijGfm9QjHAkypJtkAesU/oftVwCKppTYx4fxN
	GlkiBhaB3EgxZcb5h9PQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gVNaC-00032t-Kq; Fri, 07 Dec 2018 21:22:48 +0000
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gVNaA-000326-4D
 for linux-arm-kernel@lists.infradead.org; Fri, 07 Dec 2018 21:22:47 +0000
Received: by mail-wr1-x443.google.com with SMTP id b14so5034381wru.12
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 07 Dec 2018 13:22:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=Qs4uDAGcVXL97ifLvnitOFApRux8uziSKhY2nP1qpWc=;
 b=VU3A93J68rWpAPYozx/PVjnAe3XghKxITuFmzcejLzJRHNhPkktl4eu56D22Qd4TfW
 GViKca2HLQSQbpZn+x2dlVhgGBQvKT9lPj9KVNfhtqPudziXI7zAHkezNocyM2dgE4vP
 42ZM0Wh2hU8LoIEM0oi+ndVz5mr0BUXMRkSKRBYZqk5fhamw4iKXwWPYh/QQLW7CfUCF
 lw0rrN19eCK0OcXgR3WD7Nocb0GvCMJPIAQzwJ7gKJKjKus+Vo/zdrvq6drNpdfduh2x
 SHpxQeL2/W+PJ8McIQbWSaLBhMsIeGWuhK4XQL1zPeuAY8NBYqnCGhJOQzQ9Un11YsdR
 rlIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=Qs4uDAGcVXL97ifLvnitOFApRux8uziSKhY2nP1qpWc=;
 b=RaLfYJDTR3S7kmEJ4jYVeKgwEqpzv3KxjU+ppcJYsPh3lJzhxWZxIViGyuJvZ553+G
 t8v9kGfZ3JtuGtnq3+VY5DG0QronXJHJvJFjWfxyVaM8qYRupg70nEU8QkM1dW062r08
 6P9Gdx7LA+PmcRBhoWdjKkNlrBZmAiaLLPwPK9xMsvQj+0XkY6CDBMuCkr+3VxViyFJx
 BbPEK21K9xdP5MEydnmn6gTWIMKfnol0Uhb4EiDADKx9VWZl4KG5nXkNZ32DPySc+Uoj
 BJnT+FPPaHzudDWvtrgBo/ZmzqFRO1z12PGbmG8DKL7p1hE8l+7EppYm2558kbE8eJ/N
 m7JQ==
X-Gm-Message-State: AA+aEWalwac2v0GmKCvkIIO+lL7f6DbZE6hrBgN7oDMmvRcWKNye2COc
 Jb4PGQ8EGS50wxBwzOsmXIw=
X-Google-Smtp-Source: AFSGD/UScrJZm0/2RXrpeiTJBgzH+jsN0vo+gqEJW14qD4dGjknTWP7X3DNH7JojVDTLGKc/vGQxzQ==
X-Received: by 2002:a5d:5089:: with SMTP id a9mr3174445wrt.327.1544217753940; 
 Fri, 07 Dec 2018 13:22:33 -0800 (PST)
Received: from jernej-laptop.localnet (cpe1-8-82.cable.triera.net.
 [213.161.8.82])
 by smtp.gmail.com with ESMTPSA id b129sm3109832wmd.24.2018.12.07.13.22.31
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Fri, 07 Dec 2018 13:22:32 -0800 (PST)
From: Jernej =?utf-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To: linux-sunxi@googlegroups.com, paul.kocialkowski@bootlin.com
Subject: Re: [linux-sunxi] [PATCH v2 15/15] arm64: dts: allwinner: a64: Add
 Video Engine node
Date: Fri, 07 Dec 2018 22:22:30 +0100
Message-ID: <2823800.C4zEU5jiS7@jernej-laptop>
In-Reply-To: <20181205092444.29497-16-paul.kocialkowski@bootlin.com>
References: <20181205092444.29497-1-paul.kocialkowski@bootlin.com>
 <20181205092444.29497-16-paul.kocialkowski@bootlin.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181207_132246_167714_B7AE94A5 
X-CRM114-Status: GOOD (  15.42  )
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
Cc: devel@driverdev.osuosl.org, devicetree@vger.kernel.org,
 Sakari Ailus <sakari.ailus@linux.intel.com>,
 Maxime Ripard <maxime.ripard@bootlin.com>, linux-kernel@vger.kernel.org,
 Hans Verkuil <hverkuil@xs4all.nl>, Chen-Yu Tsai <wens@csie.org>,
 Rob Herring <robh+dt@kernel.org>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 Mark Rutland <mark.rutland@arm.com>,
 Mauro Carvalho Chehab <mchehab@kernel.org>,
 linux-arm-kernel@lists.infradead.org, linux-media@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi!

Dne sreda, 05. december 2018 ob 10:24:44 CET je Paul Kocialkowski napisal(a):
> This adds the Video Engine node for the A64. Since it can map the whole
> DRAM range, there is no particular need for a reserved memory node
> (unlike platforms preceding the A33).
> 
> Signed-off-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
> ---
>  arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi | 11 +++++++++++
>  1 file changed, 11 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
> b/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi index
> 8557d52c7c99..8d024c10d7cb 100644
> --- a/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
> +++ b/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
> @@ -397,6 +397,17 @@
>  			};
>  		};
> 
> +		video-codec@1c0e000 {
> +			compatible = "allwinner,sun50i-h5-video-engine";

You meant A64 instead of H5, right?

Best regards,
Jernej

> +			reg = <0x01c0e000 0x1000>;
> +			clocks = <&ccu CLK_BUS_VE>, <&ccu CLK_VE>,
> +				 <&ccu CLK_DRAM_VE>;
> +			clock-names = "ahb", "mod", "ram";
> +			resets = <&ccu RST_BUS_VE>;
> +			interrupts = <GIC_SPI 58 IRQ_TYPE_LEVEL_HIGH>;
> +			allwinner,sram = <&ve_sram 1>;
> +		};
> +
>  		mmc0: mmc@1c0f000 {
>  			compatible = "allwinner,sun50i-a64-mmc";
>  			reg = <0x01c0f000 0x1000>;





_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
