Return-Path: <SRS0=T5WJ=OO=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93568C04EBF
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 04:27:16 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 449E520661
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 04:27:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="jsysefLV";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="yNpKG9rk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 449E520661
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=LpyEJrEGsYU8UufrVT+F2WuPG34qia3OvGFKr49tEJI=; b=jsysefLVReyFwp
	YMbh4aNnrgSjzYawgDSK6euY3VJMRcwQ1EE5MTbDWNsxxDcsgSvJGIUeP/2EjiijdwMDiveUnyvqL
	2TgOLBusIn5BTrI0y5ueJRqyWx97p8YzicTBiStXBBv2wqpJKpWIMzu7/yxF2EW8NW4E6wQtgf4e2
	BvuBE9/WnEPaVmpLqQ7pLiW7aFTQZeiXahuK6Vw8/Z21gXwgWVeayoUJk+ap/zWFPkU2dW9l3dixZ
	Y59ZP5mYUoi4pCQHD7w/aAp8T4xiCffoT7HkIFlh6Efwq5U4Ka8XVjEWipqtP0j5OsD7gOhUJojcH
	OXUKxLB4xTLcmYbWXLOQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gUOmF-00055l-Gt; Wed, 05 Dec 2018 04:27:11 +0000
Received: from conssluserg-03.nifty.com ([210.131.2.82])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gUOmC-00054V-4Y
 for linux-arm-kernel@lists.infradead.org; Wed, 05 Dec 2018 04:27:09 +0000
Received: from mail-ua1-f50.google.com (mail-ua1-f50.google.com
 [209.85.222.50]) (authenticated)
 by conssluserg-03.nifty.com with ESMTP id wB54QhXd001421
 for <linux-arm-kernel@lists.infradead.org>; Wed, 5 Dec 2018 13:26:43 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-03.nifty.com wB54QhXd001421
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
 s=dec2015msa; t=1543984003;
 bh=bjrC8SIQ9Wql171658JORppkFGAKHljcN7ccyt7AwBQ=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
 b=yNpKG9rkDK+5nU+bKxFK27WrVJT7ptK4JU4+b4uGSO965+XAkk5h9UZ+0mIp3urO9
 TK/Gq3AEpiSJeHzRCx0c/pMS/xqtiURxC7ETcCmaE+tLwnWH1EYXDpPywHTpwRuDCb
 uwtTL4qJBh51lYSw5NeX+8Kef/plp7Su0gbAItx08TxWDfQJt/oE3bCrq5fru6av0O
 F2mnIcI+8sszlxLnqdPCKep7N1+B3BXH4GB30UWgJJosmaryXxJ1UWV55ZEX2cUUUE
 tt0RW+5sugtPOU+g6N9LBlwW1EOipfF/BTK8Oni8xIVgmOBWZ4+2uCqYptpJLEeXSo
 a/8y2AfHs6aZg==
X-Nifty-SrcIP: [209.85.222.50]
Received: by mail-ua1-f50.google.com with SMTP id d21so6628870uap.9
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 04 Dec 2018 20:26:43 -0800 (PST)
X-Gm-Message-State: AA+aEWZgvIDTbUDappiVlzuMrDQsEhCFslWpYvFyZ4RswLIJl2mxBJs8
 OgoWgnYSeUL9KM6EF7APQ2XLmMFDLzd44nAobfw=
X-Google-Smtp-Source: AFSGD/U7L09EmqlP4nFCW429bLOC9WG8gDY+Gjv2srOpTTlT6dhYmbTXIX5XRkmQBMbYKbIljHGEmnh9dAnee7Dgp/s=
X-Received: by 2002:a9f:3193:: with SMTP id v19mr10487783uad.55.1543984002635; 
 Tue, 04 Dec 2018 20:26:42 -0800 (PST)
MIME-Version: 1.0
References: <1542589274-13878-1-git-send-email-sugaya.taichi@socionext.com>
 <1542589274-13878-8-git-send-email-sugaya.taichi@socionext.com>
 <154356669840.88331.4455990896653868594@swboyd.mtv.corp.google.com>
 <CAK7LNAQEeLo=PW=DygyVxVHyn5jgRP18nb0cK+u1wGNd4BUh7Q@mail.gmail.com>
 <154394724886.88331.4940706362054124931@swboyd.mtv.corp.google.com>
