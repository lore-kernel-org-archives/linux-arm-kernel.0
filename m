Return-Path: <SRS0=DN+v=OP=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_RHS_DOB autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54B34C04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 16:03:11 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 23D8B223D1
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 16:03:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="nalYzGm0";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="tccFZHfV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 23D8B223D1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=csie.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=awWV1NK58sRtdfrDGrZS0KVuuLlEjIZaiMTtMZjQb3g=; b=nalYzGm0Gc+xeX
	PKDoi8JCNI2RA9g0TwcMRuRcu7LYhGeamz79U2bIsaMi5o6VKno4Nd3NRh8cVEN+20L7TDO+tILeM
	rKXOQQ4nBXxNTtuIPTiaGe8lmi09xjTGYYVi4N/A+lp9HZKHBqyaaXzTggIy/2mj10PiXCVu+x3Bz
	NondLZTVo4ecetoUOjv+0pnLwpvCi2Gva72D6io1lbJ4Ws+xgTZUjDbHM0YgjcgMdIRdNj3xKQVGv
	Id3OQMbYUu6ct+Tz9ruC6BiBAqNBGPOY+yqaqRRCTNV81G119jf6/2iuvuln4fsPsKDRml6Fk5xQE
	DCEyqyl7OwmecYcIutcw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gUw7E-0006Kw-SE; Thu, 06 Dec 2018 16:03:04 +0000
Received: from merlin.infradead.org ([2001:8b0:10b:1231::1])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gUw61-00065s-39
 for linux-arm-kernel@bombadil.infradead.org; Thu, 06 Dec 2018 16:01:49 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=merlin.20170209; h=Content-Type:Cc:To:Subject:Message-ID:
 Date:From:In-Reply-To:References:MIME-Version:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=ptWI6dkQo6TuLYnEhF1KmUkaUfAN5I0oZLDtoA+AED0=; b=tccFZHfVXMt3o0KwNeqvNBNAU
 zHnrvGYAEvJY2H+GNV73Ao5fbTXcFsxShEVnEEpCTihdjeNTbCmXecFxKrP5C0bLWukGxu62W9NA1
 PUNW8NBQyaDGa/V0Vc4UlnF3jpVZfXhusjZSuCtez46T7gwJiFiRk6T19KRymmavyuk9B5e+cUJf8
 mKXbzKDvZIuESbuLkGBhTCDRHxhlPZbxeRZyx9XLF/OGtLv3/46itqO+1e7ddpoesa/vUuVaJLCmB
 RHyrRfN8kMwEgzG+jW/H098jnjwzf3RVPYBT6vpdmjvxhNMNZI2ZBAF7+1I6JgyR+vA1tUYdycZ9V
 MCvjOCWQw==;
Received: from mail-ed1-f67.google.com ([209.85.208.67])
 by merlin.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gUw5w-0008WH-D3
 for linux-arm-kernel@lists.infradead.org; Thu, 06 Dec 2018 16:01:47 +0000
Received: by mail-ed1-f67.google.com with SMTP id z28so1180295edi.8
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 06 Dec 2018 08:01:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=ptWI6dkQo6TuLYnEhF1KmUkaUfAN5I0oZLDtoA+AED0=;
 b=bXaS4tN6KKVmqYPqJpAMXotEhulDp4J+5eU100im66XjknfV8nHzUV1KKMWg35u3Iv
 VaxX2vwjziqHOT4ePemWv1jP7jH7WuhiHQRdSkY/0Xqge1PE/POq9PnBop3uOgcnr5GS
 YVF0NuC6Oxc75MTXPbKiVJbP0d8OHBtUEhsTrnb6pT4oR3gXZK8xToPe7NqB4jykslll
 2lcshkWcM0VHro8TaSpvrpRnfCXcw/WjkR2Fy4Ryv0jN4n+1dGiluoHdPgVJwd1BB41Z
 Hk/MMR5qDLjwjXxutahBSRLVWjaaRhKMUmeHO5EmR4OkmxnrUyTPkjfiC5f+iuaC4gLI
 Gd6g==
X-Gm-Message-State: AA+aEWYJTCgy7InHKXmk3ft4rK3SkJmYvahrJKDp9cR/5ah34bYoJ25e
 XAaE92z3swSQYKDnuaohTOHgmcWRW3Q=
