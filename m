Return-Path: <SRS0=Fp1N=PV=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 712F2C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun, 13 Jan 2019 22:40:22 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2EAF720663
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun, 13 Jan 2019 22:40:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="F5W3QnAE";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="drh0H9KS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2EAF720663
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Tgj1NBF229FvcccZM8qirEz3wdwBl23MpKkmKXfqBCg=; b=F5W3QnAEJzWVLr
	FDi6wwh3r92U21rO4uE9iBLlSJl+LUWpQsi28f1BK4TbOZMvM16ib/INYfXXSrW/3gZe7RYYuQHvQ
	NuHZtry3JVmWrujm/L0hnlOE+i0S0lEFGViLqiHxaEn6zA2rXvPQ4y4xovCpkobb/HfxlkjeBuc74
	0vDn7/KTaW4eEP9ziVy4Bg6/9cIFISOJpYZTm72vgDTIIjYmasBYYc9tDmiWR7w7MdTx1duAZWySl
	LfN+xyQPp3y5b7sptbxQVSYJmFrg0kgQaUGH+QftKcfQZ67vlkwmqXWqmZfyDkFSHZU0rO7oiIWxp
	94ozEHTW9xHGPh9dUDkA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gioQO-0003MX-HX; Sun, 13 Jan 2019 22:40:12 +0000
Received: from mail-lj1-x244.google.com ([2a00:1450:4864:20::244])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gioQ8-0002VH-Ve
 for linux-arm-kernel@lists.infradead.org; Sun, 13 Jan 2019 22:39:58 +0000
Received: by mail-lj1-x244.google.com with SMTP id k15-v6so17333060ljc.8
 for <linux-arm-kernel@lists.infradead.org>;
 Sun, 13 Jan 2019 14:39:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=/qhjvsyUOd09thML3lB7tYlirWoM3BLFSrDlE/Ol618=;
 b=drh0H9KSP97BJz6Pj/4nIaLVxMRZRAFh32nuRooT87ExWjmoMOZsxOwZA0W8Y7dR+P
 pAK2yg7g/uB1PmFhF8qcY3f36opZuh+EnoZCldT9ut8v6d3lRo7Y4BiLpRQN+OA6ZBJO
 W3+/NgAmEXPNZU2KnL0cJhe1t+EG0Vno89k4U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=/qhjvsyUOd09thML3lB7tYlirWoM3BLFSrDlE/Ol618=;
 b=M5Nnqk9cT6U/UfzxNd+uR9gsC9q/ei3YqY8VgF9cYor06NJ8onMCtF5sl8mSflAUmL
 yARfbsqtoRPKS90xdC4uGgIQGLP8FlWUhB44qfaMasb7z9eEqpC0vDlfJvUOesJHXJwY
 zPngsQ0yO+HpbjvvXL6h0gILWk51suFErWgdsgfeu9teEW23HwcvnLzyzY5YzdXW+3gC
 wK1H3gzMQ54RvDRyJZ8eVVN6ZiBR0XFxcWbtk/KOtDLGLz75oh6rZy/1Xj/+tjx7Kdd4
 BGgjnr1oLY2YqHd7Ne5fFTsT7bXLmj0N4aLZvGceqT8B0fJ52K3trKnyeKBUJ0rWlgud
 WeTw==
X-Gm-Message-State: AJcUukfwhh9inlXrNW1oog8rfIEplpSd5Du9YcnrS+Tkeg2Ee+3PqCNm
 pspZTL3rQfsfyar6Bqu7fI/JWO4AtwoeQGT1aEboUA==
X-Google-Smtp-Source: ALg8bN7PsDSBuhq21l/m1VSi9/mSkonT9bAwfBW0dLM6nEpwfw5JXNJZmvu/WgcG60gzEH0HxAF+aI1IouuD3+9913I=
X-Received: by 2002:a2e:9107:: with SMTP id
 m7-v6mr12873702ljg.23.1547419194965; 
 Sun, 13 Jan 2019 14:39:54 -0800 (PST)
MIME-Version: 1.0
References: <CACRpkdb-zphMyZbGh5XYy2A6B1224BGFmTwr0Bm98G3oM0MeoQ@mail.gmail.com>
 <CAK8P3a08TV+sQhsCPjkXh6wOKEpLfGLqVo9+FHoXzDVXs_bY7A@mail.gmail.com>
 <CACRpkdZ7KSmgTYP8a_RUJAWKzuc652OZ420Lq4ZnzkCuESLZ2Q@mail.gmail.com>
 <20190113155047.GA12829@lenoch>
In-Reply-To: <20190113155047.GA12829@lenoch>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Sun, 13 Jan 2019 23:39:42 +0100
Message-ID: <CACRpkdbHTi9=x7-_uEYWggfxt4jNUm3JhXy=AqarW3B11d=XKg@mail.gmail.com>
Subject: Re: Hilscher NetX mach-netx refactorings
To: Ladislav Michl <ladis@linux-mips.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190113_143957_034445_FC6F6C4E 
X-CRM114-Status: GOOD (  16.66  )
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
Cc: linux-serial@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
 Robert Schwebel <r.schwebel@pengutronix.de>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Olof Johansson <olof@lixom.net>, github@hilscher.com,
 Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Sun, Jan 13, 2019 at 4:50 PM Ladislav Michl <ladis@linux-mips.org> wrote:
> On Sun, Jan 13, 2019 at 01:14:36PM +0100, Linus Walleij wrote:

> > > On a related note, there does appear to be active work on
> > > newer netx machines that were never upstreamed, see
> > > https://github.com/Hilscher/netx4000-linux/commits/v4.9-netx4000-stable
> >
> > That RS485 addition to PL011 using GPIOs is a bit hacky but
> > looks like very useful for industrial applications.
> > Ladislav, have you been in contact with Hilscher?
>
> I guess I appeared on Cc list because of commit 797537a45450 ("amba-pl011:
> Add RS485 support (ioctl and devicetree)") from above github repo which
> is based on my hack originaly done for rPi3 as I got tired of all those
> experts implementing 'drive enable' in userspace. That's broken by design
> and works only by accident.

I suppose it is one of those GPIO hacks in userspace. Yeah that makes
the GPIO maintainer very unhappy I can tell you that :/

> But as I'm also considering every single
> device running from SD card broken by design - it was perfect match ;-)

Ha ha ;)

> But seriously, it is indeed needed for industrial applications and
> should be done a bit better - I mean regarding those delays in interrupt
> context.

I suppose this thing is a bit of an oddity since the PL011
does have an RTS signal, but in this case (for reasons such
as hardware doesn't do the right thing, or the hardware engineer
didn't care do make it possible to get the RTS line out of the
chip, or the board engineer didn't think of it) a GPIO is used
for RTS instead. So what the patch does is add that as an
option.

There are DT bindings for RTS (etc):
Documentation/devicetree/bindings/serial/serial.txt

I think that GPIO support code could be implemented using
the library in:
drivers/tty/serial/serial_mctrl_gpio.c

This makes it possible to handle any extra "modem control"
pins using GPIO. I think it is fine to just look for RTS if that is all
that's needed. Possibly those extra delay settings could be
added in mctrl and added as generic DT bindings as well.
(I'm not smart enough to tell if that is possible.)

Sorry for the sidetrack.

Yours,
Linus Walleij

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