In-Reply-To: <154394724886.88331.4940706362054124931@swboyd.mtv.corp.google.com>
From: Masahiro Yamada <yamada.masahiro@socionext.com>
Date: Wed, 5 Dec 2018 13:26:06 +0900
X-Gmail-Original-Message-ID: <CAK7LNARwq7Qc527L8P8_=taApi-UE3knHceKBUosi5Yx97+row@mail.gmail.com>
Message-ID: <CAK7LNARwq7Qc527L8P8_=taApi-UE3knHceKBUosi5Yx97+row@mail.gmail.com>
Subject: Re: [PATCH 07/14] clock: milbeaut: Add Milbeaut M10V clock control
To: Stephen Boyd <sboyd@kernel.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181204_202708_420553_7C54ED5A 
X-CRM114-Status: GOOD (  21.23  )
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
Cc: Mark Rutland <mark.rutland@arm.com>, DTML <devicetree@vger.kernel.org>,
 Masami Hiramatsu <masami.hiramatsu@linaro.org>, sugaya.taichi@socionext.com,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Michael Turquette <mturquette@baylibre.com>,
 Daniel Lezcano <daniel.lezcano@linaro.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Russell King <linux@armlinux.org.uk>, Jassi Brar <jaswinder.singh@linaro.org>,
 Rob Herring <robh+dt@kernel.org>, linux-serial@vger.kernel.org,
 Jiri Slaby <jslaby@suse.com>, Thomas Gleixner <tglx@linutronix.de>,
 linux-clk <linux-clk@vger.kernel.org>,
 linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Wed, Dec 5, 2018 at 3:14 AM Stephen Boyd <sboyd@kernel.org> wrote:
>
> Quoting Masahiro Yamada (2018-12-04 03:03:53)
> > Hi Stephen,
> >
> >
> > On Fri, Nov 30, 2018 at 5:31 PM Stephen Boyd <sboyd@kernel.org> wrote:
> > >
> > > Quoting Sugaya Taichi (2018-11-18 17:01:12)
> > > > Add Milbeaut M10V clock ( including PLL ) control.
> > >
> > > Please give some more details here.
> > >
> > > >
> > > > Signed-off-by: Sugaya Taichi <sugaya.taichi@socionext.com>
> > > > ---
> > > >  drivers/clk/Makefile   |   1 +
> > > >  drivers/clk/clk-m10v.c | 671 +++++++++++++++++++++++++++++++++++++++++++++++++
> > >
> > > And this is different from Uniphier? Maybe we need a socionext
> > > directory under drivers/clk/.
> >
> >
> >
> > This is always a difficult question,
> > and I do not have a strong opinion.
> >
> >
> > I am fine with moving the files to drivers/clk/socionext
> > although no file would be shared.
> >
> >
> > FYI
> >
> > UniPhier and Milbeaut are completely different platforms
> > developed/maintained by different teams.
> >
> > They happen to live in the same company now
> > just because Socionext merged the LSI business from Panasonic and Fujitsu.
> >
> > UniPhier originates in Panasonic, while Milbeaut in Fujitsu.
> >
>
> Thanks for the background info. I'd prefer to defer to however the dts
> files are getting split up into directories. If they're all put under
> arch/arm64/boot/dts/socionext/ then I would say combine the two clk
> drivers into a socionext directory. Otherwise, keep them split out.


If you want to align with the DT directory structure,
the answer is clear.


Milbeaut DT files will be put together with UniPhier ones
into socionext directory.


For arm64, DT directories are already sorted out by vendors.

Even 32-bit ARM is going to that way.

Rob Herring just posted a python script
to move all DT files in arch/arm/boot/dts/
into vendor subdirectories.


Please let me know if you want me to
move drivers/clk/uniphier/* to drivers/clk/socionext/*.



-- 
Best Regards
Masahiro Yamada

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
