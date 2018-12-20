Return-Path: <SRS0=AHqO=O5=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17A68C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 18:24:18 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C7F3D218D9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 18:24:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="i18wnu70"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C7F3D218D9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=E9uM+FtQNAFOiKqj2luaUF5TckcGv6nulMm4+LVgjj8=; b=i18wnu70zCAHm7
	51185PNYyylQglZTGPL8NCt0//LDVvSUWe/leR3stxQOyDWiK68xB5KX+0XmabXCTv/0EgpNjeSYm
	ttRCIt0ZR90WKXQxibRSZvQQbRaRkkj4C+HsZaWeWScF2Qmpg4Fm90c6MpqK7GFvNVqxXaDCleZB4
	P8MadH6rt1YMpehor4nWGnC+0WucrqQFy8vy+PyPQRavsQDlhcSCQ74ZkcDRTZraM38BljRT8qhGn
	M0gFW0Exoq+1BVj8Nmb3Qo4klmrZ95zDgEdPLxRRChVUiFlGWab7ahNECKDbpUEcAH2Ec//ar7Y3x
	KWDqGYkBTyF72l2KDK/g==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1ga2zT-0003Xk-Pm; Thu, 20 Dec 2018 18:24:11 +0000
Received: from mail-vs1-f67.google.com ([209.85.217.67])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1ga2zF-0002vC-FY; Thu, 20 Dec 2018 18:23:59 +0000
Received: by mail-vs1-f67.google.com with SMTP id b74so1669724vsd.9;
 Thu, 20 Dec 2018 10:23:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=wmA+/JadysSKf9DDH/kza2tm5qD01kJrIDeULMshbc0=;
 b=V+a0dsMBNKD2uHrezZn8M961U9LPoT22lnn7FhUWWBT86b92GHaEs3XMetz1DAjkhP
 MHA2FIh735sqtsC5QJnFvJKcZzd+P8sU17KysMTaHBdS7EzARSk3MUokJNR0swst3sKb
 xkzxWTlqyeITDENCev3XplxHxtHNWHv8XQYRPcQHx2VCno7UzRXQ+pmSADXOycoHCIRI
 YgxAXvG/sPn/liyliuf6D622cjuEaS2d6nvL64bPxPov37+Sz/v/XaVSoan5KNNKOUSb
 B8sJWWRdxzKR7rA6yo32HsWMAIfvlKYHJrh2vt9bbYWXWKnJ2L2q2haqz3dNi4jPXRHG
 zTkQ==
X-Gm-Message-State: AA+aEWbfnbQM5wEdVWSYhbRdwSGfMLAu9lDJQeJbeECvRrJCW100HG5D
 z4SHDLQ8C+kGNKOmcgvtV2tB8MAlFjOL2ZsBB/4=
X-Google-Smtp-Source: AFSGD/XXIWt/OlZ5MmsbiHjJYDlT+c6H/3D9yKlVBD+Zh6cHIh4ZbDctFNlokMGupQFWLqHwjTaIXB/0gtMTXn3spMY=
X-Received: by 2002:a67:3885:: with SMTP id n5mr11174020vsi.96.1545330225760; 
 Thu, 20 Dec 2018 10:23:45 -0800 (PST)
MIME-Version: 1.0
References: <20181216084854.GJ13243@dragon>
 <CAK8P3a34R+Gv+H8_jjGP452i2kSqq+u0PsE-4pDnRRtY14SG0w@mail.gmail.com>
 <a73f86ff-15ce-9512-bbf0-be852cf39a35@kontron.de>
 <CAK8P3a1PMoR-WWcb_G8sTVW9HKUKvKfUZmcinkOEy9mJ5c=Lxw@mail.gmail.com>
 <6dde2248-da0d-7bd3-801b-b42b2974c038@kontron.de>
 <CAK8P3a0WCOcVjSegBKRPw3kkokE8S4JEXManqBkq4CjfcBRSMg@mail.gmail.com>
