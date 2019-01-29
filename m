Return-Path: <SRS0=P47x=QF=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CF00C169C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 17:31:58 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2F1A921473
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 17:31:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="H1SFirnM";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="Rs0akdsm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2F1A921473
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=IXFwHiHi1blh8pG3NZEDIr9HXq9+7i+lpEfIdQkRgrY=; b=H1SFirnM3Jeptp
	fns26WvIi3HFYtC3PrV7HXmHkzSNb9fi2Rhilmjza/PMk+e+8XcFGyRZfTog25M/1iI9N57yRv/9N
	yH1ttzEuRZhUVS2ZHvO91erk4MCs+9EnEkSfrj1oMllfETtGjPMtC3T5TE6Zc2wQ3q0/NpeCDOwu7
	dHa11xfguxDKS5G8vO88t0QozaS1ZhIXDkvkdiXFVWQsof4nPNfmD9pgpRAje48tHeejw6gzg/EKL
	duT8HUt/fPa/hA0TXix6T238P0BGTw8RLBylu1T+9iK6PmQ4aqwNJyQ2LK5IxcjZkwvCDICHW4wGT
	Nntdws3/gKxdqfbjHzVQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1goXEj-00055E-A1; Tue, 29 Jan 2019 17:31:49 +0000
Received: from mail-io1-xd41.google.com ([2607:f8b0:4864:20::d41])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1goXEe-00054Q-Pf
 for linux-arm-kernel@lists.infradead.org; Tue, 29 Jan 2019 17:31:47 +0000
Received: by mail-io1-xd41.google.com with SMTP id s22so16995825ioc.8
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 29 Jan 2019 09:31:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=bZh0qe15JVYEhdxehVf2IVz+a7AcDGhW0+jvnJqPk1M=;
 b=Rs0akdsmCMlEPTq9WHuH9kawCWMxee51GSzmmGmU8FOmCVbDxXNWzqQ4/lvjJ4UgM3
 9X+tFjCjaUTsp/4QhemzdFHHc08nRBAKIBHB1pPRaAuvqh/IMxcQ528J7DMaAoXwM8hR
 I2cr0BixknbZGOGPp+Z1sm8mre+8o4DaWo4xY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=bZh0qe15JVYEhdxehVf2IVz+a7AcDGhW0+jvnJqPk1M=;
 b=hukGXNesGYFvow6yshifKhIqSXNQ0l1cBVEZ3q+juECe6LtwliSCXafoVxcqEF4Fcg
 X/ZLWbI7Q3gnTxFPU5ml010cle77BGzve3BD/Tj0ZHqGlQ2VEhSzEspCa7mRlzZCj7dn
 c/9+HgaI/Rtcr2lnmFT6+mEEEwB1OxCq3YUU4IfMgMist/nABaO9Fx6dNb7DJ/W7wyGs
 cslWuiWdfmHtvAHwFFxiK0XT1VTTIo5So0O5OzM1kTIMmhb/qSl6JD7RuwLJRCwmTpez
 puiOA+9tJ+FqwzA+QZqRSOE+n3eQZZhFvx8hfdI/fXefguh2zd/t78382OlL8Ebmqt2S
 kvJA==
X-Gm-Message-State: AHQUAuZ5iedfOqEBe+ubPlufgVHWIBnyJYKV08V6+YqlUiJfMOh1qFoT
 muon5Aa2UTw0tvZ4ufayAdFtaM+sAYRNFuMLmAYMWg==
X-Google-Smtp-Source: AHgI3Ib6SZoISxrxWS5TsELBm2UfiVTshEipN4cOitSRdbmF6PAKVZDU+9CpAudCOkW2jLTPXxyLRJUpoZ+hjj+k3yE=
X-Received: by 2002:a6b:7a0a:: with SMTP id h10mr2413852iom.114.1548783103321; 
 Tue, 29 Jan 2019 09:31:43 -0800 (PST)
MIME-Version: 1.0
References: <20190124195900.22620-1-jagan@amarulasolutions.com>
 <20190124195900.22620-12-jagan@amarulasolutions.com>
 <20190125212433.ni2jg3wvpyjazlxf@flea>
 <CAMty3ZAsH2iZ+JEqTE3D58aXfGuhMSg9YoO56ZhhOeE4c4yQHQ@mail.gmail.com>
 <20190129151348.mh27btttsqcmeban@flea>
