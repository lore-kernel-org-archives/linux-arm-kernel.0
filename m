Return-Path: <SRS0=JyYb=QI=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB725C282DB
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 16:34:14 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AB65A207E0
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 16:34:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="i7MiLpiu";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="nuIVzvZR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AB65A207E0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=9UKxOiqOZrUpgnSXugmJjyeCnSqzN6IrhC1gbBE/rsY=; b=i7MiLpiue8IN20
	/ggvjERU/oTuGUZPwoBbVUK6OpMUe3B0KHxS3sGfnAo4IcsergDTbevd5zOTQQiDO3ePGMipN5Vnp
	9BI3TCSByye/7iohuiSiKPqkd4zOshkEl3FBNm4vLluXPYahxNQ1eNizzg5TD/zWikkV43OpX2Hin
	yHjK4nta8uAR3IKn5zVf8WseEJdDF4zVp6Y7XlOZOMu5Kx9rhGKqiT1YYzYSOHJCEzSM5g9EwdUr6
	XOrlnbgmFx7fj6SJv1/j2Uy3f63afPYy7JgGO6PiVcGB9zinm0+B10Sjf7NYJq068ueOD14XCm7lf
	qnw6TQD+IdyZDXrVFSWg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gpblb-0006aY-Vc; Fri, 01 Feb 2019 16:34:12 +0000
Received: from mail-io1-xd41.google.com ([2607:f8b0:4864:20::d41])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gpblX-0006Z0-K2
 for linux-arm-kernel@lists.infradead.org; Fri, 01 Feb 2019 16:34:09 +0000
Received: by mail-io1-xd41.google.com with SMTP id b16so6198071ior.1
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 01 Feb 2019 08:34:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=OsVreUKiE+8SO1xY9zWMjIdwcADin5pd8Ff6YLaDmBk=;
 b=nuIVzvZRR2Gx/XCTvBQqIsJQOwzXwBE5lp4/+5GX+I0+s03K3PzkCsL0hW9kLK9wBU
 2aQVPaoDSLdd5dHuCvTfOn2Tw15yRIMjsALyepkNunyug/2Ul3WC6RIFjctiKQCOXmly
 8qeouginDXIAMx3TBoHH6obnixZtLlMud/g2Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=OsVreUKiE+8SO1xY9zWMjIdwcADin5pd8Ff6YLaDmBk=;
 b=XKi1bqFM0McvIto266s6w6RaaPEFc14bDH5K4bQyEI15sdzWho3uuyj11cxeBLkSj4
 04xvSgrcaL3DzYvYbBsDr2ymPzNSM2L+ELGW4i4SLddpPfrONI2lo8MI3Opr5lKkOs1C
 nZsRbV3XiLRhSkkAlykHLbefh+2ANMkqM3hEksrRc+4ADEmAP45TsBPC21PrY5ddsuKb
 f8jyq3lNOaMD0uwEHvKiEeMb6DPO+Lsy7zs3pemMsK/oUEa4mlgXYjkjhmxaXc857RhQ
 YLinoeLATLVIOMrH6QeVXzHDej6wjm32t7S98oUgkX+x5HB0yiRd8KLNVooQupNFJ0Fa
 SKtw==
X-Gm-Message-State: AJcUukej7UxmztpDOc1uhk82XvL8RUdskuvkqm7StoyUTqz9RtmvPBJU
 Iz8wRcEsCztnPnbRYYx/1Pj7ShHz/1zqzkPs5YjfMw==
X-Google-Smtp-Source: AHgI3IYwHKUmMw1BKAPtwc78p5SrxzdDC6K/0ir1JWIb6e4jWtfs0+sBAQG5OGwHUxIyWEOz/XsSu01o6mx8NdfQ7xI=
X-Received: by 2002:a6b:91d4:: with SMTP id
 t203mr24253308iod.267.1549038845242; 
 Fri, 01 Feb 2019 08:34:05 -0800 (PST)
