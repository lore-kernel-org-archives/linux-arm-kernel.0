Return-Path: <SRS0=T5WJ=OO=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A877C04EB9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 06:39:21 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1BB8B2082B
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 06:39:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="ZQlvJyRm";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FjyVHdET"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1BB8B2082B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=UCQtd5uvL1A7ZwlHET44ZlnivHTB5oFtjH0DzVbwcn4=; b=ZQlvJyRm30vflz
	NqRJMfiX6jm/YaqqwQt1c7QNMxZ+IZbUdO+4muj85rOb11/62DaOfxrwqtu4qddBpTGok0AhSEKCq
	/Q+O/f7YgMtxWr7WCL7Gf36YNCphe7SzEA9e9gsoEVa3fEP2ZzDQoba8c0xyLDQXQX+ex/+nnAd1N
	jB526JAl2+nDHA4vbDrFiqZKmeA7R7r5O8grr3/ZQkV7xSnGIfjQtgFyKPV/dsvjxirt0wL0xEJCh
	fXmW10RqYxHumk9d8vRETNroX6NkXThXJBR3WNUvfjigw7/DMcqCGChwNZ3XAxxzDpHlzn2nLS66X
	geUR0PtNzRcHEFKY8UIA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gUQq4-0000RD-CN; Wed, 05 Dec 2018 06:39:16 +0000
Received: from mail-it1-x142.google.com ([2607:f8b0:4864:20::142])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gUQq0-0000Cd-Cw
 for linux-arm-kernel@lists.infradead.org; Wed, 05 Dec 2018 06:39:14 +0000
Received: by mail-it1-x142.google.com with SMTP id z7so19631418iti.0
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 04 Dec 2018 22:39:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=bWNOXW9ydDvrlIB9EdoJvokK+6eem4mZ9KOjD+Pslh4=;
 b=FjyVHdET9DQVV7R+EoBb2CrME2QYEzFiC06DAzcicXCGdJK3XTc07Bx1TNQJF0A764
 /Am3fe13i41r/fsE6jFdJkRadVlY08IHRpab2/IKGG3gBuGS/OKYE4nUKJ2zlhQTHUOv
 U4YxwEKRpYT9weqGauYSo91oAgPh+HRWhVl+92bELTY9ltEMHDA8tbu/5Husoi1c9lj/
 Yn9OvpcFpEwSPJEnx4wYLZ8vvrTlsCZbW8FBlxbW0HD1EgA3TgO9DAXZF1k6t3HTcgtv
 OXfxwFbH23wYUJea1v7fAyZaRZDs9sE7gRIwoHzdLBJ4ppaGp8yOyyUY/WTProqEVz/O
 KQpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=bWNOXW9ydDvrlIB9EdoJvokK+6eem4mZ9KOjD+Pslh4=;
 b=tpjLwiwmkCJIeNlq5YFtJT2sqs87jcTtkjUr4IuXEJRfsGvJu2t9ORQpNJhCBZb6KF
 nXxeBFnayC/pCrUS8a1eeOcRaEJNxIvCKR1RETCZqQtjZNpL2fhrRtiApzBLwn+BrCUN
 M9epV8oqq3w7huQxPjygoGyFhoyF1FC2+c43ohIYHQaxIN9lpcZ7PrSZP9etxGWbK1E6
 KmvWWFoEp0qvLujMCC6TYQ6JV8USjXIeimDQJ6rcWYbmoX9UOQ5FgcW2yA94MU21WNZx
 K8dCXGUEYkhi05ZRkb6FReDi29Og9qViJQj3mCqev+/DyjxPdCXXgWOsVNlceoRiuvhU
 Zruw==
X-Gm-Message-State: AA+aEWajzcdeUnOlsG+Nq8yXHlLZpvutvyUWVwu/rkkooMC7GFlswJ4X
 +q7ovebXuY/QjJ/XZO9QUekKZ1TYHVDCZXZLNSg=
X-Google-Smtp-Source: AFSGD/Uc3iE0+PF8C/s2cZ5jToSXM4xtF9WP/aJbVQ8TaAB3V9Dzmvx4nOari+MFuWULOYZ37sWi1bzU3ohknSRfU14=
X-Received: by 2002:a24:5a8f:: with SMTP id v137mr13992067ita.65.1543991941061; 
 Tue, 04 Dec 2018 22:39:01 -0800 (PST)
MIME-Version: 1.0
References: <20181108144454.GA3797@hp-pavilion-15-notebook-pc-brajeswar>
 <CAFqtX7kba2UBiNoMhG79joLL2N1_Hup7y+xrKrYsesXwj6-grA@mail.gmail.com>
In-Reply-To: <CAFqtX7kba2UBiNoMhG79joLL2N1_Hup7y+xrKrYsesXwj6-grA@mail.gmail.com>
From: Brajeswar Ghosh <brajeswar.linux@gmail.com>
Date: Wed, 5 Dec 2018 12:08:47 +0530
Message-ID: <CAFqtX7=7E9JSevhQVXQ+=Oor_k2Yk_eiZRmC2zStXUD8ncVQ+g@mail.gmail.com>
Subject: Re: [PATCH] arm/mach-sa1100/hackkit.c: Remove duplicate header
To: linux@armlinux.org.uk
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181204_223912_483321_A9194D3A 
X-CRM114-Status: GOOD (  14.14  )
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
Cc: Sabyasachi Gupta <sabyasachi.linux@gmail.com>,
 Souptick Joarder <jrdr.linux@gmail.com>, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Fri, Nov 16, 2018 at 8:45 PM Brajeswar Ghosh
<brajeswar.linux@gmail.com> wrote:
>
> On Thu, Nov 8, 2018 at 8:14 PM Brajeswar Ghosh
> <brajeswar.linux@gmail.com> wrote:
> >
> > Remove linux/tty.h which is included more than once
> >
> > Signed-off-by: Brajeswar Ghosh <brajeswar.linux@gmail.com>
>
> Any comment on this patch?

Any comment on this patch?

>
> > ---
> >  arch/arm/mach-sa1100/hackkit.c | 1 -
> >  1 file changed, 1 deletion(-)
> >
> > diff --git a/arch/arm/mach-sa1100/hackkit.c b/arch/arm/mach-sa1100/hackkit.c
> > index 643d5f2d9af9..0016d25e7deb 100644
> > --- a/arch/arm/mach-sa1100/hackkit.c
> > +++ b/arch/arm/mach-sa1100/hackkit.c
> > @@ -22,7 +22,6 @@
> >  #include <linux/serial_core.h>
> >  #include <linux/mtd/mtd.h>
> >  #include <linux/mtd/partitions.h>
> > -#include <linux/tty.h>
> >  #include <linux/gpio.h>
> >  #include <linux/leds.h>
> >  #include <linux/platform_device.h>
> > --
> > 2.17.1
> >

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
