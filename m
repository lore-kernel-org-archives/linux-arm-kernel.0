Return-Path: <SRS0=sKCI=QH=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78417C169C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 06:42:45 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 54A03218AC
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 06:42:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="lHHBT7Cv";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=solid-run-com.20150623.gappssmtp.com header.i=@solid-run-com.20150623.gappssmtp.com header.b="1z1UPqom"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 54A03218AC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=solid-run.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=k0vL6qgUh5+uxher9ucc4wqNBwPp1dEgdet6iUbTbvU=; b=lHHBT7Cv0pUxjq
	Mqo6kl790iYeGZFcXMf2K9YAu/2wX4LCV8YH2s1g864AmcsSRCqJdCfynJvUtA0k7tEoodhIMNsEx
	9qGmaCWjPxgn31+/xCEginGrQHJLlXBiGfFv3rKtPrq83O6GM4elqEQA8HQKexZhianUuGeZxQcj7
	IY8EVWIEpGJsSh+Kz3JtqxaTxbws2tlr7tpZChqArtXNtvL02uGTIv00ExlH+8KeXQ1hvZsniB3p/
	oaKvOOCtlY2cMd5fZ5BB1abVcYJvGEm5NC/B1u/Oq6sa1yj8MmyJ5x18N+zbxGheIVhOj5HSFdCc6
	gB0Mq23LQ0tY8nxvBjVA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gp63g-0000I6-4J; Thu, 31 Jan 2019 06:42:44 +0000
Received: from mail-yw1-xc43.google.com ([2607:f8b0:4864:20::c43])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gp63c-0000Hg-7d
 for linux-arm-kernel@lists.infradead.org; Thu, 31 Jan 2019 06:42:41 +0000
Received: by mail-yw1-xc43.google.com with SMTP id b63so859020ywc.11
 for <linux-arm-kernel@lists.infradead.org>;
 Wed, 30 Jan 2019 22:42:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=solid-run-com.20150623.gappssmtp.com; s=20150623;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=qYq/MfBIDrvvJHQVogQKce+h7+rp4/WxgM4Qk2ZdRac=;
 b=1z1UPqom7Nk9IDFIgO2egLq31kbBy5CRyqT8YqikUlVuYUZun/XExRzkr6gKSlq9X5
 xeZlP5gRsdnCroWHoBjslYlp0nSYvJgtQySgh+jl6iFdMtN4IZAg5Yw4s7FvHoPIkQYN
 FuI41CaSZy0fwi1jiwNKlOIc+W7l220EOh+0XDxk186cy9hEOM5KPwOf/rK5u8T1ypx1
 PPnlkqe5ME1hmmS1dZFNIF0tsI9uO11FTX5F24LTnBVuIJdFNeRMswUCNJvjWNAsHeb/
 w95Pd+ktggr0Cms5rYNSQApyjRAhKoEi0aI0KBD3JuGlfv/XffjmCHW7m2WlY4pDD6hx
 cAew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=qYq/MfBIDrvvJHQVogQKce+h7+rp4/WxgM4Qk2ZdRac=;
 b=KiuPreIdxZYOVEQisDtpLUF5v65VUdtIWLrW3YXaTenE+8I0TZWSLenpGSa7qDxmjV
 1lfElA7azoxY8Sd3ZThwMcosPd+BDdZaw8cDx94jh3wu2dzyieYZ9NIXf+bVbkeMfQ/S
 hwsGTeWgeVlebV+U6Rvc4Hr4P38xrdoT5uPs2JKn8tTwOSnyB6rGT/Z6NpCE7u0AjM3X
 BDK0jy/rIbZ6qcIr1EYAAp8nsyCyNFfXKmvFO67wM8jVsPM0xMlpxoucWV7tev7CJGV6
 81qD0c7A4WWUkGytSzadQWkal4p9Ld+7fjZSvG/cR8d3pkPFIWQKcARaBmnqjJCjZOF2
 lcKA==
X-Gm-Message-State: AJcUukfomfDVv2MkSdHP0TOdEUtm6jtK9QCmi4FwN6Sa+zdya2ZbPi+k
 z5fk/K+0BxVQeHmIzIJeiQ8zT8LY4VCjXgdAUoemhQ==
X-Google-Smtp-Source: ALg8bN6KUjg8JraN881Iolgj2ssAFbHtt+e/Ts68bO4K0RfRkbZy9/oL7n8/kkJHZW/0vpQ8uE8FG0OEs09OCtCkDQY=
X-Received: by 2002:a0d:db97:: with SMTP id
 d145mr32146924ywe.487.1548916958745; 
 Wed, 30 Jan 2019 22:42:38 -0800 (PST)
MIME-Version: 1.0
References: <cover.1548861664.git.baruch@tkos.co.il>
In-Reply-To: <cover.1548861664.git.baruch@tkos.co.il>
From: Jon Nettleton <jon@solid-run.com>
Date: Thu, 31 Jan 2019 07:42:02 +0100
Message-ID: <CABdtJHvy21h2EOhPGzZsva1pOfXt=jzgbfPnbQCf1drUnuo2Sw@mail.gmail.com>
Subject: Re: [PATCH 0/4] ARM: dts: hummingboard2: fixes and improvements
To: Baruch Siach <baruch@tkos.co.il>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190130_224240_405225_65125548 
X-CRM114-Status: GOOD (  13.49  )
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
Cc: Sascha Hauer <s.hauer@pengutronix.de>, Russell King <linux@armlinux.org.uk>,
 NXP Linux Team <linux-imx@nxp.com>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Fabio Estevam <fabio.estevam@nxp.com>, Shawn Guo <shawnguo@kernel.org>,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Wed, Jan 30, 2019 at 5:18 PM Baruch Siach <baruch@tkos.co.il> wrote:
>
> The first two patches fix UART on the optional mikroBUS header.
>
> The last two patches add optional CAN and RS485 peripherals. I sent these
> patches before, but they were not applied at the time:
>
>   https://patchwork.kernel.org/patch/10528011/
>   https://patchwork.kernel.org/patch/10528013/
>
> Both patches are rebased here on top of the UART fixes.
>
> Baruch Siach (4):
>   ARM: dts: hummingboard2: fix uart3 Rx pin conf
>   ARM: dts: hummingboard2: add uart3 pinmux for board rev 1.4
>   ARM: dts: hummingboard2: describe optional rs485
>   ARM: dts: hummingboard2: describe optional can bus
>
>  arch/arm/boot/dts/imx6qdl-hummingboard2.dtsi | 42 +++++++++++++++++++-
>  1 file changed, 41 insertions(+), 1 deletion(-)
>

Thanks Baruch,

I would like to note here that I am unhappy with that the only
solution for configuration options is to add comments mentioning
conflicting device-tree entries.  While it does at least provide a
reference for users wanting this functionality it is a terrible
solution.  The only way to manage this properly would be to support
device-tree overlay fragments in the kernel-tree. I would much rather
have an overlays subdirectory infrastructure or some other mechanism
where these options could be properly written and applied to a "base"
dtb.

-Jon

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