MIME-Version: 1.0
References: <20190124195900.22620-1-jagan@amarulasolutions.com>
 <20190124195900.22620-12-jagan@amarulasolutions.com>
 <20190125212433.ni2jg3wvpyjazlxf@flea>
 <CAMty3ZAsH2iZ+JEqTE3D58aXfGuhMSg9YoO56ZhhOeE4c4yQHQ@mail.gmail.com>
 <20190129151348.mh27btttsqcmeban@flea>
 <CAMty3ZAjAoti8Zu80c=OyCA+u-jtQnkidsKSNz_c2OaRswqc3w@mail.gmail.com>
 <20190201143102.rcvrxstc365mezvx@flea>
In-Reply-To: <20190201143102.rcvrxstc365mezvx@flea>
From: Jagan Teki <jagan@amarulasolutions.com>
Date: Fri, 1 Feb 2019 22:03:53 +0530
Message-ID: <CAMty3ZBzUKfXW33JE6BGc8WOrcW1pGZH91x-2C9BLY-LDQRLgg@mail.gmail.com>
Subject: Re: [PATCH v6 11/22] clk: sunxi-ng: a64: Add minimum rate for PLL_MIPI
To: Maxime Ripard <maxime.ripard@bootlin.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190201_083407_820468_6687AC44 
X-CRM114-Status: GOOD (  35.63  )
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
 devicetree <devicetree@vger.kernel.org>, David Airlie <airlied@linux.ie>,
 Michael Turquette <mturquette@baylibre.com>,
 linux-sunxi <linux-sunxi@googlegroups.com>,
 linux-kernel <linux-kernel@vger.kernel.org>,
 dri-devel <dri-devel@lists.freedesktop.org>, Chen-Yu Tsai <wens@csie.org>,
 Rob Herring <robh+dt@kernel.org>, Daniel Vetter <daniel@ffwll.ch>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 linux-amarula@amarulasolutions.com, linux-clk <linux-clk@vger.kernel.org>,
 linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Fri, Feb 1, 2019 at 8:01 PM Maxime Ripard <maxime.ripard@bootlin.com> wrote:
