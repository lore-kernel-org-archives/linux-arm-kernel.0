Return-Path: <SRS0=E6Hv=PM=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C131DC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 13:32:56 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 88FD2208E3
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 13:32:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="AGnaponT";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=verge.net.au header.i=@verge.net.au header.b="IgPGLNXc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 88FD2208E3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=verge.net.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=f/bw1lg0yVdBHgQzlGkaWyD2qitTuG511kkXFdF7jcE=; b=AGnaponT5zCynG
	2JxSHRtNBbn+f/QkmL7OK+BnrrElAxJ2wGcyzgBwpSyMJk0mRUZKsGO9Lce1H170qN855LpvuyVXS
	2ivWzXDpkT3kRWaaRY7BYyMTZQK49xh3A+dLLDPwnF3LMVy19xPTmimKPQeqQzm7kMeAfLiFc1uNS
	hfuV2A/2STKOJo0yDvjS0FAi2VE7c288ya7XvOMR6seZVTuRaHGtrANu9dkYYjhLKq6wAoM/naC/X
	1rD20AhaufsAQUb2StCus26Lw4suEUwgbEHZJe80lnHwrPzhW7UT0SNvoOqp4zHp5xdMH1jF7rO46
	Ugt9IpdKZ3of7KNYMjrg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gfPao-0008CE-Ex; Fri, 04 Jan 2019 13:32:54 +0000
Received: from kirsty.vergenet.net ([202.4.237.240])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gfPV5-00056x-OL
 for linux-arm-kernel@lists.infradead.org; Fri, 04 Jan 2019 13:27:19 +0000
Received: from reginn.horms.nl (watermunt.horms.nl [80.127.179.77])
 by kirsty.vergenet.net (Postfix) with ESMTPA id 5A50B25B791;
 Sat,  5 Jan 2019 00:26:58 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=verge.net.au; s=mail;
 t=1546608418; bh=isCh6H0lOt3l85QDngid6rzi+HqrpFKJieTA3z5sGqQ=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=IgPGLNXcrpB1bvifQlOUznSkoe/1jL1lEN+g9ILUb9c9gWn5S8VZi52eSVd7xD6fG
 VYiJ9M0RfJiWzBnE/z79f+4Y16YJvL12gLOMjY1HxkafITgLBUvbP06p7PoR+R1Ab1
 +P6G5DwMhO2pmBXVFQAYEoIhLZT/hEY3VeF0Hdw4=
Received: by reginn.horms.nl (Postfix, from userid 7100)
 id 4C975940376; Fri,  4 Jan 2019 14:26:56 +0100 (CET)
Date: Fri, 4 Jan 2019 14:26:56 +0100
From: Simon Horman <horms@verge.net.au>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH/RFT] arm64: dts: renesas: r8a77990-ebisu: Add BD9571 PMIC
Message-ID: <20190104132655.usp2mjyh2sdqds4w@verge.net.au>
References: <1543675408-11382-1-git-send-email-ykaneko0929@gmail.com>
 <CAMuHMdXvGEZpuDr6oWH0QGxVtfx-EUiQJ+_Jt33dZhn_Lw4EYQ@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAMuHMdXvGEZpuDr6oWH0QGxVtfx-EUiQJ+_Jt33dZhn_Lw4EYQ@mail.gmail.com>
Organisation: Horms Solutions BV
User-Agent: NeoMutt/20170113 (1.7.2)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190104_052700_354134_8981A069 
X-CRM114-Status: GOOD (  20.69  )
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
Cc: Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
 Magnus Damm <magnus.damm@gmail.com>, Yoshihiro Kaneko <ykaneko0929@gmail.com>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>,
 Marek Vasut <marek.vasut@gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Mon, Dec 03, 2018 at 09:25:30AM +0100, Geert Uytterhoeven wrote:
> Hi Kaneko-san,
> 
> On Sat, Dec 1, 2018 at 3:43 PM Yoshihiro Kaneko <ykaneko0929@gmail.com> wrote:
> > From: Takeshi Kihara <takeshi.kihara.df@renesas.com>
> >
> > This patch adds the regulator definition required for operation of
> > S2RAM.
> >
> > Signed-off-by: Takeshi Kihara <takeshi.kihara.df@renesas.com>
> > Signed-off-by: Yoshihiro Kaneko <ykaneko0929@gmail.com>
> 
> Thanks for your patch!
> 
> > --- a/arch/arm64/boot/dts/renesas/r8a77990-ebisu.dts
> > +++ b/arch/arm64/boot/dts/renesas/r8a77990-ebisu.dts
> > @@ -425,6 +425,26 @@
> >         };
> >  };
> >
> > +&i2c_dvfs {
> > +       status = "okay";
> > +
> > +       clock-frequency = <400000>;
> > +
> > +       pmic: pmic@30 {
> > +               pinctrl-0 = <&irq0_pins>;
> > +               pinctrl-names = "default";
> > +
> > +               compatible = "rohm,bd9571mwv";
> > +               reg = <0x30>;
> > +               interrupt-parent = <&intc_ex>;
> > +               interrupts = <0 IRQ_TYPE_LEVEL_LOW>;
> > +               interrupt-controller;
> > +               #interrupt-cells = <2>;
> > +               gpio-controller;
> > +               #gpio-cells = <2>;
> 
> Just adding this node is not sufficient to make S2RAM work.
> As per Documentation/devicetree/bindings/mfd/bd9571mwv.txt, you also have
> to describe the DDR-Backup Power configuration.
> 
> On the Ebisu-4D development board, only the DDR0 power rail is used, and
> needs to be kept powered when backup mode is enabled.
> 
>         rohm,ddr-backup-power = <0x1>;
>         rohm,rstbmode-level;
> 
> Unfortunately resume from s2ram doesn't work with this, probably due to an
> issue in ATF.  This may have been fixed in IPL and Secure Monitor Rev1.0.22,
> which claims to add support for the Ebisu-4D board.

Thanks, do you know of any information on how to get IPL and Secure Monitor
running / updated on Ebisu-4D?

> I don't know if plain Ebisu needs a different configuration.
> 
> > +       };
> > +};
> > +
> >  &lvds0 {
> >         status = "okay";
> >
> 
> The rest is fine, hence with the above fixed and tested:
> 
> Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

I assume that working S2RAM is part of such testing.
Is that correct?

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
