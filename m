Return-Path: <SRS0=rVA4=OU=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.9 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAB00C6783B
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 22:21:06 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BA5082084C
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 22:21:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Zh9uAItb";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="dCZeUkrm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BA5082084C
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=aLWO+j7MPsFzn/jpUOhoE2S5/Frn9B10kNQgXieLSB0=; b=Zh9uAItbHwec/R
	2dbjSWZ4y79tURyciA98oMjB0e2NZvZQQlPdrvkHs3dSZxF8NI+tGp3zo7ZCa/FGq08kmL/5/oVX9
	gY3RJBgYTWjJS5y9JXSuK8zAMRxKym9NLRmFjkMC10EHGQa3U3JWzqwWjC9LI1OJrTHM+cx76p6qA
	/qVxKgrRysX4k2oqJPXIk0qCPdvTZszeO1vu3UVH1hiAvy33zKPG9DqOVlJb20f8AJIRVhasKumfS
	dyze+zBtczDz1gaYbp5VbvgXK3XzWxWxq72pPcgk1NNn3VIvdgbjGRLGylp6gPR8956QdCa57Pq8z
	tpLbnFY7CTAT0Xq6TiCA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gWqOm-00061D-L3; Tue, 11 Dec 2018 22:21:04 +0000
Received: from mail-ot1-x342.google.com ([2607:f8b0:4864:20::342])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gWqOh-0005zz-3j; Tue, 11 Dec 2018 22:21:01 +0000
Received: by mail-ot1-x342.google.com with SMTP id s5so15684338oth.7;
 Tue, 11 Dec 2018 14:20:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=googlemail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=P9a11awUfFqdRCRlsiMdMfxUKo4+WuSnI5J0mWUVE0I=;
 b=dCZeUkrmfE5hCPFIEfLxextyNAFYumyrItKcLIm/6AXacSIqyjD8miZ5nCYdL5fTpN
 51F43RoQIUIIJqVWMHV5pZcC+7h0M+vQFHwFaGlIPkbuXUFwVPIhcNiDWvAShVLqawze
 6fo0vYlzQzdSBshO/lvo/SkXCW80ueWG58CbS3OHNpWcMQSCEgjZyz29yCyBY2fJ3TUA
 x5rWXDe/ZOuIDnAxdg9TVZ9ml4/lQXVdkd2WCex+RLcQ6e/3D5SNYL80TZYLzdTbnRkq
 5HOYtsthu8POJeh1qDQgKChgE/44jJ8A4W67P3k+/sOdHvB7DENuGS7qgG4KOsE0GL+d
 ZdbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=P9a11awUfFqdRCRlsiMdMfxUKo4+WuSnI5J0mWUVE0I=;
 b=Wyhd7YC30rqFtADP+WYrzq07PbasstQHhKr7+XV9g8NWYALcL528KAf2g04ZbLOYs4
 W9kuAYVMo9b4U0AVWruejH80chIuLwqURdxoYhL0KszPa3FHfmxn7aywZLplgjBueyI1
 NFzgGjeF9QUpJCLhabR7CJUqUnROpgPaLKCVQiEW0W6BUaiSXuVuU39T33jE1GJK1G9a
 pwfoZ+VF4/Pd1d+AXxZK+4BT4A9/fY0QnrxLsKxzkGZe++QhiyFcpwRmgmTMj031Ks4m
 1bdImAZK0+28yL74xX3cbqjWsYVCGz/jrZkCg2i4HaJnAZOzNwOtosLLF8C7RKUexsA3
 ReNw==
X-Gm-Message-State: AA+aEWZoa1znFFUscMHsqY4Y5fQ/FCDNj+WAz1RjndCjzkJrAPlAxbnS
 G9spTEG/pDxKb63Tk8g7WYAaU5VQ3hjfU7lh1JY=
X-Google-Smtp-Source: AFSGD/UlGbcwYWT5VWH3PcFpAjNgEObsSZ4VLLCE5Bpl12tJ4bYs0UfGyIQmlSa7JC9L5dGa1b6UkPXvYF4XSsDkDII=
X-Received: by 2002:a9d:715d:: with SMTP id y29mr13001891otj.148.1544566848196; 
 Tue, 11 Dec 2018 14:20:48 -0800 (PST)
MIME-Version: 1.0
References: <20181208171247.22238-1-martin.blumenstingl@googlemail.com>
 <20181208171247.22238-4-martin.blumenstingl@googlemail.com>
 <7345cb90-b63d-5461-d97c-89ef563dc421@baylibre.com>
