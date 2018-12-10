Return-Path: <SRS0=/awj=OT=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AA81C67839
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 16:07:52 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 399E72082F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 16:07:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="ZzMqsOoR";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="qZrqOe9i"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 399E72082F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=cVk/QkAfL2Fv6M5CY5GaubROhX3LorE/7SI8buljMvg=; b=ZzMqsOoRR7qf0/
	zCcmwQMQmxhD0hG3ShQqZ9ccizkIj2cwN5nXwiIETudb/DuCbryr3NPLz/PW8Eny1md1n+YkQhRo2
	zFHxhNRvESd0KoZLaVJjjPFGpQNrbJQfUD9xxk3qCI9WVS1gZimJjbCpsSKk118AcoWNDXbF2TIQg
	h7V2cyNxLalsbsjd/3IWvKlRt4fVlQmnSojJB7GfawD4+71cUXAZnF5eGWY/UkaUGopcysdYvp2TA
	UjgYGqjsrY11zw71MfyGiDEVeZBi6Npkgs1/g3UvdzjhryJhYFq67DsVa45jsNXY1qiCkdpFikVPl
	+Yy28e/ll22ZLigrUdzA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gWO62-00031c-Mf; Mon, 10 Dec 2018 16:07:50 +0000
Received: from mail-ot1-x344.google.com ([2607:f8b0:4864:20::344])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gWO5y-00030u-Td
 for linux-arm-kernel@lists.infradead.org; Mon, 10 Dec 2018 16:07:48 +0000
Received: by mail-ot1-x344.google.com with SMTP id v23so10878666otk.9
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 10 Dec 2018 08:07:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=706PBGmkV48/HcbLMZWflsnZr+TVd3yuVsGo/4DR1f8=;
 b=qZrqOe9iym2AL2GkjgW8rRNrL6Lh3xM6Y2S2PhEd30uLK31ZdzOhVYJYW3ZDkrnkJk
 EHNotu5j1Gc4gjAAtwOffzQoV7ShVWggmFvlsydstPAOWrcVFbgFmYiyhgHnB+EBzmkb
 6C5PuH1RS0zu+74H6lG6eYz/k/yYrw7+EHZw0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=706PBGmkV48/HcbLMZWflsnZr+TVd3yuVsGo/4DR1f8=;
 b=G4ipyQuVnkpn2F8UnzHqXlovpBoy6nOZropLQ5nbYvz2adX52Ti6h6xonvGZthYvGB
 kDoX1O7wKPAcqNz7lbbtg1Y9lDYndOOS6YwWYs/IAkn39Wzhx9jecIlkOWPydJEtVOlA
 EuYBwMG0SJtyrUEL2zZuZ/Ww5YPTDSsJqw0Lg9tsTvlBJekFh2bf7u7zc+QfKCCjocIt
 ReZ8JWE7m6isH/CmHT5T5/Y66yFvVwbIZYOhAPDp5c1qt6RW7wATR9Oz4cWobrugrGG/
 4a3OSzmYytPBdOBHYfy/MgV4n/cCP2fivU1fEKtBFPewwo6aRtvOVBP0pM1TUrDMdUWU
 8lnw==
X-Gm-Message-State: AA+aEWanHEf5vnglZbPdxem3Gpuo0P7uULQIWNJScHRIC6Xf7rPmwgFf
 0u3bDLBdpL7I0r6aPwPGB0UXNWELSHuxbyPDieMpOQ==
X-Google-Smtp-Source: AFSGD/V1iqxAWyhgJZlBWmb/eoW6+lrCG3VgAy2gxGkP+QDXODZCCN243GoIeyy0Wj/G1FzHNc0cpRqgubPfto/ZsPg=
X-Received: by 2002:a9d:4682:: with SMTP id z2mr8780542ote.104.1544458055714; 
 Mon, 10 Dec 2018 08:07:35 -0800 (PST)
MIME-Version: 1.0
References: <20181113111633.20189-1-jagan@amarulasolutions.com>
 <20181113111633.20189-9-jagan@amarulasolutions.com>
 <20181115095551.uctdkfmuwlnzhjnn@flea>
 <CAMty3ZAEHiovm6OF6JvJVQR4aqpG1Q3ML5YqxJkF2ntwRkUO=A@mail.gmail.com>
 <20181120155715.andrjp5kg6ugcv72@flea>
 <CAMty3ZCUOJmvekupOwh281g5HaazTpBbukWQY2Pv2OYypAwciw@mail.gmail.com>
 <20181127102450.b65jzhrdpxn5rxmk@flea>
 <CAMty3ZDTvn4VF_oOvEi2jCw9Rw5WPd1LQT3SZ5X1K0fJAFg2cQ@mail.gmail.com>
 <20181207132136.oa4nzpczytzxhl2d@flea>
In-Reply-To: <20181207132136.oa4nzpczytzxhl2d@flea>
From: Jagan Teki <jagan@amarulasolutions.com>
Date: Mon, 10 Dec 2018 21:37:23 +0530
Message-ID: <CAMty3ZB4uSxMETSrGbod54N++rimTmv1jNnCPKCy0PRa2e9WFw@mail.gmail.com>
Subject: Re: [linux-sunxi] Re: [PATCH v4 08/26] drm/sun4i: sun6i_mipi_dsi: Fix
 VBP size calculation
