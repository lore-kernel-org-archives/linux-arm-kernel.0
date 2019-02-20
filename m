Return-Path: <SRS0=0Bxu=Q3=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3191C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 14:05:37 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7501F2146E
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 14:05:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="QVhEUQAr";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Pm1ABLiq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7501F2146E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=zBhmRq7xF3bcSjUMrjZiBt0GDLLDAoTx56As0C4b6ko=; b=QVhEUQArw/hZpu
	+5ksvEUG5ANKbhR53RhG/7m9U9HQqKs+S1KrfYuc/4odO928tpUL2Nr3h4vuoBKZ5F764WFApYvuh
	smFAQlSR24aiJiqpG7wywN7TlwxCEZj5ZRdldl22UABfAOrfIko/SlmSkd+Iu79EbFyM5zfK2e+yf
	5y5Foi8P9EoJQBz2lnDoVxzox5cMUxosbhRrCfzRJyddO7bZYX2r+YCEXvwL13HPNjnUBnWxMxXST
	xRgrNQtv1rUxWqMweyJmrrn1XnGLDWvUtOwmWl/NoGo/N+p/XZ9ILhpCNHkgH/fLF3p1wg4Yiru2l
	P20MTzq7q25pdsoGFQaQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gwSVD-0004bC-FS; Wed, 20 Feb 2019 14:05:35 +0000
Received: from mail-it1-x144.google.com ([2607:f8b0:4864:20::144])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gwSVA-0004aq-W9
 for linux-arm-kernel@lists.infradead.org; Wed, 20 Feb 2019 14:05:34 +0000
Received: by mail-it1-x144.google.com with SMTP id z124so15678989itc.2
 for <linux-arm-kernel@lists.infradead.org>;
 Wed, 20 Feb 2019 06:05:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=vnywmEJQ5bqQfLzt5vAo/SeZGb+fbCTVsFOC8aD5U+k=;
 b=Pm1ABLiqKzTgx4IqWkAR+p4uEpDoZhOJdfBeEz8k4TkLnUzPyjEmPYO/4G+62Pb7dR
 IyNzcoA9tC1VVdWHYx8EdRfkeccn0X0ayaINcDrAacAZDJeytRsJN7noU/3mhSdNwOh0
 oQ4JtvFviLpqOs7/3REZExZgYlRRjx6vUNRMAJF+lu5UiNDM60ReG5AmXUf0BSHkrQPk
 yRo6BDGlmezfSAEN0gz/nm4TVBmcEyF739tUN7S/68uQjq3Z5ZiwBJ6+xWe9NUcvdymJ
 O3epdF6UpwQ6g52rJwvFFcJTKKx9R9R+FFAY9h3lTOdL4FGkCGDl86hfRJOAuzea1+sk
 qLdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=vnywmEJQ5bqQfLzt5vAo/SeZGb+fbCTVsFOC8aD5U+k=;
 b=FxyI9jXyZrSpRJh73F2NkzPPR1MXlbZ6oBIdRk6DtOMF2R2g5BHUNbHNiiVGbTO6bf
 0ahSrd0dT11OUEPf7XjWSxsmzv77rZmifkO4osDSQPy6CcmL4WM5grcBwriB+Ur9skv5
 bu/rZQ7uLxhqlJV8sB0DRfdWRyYziH7ON8LpoSOajnzBOr0k2iK9PsqKqbPFd114KmoL
 0lPPTCMwXy5tr+IWe4zPxUiwQuYbzMzY2C9EkIJmMBtlY/8OqBN0zm6TvG32tnmZ+LDv
 zT6Hd+FvPSMMnKqi6P8nlqW10hpVd3ktTGK3lCqYlyjlpyBx6wP9k7DCczo5EOK5tw6q
 iezQ==
X-Gm-Message-State: AHQUAubU83+OWvBqtqIA95rr9mlHF3GV4+beAq7RW5Cm0KYEM6ATm9YU
 h0Cy1JpAUgdLxWtOMqu8DrtQcuWMnZYnKg598zk=
X-Google-Smtp-Source: AHgI3IbJeMnsMeF+/G16AeQOjBWzNw3gOKSEJSQa+9nd2GBfJ8AgKXKSiVFKRLJnpkEGeR0pTNflF93XZ0kCWVBwe2k=
X-Received: by 2002:a6b:7108:: with SMTP id q8mr19381004iog.7.1550671531649;
 Wed, 20 Feb 2019 06:05:31 -0800 (PST)
MIME-Version: 1.0
References: <20190217162316.14111-1-tiny.windzz@gmail.com>
 <20190217162316.14111-3-tiny.windzz@gmail.com>
 <20190218084931.fdut6d4cgwkwvihx@flea>
In-Reply-To: <20190218084931.fdut6d4cgwkwvihx@flea>
From: Frank Lee <tiny.windzz@gmail.com>
Date: Wed, 20 Feb 2019 22:05:10 +0800
Message-ID: <CAEExFWuAwUzXwjTiekGsjxY0Jop5_tYVgLj5gi9+Kqq=aFyT4w@mail.gmail.com>
Subject: Re: [PATCH 2/5] nvmem: sunxi-sid: add support for H5's SID controller
To: Maxime Ripard <maxime.ripard@bootlin.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190220_060533_058152_033F0CC7 
X-CRM114-Status: GOOD (  18.63  )
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
 Srini Kandagatla <srinivas.kandagatla@linaro.org>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

HI Maxime and ChenYu,

On Mon, Feb 18, 2019 at 4:49 PM Maxime Ripard <maxime.ripard@bootlin.com> wrote:
>
> On Sun, Feb 17, 2019 at 11:23:13AM -0500, Yangtao Li wrote:
> > Add support for H5's SID controller.
> >
> > Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
> > ---
> >  drivers/nvmem/sunxi_sid.c | 6 ++++++
> >  1 file changed, 6 insertions(+)
> >
> > diff --git a/drivers/nvmem/sunxi_sid.c b/drivers/nvmem/sunxi_sid.c
> > index 570a2e354f30..036029e90921 100644
> > --- a/drivers/nvmem/sunxi_sid.c
> > +++ b/drivers/nvmem/sunxi_sid.c
> > @@ -219,11 +219,17 @@ static const struct sunxi_sid_cfg sun50i_a64_cfg = {
> >       .size = 0x100,
> >  };
> >
> > +static const struct sunxi_sid_cfg sun50i_h5_cfg = {
> > +     .value_offset = 0x200,
> > +     .size = 0x100,
> > +};
>
> IIRC, there was an endianness issue on the newer SoCs, with the driver
> converting the data from big endian to little endian, while it's
> actually stored little endian in the SID.
>
> Have you checked the SID content?
It seems that data by hexdump /sys/bus/nvmem/devices/sunxi_sid/nvmem or
by md command in uboot , the data is different in some soc.

Sorry, I replied a bit late.
Any suggestions to solve it?

Yangtao
>
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