In-Reply-To: <20190129151348.mh27btttsqcmeban@flea>
From: Jagan Teki <jagan@amarulasolutions.com>
Date: Tue, 29 Jan 2019 23:01:31 +0530
Message-ID: <CAMty3ZAjAoti8Zu80c=OyCA+u-jtQnkidsKSNz_c2OaRswqc3w@mail.gmail.com>
Subject: Re: [PATCH v6 11/22] clk: sunxi-ng: a64: Add minimum rate for PLL_MIPI
To: Maxime Ripard <maxime.ripard@bootlin.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190129_093145_335142_5F0AF37C 
X-CRM114-Status: GOOD (  23.80  )
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

On Tue, Jan 29, 2019 at 8:43 PM Maxime Ripard <maxime.ripard@bootlin.com> wrote:
>
> On Mon, Jan 28, 2019 at 03:06:10PM +0530, Jagan Teki wrote:
> > On Sat, Jan 26, 2019 at 2:54 AM Maxime Ripard <maxime.ripard@bootlin.com> wrote:
> > >
> > > On Fri, Jan 25, 2019 at 01:28:49AM +0530, Jagan Teki wrote:
> > > > Minimum PLL used for MIPI is 500MHz, as per manual, but
> > > > lowering the min rate by 300MHz can result proper working
> > > > nkms divider with the help of desired dclock rate from
> > > > panel driver.
> > > >
> > > > Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
> > > > Acked-by: Stephen Boyd <sboyd@kernel.org>
> > >
> > > Going 200MHz below the minimum doesn't seem really reasonable. What
> > > is the issue that you are trying to fix here?
> > >
> > > It looks like it's picking bad dividers, but if that's the case, this
> > > isn't the proper fix.
> >
> > As I stated in earlier patches, the whole idea is pick the desired
> > dclk divider based dclk rate. So the dotclock, sun4i_dclk_round_rate
> > is unable to get the proper dclk divider at the end, so it eventually
> > picking up wrong divider value and fired vblank timeout.
> >
> > So, we come-up with optimal and working min_rate 300MHz in pll-mipi to
> > get the desired clock something like below.
> > [    2.415773] [drm] No driver support for vblank timestamp query.
> > [    2.424116] sun4i_dclk_round_rate: min_div = 4 max_div = 127, rate = 55000000
> > [    2.424172] ideal = 220000000, rounded = 0
> > [    2.424176] ideal = 275000000, rounded = 0
> > [    2.424194] ccu_nkm_round_rate: rate = 330000000
> > [    2.424197] ideal = 330000000, rounded = 330000000
> > [    2.424201] sun4i_dclk_round_rate: div = 6 rate = 55000000
> > [    2.424205] sun4i_dclk_round_rate: min_div = 4 max_div = 127, rate = 55000000
> > [    2.424209] ideal = 220000000, rounded = 0
> > [    2.424213] ideal = 275000000, rounded = 0
> > [    2.424230] ccu_nkm_round_rate: rate = 330000000
> > [    2.424233] ideal = 330000000, rounded = 330000000
> > [    2.424236] sun4i_dclk_round_rate: div = 6 rate = 55000000
> > [    2.424253] ccu_nkm_round_rate: rate = 330000000
> > [    2.424270] ccu_nkm_round_rate: rate = 330000000
> > [    2.424278] sun4i_dclk_recalc_rate: val = 1, rate = 330000000
> > [    2.424281] sun4i_dclk_recalc_rate: val = 1, rate = 330000000
> > [    2.424306] ccu_nkm_set_rate: rate = 330000000, parent_rate = 297000000
> > [    2.424309] ccu_nkm_set_rate: _nkm.n = 5
> > [    2.424311] ccu_nkm_set_rate: _nkm.k = 2
> > [    2.424313] ccu_nkm_set_rate: _nkm.m = 9
> > [    2.424661] sun4i_dclk_set_rate div 6
> > [    2.424668] sun4i_dclk_recalc_rate: val = 6, rate = 55000000
> >
> > But look like this wouldn't valid for all other dclock rates, say BPI
> > panel has 30MHz clock that would failed with this logic.
> >
> > On the other side Allwinner BSP calculating dclk divider based on the
> > SoC's. for A33 [1] it is fixed dclk divider of 4 and for A64 is is
> > calculated based on the bpp/lanes.
>
> It looks like the A64 has the same divider of 4:
> https://github.com/BPI-SINOVOIP/BPI-M64-bsp/blob/master/linux-sunxi/drivers/video/sunxi/disp2/disp/de/lowlevel_sun50iw1/de_dsi.c#L12
>
> I think you're confusing it with the ratio between the pixel clock and
> the dotclock, called dsi_div:
> https://github.com/BPI-SINOVOIP/BPI-M64-bsp/blob/master/linux-sunxi/drivers/video/sunxi/disp2/disp/de/lowlevel_sun50iw1/disp_al.c#L198

