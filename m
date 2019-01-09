Return-Path: <SRS0=Odjb=PR=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A831C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 19:09:16 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 650E020685
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 19:09:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="etf3c8v9";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="TvU7YJv6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 650E020685
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=OZAPrSlBrye0d/OERASLEzXISInFNFROd9lGLJSWqtc=; b=etf3c8v9b0yqwL
	Uztabk2Po2HW2twoBXQbBzpMiv7sbxCqHqHso5xXR8WvXvrFLd3S+azqEgsRUcuUDw6+s3ollbbQ7
	FFDOX8XvCPCiKdnzETz7xMQI0xzzcBuOUYCKlszdVyPNJbY12+vYmFL5OrigBkRONmJeDiqjH1Thd
	vfdvZoJKci37/Qs5/TYG/5yH7f1Lj1N672f2fMG0xvIkrhn6SaLz3G3OmNTca+bDT+AKKPzQSjR6M
	2ihNZOarj6hSEUNComoFGpexo5I7/8E9zpCQFn7W5WSH+OaJUpqkxi0tNgP+U+X8wvF76kD8so/Gq
	C6Zvg0uRE5QzoMDaOROQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1ghJE1-0001VD-RW; Wed, 09 Jan 2019 19:09:13 +0000
Received: from mail-io1-xd44.google.com ([2607:f8b0:4864:20::d44])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1ghJDz-0001Uq-9T
 for linux-arm-kernel@lists.infradead.org; Wed, 09 Jan 2019 19:09:12 +0000
Received: by mail-io1-xd44.google.com with SMTP id r200so6885105iod.11
 for <linux-arm-kernel@lists.infradead.org>;
 Wed, 09 Jan 2019 11:09:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=AXZT4VHugkGKeRGT88/HaZwrBVVB394UI+pwQ6ZW+10=;
 b=TvU7YJv6x29/i+OJ0dQazYCO2iAP5BlCDpHNlVQRVV9MVuPxk9glN8i6XB6rXwEy8v
 EYHp7R6LnmmWUvLRY+Xlr5DtTGdfXiPo3svTWtK4/woWin24l7UEF/fQ1kvg6yKevzqf
 X7unrBjK32rfUEDPBnTrDfxTq4006yKtLxJ94=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=AXZT4VHugkGKeRGT88/HaZwrBVVB394UI+pwQ6ZW+10=;
 b=aPOTisFS3/8Sekrpj558Fz+5esNwYlT5EKBw5Vna90wq9eeqi4C55ohnQU8QYr3HZp
 ols9k07gJTCZw4B88XbXvPD89hxXFeADbUJgkSXU7Twl9WRo9Nek0xnnYdBv2B9UGNEd
 lHsWbLgxkfRENMPX2jcuQde/79gZ13AkouO4nZZr+fyxWu3XoZzOcstbJP3EOMv26r/C
 xj48Qp+ZRZwZA4bv95oL8KRe1vDR40kwnbmHhJ3UjM4RmD+mzd3hGn61NC62Vq6OHCfi
 lniQzlxf45ZnlBd/XcPZBTaKC/UXty/6wGqn5acWi3O8BFnQK1FxfL6Rx4uXfxd+WN29
 7YHw==
X-Gm-Message-State: AJcUukcs9ZhyElaE78azmDAxJ5QMEcKMCHhtj6qM9AwNzisoTEYqX3BH
 rumqplaKjR/P1Rgu344qc5zrsf+Cm8/mcDJiqtBlnQ==
X-Google-Smtp-Source: ALg8bN43NhDbxulZIkooIMEKFGCsP95uM/1+OrSso0V2jCiqcXt+OWR3aZKm/z26g+/bqd7EwK5n7PClknSDAqd504Y=
X-Received: by 2002:a6b:c8c9:: with SMTP id y192mr4398413iof.183.1547060950226; 
 Wed, 09 Jan 2019 11:09:10 -0800 (PST)
MIME-Version: 1.0
References: <1547056892-16527-1-git-send-email-vincent.guittot@linaro.org>
 <CACRpkdbA8cvoaG_5=JCrpQd2k1HYRxUjqGsoGJLLvroGGQukkA@mail.gmail.com>
In-Reply-To: <CACRpkdbA8cvoaG_5=JCrpQd2k1HYRxUjqGsoGJLLvroGGQukkA@mail.gmail.com>
From: Vincent Guittot <vincent.guittot@linaro.org>
Date: Wed, 9 Jan 2019 20:08:59 +0100
Message-ID: <CAKfTPtAaVXjm8sf1o=4yfRt_pyVU0T7H8jOatm6EreYVNoWj+w@mail.gmail.com>
Subject: Re: [PATCH] arm64/hisilicon: fix SDcard detection
To: Linus Walleij <linus.walleij@linaro.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190109_110911_337175_B132EA10 
X-CRM114-Status: GOOD (  14.81  )
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

On Wed, 9 Jan 2019 at 19:28, Linus Walleij <linus.walleij@linaro.org> wrote:
>
> Hi Vincent!
>
> On Wed, Jan 9, 2019 at 7:01 PM Vincent Guittot
> <vincent.guittot@linaro.org> wrote:
>
> > commit 89a5e15bcba8 ("gpio/mmc/of: Respect polarity in the device tree")
> > has changed how cd_gpios phandle and cd-inverted are used to set gpio's flags.
> >
> > Since this change, hikey960 SDcard is not detected anymore because flags
> > are not set correctly. Updating cd-gpios to set GPIO_ACTIVE_LOW instead
> > of high, fixes the problem.
> >
> > Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
>
> Please check if this patch fixes your problem:
> https://marc.info/?l=linux-mmc&m=154637189021211&w=2

This fix the problem

>
> > --- a/arch/arm64/boot/dts/hisilicon/hi3660-hikey960.dts
> > +++ b/arch/arm64/boot/dts/hisilicon/hi3660-hikey960.dts
> > @@ -582,7 +582,7 @@
> >         sd-uhs-sdr104;
> >         disable-wp;
> >         cd-inverted;
> > -       cd-gpios = <&gpio25 3 0>;
> > +       cd-gpios = <&gpio25 3 GPIO_ACTIVE_LOW>;
>
> This is also a good change, but the old device tree should
> continue to work so we need to fix the real bug.
>
> If you also remove "cd-inverted" above, this patch should
> hopefully still work and be fine to apply as well.

ok. I'm going to send an update

>
> Yours,
> Linus Walleij

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
