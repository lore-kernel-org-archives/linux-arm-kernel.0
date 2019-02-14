Return-Path: <SRS0=niBm=QV=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4E45C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 14:07:18 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7FFDA2229F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 14:07:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="lP9vaxft";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DibK3K1I"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7FFDA2229F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=TqaAa/svbyjpAn2gPc1aie2cRo4DV6Q/AXeQ0VVds7k=; b=lP9vaxftG/Z6+n
	D5bnVF3rryfwaEWA2hrhZtMZZoRSrMIwyKTm+ScVGryF86MxjIpHlZNyQOAZJM/zMIjfBeXzHQWz0
	eTUrjOUe5r2OlO+Jz9Rf4ral5tBF1il8/scjNKNBbIARe65zqvuBtveE0mDhyL1nilLU+IU0T1Jbq
	zTcikDL7L03KJ0EIj2lk5+ph/mnEus12xxpFtXSoKYE4Tnkg+BqW/MC+Iqd/Mo6uhVEloTXQTOXIh
	xzydsXVzzp1NSrMdO9HH+lhUEeSNdJFesC/ZrSObFJfodSO0SmPuJxAjjbfg7wPpc/M9H3Miqi0Lj
	rNsYbB+DOaUR9OPuV/SA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1guHfY-0002uj-UA; Thu, 14 Feb 2019 14:07:16 +0000
Received: from mail-it1-x144.google.com ([2607:f8b0:4864:20::144])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1guHfV-0002uK-H2
 for linux-arm-kernel@lists.infradead.org; Thu, 14 Feb 2019 14:07:15 +0000
Received: by mail-it1-x144.google.com with SMTP id z131so4825233itf.5
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 14 Feb 2019 06:07:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=SDweC0/rM/7wIRwhhNBqenxhLevIilMXlbaDUD5AX3E=;
 b=DibK3K1IFnn644i1VQI7ocdSTjWbrqbJqhhpBYf87UCghvxQJvSL/QRz0l6XsbRfai
 tL3xomjENcO1ZP1Ujhz4yHkjJBEWzWlgXEsV31SkMIQ8/SxVPr5kmInv58sf/ufGHTDY
 DjMV1YQxjdIXCbNZrlt21mGX8aOTnLrcZ3QDO/PWdT6wPtZPKYilMNrPzviXWg96/hvp
 IJBG/INd91/Q21fe71wu+bz29cISE8QP1IsgQ6/BUcO+7oFXyAZjny7dL09/ZvFxciEq
 MBPU7GmEaRrMJLcGypHEhk6/iON/zLWpmxSgKP0PX5EWF3434mGTOQdaXjAjitvLYdjC
 GRVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=SDweC0/rM/7wIRwhhNBqenxhLevIilMXlbaDUD5AX3E=;
 b=qMUbG+fTKLz3n7RVqSy9IOJ2iz8WIrQeVZ7AZaBVw6XPcRt+3Dt5/OupAZRu88vhOP
 f1ScGmW3VbVDy3/FXI6SzH69RnGJ3Cor2IqN4POqIN/KpxtBzua6Aqkua/Q++jv0Kp9u
 iuF0sVoaQgRAHlHJoZIqYs0WcA7f87BkYConIOPvwXUiwFtIKXyrzyXJRvjJk3RlJvjO
 ceJytwo6/PUAfzq7mXtNpMGyUvP/FdgqECQiKPBT5edXM9L+MuVj7KXFwa60OgJMZRBT
 QuXvXjhXJZ0dCn6fzwqyxPxSbge4o1ZhFarkrBC2UeyO8MCnKAh+qeibO6Z4/GTA0Muc
 0YKg==
X-Gm-Message-State: AHQUAuYZ5ZmLU617H+Q+rt4tcL7BudBUUVbTzk8NNSuEI+g8Gi55cgRF
 VikMRUfHjeHzrwmurGqN2zgLPrtQyWta9qV9ofs=
X-Google-Smtp-Source: AHgI3IY482eIDUsLvvnmnYjMDQ6H105S0ndyX92l+wfORvgTXxOMNkbjXleDkW0FOaETGIoSce0V0/r6K2WP8z1eTFM=
X-Received: by 2002:a02:b885:: with SMTP id p5mr2157236jam.60.1550153232531;
 Thu, 14 Feb 2019 06:07:12 -0800 (PST)
MIME-Version: 1.0
References: <20190214130910.9201-1-tiny.windzz@gmail.com>
 <20190214130910.9201-2-tiny.windzz@gmail.com>
 <20190214134617.b44pa7onf3brmhhj@flea>
In-Reply-To: <20190214134617.b44pa7onf3brmhhj@flea>
From: Frank Lee <tiny.windzz@gmail.com>
Date: Thu, 14 Feb 2019 22:07:02 +0800
Message-ID: <CAEExFWvG4Vz2KsDnHJ6BL72nD6x=Lp+Hzj+q7LfggzFtzrgRow@mail.gmail.com>
Subject: Re: [PATCH 1/4] arm64: dts: allwinner: h6: orangepi: Add CPU supply
 regulator
To: Maxime Ripard <maxime.ripard@bootlin.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190214_060713_566991_B2F29570 
X-CRM114-Status: GOOD (  20.37  )
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
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Chen-Yu Tsai <wens@csie.org>, robh+dt@kernel.org,
 Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Thu, Feb 14, 2019 at 9:46 PM Maxime Ripard <maxime.ripard@bootlin.com> wrote:
>
> Hi!
>
> Thanks for your patches
>
> On Thu, Feb 14, 2019 at 08:09:07AM -0500, Yangtao Li wrote:
> > The original orangepi use the dcdca to supply the CPU cores. According
> > to the axp805 spec, the range of dcdca is 0.6 to 1.1v, 1.12 to 1.52v.
> > In order to support more CPU frequency, slightly increase the voltage
> > maximum and minimum.
> >
> > Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
> > ---
> >  arch/arm64/boot/dts/allwinner/sun50i-h6-orangepi.dtsi | 8 ++++++--
> >  1 file changed, 6 insertions(+), 2 deletions(-)
> >
> > diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h6-orangepi.dtsi b/arch/arm64/boot/dts/allwinner/sun50i-h6-orangepi.dtsi
> > index b2526dac2fcf..e7aebaf91ede 100644
> > --- a/arch/arm64/boot/dts/allwinner/sun50i-h6-orangepi.dtsi
> > +++ b/arch/arm64/boot/dts/allwinner/sun50i-h6-orangepi.dtsi
> > @@ -159,8 +159,8 @@
> >
> >                       reg_dcdca: dcdca {
> >                               regulator-always-on;
> > -                             regulator-min-microvolt = <810000>;
> > -                             regulator-max-microvolt = <1080000>;
> > +                             regulator-min-microvolt = <800000>;
> > +                             regulator-max-microvolt = <1160000>;
>
> This violates the minimum and maximum recommended voltages in the H6
> datasheet. Could you clarify why you are doing so (ideally in the
> commit log)?
In fact, in sunxi's sdk, the actual minimum and maximum voltage of the
cpu is smaller or larger than the datasheet.

For some better quality ic, the minimum voltage can be smaller.
For some poor quality ic, the maximum voltage needs to be increased a little.

MBR,
Yangtao
>
> Thanks!
> Maxime
>
> --
> Maxime Ripard, Bootlin
> Embedded Linux and Kernel engineering
> https://bootlin.com

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