In-Reply-To: <CAK8P3a0WCOcVjSegBKRPw3kkokE8S4JEXManqBkq4CjfcBRSMg@mail.gmail.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 20 Dec 2018 19:23:34 +0100
Message-ID: <CAMuHMdW1NsqEHWBBn77wTAYnXi068iT2Lo8rxUUSvbo5UHDTkA@mail.gmail.com>
Subject: Re: [GIT PULL] FSL QSPI device tree cleanup for 4.21
To: Arnd Bergmann <arnd@arndb.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181220_102357_528876_553F336A 
X-CRM114-Status: GOOD (  25.00  )
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
Cc: frieder.schrempf@kontron.de, linux-spi <linux-spi@vger.kernel.org>,
 arm-soc <arm@kernel.org>, linux-mtd <linux-mtd@lists.infradead.org>,
 linux-imx@nxp.com, Sascha Hauer <kernel@pengutronix.de>,
 Fabio Estevam <fabio.estevam@nxp.com>, Shawn Guo <shawnguo@kernel.org>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi Arnd,

On Thu, Dec 20, 2018 at 5:33 PM Arnd Bergmann <arnd@arndb.de> wrote:
> On Thu, Dec 20, 2018 at 5:23 PM Schrempf Frieder
> <frieder.schrempf@kontron.de> wrote:
> > On 20.12.18 17:11, Arnd Bergmann wrote:
> > > On Thu, Dec 20, 2018 at 5:03 PM Schrempf Frieder
> > > <frieder.schrempf@kontron.de> wrote:
> > >>
> > >> On 20.12.18 16:50, Arnd Bergmann wrote:
> > >>> On Sun, Dec 16, 2018 at 9:50 AM Shawn Guo <shawnguo@kernel.org> wrote:
> > >>>> As the series cleans up both i.MX/Freescale arm32 and arm64 device
> > >>>> trees, the pull request is based on a merge of tag imx-dt-4.21 and
> > >>>> imx-dt64-4.21 that have already been pulled into arm-soc next/dt branch.
> > >>>> This comes a bit late, and we appreciate it if you can pull it for 4.21,
> > >>>> as it paves the way for new QSPI driver under SPI framework to land in
> > >>>> the next release cycle.  Thanks.
> > >>>
> > >>> Pulled into next/dt. For my understanding, what is going to happen
> > >>> with the fsl-quadspi mtd driver? Will it remain as part of the kernel
> > >>> to support old DTB files, or will that transitions mean those stop
> > >>> working with new kernels and have to be updated the same way?
> > >>
> > >> Thanks for pulling these late changes. The old SPI NOR driver
> > >> (fsl-quadspi.c) will be replaced by the new SPI driver. Old dtb files
> > >> will work with the new driver if they already have the reg properties
> > >> set up correctly (which should be the case, but who knows what setups
> > >> exist out-of-tree).
> > >
> > > Ok, good.
> > >
> > >> There will be a performance penalty though if you do not set
> > >> spi-[tx/rx]-bus-width to 4.
> > >
> > > I guess that's acceptable, but what is the reason for requiring
> > > this? Would it be possible to have the qspi driver add those
> > > properties and print a warning whenever the dtb doesn't
> > > already contain them?
> >
> > As the new driver is a SPI driver, the common rules in
> > Documentation/devicetree/bindings/spi/spi-bus.txt apply and
> > spi-[tx/rx]-bus-width are defined to default to 1 if not specified.
> > So we can't set those properties in the driver if they are missing in
> > the dtb as we would deviate from the standard, although it would make
> > more sense for a *Quad*-SPI driver to default to 4.
>
> Right, I guess that makes sense.
>
> Now, you could change the binding for the fsl-quadspi driver to
> require the bus-width properties, which would then just make
> the old dtb files invalid, and you give us an excuse to override
> the properties by adding the =4 ones, once that is documented
> in the driver specific binding.
>
> Since it's only a performance difference, I suppose we can live
> with the limitation and stay a little closer to the normal binding.

Please note that a quad-capable SPI FLASH may be physically wired
to a quad-capable SPI controller using only 2 wires, so defaulting to
4 may cause issues.  Defaulting to 2 may work, if the device is
dual-capable.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
