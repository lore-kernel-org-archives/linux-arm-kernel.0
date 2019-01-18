Return-Path: <SRS0=p0aQ=P2=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 827ADC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 15:44:40 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 539DA20896
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 15:44:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="cZwYPwBh";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="f6tuhciC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 539DA20896
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=y7Tm8Ccx8WBs8LzEJ+ELc0mN4EoKyxhp6kcoly3owVQ=; b=cZwYPwBhTozDpG
	r8OfIldoi7vfPlNkTLEdJ/snnK4l9tyke7V9FI/Td3Tq97FlWNFonhcMWlLM20wRdxW0HdH81X+vf
	AQRPRdBxchBSLUCFFbOF5wlQ5mh0r7ui5QAMRHju7E9M8mZPsQOClplBKlYIr5HMAVMJhGf8J2X8T
	Iuu3fyQu0fwHvV/zfg2TzNokUsF0gowb6uPulOTBATdaL8Qal/cwUVTcehR0WH0lDYCc0lNip1nQ8
	Ks1aIENVujPC9o2AP6QMCmM2w0aBpc5VynMbg4P2DXTpYSp+sfScrzN6U5VY1Xd7pYvnUauya2s4l
	yjPOCB+DrV7LwwTGIZww==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gkWJy-0001Yi-VY; Fri, 18 Jan 2019 15:44:38 +0000
Received: from mail-it1-x142.google.com ([2607:f8b0:4864:20::142])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gkWJs-0001NL-OW
 for linux-arm-kernel@lists.infradead.org; Fri, 18 Jan 2019 15:44:36 +0000
Received: by mail-it1-x142.google.com with SMTP id p197so6360809itp.0
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 18 Jan 2019 07:44:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=M8rXTSbBX4ubMvOTSWd77IQNaWFBuPmToHx2tviAqv8=;
 b=f6tuhciCex2pZhhiAe+9TsKtQQMPXIxp/GZCnFoQ2lOYUxu8PzjpdZ28GrY3+ari/7
 ClVCsgWJRqcJ4ZUkepP7DnoMeUy7CPjzTUxRGOovNivX8D0YTKqF0vHN2ZKGfN2Szuiz
 BBsSBEIxoolJqcSsitbbXBgKw5QSuoPimSBfo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=M8rXTSbBX4ubMvOTSWd77IQNaWFBuPmToHx2tviAqv8=;
 b=f15iFzmeuXu1slnrG5ImC+8U1QurVDSqBjoYJ2mJ3gmuP5k6hKsrwp8xBIWauvt7O9
 qJ9HhZa6cqPuI6qw/5oq3Ex518olSTqgnvvkr/HlA1+zISAaPJC0wTKGUzCMvY4eei3o
 D5+CmJRQGJRlbSk5LTt/QkrE67N4GQ8NIBCZunTKryF6iXDdXRPTz+pL9qjrSX1c+bn0
 fT/KlvUHG4rhUSsUkCcGCQOurBMT7Ty+gW8j43DqsWt4dgbPmR1EEn0YKgIzmNgdhVZQ
 xCwd4li9V0BuRQ6jahJkcyfH1F2oZtByY30fcpWkJjcKq80ouwUdo5S8qzVacdQtPn89
 /3oQ==
X-Gm-Message-State: AJcUukczLvWsm3PUlA50lle5b8rqL0Ev67chBDnNkdjoor90iwtrsFSd
 qzbO1uxlTqBgRWigg/7GEQJqcUP7KgqZen390gs8Dw==
X-Google-Smtp-Source: ALg8bN6L/+sKvZ0HTo+pIJ0mihUdAg+iv8v9dLRS+wyz/iSOZ/Oqc48dXJYeSuGKMMhAWuAT1z0BlLaP1k/SJLNIQ9o=
X-Received: by 2002:a24:10cb:: with SMTP id 194mr11701953ity.173.1547826271072; 
 Fri, 18 Jan 2019 07:44:31 -0800 (PST)
MIME-Version: 1.0
References: <20181210161729.29720-1-jagan@amarulasolutions.com>
 <20181210161729.29720-8-jagan@amarulasolutions.com>
 <20181211164900.wfmkmbrbj3nmlb3h@flea>
 <CAMty3ZB5F5jD9iJT1soXSA5HtQOf5W9rKO9nCdGFUfVo0hpO4Q@mail.gmail.com>
 <20190107141158.zaimizk4rlqa6xli@flea>
 <CAMty3ZBb8byOwh=_W83Ta0Dse1qkoqccOeaBEY9oHPaxDxe9QA@mail.gmail.com>
 <20190108085829.clianbtjovu3oieq@flea>
 <CAMty3ZC9OQtwT-iH=S1LhHsBPc_jFKGAnCYYeR9nuKuDWSKLQw@mail.gmail.com>
 <20190112164319.whr7gwvl4oux5svz@flea>
 <CAMty3ZD8X9KmHjUtAo-+Y83a2j8NF3DjM9Yr3LPMxOvQ8kOV7g@mail.gmail.com>
 <20190116191756.ajzzaga43srk77dk@flea>
 <CAMty3ZCw8itG=nizA5E218HT5kg=-xDzLmShF51vRh4ENYKuBA@mail.gmail.com>
