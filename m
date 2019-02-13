Return-Path: <SRS0=x1Tr=QU=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C522C282C2
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 09:19:47 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 197B2222C0
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 09:19:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="KaCpuyam";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="qDQT8GFv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 197B2222C0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=DfdC472aLfri1ODZhHuyV3bQ3os8f7tYDtsUXCzW7tA=; b=KaCpuyamXLLpso
	ALWs14LbTVfWGBPYFFgud1KMizmbkHCPxnj+TH80qb3RYsAR69A/YG49Ypr24i1Vg1/ku6YjzXGFL
	tbrxBPPwGbqqCRVZr+wFAB8fUddmSZCuhuZ7kSHRMw2ABymN3brUV2P2EKpcE6iMyMEfQVcbGg/O1
	iesj8GbSheLjVk2Q/s/+iWF5WQmILQcNLp2xiJWMSYWzqLK0n1z3VvOL3adgVA2WLvF0fzJYaqt90
	gfWCOIs9Hhz4jFqV9w/Ce/OEj95vl8GyLfMNDEdKhEqpHmczmY6hTz1eeR6r278sHq8oIJDmAp0YV
	mcB1lE8pbdMNgw+fL72Q==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gtqhk-0002kW-S5; Wed, 13 Feb 2019 09:19:44 +0000
Received: from mail-it1-x143.google.com ([2607:f8b0:4864:20::143])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gtqha-0002aF-J6
 for linux-arm-kernel@lists.infradead.org; Wed, 13 Feb 2019 09:19:40 +0000
Received: by mail-it1-x143.google.com with SMTP id z7so4258541iti.0
 for <linux-arm-kernel@lists.infradead.org>;
 Wed, 13 Feb 2019 01:19:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=suiqjiV/3v7/sXoqCHDymg+ph6X+23+FUiEu0DKo16Y=;
 b=qDQT8GFvjnlkX1Ds44AYVi4ILsJvDPT03Iz6c8hPXzgLATXyAjviON6+vzvmgOZ3ap
 ydKl6C+l8GmsVPW/EAHE2Inli6hVkZs0dHyF3/NvwPFj+sMMsq/E+VHL5jcBMOoM8Qzb
 zgxZlFJsJ+8Tt5gJ94tSo1yJpqdqsdt4YHdO8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=suiqjiV/3v7/sXoqCHDymg+ph6X+23+FUiEu0DKo16Y=;
 b=POOCwxpwtJvGR5EXEItHjTz+ElnDMadeio6Eih/RlCUesImFMOfh1s0EpUa6XX+Rou
 OseBxpPR5AOEz4CF5t/VbKRbv+bp5deHBiIbWNtR/1kY+tkadloKlB3+KacVlWkL4Js6
 gVFizwDzA1jXpyMASXLQjQWfA1iPzD7y7cMy4llFEs4U59QJrXkep8xqAXJmHqPtb3Rw
 diZTkOZKzzynqL+KKAK+Lc53yxjrIGCNlr1dEf/wBNJxQwWxmHfTq2TYZqRXKnSfIaQR
 mwhb6H62ovhv5dwSxzfN35IYbNBR524mSh73J1uWOG8emccs3bMsLbBieeY5FKiRpoWb
 Prnw==
X-Gm-Message-State: AHQUAuYqYANhGbigF7seUdDtTUkR+egwERxtWV0lRqaCni6iVK9pPi/Y
 7ZR/gvZbd3/Yrlq+JIWRuGRqQ2unFTc1abY9c1/8SA==
X-Google-Smtp-Source: AHgI3IY0QB990fMWVki8Kr2ijwfqnVm0vmvmNzZT3ufy9FCTR4jzj674f5//NmA5xa03EpvAwigbj/gsJI1SKT05gUM=
X-Received: by 2002:a24:6891:: with SMTP id v139mr1764177itb.107.1550049573146; 
 Wed, 13 Feb 2019 01:19:33 -0800 (PST)
MIME-Version: 1.0
References: <20190201154232.10505-1-jagan@amarulasolutions.com>
 <CAMty3ZBspvP=qZEK9vaowVq4f5W3Qx2qHkwcuAnCOOjV29=Y_Q@mail.gmail.com>
 <20190213090308.dlcwgcrhg264k2cu@flea>
In-Reply-To: <20190213090308.dlcwgcrhg264k2cu@flea>
From: Jagan Teki <jagan@amarulasolutions.com>
Date: Wed, 13 Feb 2019 14:49:21 +0530
Message-ID: <CAMty3ZCSMRm-0suApB4Zb+kE1M2sWn3F7ugPBFWaL4ap7cJejQ@mail.gmail.com>
Subject: Re: [PATCH v7 00/23] drm/sun4i: Allwinner A64 MIPI-DSI support
To: Maxime Ripard <maxime.ripard@bootlin.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190213_011935_394395_9F93FA9B 
X-CRM114-Status: GOOD (  22.70  )
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

