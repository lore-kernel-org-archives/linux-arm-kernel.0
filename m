Return-Path: <SRS0=BOBm=QX=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C713BC4360F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat, 16 Feb 2019 20:28:34 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9308E218C3
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat, 16 Feb 2019 20:28:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="dUcmyAQI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9308E218C3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sntech.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=4DaeVuG55yWpLpUjbLZHJ7vfsG+Ova802uNIHwUTfKY=; b=dUcmyAQIJT3RHi
	VEo6oyw3lX5zmQtj1wvrry0v7Hpi8JaLSSocUR3pN29XhqkU5VyRZF7xSQqHBmLBCOAxUcWX1Bg9B
	z+DrsGz9zJL97ukUgBgxcJFbjJPCGaU3OHLAVfRHdUKlOM9zk0/ce5V6Utv5/V9xmZgX7gwAmG7X/
	BCaNPkWjh863WufVRqC3phlaw3mJRF+K2cFpdJntUyKBj0o1PN7yuhxgQoSizf/mEbtEn0LLSyc6G
	mgxrD7d4AVJ5+rH+t40jHZxpsTuD+JH2htmcwM68Tv0gJgDJuIq+WUN+X7l5p8ScFqYRARDvQ4w4V
	uf4b+2LRWWD4U9TwGe1A==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gv6Zc-0001jM-G4; Sat, 16 Feb 2019 20:28:32 +0000
Received: from gloria.sntech.de ([185.11.138.130])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gv6ZX-0001ek-Fh; Sat, 16 Feb 2019 20:28:29 +0000
Received: from p57b77d08.dip0.t-ipconnect.de ([87.183.125.8]
 helo=phil.localnet)
 by gloria.sntech.de with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.89) (envelope-from <heiko@sntech.de>)
 id 1gv6ZP-0007d1-K7; Sat, 16 Feb 2019 21:28:19 +0100
From: Heiko Stuebner <heiko@sntech.de>
To: Alexandru M Stan <amstan@chromium.org>
Subject: Re: [PATCH] ARM: dts: rockchip: add chosen node on veyron chromebooks
Date: Sat, 16 Feb 2019 21:28:13 +0100
Message-ID: <2105716.Hge0YL7z4n@phil>
In-Reply-To: <CAHNYxRzyVjLbT00ryBBkqK67JKFs7bvFR=G=rdvVa_o-q8zN9Q@mail.gmail.com>
References: <20190215115150.32299-1-enric.balletbo@collabora.com>
 <22158501.cNvkU8jGDh@diego>
 <CAHNYxRzyVjLbT00ryBBkqK67JKFs7bvFR=G=rdvVa_o-q8zN9Q@mail.gmail.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190216_122827_675253_CF8EC984 
X-CRM114-Status: GOOD (  15.97  )
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
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org,
 Doug Anderson <dianders@chromium.org>,
 linux-kernel <linux-kernel@vger.kernel.org>,
 "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
 Rob Herring <robh+dt@kernel.org>,
 Enric Balletbo i Serra <enric.balletbo@collabora.com>, kernel@collabora.com,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Am Samstag, 16. Februar 2019, 02:13:25 CET schrieb Alexandru M Stan:
> On Fri, Feb 15, 2019 at 3:09 PM Heiko St=FCbner <heiko@sntech.de> wrote:
> >
> > Hi Enric,
> >
> > Am Freitag, 15. Februar 2019, 12:51:50 CET schrieb Enric Balletbo i Ser=
ra:
> > > In order to use earlycon, the stdout-path property needs to be set
> > > in the chosen node.
> > >
> > > Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
> >
> > What's the reason for adding this only for the Chromebook variants?
> > Uart2 is pretty much the standard output for all devices, so I'd assume
> > at least all veyron boards should use uart2 as well, making this ideally
> > live in the rk3288-veyron.dtsi instead?
> =

> Yep, all veyriants use uart 2, even when they're not chromebooks.
> Feel free to put it in the other file instead.
> =

> Otherwise it'll make things like the Asus Chromebit (mickey), AOpen
> Chromebox mini (fievel), and AOpen Chromebase (tiger) unhappy
> while debugging.
> =

> The rk3288-veyron-chromebook.dtsi file is more for things that make
> a chromebook portable. Ex: built in display, lid switch, cros-ec.
> =

> Note how we have no uart2 references either in our tree in the
> chromebook specific dtsi:
> https://chromium.googlesource.com/chromiumos/third_party/kernel/+/chromeo=
s-3.14/arch/arm/boot/dts/rk3288-veyron-chromebook.dtsi

thanks for the confirmation :-) .

I've moved the choosen node over to veyron.dtsi and applied the result
for 5.1

Thanks
Heiko



_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
