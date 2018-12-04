Return-Path: <SRS0=gVCq=ON=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7254EC04EBF
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 18:14:25 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 467F62081C
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 18:14:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="t1/W1e5K";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="ApGrVQj1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 467F62081C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Date:Subject:Message-ID:References:
	In-Reply-To:From:To:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=/6CWio1qmWKB0NFX4cSxVzd0TPipPgu0AxeRolNIXJM=; b=t1/W1e5KQWCtPr
	M78xIqPaV/wR2+yIrRl4fmYbVQ2L5NW1Qdqm/4OjEESsRXHJwqTE5tb52iV05EiuA1SU0oXCH3f2g
	W3/6MbCbwrh/7jqdPsghN6yscT5qUyILKiNbJ+3j6tvX1jtwUiDJkFBnI8zHQhd8ZyjjYUbAjSjF2
	1f3Q158NNgv5m4Ub76Fu1cUuEZ3dBaYG0BjTrb0DUeTT7pN03BEgWBBs3TNbQWyKN2NcA3FKkJ/wB
	hSXQAdpatPl79TJ1LofVcptRq0Zwaa5fGcNpZVLvA6mt8mIUsNLmKmy0o4Q/wLTsdYksmt5JSahpJ
	O9Fv+pKyvL2BecDYbBLg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gUFDD-0005hF-8E; Tue, 04 Dec 2018 18:14:23 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gUFD9-0005gS-W3
 for linux-arm-kernel@lists.infradead.org; Tue, 04 Dec 2018 18:14:21 +0000
Received: from localhost (unknown [104.132.0.74])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 9121C2081C;
 Tue,  4 Dec 2018 18:14:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1543947249;
 bh=6bTTxQJOrUPlJgQrN8eLS03HzfWoHwHNP21kd4F5NXs=;
 h=To:From:In-Reply-To:Cc:References:Subject:Date:From;
 b=ApGrVQj19o5go1VatVaZHvHZ8c6OP2QZOvvGRFrQn4nWKn2+ZBCZ6DwHN4szytjco
 3IH08Y7CXpiWJbWmRgFu9RziSNn+674YJETm0flCilQnDUyTNVvGpEe73pg/iHLAcA
 pmalRRzLg+IBiD+OWxDVXbQA6cF9wqsWopobKUQE=
MIME-Version: 1.0
To: Masahiro Yamada <yamada.masahiro@socionext.com>
From: Stephen Boyd <sboyd@kernel.org>
In-Reply-To: <CAK7LNAQEeLo=PW=DygyVxVHyn5jgRP18nb0cK+u1wGNd4BUh7Q@mail.gmail.com>
References: <1542589274-13878-1-git-send-email-sugaya.taichi@socionext.com>
 <1542589274-13878-8-git-send-email-sugaya.taichi@socionext.com>
 <154356669840.88331.4455990896653868594@swboyd.mtv.corp.google.com>
 <CAK7LNAQEeLo=PW=DygyVxVHyn5jgRP18nb0cK+u1wGNd4BUh7Q@mail.gmail.com>
Message-ID: <154394724886.88331.4940706362054124931@swboyd.mtv.corp.google.com>
User-Agent: alot/0.7
Subject: Re: [PATCH 07/14] clock: milbeaut: Add Milbeaut M10V clock control
Date: Tue, 04 Dec 2018 10:14:08 -0800
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181204_101420_048606_DB664290 
X-CRM114-Status: GOOD (  16.50  )
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

Quoting Masahiro Yamada (2018-12-04 03:03:53)
> Hi Stephen,
> 
> 
> On Fri, Nov 30, 2018 at 5:31 PM Stephen Boyd <sboyd@kernel.org> wrote:
> >
> > Quoting Sugaya Taichi (2018-11-18 17:01:12)
> > > Add Milbeaut M10V clock ( including PLL ) control.
> >
> > Please give some more details here.
> >
> > >
> > > Signed-off-by: Sugaya Taichi <sugaya.taichi@socionext.com>
> > > ---
> > >  drivers/clk/Makefile   |   1 +
> > >  drivers/clk/clk-m10v.c | 671 +++++++++++++++++++++++++++++++++++++++++++++++++
> >
> > And this is different from Uniphier? Maybe we need a socionext
> > directory under drivers/clk/.
> 
> 
> 
> This is always a difficult question,
> and I do not have a strong opinion.
> 
> 
> I am fine with moving the files to drivers/clk/socionext
> although no file would be shared.
> 
> 
> FYI
> 
> UniPhier and Milbeaut are completely different platforms
> developed/maintained by different teams.
> 
> They happen to live in the same company now
> just because Socionext merged the LSI business from Panasonic and Fujitsu.
> 
> UniPhier originates in Panasonic, while Milbeaut in Fujitsu.
> 

Thanks for the background info. I'd prefer to defer to however the dts
files are getting split up into directories. If they're all put under
arch/arm64/boot/dts/socionext/ then I would say combine the two clk
drivers into a socionext directory. Otherwise, keep them split out.


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