X-Google-Smtp-Source: AFSGD/Vh4ss8Zs6Xx15aFmbinLq9VSnUFAPD5H44E/xWt2WDs9YX6BQktLzYrJqfa5jcdtAJxXCPVg==
X-Received: by 2002:a50:ac81:: with SMTP id x1mr25751686edc.71.1544112090336; 
 Thu, 06 Dec 2018 08:01:30 -0800 (PST)
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com.
 [209.85.128.42])
 by smtp.gmail.com with ESMTPSA id d8-v6sm151295ejy.34.2018.12.06.08.01.29
 for <linux-arm-kernel@lists.infradead.org>
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 06 Dec 2018 08:01:29 -0800 (PST)
Received: by mail-wm1-f42.google.com with SMTP id z18so1499588wmc.4
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 06 Dec 2018 08:01:29 -0800 (PST)
X-Received: by 2002:a1c:f605:: with SMTP id w5mr3692453wmc.116.1544112088837; 
 Thu, 06 Dec 2018 08:01:28 -0800 (PST)
MIME-Version: 1.0
References: <cover.50931fbda5c95345087740e4c1ef5a57fdd53480.1544104801.git-series.maxime.ripard@bootlin.com>
 <CAGb2v672oGHpeKEb4HV8ecZro2v-NPC9cV_DKPdNv9dy2OTREQ@mail.gmail.com>
 <20181206154748.45iqfnlirm6blt4k@flea>
In-Reply-To: <20181206154748.45iqfnlirm6blt4k@flea>
From: Chen-Yu Tsai <wens@csie.org>
Date: Fri, 7 Dec 2018 00:01:18 +0800
X-Gmail-Original-Message-ID: <CAGb2v65wEMd0iCMBD83Sr5fpEkTte6S9-sJyoYLJmGzEOFYJNQ@mail.gmail.com>
Message-ID: <CAGb2v65wEMd0iCMBD83Sr5fpEkTte6S9-sJyoYLJmGzEOFYJNQ@mail.gmail.com>
Subject: Re: [PATCH 0/2] pinctrl: sunxi: Account for per-bank GPIO regulators
To: Maxime Ripard <maxime.ripard@bootlin.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181206_110144_453255_A18FFBA9 
X-CRM114-Status: GOOD (  23.56  )
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
Cc: linux-gpio@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>,
 =?UTF-8?Q?Myl=C3=A8ne_Josserand?= <mylene.josserand@bootlin.com>,
 linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Thu, Dec 6, 2018 at 11:47 PM Maxime Ripard <maxime.ripard@bootlin.com> wrote:
>
> Hi,
>
> On Thu, Dec 06, 2018 at 11:28:21PM +0800, Chen-Yu Tsai wrote:
> > On Thu, Dec 6, 2018 at 10:02 PM Maxime Ripard <maxime.ripard@bootlin.com> wrote:
> > > The main interogation I have currently is whether we should always try to
> > > get the regulator for the current branch, or if we should restrict it to
> > > the one available on the SoCs.
> >
> > Not sure what you mean here, but we should probably just list the actual
> > names.
>
> The A20 for example doesn't have a VCC-PB regulator, so do we want to
> try to grab it if we request a PB* pin, or should we just know that
> somehow and not do it?

AFAIK, pin banks that don't have a separate supply are powered collectively
by VCC-IO, as mentioned below in my previous reply.

> > For pre-A20 SoCs (A10/A10s/A13), they aren't even named VCC-Px. Instead
> > they are named after the primary function of the pin bank, such as
> > VCC-CARD, VCC-NAND, VCC-CSI0, VCC-CSI1.
>
> I'd really prefer to stick to vcc-pX, that's pretty obvious even for
> those older SoCs, and we can maintain some consistency that way.

IRRC Mark said that supply names should match design names, not what is
convenient. And then again there's the fallback for those that don't have
separate rails.

> > For pin banks that don't have per-bank power inputs, you should fall back
> > to VCC-IO, or VCC-RTC in the case of the PL pins.
> >
> > So here's the rub: On A33 and later SoCs that are paired with a PMIC, VCC-PL
> > or VCC-RTC is powered by the RTC regulator of the PMIC, which only gets
> > registered when the PMIC regulator driver is probed, which needs the RSB
> > controller, which needs the pin controller and the PL pins...
>
> I haven't seen any VCC-P* on the A33, do you have a reference?

The A33 has a VCC-PD. This is not listed in the datasheet, but is shown in
schematics. Other pins would be powered by VCC-IO, with the exception of PL,
which would be power by VCC-RTC. The last bit is just a guess. We should
probably ask Allwinner, or try to do some tests.

ChenYu

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