To: Maxime Ripard <maxime.ripard@bootlin.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181210_080746_952088_CD72CEF5 
X-CRM114-Status: GOOD (  28.55  )
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
 devicetree <devicetree@vger.kernel.org>,
 Jernej Skrabec <jernej.skrabec@siol.net>, David Airlie <airlied@linux.ie>,
 Catalin Marinas <catalin.marinas@arm.com>,
 Michael Turquette <mturquette@baylibre.com>,
 linux-sunxi <linux-sunxi@googlegroups.com>, Will Deacon <will.deacon@arm.com>,
 linux-kernel <linux-kernel@vger.kernel.org>,
 dri-devel <dri-devel@lists.freedesktop.org>,
 Vasily Khoruzhick <anarsoul@gmail.com>, Stephen Boyd <sboyd@kernel.org>,
 Chen-Yu Tsai <wens@csie.org>, Rob Herring <robh+dt@kernel.org>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 linux-amarula@amarulasolutions.com, linux-clk <linux-clk@vger.kernel.org>,
 linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
 Icenowy Zheng <icenowy@aosc.io>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Fri, Dec 7, 2018 at 6:51 PM Maxime Ripard <maxime.ripard@bootlin.com> wrote:
>
> On Tue, Nov 27, 2018 at 04:34:35PM +0530, Jagan Teki wrote:
> > On Tue, Nov 27, 2018 at 3:55 PM Maxime Ripard <maxime.ripard@bootlin.com> wrote:
> > >
> > > On Tue, Nov 20, 2018 at 09:55:42PM +0530, Jagan Teki wrote:
> > > > On Tue, Nov 20, 2018 at 9:27 PM Maxime Ripard <maxime.ripard@bootlin.com> wrote:
> > > > >
> > > > > On Thu, Nov 15, 2018 at 11:19:53PM +0530, Jagan Teki wrote:
> > > > > > On Thu, Nov 15, 2018 at 3:26 PM Maxime Ripard <maxime.ripard@bootlin.com> wrote:
> > > > > > >
> > > > > > > Hi,
> > > > > > >
> > > > > > > On Tue, Nov 13, 2018 at 04:46:15PM +0530, Jagan Teki wrote:
> > > > > > > > The horizontal and vertical back porch calculation in BSP
> > > > > > > > code is simply following the Linux drm comment diagram, in
> > > > > > > > include/drm/drm_modes.h which is
> > > > > > > >
> > > > > > > > [hv]back porch = [hv]total - [hv]sync_end
> > > > > > > >
> > > > > > > > BSP code form BPI-M64-bsp is calculating vertical back porch as
> > > > > > > > (from linux-sunxi/drivers/video/sunxi/disp2/disp/de/disp_lcd.c)
> > > > > > > >
> > > > > > > > timmings->ver_sync_time= panel_info->lcd_vspw;
> > > > > > > > timmings->ver_back_porch= panel_info->lcd_vbp-panel_info->lcd_vspw;
> > > > > > > >
> > > > > > > > vbp = panel->lcd_vbp;
> > > > > > > > vspw = panel->lcd_vspw;
> > > > > > > > dsi_dev[sel]->dsi_basic_size0.bits.vbp = vbp-vspw;
> > > > > > > > dsi_dev[sel]->dsi_basic_size0.bits.vbp = panel->lcd_vbp - panel->lcd_vspw;
> > > > > > > > =>  timmings->ver_back_porch + panel_info->lcd_vspw - panel_info->lcd_vspw
> > > > > > > > =>  timmings->ver_back_porch
> > > > > > > > =>  mode->vtotal - mode->end
> > > > > > > >
> > > > > > > > Which evatually same as mode->vtotal - mode->vsync_end so update the
> > > > > > > > same in SUN6I_DSI_BASIC_SIZE0_VBP
> > > > > > > >
> > > > > > > > On the information note, existing SUN6I_DSI_BASIC_SIZE0_VSA is proper
> > > > > > > > value.
> > > > > > > >
> > > > > > > > Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
> > > > > > >
> > > > > > > I've tested your changes on my A33 board, and this commit will break
> > > > > > > it.
> > > > > > >
> > > > > > > It creates vblank timeouts, and visual artifacts at the bottom of the
> > > > > > > display.
> > > > > >
> > > > > > Strange, VBP is earlier gives front porch which is anyway wrong.
> > > > > >
> > > > > > >
> > > > > > > Later commits seem to fix the issue, but will create some blanking on
> > > > > > > the upper third of the display.
> > > > > > >
> > > > > > > Since the documentation is quite sparse, and a MIPI-DSI analyzer is
> > > > > > > way too expensive, I'd really like to have at least what each of these
> > > > > > > commits are actually fixing, and what symptoms each of these were
> > > > > > > causing, and not just "the BSP does it".
> > > > > >
> > > > > > W/o this 2-lane panel is breaking, same vblank timeout and visual
> > > > > > artifacts at the bottom of the panel. though the commits may reference
> > > > > > BSP, I have at-least tested on 3 different panels for us to prove its
> > > > > > working.
> > > > > >
> > > > > > > Having some datasheet for the panels you had working would help too.
> > > > > >
> > > > > > Unfortunately datasheet doesn't have any required information what we
> > > > > > actually looking for.
> > > > >
> > > > > Not even the timings? How did you get that information then?
> > > >
> > > > datasheet has timing values, but this changes need controller
> > > > information about VBP register that I don't have. But again existing
> > > > VBP is not back porch for real, it's front porch.
> > >
> > > Yet, this breaks the existing setup. So again:
> >
> > Was it with 4-lane or 2-lane panel? can you test it with 2-lane panel?
> > I can see the issue on 2-lane but the 4-lane working fine with this
> > patch even.
>
> It's a 4 lane display.

Thanks, look like my panel timings seems reverse b/w BP and FP. It
work irrespective of this change after proper update.

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