>
> On Tue, Jan 29, 2019 at 11:01:31PM +0530, Jagan Teki wrote:
> > On Tue, Jan 29, 2019 at 8:43 PM Maxime Ripard <maxime.ripard@bootlin.com> wrote:
> > >
> > > On Mon, Jan 28, 2019 at 03:06:10PM +0530, Jagan Teki wrote:
> > > > On Sat, Jan 26, 2019 at 2:54 AM Maxime Ripard <maxime.ripard@bootlin.com> wrote:
> > > > >
> > > > > On Fri, Jan 25, 2019 at 01:28:49AM +0530, Jagan Teki wrote:
> > > > > > Minimum PLL used for MIPI is 500MHz, as per manual, but
> > > > > > lowering the min rate by 300MHz can result proper working
> > > > > > nkms divider with the help of desired dclock rate from
> > > > > > panel driver.
> > > > > >
> > > > > > Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
> > > > > > Acked-by: Stephen Boyd <sboyd@kernel.org>
> > > > >
> > > > > Going 200MHz below the minimum doesn't seem really reasonable. What
> > > > > is the issue that you are trying to fix here?
> > > > >
> > > > > It looks like it's picking bad dividers, but if that's the case, this
> > > > > isn't the proper fix.
> > > >
> > > > As I stated in earlier patches, the whole idea is pick the desired
> > > > dclk divider based dclk rate. So the dotclock, sun4i_dclk_round_rate
> > > > is unable to get the proper dclk divider at the end, so it eventually
> > > > picking up wrong divider value and fired vblank timeout.
> > > >
> > > > So, we come-up with optimal and working min_rate 300MHz in pll-mipi to
> > > > get the desired clock something like below.
> > > > [    2.415773] [drm] No driver support for vblank timestamp query.
> > > > [    2.424116] sun4i_dclk_round_rate: min_div = 4 max_div = 127, rate = 55000000
> > > > [    2.424172] ideal = 220000000, rounded = 0
> > > > [    2.424176] ideal = 275000000, rounded = 0
> > > > [    2.424194] ccu_nkm_round_rate: rate = 330000000
> > > > [    2.424197] ideal = 330000000, rounded = 330000000
> > > > [    2.424201] sun4i_dclk_round_rate: div = 6 rate = 55000000
> > > > [    2.424205] sun4i_dclk_round_rate: min_div = 4 max_div = 127, rate = 55000000
> > > > [    2.424209] ideal = 220000000, rounded = 0
> > > > [    2.424213] ideal = 275000000, rounded = 0
> > > > [    2.424230] ccu_nkm_round_rate: rate = 330000000
> > > > [    2.424233] ideal = 330000000, rounded = 330000000
> > > > [    2.424236] sun4i_dclk_round_rate: div = 6 rate = 55000000
> > > > [    2.424253] ccu_nkm_round_rate: rate = 330000000
> > > > [    2.424270] ccu_nkm_round_rate: rate = 330000000
> > > > [    2.424278] sun4i_dclk_recalc_rate: val = 1, rate = 330000000
> > > > [    2.424281] sun4i_dclk_recalc_rate: val = 1, rate = 330000000
> > > > [    2.424306] ccu_nkm_set_rate: rate = 330000000, parent_rate = 297000000
> > > > [    2.424309] ccu_nkm_set_rate: _nkm.n = 5
> > > > [    2.424311] ccu_nkm_set_rate: _nkm.k = 2
> > > > [    2.424313] ccu_nkm_set_rate: _nkm.m = 9
> > > > [    2.424661] sun4i_dclk_set_rate div 6
> > > > [    2.424668] sun4i_dclk_recalc_rate: val = 6, rate = 55000000
> > > >
> > > > But look like this wouldn't valid for all other dclock rates, say BPI
> > > > panel has 30MHz clock that would failed with this logic.
> > > >
> > > > On the other side Allwinner BSP calculating dclk divider based on the
> > > > SoC's. for A33 [1] it is fixed dclk divider of 4 and for A64 is is
> > > > calculated based on the bpp/lanes.
> > >
> > > It looks like the A64 has the same divider of 4:
> > > https://github.com/BPI-SINOVOIP/BPI-M64-bsp/blob/master/linux-sunxi/drivers/video/sunxi/disp2/disp/de/lowlevel_sun50iw1/de_dsi.c#L12
> > >
> > > I think you're confusing it with the ratio between the pixel clock and
> > > the dotclock, called dsi_div:
> > > https://github.com/BPI-SINOVOIP/BPI-M64-bsp/blob/master/linux-sunxi/drivers/video/sunxi/disp2/disp/de/lowlevel_sun50iw1/disp_al.c#L198
> >
> > Ahh.. I thought this initially but as far as DSI clock computation is
> > concern, the L12 tcon_div is local variable which is used for edge0
> > computation in burst mode and not for the dsi clock computation. Since
> > the BSP is unable to get the tcon_div during edge0 computation, they
> > defined it locally I think.
> >
> > You can see the lcd_clk_config() code [2], where we can see DSI clock
> > computation using dsi_div value.
> >
> > Here is dump after the in Line 792 which is after computation[3]
> > [   10.800737] lcd_clk_config: dsi_div = 6, tcon_div = 4, lcd_div = 1
> > [   10.800743] lcd_clk_config: lcd_dclk_freq = 55, dclk_rate = 55000000
> > [   10.800749] lcd_clk_config: lcd_rate = 330000000, pll_rate = 330000000
> >
> > The above dump the lcd_rate 330MHz is computed with panel clock, 55MHz
> > into dsi_div 6. So this can be our actual divider values dclk_min_div,
> > dclk_max_div in sun4i_dclk_round_rate (from
> > drivers/gpu/drm/sun4i/sun4i_dotclock.c)
>
> I wish it was in your commit log in the first place, instead of having
> to exchange multiple mails over this.
>
> However, I don't think that's quite true, and it might be a bug in
> Allwinner's implementation (or rather something quite confusing).
>
> You're right that the lcd_rate and pll_rate seem to be generated from
> the pixel clock, and it indeed looks like the ratio between the pixel
> clock and the TCON dotclock is defined through the number of bits per
> lanes.
>
> However, in this case, dsi_rate is actually the same than lcd_rate,
> since pll_rate is going to be divided by dsi_div:
> https://github.com/BPI-SINOVOIP/BPI-M64-bsp/blob/master/linux-sunxi/drivers/video/sunxi/disp2/disp/de/disp_lcd.c#L791
>
> Since lcd_div is 1, it also means that in this case, dsi_rate ==
> dclk_rate.