In-Reply-To: <CAMty3ZCw8itG=nizA5E218HT5kg=-xDzLmShF51vRh4ENYKuBA@mail.gmail.com>
From: Jagan Teki <jagan@amarulasolutions.com>
Date: Fri, 18 Jan 2019 21:14:19 +0530
Message-ID: <CAMty3ZDbTgo3EY12VC0X_XuaRobQXvHx=Y6-_sgSWxDm1ZXbHQ@mail.gmail.com>
Subject: Re: [PATCH v5 07/17] drm/sun4i: sun6i_mipi_dsi: Refactor vertical
 video start delay
To: Maxime Ripard <maxime.ripard@bootlin.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190118_074433_278982_59232729 
X-CRM114-Status: GOOD (  19.81  )
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
Cc: Stephen Boyd <sboyd@kernel.org>,
 Michael Turquette <mturquette@baylibre.com>,
 linux-sunxi <linux-sunxi@googlegroups.com>,
 linux-kernel <linux-kernel@vger.kernel.org>,
 dri-devel <dri-devel@lists.freedesktop.org>, Chen-Yu Tsai <wens@csie.org>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 linux-amarula@amarulasolutions.com, linux-clk <linux-clk@vger.kernel.org>,
 linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Thu, Jan 17, 2019 at 10:02 AM Jagan Teki <jagan@amarulasolutions.com> wrote:
>
> On Thu, Jan 17, 2019 at 12:48 AM Maxime Ripard
> <maxime.ripard@bootlin.com> wrote:
> >
> > On Sun, Jan 13, 2019 at 01:07:41AM +0530, Jagan Teki wrote:
> > > > > > > > Again, I cannot help you without the datasheet for the panels you're
> > > > > > > > trying to submit.
> > > > > > >
> > > > > > > The panel bound with Sitronix ST7701 IC
> > > > > > > http://www.startek-lcd.com/res/starteklcd/pdres/201705/20170512144242904.pdf
> > > > > >
> > > > > > It's the controller, not the panel
> > > > >
> > > > > As I said before, the datasheet of that panel doesn't have any
> > > > > information except electrical characteristics and used IC which is
> > > > > ST7701.
> > > > >
> > > > > I have one more panel, which is from Bananapi, S070WV20-CT16 ICN621
> > > > > please find the attachment for the same.
> > > > >
> > > > > Here is some more details of the same.
> > > > >
> > > > > https://github.com/yesnoandor/x300/blob/master/kernel/arch/arm/boot/dts/erobbing/x300/x300.dtsi#L81
> > > > > https://github.com/wxzed/Raspberry_5MIPI_Display/blob/master/I2C_Slave/USER/main.c#L15
> > > > >
> > > > > https://github.com/eliot-shao/qcom/blob/master/icn6211_cxn0102/kernel/drivers/video/msm/mdss/mdss_i2c_interface.c#L152
> > > > > matches timings for
> > > > > https://github.com/eliot-shao/qcom/blob/master/icn6211_cxn0102/kernel/arch/arm/boot/dts/qcom/dsi-mipi-2-rgb_1280p_video.dtsi#L20
> > > > >
> > > > > https://github.com/zestroly/micromat/blob/master/test/raspberry/ICN6211.cpp#L169
> > > >
> > > > Where did you get the timings from then?
> > >
> > > You mean drm_mode timings, the same panel with RGB available in
> > > panel-simple[1], and dsi driver in Mailing list[2] and actual DSI
> > > sequence commands from BSP[3]
> > >
> > > [1] https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/drivers/gpu/drm/panel/panel-simple.c?id=7ad8b41cd8f5c2842646d01cdd576663caee04a7
> > > [2] https://patchwork.kernel.org/patch/10680331/
> > > [3] https://github.com/BPI-SINOVOIP/BPI-M64-bsp/blob/master/linux-sunxi/drivers/video/sunxi/disp2/disp/lcd/S070WV20_MIPI_RGB.c
> >
> > So you had no reliable source for the timings then? How do you know if
> > all your patches that are timing related are right then?
>
> I don't understand your point, or may be I confused with many links
> that I attached in previous mail.
>
> 1. Patch for same panel timings are already in Mainline that was
> tested on one of the board. [1]
> 2. Driver from AW, released bsp from BPI-M64-bsp [3]
>
> Do you think the above two points are not valid sources?

fyi, the panel datasheet attached in above mail has timing information.

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
