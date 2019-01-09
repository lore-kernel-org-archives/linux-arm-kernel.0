Return-Path: <SRS0=Odjb=PR=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34134C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 18:28:09 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F3A1121738
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 18:28:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="G6r+XEoj";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="e0suuRRY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F3A1121738
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=yWt/YSwTdkpUKyhg8pAyExy4y2wiQmy2DPgRupQgl9s=; b=G6r+XEoj5eEBPj
	FFB+5Dc8oGlwpgjGPiAHr02M9Y0LzHRcVgd9RPoOJf1/nbESZlrh3UOs8K04jsjRhyRVLxI3GCb3w
	pke17MnBmPAnedQzBWettqve+AKaYF/hRhg6BPTVMLQilUsrFrrf6hMIgaczojZSDu4JX7SqaZNFa
	HB3iX8aP0vpFYdoDYWqZzuJ07VtFw+X0ZGa0SaVeAJntQykbFzT1WfEqy8z/J+RXuoSRUmxMKqo3d
	IXMvSAIT1RsN+ClBdTbs1SrCQ/BGt7XneIUFNrH0VOYYbElSB+kYlcCzjlabNMlgeSC7H6Gv9I2Fq
	toikMKglXcyWno7Z5d8Q==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1ghIaF-0007jH-KS; Wed, 09 Jan 2019 18:28:07 +0000
Received: from mail-lj1-x242.google.com ([2a00:1450:4864:20::242])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1ghIaB-0007iR-Gr
 for linux-arm-kernel@lists.infradead.org; Wed, 09 Jan 2019 18:28:05 +0000
Received: by mail-lj1-x242.google.com with SMTP id v1-v6so7372526ljd.0
 for <linux-arm-kernel@lists.infradead.org>;
 Wed, 09 Jan 2019 10:28:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=8RJuycZFVnX/932+Qivq9pRyV9V81OMvCpk9Z/FH5yk=;
 b=e0suuRRYxRZfYJ0095LKqRW5UyRompvFzbKYpIO+ErTQMD5I0Zq0s2uU1PCr/oJ3ke
 +3lEGx6+Ea6HFOd363en13nx/v4X/1bOagcFbTKvsATwVdp66/Enge++G82yrfepjXQP
 camKmoPs5YpUWQ3A2sePy/CBMczdOqopSsnNc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=8RJuycZFVnX/932+Qivq9pRyV9V81OMvCpk9Z/FH5yk=;
 b=lXBOJ/oRz0mgGzAf6wVneD9XTb+2XqKAONi9n4f07NvwnTJcWRpVoMa8gOcsRfaaCG
 xcTK1+mvX43Tl18sx8wY65hmh6OrbPDKR6Wp2WAHXTF1/uxE0QZADBt09qwtBOIRo/4h
 56cjb/WBe8fVCGaXEZ3Uok59jFgQ9V0U9/vroi933T67baeXXvqfqymWQ3C7LxAwyfR3
 V1pAqpDepQYSTuW0wyNdOWi1k0gRkMyPuFUl9mf3NtRCBjI97KS0CuK/3c5D37B5k9fQ
 PBkC89LoVRyzIcZOhikFkH8OEGAHw/65zL6f4TtwSRStcvOuvnYkp0ORVPeXegLHFyqN
 00og==
X-Gm-Message-State: AJcUukcl2IIpq1MXqvIMulnR/EQLqsl7/WbGZKhk033pcy61HrfpljNh
 GOufe0BJiqmI97Jz4ERq+f0S0dqHhtFHeHCZTZo93A==
X-Google-Smtp-Source: ALg8bN4EuzDZSDDC3fZTwgwqZYW1ZaHKTlfwBCyaACJ7fNnndSMSPKqNxMN4OpMtlZShpdi92D66Pz15wznCrYfwOak=
X-Received: by 2002:a2e:9107:: with SMTP id m7-v6mr4120473ljg.23.1547058481240; 
 Wed, 09 Jan 2019 10:28:01 -0800 (PST)
MIME-Version: 1.0
References: <1547056892-16527-1-git-send-email-vincent.guittot@linaro.org>
In-Reply-To: <1547056892-16527-1-git-send-email-vincent.guittot@linaro.org>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Wed, 9 Jan 2019 19:27:48 +0100
Message-ID: <CACRpkdbA8cvoaG_5=JCrpQd2k1HYRxUjqGsoGJLLvroGGQukkA@mail.gmail.com>
Subject: Re: [PATCH] arm64/hisilicon: fix SDcard detection
To: Vincent Guittot <vincent.guittot@linaro.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190109_102803_567584_129F7C16 
X-CRM114-Status: GOOD (  11.31  )
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
Cc: Mark Rutland <mark.rutland@arm.com>,
 "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
 <devicetree@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Xu Wei <xuwei5@hisilicon.com>, Rob Herring <robh+dt@kernel.org>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi Vincent!

On Wed, Jan 9, 2019 at 7:01 PM Vincent Guittot
<vincent.guittot@linaro.org> wrote:

> commit 89a5e15bcba8 ("gpio/mmc/of: Respect polarity in the device tree")
> has changed how cd_gpios phandle and cd-inverted are used to set gpio's flags.
>
> Since this change, hikey960 SDcard is not detected anymore because flags
> are not set correctly. Updating cd-gpios to set GPIO_ACTIVE_LOW instead
> of high, fixes the problem.
>
> Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>

Please check if this patch fixes your problem:
https://marc.info/?l=linux-mmc&m=154637189021211&w=2

> --- a/arch/arm64/boot/dts/hisilicon/hi3660-hikey960.dts
> +++ b/arch/arm64/boot/dts/hisilicon/hi3660-hikey960.dts
> @@ -582,7 +582,7 @@
>         sd-uhs-sdr104;
>         disable-wp;
>         cd-inverted;
> -       cd-gpios = <&gpio25 3 0>;
> +       cd-gpios = <&gpio25 3 GPIO_ACTIVE_LOW>;

This is also a good change, but the old device tree should
continue to work so we need to fix the real bug.

If you also remove "cd-inverted" above, this patch should
hopefully still work and be fine to apply as well.

Yours,
Linus Walleij

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