On Wed, Feb 13, 2019 at 2:33 PM Maxime Ripard <maxime.ripard@bootlin.com> wrote:
>
> On Tue, Feb 12, 2019 at 03:16:02PM +0530, Jagan Teki wrote:
> > On Fri, Feb 1, 2019 at 9:12 PM Jagan Teki <jagan@amarulasolutions.com> wrote:
> > >
> > > Here is next version changes for Allwinner A64 MIPI-DSI support
> > >
> > > This series grouped the changes like previous version[1] with different
> > > sets to support three different panels types that can fit into the DSI
> > > controller.
> > >
> > > set:1, for 4-lane, burst mode support
> > > - patch 0001: 0009, DSI controller changes that support burst mode.
> > >
> > > set:2, for A64 DSI support
> > > - patch 0010: tcon dclk divider computation based on A64 BSP.
> > > - patch 0011: 0017, Allwinner A64 DSI controller changes.
> > >
> > > set:3, enable 4-lane burst mode panel:
> > > - patch 0018: Overlay patch that enable Feiyang FY07024DI26A30-D
> > >   burst mode panel on Pine64-LTS
> > >
> > > set:4, enable 4-lane video mode panel:
> > > - patch 0019: msg type MIPI_DSI_GENERIC_SHORT_WRITE_2_PARAM support
> > > - patch 0020: Overlay patch that enable Bananapi S070WV20-CT16 ICN6211
> > >   panel on Bananapi M64
> > >
> > > set:5, enable 2-lane video mode panel:
> > > - patch 0021, 0022: DSI hfp and hbp timings fixes
> > > - patch 0023: Enable Techstar TS8550B panel on Amarula A64-Relic
> > >
> > > Changes for v7:
> > > - moved vcc-dsi binding to required filed.
> > > - drop quotes on fallback dphy bindings.
> > > - drop min_rate clock pll-mipi patches.
> > > - introduce dclk divider computation as like A64 BSP.
> > > - add A64 DSI quark patches.
> > > - fixed A64 DSI pipeline.
> > > - add proper commit messages.
> > > - collect Merlijn Wajer Tested-by credits.
> > > Changes for v6:
> > > - dropped unneeded changes, patches
> > > - fixed all burst mode patches as per previous version comments
> > > - rebase on master
> > > - update proper commit message
> > > - dropped unneeded comments
> > > - order the patches that make review easy
> > > Changes for v5:
> > > - collect Rob, Acked-by
> > > - droped "Fix VBP size calculation" patch
> > > - updated vblk timing calculation.
> > > - droped techstar, bananapi dsi panel drivers which may require
> > >   bridge or other setup. it's under discussion.
> > > Changes for v4:
> > > - droppoed untested CCU_FEATURE_FIXED_POSTDIV check code in
> > >   nkm min, max rate patches
> > > - create two patches for "Add Allwinner A64 MIPI DSI support"
> > >   one for has_mod_clk quirk and other one for A64 support
> > > - use existing driver code construct for hblk computation
> > > - dropped "Increase hfp packet overhead" patch [2], though BSP added
> > >   this but we have no issues as of now.
> > >   (no issues on panel side w/o this change)
> > > - create separate function for vblk computation
> > > - enable vcc-dsi regulator in dsi_runtime_resume
> > > - collect Rob, Acked-by
> > > - update MAINTAINERS file for panel drivers
> > > - cleanup commit messages
> > > - fixed checkpatch warnings/errors
> > >
> > > [1] https://patchwork.kernel.org/cover/10779893/
> > >
> > > Any inputs?
> > > Jagan.
> > >
> > > Jagan Teki (23):
> > >   drm/sun4i: sun6i_mipi_dsi: Compute burst mode loop N1 instruction
> > >     delay
> > >   drm/sun4i: sun6i_mipi_dsi: Support instruction loop selection
> > >   drm/sun4i: sun6i_mipi_dsi: Setup burst mode timings
> > >   drm/sun4i: sun6i_mipi_dsi: Simplify drq to support all modes
> > >   drm/sun4i: tcon: Export get tcon0 routine
> > >   drm/sun4i: sun6i_mipi_dsi: Probe tcon0 during dsi_bind
> > >   drm/sun4i: sun6i_mipi_dsi: Setup burst mode
> > >   drm/sun4i: sun6i_mipi_dsi: Enable trail_inv and trail_fill controls
> > >   drm/sun4i: sun6i_mipi_dsi: Enable HBP, HSA_HSE for burst mode
> >
> > Can you pick these burst changes which are generic to all SoCs. and
> > reset will send once we decide the tcon clock.
>
> These patches don't implement what we discussed last week, and as I
> told you already, most of them really need some work on the commit log
> and their explanations.

If I'm not wrong, we discussed about tcon_dclk (PLL_MIPI) last week
[1] and these burst changes between 01/23 to 09/23 which are generic
changes to DSI and not related to clock. Apart from that I made few
changes on commit logs between the versions (which I was mentioned on
the cover-letter patch). If any issues issues on commit message,
please let me know so-that I can rework.

[1] https://patchwork.kernel.org/patch/10780041/

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
