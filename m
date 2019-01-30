Return-Path: <SRS0=csPt=QG=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B4B3C282D7
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 15:27:25 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 69DA42087F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 15:27:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="lIYvUVsu";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="baUrPWxC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 69DA42087F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=w3bEC9Co/neqCawrewS4KPdhuP+JCRO7d/0KL/7bLoI=; b=lIYvUVsu/FD/P9
	NkKoGKxRBEhBPXe7arJ0Fz8H1y5jsNihl0NR0LzMZXByu3rj/ZLjfykTho+12PShsO7iBULY+TLs3
	54hZmkTmWN1HS/VNGo/5kqnCgHA7xkSVnO1kfHV2lrW7rfPyURvVf7z3lWNnNvIfhzAYpZTlcgZIY
	XxKQl0+B/jXv6iv21eUA3EtOIrja8LhqOTbQyP0PSRRCpwjoGOGpZ70Kx8mI0xWEmz0f9VP7Zluis
	WgIqdSgKyFB61sgRA86rI9iuxReGhpKcJOM+ZsfoK8WWoa6z9e6POVEqn9Cq8gF1ONlljXoFjGit1
	ylLItjy/UOpjPAx5lF4A==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gorlr-0002eV-Gk; Wed, 30 Jan 2019 15:27:23 +0000
Received: from mail-ed1-x544.google.com ([2a00:1450:4864:20::544])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gorlf-0002OV-Cd; Wed, 30 Jan 2019 15:27:13 +0000
Received: by mail-ed1-x544.google.com with SMTP id b3so19381392ede.1;
 Wed, 30 Jan 2019 07:27:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:content-transfer-encoding:in-reply-to
 :user-agent; bh=f98j6mmZbCQLTqIqnb3teBzYPbTR/4082gObU1s4slE=;
 b=baUrPWxCGlxVe2uAI4kSkA23zzz+ccit+b8/VSStN1i/WOC+l0T8pclJ6Nj+OWaye7
 sLn2SI1/lxTAFV1lYZotffBfLG15LcZ18RT53AUPWOpm6ZaZhaUwtI2ejUM/RKQGs2VR
 XBKjUAnfq+FlxoKnePDzCVxps4TPo49iI//M/OaHPPlhIfpDESsYZjllD4w1UrGQpaIS
 t4V1YlvJgHm8PHqfJM5Xr1TSGhCmyzlvJhN0P7ytI9bihq7a5jX0T+bFujpHcfhAPPjr
 bC+J3zDAWOr4ht6hdfjdoyB7JztHUDZkkyEIcpzmQawXtwicawf3Cfmip811H58ljJkh
 w80A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to:user-agent;
 bh=f98j6mmZbCQLTqIqnb3teBzYPbTR/4082gObU1s4slE=;
 b=G3ZOpFrzTjlyUyQ789ILWvoyoQ4IE+7qjkEoEmjEHeNQ6qqZ+AShoo4eZ4BDZyhzle
 9yj7gbhdqsLRHzwCN0dg+YRFn0gnCjwt9UwV2p64fQPwvwsv3JF0wFH8zVM/fDZ4dysR
 sSJtYcxVU09SAAqdFk7M9cGd4UNwKmbdS/oJv13jIyKAR3Gxhsz60kXSp+UJWDGVefmu
 4WnEhhHXw+t2+oTnLoOCZGqREOJtL+2rMDcMJ7VFnN9PBq1ntBj/H5KlS+uzqBKVLxis
 u6rkyzO0RU+WcP0+CqWy5ceGmzxULlLAakc2Y52i029b8XGW4GbRbt56U70BkE85dp20
 6iZg==
X-Gm-Message-State: AJcUukeTmvE4H7ID28TlDHrrPyIBaHF0pBRNZtcwG30FbISCk8qQno9O
 ivD8uoF3gT0ooDWVN1KbV3Y=
X-Google-Smtp-Source: ALg8bN6wKA2nlz5ve8BB6vTXAxwchE9xOXTpsWrpY7PaG2MMsVCgYiowLAPbsaj+v3xfOdfkq6g2wg==
X-Received: by 2002:a50:90c6:: with SMTP id d6mr31209880eda.15.1548862029089; 
 Wed, 30 Jan 2019 07:27:09 -0800 (PST)
