Return-Path: <SRS0=LcWp=QO=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 840E4C282C2
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 10:33:49 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4F6B12147C
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 10:33:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Pw14dEwx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4F6B12147C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=jjWzPP3KBGCdsPejjc22yOrc6YomJBk7RpuW+XxuGZQ=; b=Pw14dEwxrio30M
	LRRz5wOvJTY/Pe8gWGyrzXjnGFbK//ePwOgpwQn0hhImg14QWgmzh562jstnwdN5b9G7vFlS6dt9A
	wHzCQ+yChcUjSDorHTLPVRfUFnvgur2l25wvHDu4GMnY7SUVIFHOA+elt5sZXiF+NQT1eyUBMvRiF
	SdtFxw2JNPrQnTGn3x3RIkiZWAXysTukZz5ObaSRrW1S7JRMRWVxrfh/quxKZnJQ0uEoemKHYPkpr
	lEjNE/KmLXs5LsodlYphWTgfF6ctkhy7L9j9/awExJZPPoKGqfQIzThycxS3n5z5FBc9BEHKSgyaW
	vTLIk3Hh5TPEm8OLOxnA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1grh05-0003vw-2P; Thu, 07 Feb 2019 10:33:45 +0000
Received: from mail-ua1-f66.google.com ([209.85.222.66])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1grh01-0003va-FF
 for linux-arm-kernel@lists.infradead.org; Thu, 07 Feb 2019 10:33:43 +0000
Received: by mail-ua1-f66.google.com with SMTP id d2so3286586ual.2
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 07 Feb 2019 02:33:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=GbxMf+fJtPyVruQMLobztNCdYkfsYTSFMFwlgTYcjVM=;
 b=CZMkdruVK3wefUhu35iE4rA62uy9QcPhoU3+5H6XHu+8kZvTneqp3Bki2UB5SvajBX
 0uRWD8gsXF65amBiTEfdU4BhL38fJuK1R29nvKh076JuLK0sWtcWz0ltmqh0dteBEwfC
 RBSDbjQA9Y/wDm9hGnE7lTjmTj7BxBwZuEsKG9RBE7qir5GIFQMN8+FQSq84sdrOtij5
 I49u/5A89ns0KnJ4DaQDeUD1DuBgRFqk3bEeDFJ/oYiRVV81hS6L5a0StslDE4woLrPi
 DjKHDuk370bx75s7gta6VUdidh12sugSQ7k0o95uYF8MOIXEcF9G/omWnXriQTMsi+Gd
 FSFQ==
X-Gm-Message-State: AHQUAua41j+I9B8HEo3XLDMDdkk1un2kDbMW0zOO27bEjj8GRMwtyE9x
 1YVzGx93Nzec3g2aoE+ado9eceSQdc3OpsJHwJE=
X-Google-Smtp-Source: AHgI3IZvLEydvT/oPvjVi6j40lbTLSLelti831IrEieTEu34OspahLVQqwzKbL/6IZWN9Iydss9H77F7+Oo5AwV9IW4=
X-Received: by 2002:a9f:2726:: with SMTP id a35mr5720618uaa.75.1549535619947; 
 Thu, 07 Feb 2019 02:33:39 -0800 (PST)
MIME-Version: 1.0
References: <1543675408-11382-1-git-send-email-ykaneko0929@gmail.com>
 <CAMuHMdXvGEZpuDr6oWH0QGxVtfx-EUiQJ+_Jt33dZhn_Lw4EYQ@mail.gmail.com>
 <20190104132655.usp2mjyh2sdqds4w@verge.net.au>
In-Reply-To: <20190104132655.usp2mjyh2sdqds4w@verge.net.au>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 7 Feb 2019 11:33:28 +0100
Message-ID: <CAMuHMdWs2Z1csN14EGvV+HnM8Ko0Du0LY=zt=Zp9N7TD=cVdAA@mail.gmail.com>
Subject: Re: [PATCH/RFT] arm64: dts: renesas: r8a77990-ebisu: Add BD9571 PMIC
To: Simon Horman <horms@verge.net.au>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190207_023341_511037_B35AB716 
X-CRM114-Status: GOOD (  25.27  )
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

Hi Simon,

On Fri, Jan 4, 2019 at 2:27 PM Simon Horman <horms@verge.net.au> wrote:
> On Mon, Dec 03, 2018 at 09:25:30AM +0100, Geert Uytterhoeven wrote:
> > On Sat, Dec 1, 2018 at 3:43 PM Yoshihiro Kaneko <ykaneko0929@gmail.com> wrote:
> > > From: Takeshi Kihara <takeshi.kihara.df@renesas.com>
> > >
> > > This patch adds the regulator definition required for operation of
> > > S2RAM.
> > >
> > > Signed-off-by: Takeshi Kihara <takeshi.kihara.df@renesas.com>
> > > Signed-off-by: Yoshihiro Kaneko <ykaneko0929@gmail.com>
> >
> > Thanks for your patch!
> >
> > > --- a/arch/arm64/boot/dts/renesas/r8a77990-ebisu.dts
> > > +++ b/arch/arm64/boot/dts/renesas/r8a77990-ebisu.dts
> > > @@ -425,6 +425,26 @@
> > >         };
> > >  };
> > >
> > > +&i2c_dvfs {
> > > +       status = "okay";
> > > +
> > > +       clock-frequency = <400000>;
> > > +
> > > +       pmic: pmic@30 {
> > > +               pinctrl-0 = <&irq0_pins>;
> > > +               pinctrl-names = "default";
> > > +
> > > +               compatible = "rohm,bd9571mwv";
> > > +               reg = <0x30>;
> > > +               interrupt-parent = <&intc_ex>;
> > > +               interrupts = <0 IRQ_TYPE_LEVEL_LOW>;
> > > +               interrupt-controller;
> > > +               #interrupt-cells = <2>;
> > > +               gpio-controller;
> > > +               #gpio-cells = <2>;
> >
> > Just adding this node is not sufficient to make S2RAM work.
> > As per Documentation/devicetree/bindings/mfd/bd9571mwv.txt, you also have
> > to describe the DDR-Backup Power configuration.
> >
> > On the Ebisu-4D development board, only the DDR0 power rail is used, and
> > needs to be kept powered when backup mode is enabled.
> >
> >         rohm,ddr-backup-power = <0x1>;
> >         rohm,rstbmode-level;
> >
> > Unfortunately resume from s2ram doesn't work with this, probably due to an
> > issue in ATF.  This may have been fixed in IPL and Secure Monitor Rev1.0.22,
> > which claims to add support for the Ebisu-4D board.
>
> Thanks, do you know of any information on how to get IPL and Secure Monitor
> running / updated on Ebisu-4D?

This is now working with upstream ATF (v2.0-763-ga45ccf135e48efc7)

> > I don't know if plain Ebisu needs a different configuration.
> >
> > > +       };
> > > +};
> > > +
> > >  &lvds0 {
> > >         status = "okay";
> > >
> >
> > The rest is fine, hence with the above fixed and tested:
> >
> > Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
>
> I assume that working S2RAM is part of such testing.
> Is that correct?

That is correct.

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
