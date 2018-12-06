Return-Path: <SRS0=DN+v=OP=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_RHS_DOB autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 658C5C64EB1
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 17:08:28 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 345C720661
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 17:08:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="BNjVU5DQ";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="PTojt70g"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 345C720661
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=kODjHicVZdjF4GtN4PAflh2PQKOM3l/xvJ66dTELyK8=; b=BNjVU5DQiWuVNO
	TtOzBLbjnvHflmUWSLWOnv1+B1aXOt/R0VvoxxyOe/xwz47dGmiaIUBpCsrMEKKQWKMPkEJ2Wmu0L
	cdxcJFgMfcfAwES435oKNEqf9iRmYxNtf3wYx3n4ITIO75CZdg45Erx3BJMayaPJxVrzD8aRerGnZ
	6/2UMAWxZTKCcXL3xCs3oLm5kTuRafj19KQA3H+n1pqHkH03snNn924SVaGBBfubnuhPc/SAbWwHX
	xLEQCS1cQ7CEAM32bWYBznyiy1zly4nIf2vxdxMLtEOQez1k4IpmrvnyzXfUI3DHOI/G/9TKpSICo
	JOqD9yYQJCyw0cxXMi0Q==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gUx8V-0005Ga-3j; Thu, 06 Dec 2018 17:08:27 +0000
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gUx8R-0005Fs-2T
 for linux-arm-kernel@lists.infradead.org; Thu, 06 Dec 2018 17:08:25 +0000
Received: by mail-wr1-x442.google.com with SMTP id t27so1227945wra.6
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 06 Dec 2018 09:08:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=n1Wh1MYeW4IZXesY5bRiGqpWcwQezW04aN8+hh/Gqas=;
 b=PTojt70gYUvsg4CCC7Ug8CT9Tf2NSiNiZqBST0WBsI2JpbK9qOvvl28vPqHjy0lA7N
 t1LKwAIYNov6QHn7q+f2KudQbiau6VZXdDBL32N61TUT0+3mOjPUtYdQMTxv9S61MxfN
 YQ5td830pChNCppVFe9JSf+CkpUHhJVd8r/t0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=n1Wh1MYeW4IZXesY5bRiGqpWcwQezW04aN8+hh/Gqas=;
 b=hT2BILOnNgsRNDmxwr7nMwZFAJwglAT7vTtG6ILnlynkTY4OllCX6Sn1fH1bnhv3VD
 pro6apj197f8txqxtrIQXpgbX3yf8iD5E5BKmSZESctCptDu5oun9AQGEYRT3780mSAx
 hJiiDDUbeaIU8yfZDhJFYBTZrS4ffk1ckniGEUH6blqZwsCVS17sMw2Al84BtCHR+xvp
 2fFuoFRuqZaJ1o3bDK/INHTNty/osxa6AHyn8fkqFORVwNoOFRW/lPwQaDM2RqxMBgdO
 RHEZ+k/1E2gSa1PzhEAwvN90psoLixsQKTWj/8Z1IaDWiesXSAuOwNh0a/4ofTSFhgDe
 wtqg==
X-Gm-Message-State: AA+aEWahZc68shtnKmoA8P2AQeaB+JEjj3xFTJfghQt/clCpDqXjkfsD
 +2rw0HMvSaGCUsvLGFt73AV5NC/rIDlgC5oG+mFUog==
X-Google-Smtp-Source: AFSGD/V/S1uynPvxft/BTBJeHJ8bwDFcJBB57C0H8kh7CS8NSEdgBc9Xetv4WSG9+1doJQfPSTbt2tQIbSKI9mlZiHI=
X-Received: by 2002:adf:e891:: with SMTP id d17mr28032263wrm.140.1544116090511; 
 Thu, 06 Dec 2018 09:08:10 -0800 (PST)
MIME-Version: 1.0
References: <20181206132306.11843-1-jagan@amarulasolutions.com>
 <20181206132306.11843-2-jagan@amarulasolutions.com>
 <20181206153445.kqu2pep5orktr6yv@flea>