Received: from archlinux-ryzen ([2a01:4f9:2a:1fae::2])
 by smtp.gmail.com with ESMTPSA id p16-v6sm352314eju.73.2019.01.30.07.27.08
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Wed, 30 Jan 2019 07:27:08 -0800 (PST)
Date: Wed, 30 Jan 2019 08:27:06 -0700
From: Nathan Chancellor <natechancellor@gmail.com>
To: Miquel Raynal <miquel.raynal@bootlin.com>
Subject: Re: [PATCH] mtd: rawnand: meson: Fix linking error on 32-bit platforms
Message-ID: <20190130152706.GA31999@archlinux-ryzen>
References: <20190129214657.5877-1-natechancellor@gmail.com>
 <42d2e92e-9f5a-62b2-c0af-b7f3544d79d2@amlogic.com>
 <20190130103220.27b13ab9@xps13>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190130103220.27b13ab9@xps13>
User-Agent: Mutt/1.11.2 (2019-01-07)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190130_072711_437997_9CFA4EE4 
X-CRM114-Status: GOOD (  18.86  )
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
Cc: Boris Brezillon <bbrezillon@kernel.org>,
 Richard Weinberger <richard@nod.at>, linux-kernel@vger.kernel.org,
 Liang Yang <liang.yang@amlogic.com>, linux-mtd@lists.infradead.org,
 Kevin Hilman <khilman@baylibre.com>, linux-amlogic@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Wed, Jan 30, 2019 at 10:32:20AM +0100, Miquel Raynal wrote:
> Hi Liang, Nathan,
> =

> Liang Yang <liang.yang@amlogic.com> wrote on Wed, 30 Jan 2019 17:26:39
> +0800:
> =

> > Hi Nathan,
> > =

> > On 2019/1/30 5:46, Nathan Chancellor wrote:
> > > On arm little endian allyesconfig:
> > > =

> > >    ld.lld: error: undefined symbol: __aeabi_uldivmod  =

> > >    >>> referenced by meson_nand.c
> > >    >>> mtd/nand/raw/meson_nand.o:(meson_nfc_setup_data_interface) in =
archive drivers/built-in.a  =

> > > =

> > > The dividend tBERS_max is u64, meaning we need to use DIV_ROUND_UP_ULL
> > > (which wraps do_div) to prevent the compiler from emitting
> > > __aebi_uldivmod.
> > > =

> > > Fixes: 2d570b34b41a ("mtd: rawnand: meson: add support for Amlogic NA=
ND flash controller")
> > > Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
> > > ---
> > >   drivers/mtd/nand/raw/meson_nand.c | 4 ++--
> > >   1 file changed, 2 insertions(+), 2 deletions(-)
> > > =

> > > diff --git a/drivers/mtd/nand/raw/meson_nand.c b/drivers/mtd/nand/raw=
/meson_nand.c
> > > index e858d58d97b0..6f12a96195d1 100644
> > > --- a/drivers/mtd/nand/raw/meson_nand.c
> > > +++ b/drivers/mtd/nand/raw/meson_nand.c
> > > @@ -1116,8 +1116,8 @@ int meson_nfc_setup_data_interface(struct nand_=
chip *nand, int csline,
> > >   				       div * NFC_CLK_CYCLE);
> > >   	meson_chip->tadl =3D DIV_ROUND_UP(PSEC_TO_NSEC(timings->tADL_min),
> > >   					div * NFC_CLK_CYCLE);
> > > -	tbers_clocks =3D DIV_ROUND_UP(PSEC_TO_NSEC(timings->tBERS_max),
> > > -				    div * NFC_CLK_CYCLE);
> > > +	tbers_clocks =3D DIV_ROUND_UP_ULL(PSEC_TO_NSEC(timings->tBERS_max),
> > > +					div * NFC_CLK_CYCLE);  =

> > =

> > Looks good to me:
> > =

> > Acked-by: Liang Yang <liang.yang@amlogic.com>
> =

> This is nand/next material, so if you don't mind I would like to squash
> this fix into the original commit inserting the driver.
> =

> =

> Thanks,
> Miqu=E8l

Hi Miquel,

That is totally fine by me, thanks for the quick response!

Nathan

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