In-Reply-To: <7345cb90-b63d-5461-d97c-89ef563dc421@baylibre.com>
From: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date: Tue, 11 Dec 2018 23:20:36 +0100
Message-ID: <CAFBinCABGbMu--+dr68CHoTcbis-TsUE3sA8QHhQofgv3eJs5w@mail.gmail.com>
Subject: Re: [PATCH 3/5] clk: meson: meson8b: add the GPU clock tree
To: Neil Armstrong <narmstrong@baylibre.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181211_142059_160263_6AB736AE 
X-CRM114-Status: GOOD (  25.94  )
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
Cc: devicetree@vger.kernel.org, sboyd@kernel.org, khilman@baylibre.com,
 mturquette@baylibre.com, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, robh+dt@kernel.org,
 linux-amlogic@lists.infradead.org, linux-clk@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, jbrunet@baylibre.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi Neil,

On Tue, Dec 11, 2018 at 10:21 AM Neil Armstrong <narmstrong@baylibre.com> wrote:
>
> On 08/12/2018 18:12, Martin Blumenstingl wrote:
> > Add the GPU clock tree on Meson8, Meson8b and Meson8m2.
> >
> > The GPU clock tree on Meson8b and Meson8m2 is almost identical to the
> > one one GXBB:
> > - there's a glitch-free mux at HHI_MALI_CLK_CNTL[31]
> > - there are two identical parents for this mux: mali_0 and mali_1, each
> >   with a gate, divider and mux
> > - the parents of mali_0_sel and mali_1_sel are identical to GXBB except
> >   there's no GP0_PLL on these 32-bit SoCs
> >
> > Meson8 is different because it does not have the glitch-free mux.
> > Instead if only has the mali_0 clock tree. The parents of mali_0_sel are
> > identical to the ones on Meson8b and Meson8m2.
> >
> > Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
> > ---
> >  drivers/clk/meson/meson8b.c | 146 ++++++++++++++++++++++++++++++++++++
> >  drivers/clk/meson/meson8b.h |   9 ++-
> >  2 files changed, 154 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/clk/meson/meson8b.c b/drivers/clk/meson/meson8b.c
> > index 0b9353d8d4fd..748552c5f6c8 100644
> > --- a/drivers/clk/meson/meson8b.c
> > +++ b/drivers/clk/meson/meson8b.c
> > @@ -1573,6 +1573,135 @@ static struct clk_regmap meson8b_hdmi_sys = {
> >       },
> >  };
> >
> > +/*
> > + * The MALI IP is clocked by two identical clocks (mali_0 and mali_1)
> > + * muxed by a glitch-free switch on Meson8b and Meson8m2. Meson8 only
> > + * has mali_0 and no glitch-free mux.
> > + */
> > +static const char * const meson8b_mali_0_1_parent_names[] = {
> > +     "xtal", "mpll2", "mpll1", "fclk_div7", "fclk_div4", "fclk_div3",
> > +     "fclk_div5"
> > +};
> > +
> > +static u32 meson8b_mali_0_1_mux_table[] = { 0, 2, 3, 4, 5, 6, 7 };
> > +
> > +static struct clk_regmap meson8b_mali_0_sel = {
> > +     .data = &(struct clk_regmap_mux_data){
> > +             .offset = HHI_MALI_CLK_CNTL,
> > +             .mask = 0x7,
> > +             .shift = 9,
> > +             .table = meson8b_mali_0_1_mux_table,
> > +     },
> > +     .hw.init = &(struct clk_init_data){
> > +             .name = "mali_0_sel",
> > +             .ops = &clk_regmap_mux_ops,
> > +             .parent_names = meson8b_mali_0_1_parent_names,
> > +             .num_parents = ARRAY_SIZE(meson8b_mali_0_1_parent_names),
> > +             /*
> > +              * Don't propagate rate changes up because the only changeable
> > +              * parents are mpll1 and mpll2 but we need those for audio and
> > +              * RGMII (Ethernet). We don't want to change the audio or
> > +              * Ethernet clocks when setting the GPU frequency.
> > +              */
> > +             .flags = 0,
> > +     },
> > +};
> > +
> > +static struct clk_regmap meson8b_mali_0_div = {
> > +     .data = &(struct clk_regmap_div_data){
> > +             .offset = HHI_MALI_CLK_CNTL,
> > +             .shift = 0,
> > +             .width = 7,
> > +     },
> > +     .hw.init = &(struct clk_init_data){
> > +             .name = "mali_0_div",
> > +             .ops = &clk_regmap_divider_ops,
> > +             .parent_names = (const char *[]){ "mali_0_sel" },
> > +             .num_parents = 1,
> > +             .flags = CLK_SET_RATE_PARENT,
> > +     },
> > +};
> > +
> > +static struct clk_regmap meson8b_mali_0 = {
> > +     .data = &(struct clk_regmap_gate_data){
> > +             .offset = HHI_MALI_CLK_CNTL,
> > +             .bit_idx = 8,
> > +     },
> > +     .hw.init = &(struct clk_init_data){
> > +             .name = "mali_0",
> > +             .ops = &clk_regmap_gate_ops,
> > +             .parent_names = (const char *[]){ "mali_0_div" },
> > +             .num_parents = 1,
> > +             .flags = CLK_SET_RATE_PARENT,
> > +     },
> > +};
> > +
> > +static struct clk_regmap meson8b_mali_1_sel = {
> > +     .data = &(struct clk_regmap_mux_data){
> > +             .offset = HHI_MALI_CLK_CNTL,
> > +             .mask = 0x7,
> > +             .shift = 25,
> > +             .table = meson8b_mali_0_1_mux_table,
> > +     },
> > +     .hw.init = &(struct clk_init_data){
> > +             .name = "mali_1_sel",
> > +             .ops = &clk_regmap_mux_ops,
> > +             .parent_names = meson8b_mali_0_1_parent_names,
> > +             .num_parents = ARRAY_SIZE(meson8b_mali_0_1_parent_names),
> > +             /*
> > +              * Don't propagate rate changes up because the only changeable
> > +              * parents are mpll1 and mpll2 but we need those for audio and
> > +              * RGMII (Ethernet). We don't want to change the audio or
> > +              * Ethernet clocks when setting the GPU frequency.
> > +              */
> > +             .flags = 0,
> > +     },
> > +};
> > +
> > +static struct clk_regmap meson8b_mali_1_div = {
> > +     .data = &(struct clk_regmap_div_data){
> > +             .offset = HHI_MALI_CLK_CNTL,
> > +             .shift = 16,
> > +             .width = 7,
> > +     },
> > +     .hw.init = &(struct clk_init_data){
> > +             .name = "mali_1_div",
> > +             .ops = &clk_regmap_divider_ops,
> > +             .parent_names = (const char *[]){ "mali_1_sel" },
> > +             .num_parents = 1,
> > +             .flags = CLK_SET_RATE_PARENT,
> > +     },
> > +};
> > +
> > +static struct clk_regmap meson8b_mali_1 = {
> > +     .data = &(struct clk_regmap_gate_data){
> > +             .offset = HHI_MALI_CLK_CNTL,
> > +             .bit_idx = 24,
> > +     },
> > +     .hw.init = &(struct clk_init_data){
> > +             .name = "mali_1",
> > +             .ops = &clk_regmap_gate_ops,
> > +             .parent_names = (const char *[]){ "mali_1_div" },
> > +             .num_parents = 1,
> > +             .flags = CLK_SET_RATE_PARENT,
> > +     },
> > +};
> > +
> > +static struct clk_regmap meson8b_mali = {
> > +     .data = &(struct clk_regmap_mux_data){
> > +             .offset = HHI_MALI_CLK_CNTL,
> > +             .mask = 1,
> > +             .shift = 31,
> > +     },
> > +     .hw.init = &(struct clk_init_data){
> > +             .name = "mali",
> > +             .ops = &clk_regmap_mux_ops,
> > +             .parent_names = (const char *[]){ "mali_0", "mali_1" },
> > +             .num_parents = 2,
> > +             .flags = CLK_SET_RATE_PARENT,
> > +     },
> > +};
> > +
> >  /* Everything Else (EE) domain gates */
> >
> >  static MESON_GATE(meson8b_ddr, HHI_GCLK_MPEG0, 0);
> > @@ -1833,6 +1962,9 @@ static struct clk_hw_onecell_data meson8_hw_onecell_data = {
> >               [CLKID_HDMI_SYS_SEL]        = &meson8b_hdmi_sys_sel.hw,
> >               [CLKID_HDMI_SYS_DIV]        = &meson8b_hdmi_sys_div.hw,
> >               [CLKID_HDMI_SYS]            = &meson8b_hdmi_sys.hw,
> > +             [CLKID_MALI_0_SEL]          = &meson8b_mali_0_sel.hw,
> > +             [CLKID_MALI_0_DIV]          = &meson8b_mali_0_div.hw,
> > +             [CLKID_MALI]                = &meson8b_mali_0.hw,
> >               [CLK_NR_CLKS]               = NULL,
> >       },
> >       .num = CLK_NR_CLKS,
> > @@ -2012,6 +2144,13 @@ static struct clk_hw_onecell_data meson8b_hw_onecell_data = {
> >               [CLKID_HDMI_SYS_SEL]        = &meson8b_hdmi_sys_sel.hw,
> >               [CLKID_HDMI_SYS_DIV]        = &meson8b_hdmi_sys_div.hw,
> >               [CLKID_HDMI_SYS]            = &meson8b_hdmi_sys.hw,
> > +             [CLKID_MALI_0_SEL]          = &meson8b_mali_0_sel.hw,
> > +             [CLKID_MALI_0_DIV]          = &meson8b_mali_0_div.hw,
> > +             [CLKID_MALI_0]              = &meson8b_mali_0.hw,
> > +             [CLKID_MALI_1_SEL]          = &meson8b_mali_1_sel.hw,
> > +             [CLKID_MALI_1_DIV]          = &meson8b_mali_1_div.hw,
> > +             [CLKID_MALI_1]              = &meson8b_mali_1.hw,
> > +             [CLKID_MALI]                = &meson8b_mali.hw,
> >               [CLK_NR_CLKS]               = NULL,
> >       },
> >       .num = CLK_NR_CLKS,
> > @@ -2167,6 +2306,13 @@ static struct clk_regmap *const meson8b_clk_regmaps[] = {
> >       &meson8b_hdmi_sys_sel,
> >       &meson8b_hdmi_sys_div,
> >       &meson8b_hdmi_sys,
> > +     &meson8b_mali_0_sel,
> > +     &meson8b_mali_0_div,
> > +     &meson8b_mali_0,
> > +     &meson8b_mali_1_sel,
> > +     &meson8b_mali_1_div,
> > +     &meson8b_mali_1,
> > +     &meson8b_mali,
> >  };
> >
> >  static const struct meson8b_clk_reset_line {
> > diff --git a/drivers/clk/meson/meson8b.h b/drivers/clk/meson/meson8b.h
> > index 87fba739af81..f212e2304ff5 100644
> > --- a/drivers/clk/meson/meson8b.h
> > +++ b/drivers/clk/meson/meson8b.h
> > @@ -33,6 +33,7 @@
> >  #define HHI_VID_CLK_CNTL2            0x194 /* 0x65 offset in data sheet */
> >  #define HHI_VID_DIVIDER_CNTL         0x198 /* 0x66 offset in data sheet */
> >  #define HHI_SYS_CPU_CLK_CNTL0                0x19c /* 0x67 offset in data sheet */
> > +#define HHI_MALI_CLK_CNTL            0x1b0 /* 0x6c offset in data sheet */
> >  #define HHI_HDMI_CLK_CNTL            0x1cc /* 0x73 offset in data sheet */
> >  #define HHI_NAND_CLK_CNTL            0x25c /* 0x97 offset in data sheet */
> >  #define HHI_MPLL_CNTL                        0x280 /* 0xa0 offset in data sheet */
> > @@ -139,8 +140,14 @@
> >  #define CLKID_HDMI_SYS_SEL   172
> >  #define CLKID_HDMI_SYS_DIV   173
> >  #define CLKID_HDMI_SYS               174
> > +#define CLKID_MALI_0_SEL     175
> > +#define CLKID_MALI_0_DIV     176
> > +#define CLKID_MALI_0         177
> > +#define CLKID_MALI_1_SEL     178
> > +#define CLKID_MALI_1_DIV     179
> > +#define CLKID_MALI_1         180
> >
> > -#define CLK_NR_CLKS          175
> > +#define CLK_NR_CLKS          181
> >
> >  /*
> >   * include the CLKID and RESETID that have
> >
>
> Reviewed-by: Neil Armstrong <narmstrong@baylibre.com>
thank you for reviewing this!

> Changing mali clock for Meson8 will be fun aswell !
> How amlogic does that ? the only change the divider ?
I'm not sure how it works in practice, but the sequence is:
- spin_lock_irqsave (from mali_clock_critical)
- disable the clock
- change the divider and mux
- enable the clock again
- spin_unlock_irqrestore
(this is identical to the glitch-free mux setup except there's an
additional step for changing the mux before disabling the mali_0 clock
and after enabling the mali_0 clock again)

I learned the hard way that we can't access the Mali registers if the
clock is disabled.
so we need to be careful with this. my plan is to check the progress
of the lima driver from time to time - once there's frequency scaling
code I'll test it to see whether it works (or what I have to adjust)


Regards
Martin


[0] https://github.com/endlessm/linux-meson/blob/cd4096c3ff4eb5b8a8a5581bb46508601c5470dc/drivers/amlogic/gpu/mali/platform/mali_clock.c#L54

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