In-Reply-To: <20181206153445.kqu2pep5orktr6yv@flea>
From: Michael Nazzareno Trimarchi <michael@amarulasolutions.com>
Date: Thu, 6 Dec 2018 18:07:59 +0100
Message-ID: <CAOf5uwk_k-Y8ZZFbtjUup5U27wN_E+fvqEDs5m3csnzdneN1KQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] arm64: dts: allwinner: a64: Add A64 CSI controller
To: Maxime Ripard <maxime.ripard@bootlin.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181206_090823_596546_00DBBE03 
X-CRM114-Status: GOOD (  19.73  )
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
Cc: Mark Rutland <mark.rutland@arm.com>,
 devicetree <devicetree@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
 Chen-Yu Tsai <wens@csie.org>, Rob Herring <robh+dt@kernel.org>,
 Jagan Teki <jagan@amarulasolutions.com>, linux-amarula@amarulasolutions.com,
 linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi Maxime

On Thu, Dec 6, 2018 at 4:34 PM Maxime Ripard <maxime.ripard@bootlin.com> wrote:
>
> On Thu, Dec 06, 2018 at 06:53:05PM +0530, Jagan Teki wrote:
> > Allwinner A64 CSI controller has similar features as like in
> > H3, So add support for A64 via H3 fallback.
> >
> > Also updated CSI_SCLK to use 300MHz via assigned-clocks, since
> > the default clock 600MHz seems unable to drive the sensor(ov5640)
> > to capture the image.
> >
> > Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
> > ---
> > Changes for v2:
> > - Use CSI_SCLK to 300MHz
> >
> >  arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi | 23 +++++++++++++++++++
> >  1 file changed, 23 insertions(+)
> >
> > diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi b/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
> > index 384c417cb7a2..d7ab0006ebce 100644
> > --- a/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
> > +++ b/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
> > @@ -532,6 +532,12 @@
> >                       interrupt-controller;
> >                       #interrupt-cells = <3>;
> >
> > +                     csi_pins: csi-pins {
> > +                             pins = "PE0", "PE2", "PE3", "PE4", "PE5", "PE6",
> > +                                    "PE7", "PE8", "PE9", "PE10", "PE11";
> > +                             function = "csi0";
> > +                     };
> > +
> >                       i2c0_pins: i2c0_pins {
> >                               pins = "PH0", "PH1";
> >                               function = "i2c0";
> > @@ -899,6 +905,23 @@
> >                       status = "disabled";
> >               };
> >
> > +             csi: csi@1cb0000 {
> > +                     compatible = "allwinner,sun50i-a64-csi",
> > +                                  "allwinner,sun8i-h3-csi";
> > +                     reg = <0x01cb0000 0x1000>;
> > +                     interrupts = <GIC_SPI 84 IRQ_TYPE_LEVEL_HIGH>;
> > +                     clocks = <&ccu CLK_BUS_CSI>,
> > +                              <&ccu CLK_CSI_SCLK>,
> > +                              <&ccu CLK_DRAM_CSI>;
> > +                     clock-names = "bus", "mod", "ram";
> > +                     resets = <&ccu RST_BUS_CSI>;
> > +                     pinctrl-names = "default";
> > +                     pinctrl-0 = <&csi_pins>;
> > +                     assigned-clocks = <&ccu CLK_CSI_SCLK>;
> > +                     assigned-clock-rates = <300000000>;
>
> That should be enforced in the driver.
>

We are not really sure what is the best here. Our first idea was to
put in the board file and then Jagan
decide to put in dtsi. We don't have enough coverage of camera on this
CPU and I prefer to stay with this
minimal change that does not impact the driver.

Michael

> Maxime
>
> --
> Maxime Ripard, Bootlin
> Embedded Linux and Kernel engineering
> https://bootlin.com



-- 
| Michael Nazzareno Trimarchi                     Amarula Solutions BV |
| COO  -  Founder                                      Cruquiuskade 47 |
| +31(0)851119172                                 Amsterdam 1018 AM NL |
|                  [`as] http://www.amarulasolutions.com               |

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