Ahh.. I thought this initially but as far as DSI clock computation is
concern, the L12 tcon_div is local variable which is used for edge0
computation in burst mode and not for the dsi clock computation. Since
the BSP is unable to get the tcon_div during edge0 computation, they
defined it locally I think.

You can see the lcd_clk_config() code [2], where we can see DSI clock
computation using dsi_div value.

Here is dump after the in Line 792 which is after computation[3]
[   10.800737] lcd_clk_config: dsi_div = 6, tcon_div = 4, lcd_div = 1
[   10.800743] lcd_clk_config: lcd_dclk_freq = 55, dclk_rate = 55000000
[   10.800749] lcd_clk_config: lcd_rate = 330000000, pll_rate = 330000000

The above dump the lcd_rate 330MHz is computed with panel clock, 55MHz
into dsi_div 6. So this can be our actual divider values dclk_min_div,
dclk_max_div in sun4i_dclk_round_rate (from
drivers/gpu/drm/sun4i/sun4i_dotclock.c)

We can even confirm this from Mainline code:
[    1.866128] sun4i_dclk_round_rate: min_div = 6 max_div = 6, rate = 55000000
[    1.873112] round_rate, parent = 330000000
[    1.877351] round_rate, rate = 330000000
[    1.881338] ideal = 330000000, rounded = 330000000, div = 6
[    1.887232] sun4i_dclk_round_rate: div = 6 rate = 55000000
[    1.887239] sun4i_dclk_round_rate: min_div = 6 max_div = 6, rate = 55000000
[    1.887243] round_rate, parent = 330000000
[    1.887259] round_rate, rate = 330000000
[    1.887264] ideal = 330000000, rounded = 330000000, div = 6
[    1.887267] sun4i_dclk_round_rate: div = 6 rate = 55000000
[    1.887270] round_rate, parent = 330000000
[    1.887286] round_rate, rate = 330000000
[    1.887292] round_rate, parent = 330000000
[    1.887307] round_rate, rate = 330000000
[    1.887320] sun4i_dclk_recalc_rate: val = 1, rate = 330000000
[    1.887324] sun4i_dclk_recalc_rate: val = 1, rate = 330000000
[    1.887350] rate = 330000000
[    1.887353] parent_rate = 297000000
[    1.887355] reg = 0x80c00000
[    1.887359] _nkm.n = 5, nkm->n.offset = 0x1, nkm->n.shift = 8
[    1.887362] _nkm.k = 2, nkm->k.offset = 0x1, nkm->k.shift = 4
[    1.887365] _nkm.m = 9, nkm->m.offset = 0x1, nkm->m.shift = 0
[    1.887712] sun4i_dclk_set_rate div 6
[    1.887720] sun4i_dclk_recalc_rate: val = 6, rate = 55000000

So, the dsi_div from AW BSP is our dclk_mini_div(and dclk_max_div) and
that can be computed as format/lanes in A64.

Hope this explaining clears the diff, let me know if I miss anything.

[2] https://github.com/BPI-SINOVOIP/BPI-M64-bsp/blob/master/linux-sunxi/drivers/video/sunxi/disp2/disp/de/disp_lcd.c#L781
[3] https://github.com/BPI-SINOVOIP/BPI-M64-bsp/blob/master/linux-sunxi/drivers/video/sunxi/disp2/disp/de/disp_lcd.c#L792

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