Yes, but the lcd_rate and dsi_rate are not same, since dsi_rate is
again computed as dsi_div with pll_rate.

lcd_rate = dclk_rate * 6;
pll_rate = lcd_rate * 1;
dsi_rate = pll_rate / 6;

[   14.719981] tcon_div = 4, lcd_div = 1, dsi_div = 6, dsi_rate = 148500000
[   14.722666] dsi_div = 6, lcd_div = 1
[   14.722695] [DISP]disp_module_init finish
[   14.727699] lcd_rate = 180000000, pll_rate = 180000000
[   14.730269] dsi_rate = 30000000

> The DSI module clock however, is always set to 148.5 MHz. Indeed, if
> we look at:
> https://github.com/BPI-SINOVOIP/BPI-M64-bsp/blob/master/linux-sunxi/drivers/video/sunxi/disp2/disp/de/disp_lcd.c#L804
>
> We can see that the rate in clk_info is used if it's different than
> 0. This is filled by disp_al_lcd_get_clk_info, which, in the case of a
> DSI panel, will hardcode it to 148.5 MHz:
> https://github.com/BPI-SINOVOIP/BPI-M64-bsp/blob/master/linux-sunxi/drivers/video/sunxi/disp2/disp/de/lowlevel_sun50iw1/disp_al.c#L164
>
> So, the DSI clock is set to this here:
> https://github.com/BPI-SINOVOIP/BPI-M64-bsp/blob/master/linux-sunxi/drivers/video/sunxi/disp2/disp/de/disp_lcd.c#L805
>
> The TCON *module* clock (the one in the clock controller) has been set
> to lcd_rate (so the pixel clock times the number of bits per lane) here:
> https://github.com/BPI-SINOVOIP/BPI-M64-bsp/blob/master/linux-sunxi/drivers/video/sunxi/disp2/disp/de/disp_lcd.c#L800
>
> And the PLL has been set to the same rate here:
> https://github.com/BPI-SINOVOIP/BPI-M64-bsp/blob/master/linux-sunxi/drivers/video/sunxi/disp2/disp/de/disp_lcd.c#L794
>
> Let's take a step back now: that function we were looking at,
> lcd_clk_config, is called by lcd_clk_enable, which is in turn called
> by disp_lcd_enable here:
> https://github.com/BPI-SINOVOIP/BPI-M64-bsp/blob/master/linux-sunxi/drivers/video/sunxi/disp2/disp/de/disp_lcd.c#L1328
>
> The next function being called is disp_al_lcd_cfg, and that function
> will hardcode the TCON dotclock divider to 4, here:
> https://github.com/BPI-SINOVOIP/BPI-M64-bsp/blob/master/linux-sunxi/drivers/video/sunxi/disp2/disp/de/lowlevel_sun50iw1/disp_al.c#L240

Haa.. this is reason I have TCON_DCLK register value is 4 in BSP
# devmem 0x01c0c044
0xF0000004

> So, in the end, the dotclock divider is always 4, the DSI module clock
> is set to 148.5 MHz, and the TCON module clock is set to 330MHz. Since
> the TCON module clock doesn't have a divider, the PLL is set at that
> same value but this is redundant.

330 or 180MHz. if we have pixel clock 30MHz with 6 div value it's 180MHz.

>
> I'll experiment with this and try to see how it works on the A33.

OK, thanks. will try digging further on this from my side as well.

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
