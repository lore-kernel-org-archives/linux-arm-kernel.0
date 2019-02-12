Return-Path: <SRS0=CPNf=QT=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3A6DC282CE
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 09:46:26 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6B49620821
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 09:46:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="ZxGI6t/x";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="UteXABVN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6B49620821
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=GcXdDeHRhIfw0O50lJ3119E19lNgQtlxk5uDU6vaNyo=; b=ZxGI6t/xUDw8H7
	sQcJbKmVW3OjeGAtqsD+3cFcnYhAzOwrPLGIrPS+YF3XXC7vYBob3prSjkjDok3kUhRWL0YMBpqXH
	nj9Vd8d3vAJX0pWuhT2HC/5qkJSyAN82I4r0ezsK8d5mwhuhMhvzedS2Pt3CYG9T6I5c+Vu6Etnhd
	SGEWQjyvq7jgHPYBGr1UIOaPCRZUMc1sUZiH4WoZJ/o4+jH3CdrMcyuWnVVTiTb4pQUITu1DZKiM4
	QEQXLqb4qfbRemrtMb3SgOZ3BcTKloFzfYYb9HINtcifymHnJmsPK4i6cSEoykSkDjwjWYzyQMIkq
	2dFv8j6HJ3FyyrlXkOVA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gtUdx-0004Qr-Eg; Tue, 12 Feb 2019 09:46:21 +0000
Received: from mail-it1-x144.google.com ([2607:f8b0:4864:20::144])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gtUdr-0004OY-D7
 for linux-arm-kernel@lists.infradead.org; Tue, 12 Feb 2019 09:46:18 +0000
Received: by mail-it1-x144.google.com with SMTP id z7so5733359iti.0
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 12 Feb 2019 01:46:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=05CniVm9PLCTpTi84DDJvIByzSMkdbNsdq0wM1zg6bs=;
 b=UteXABVNaGCBS/tHUabW/5SZKWfm+IpAFT5pyBZRq/ZiRG4z17DBZB03wEQzqc5pfy
 bVm76uuUEU84rxjjoAfzt1woJOILw6K2LXLUT+aemcTu1cFeGVAFrxFqfnPkoG9MzXPg
 +5d4yT8e/rI3UK4IbBIFIm5+2UOvfOdaoT5ls=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=05CniVm9PLCTpTi84DDJvIByzSMkdbNsdq0wM1zg6bs=;
 b=GK9Jf/L/Da+a6w6vu2DlStdZFjzp138PTE5HO9UqxJMQO0KEDvUTdzGfA2V+AfpOjj
 LSEn+x7XXOaMEbp6aplOgt4040hX86Caw/+dQ5u8l90kcqpHKbtuRmGUrSXn8TDhuY3t
 2rJdEYiEWXV7Xiq5pKYOpdAiPxxshhT9FZev1Q+oy9mZ3+MJj3GormwGJUoEIZ25XPLe
 q1FdDkClyOUs9HODbQV8hrNW6DG4CjxPFdUy9cneptbw19dATQv+8ubFTrzbBFQ5lY9X
 qS/XDpmPg1IheGFQ2bPc2S1HnQzUlA9WlL4WDwMSV2Jv3dFhXbez5TNdVYmQB/vUGZA0
 Jk4g==
X-Gm-Message-State: AHQUAuZq5hrHUW3Ula/E3nwRnwmnf+i4yMtIWaunv+QYPHb9cgE2BoTD
 KmGnQ5LVB37QaFABmODzN0tAHZZyxGzt0eoTBt8fYA==
X-Google-Smtp-Source: AHgI3Ib86k93mfKNJvQH3NjDKtEduAkqTTLeuPW1AiUV7u0STgkVVNdjzLiATWXLCSJoswBvz/LQ91xYDDU8/ZfhBiE=
X-Received: by 2002:a24:385:: with SMTP id e127mr1350371ite.32.1549964774244; 
 Tue, 12 Feb 2019 01:46:14 -0800 (PST)
MIME-Version: 1.0
References: <20190201154232.10505-1-jagan@amarulasolutions.com>
In-Reply-To: <20190201154232.10505-1-jagan@amarulasolutions.com>
From: Jagan Teki <jagan@amarulasolutions.com>
Date: Tue, 12 Feb 2019 15:16:02 +0530
Message-ID: <CAMty3ZBspvP=qZEK9vaowVq4f5W3Qx2qHkwcuAnCOOjV29=Y_Q@mail.gmail.com>
Subject: Re: [PATCH v7 00/23] drm/sun4i: Allwinner A64 MIPI-DSI support
To: Maxime Ripard <maxime.ripard@bootlin.com>, David Airlie <airlied@linux.ie>,
 Daniel Vetter <daniel@ffwll.ch>, Chen-Yu Tsai <wens@csie.org>, 
 Michael Turquette <mturquette@baylibre.com>, Rob Herring <robh+dt@kernel.org>, 
 Mark Rutland <mark.rutland@arm.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190212_014615_636860_C531B028 
X-CRM114-Status: GOOD (  13.99  )
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
Cc: devicetree <devicetree@vger.kernel.org>,
 linux-kernel <linux-kernel@vger.kernel.org>,
 dri-devel <dri-devel@lists.freedesktop.org>,
 linux-sunxi <linux-sunxi@googlegroups.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 linux-amarula@amarulasolutions.com, linux-clk <linux-clk@vger.kernel.org>,
 linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Fri, Feb 1, 2019 at 9:12 PM Jagan Teki <jagan@amarulasolutions.com> wrote:
>
> Here is next version changes for Allwinner A64 MIPI-DSI support
>
> This series grouped the changes like previous version[1] with different
> sets to support three different panels types that can fit into the DSI
> controller.
>
> set:1, for 4-lane, burst mode support
> - patch 0001: 0009, DSI controller changes that support burst mode.
>
> set:2, for A64 DSI support
> - patch 0010: tcon dclk divider computation based on A64 BSP.
> - patch 0011: 0017, Allwinner A64 DSI controller changes.
>
> set:3, enable 4-lane burst mode panel:
> - patch 0018: Overlay patch that enable Feiyang FY07024DI26A30-D
>   burst mode panel on Pine64-LTS
>
> set:4, enable 4-lane video mode panel:
> - patch 0019: msg type MIPI_DSI_GENERIC_SHORT_WRITE_2_PARAM support
> - patch 0020: Overlay patch that enable Bananapi S070WV20-CT16 ICN6211
>   panel on Bananapi M64
>
> set:5, enable 2-lane video mode panel:
> - patch 0021, 0022: DSI hfp and hbp timings fixes
> - patch 0023: Enable Techstar TS8550B panel on Amarula A64-Relic
>
> Changes for v7:
> - moved vcc-dsi binding to required filed.
> - drop quotes on fallback dphy bindings.
> - drop min_rate clock pll-mipi patches.
> - introduce dclk divider computation as like A64 BSP.
> - add A64 DSI quark patches.
> - fixed A64 DSI pipeline.
> - add proper commit messages.
> - collect Merlijn Wajer Tested-by credits.
> Changes for v6:
> - dropped unneeded changes, patches
> - fixed all burst mode patches as per previous version comments
> - rebase on master
> - update proper commit message
> - dropped unneeded comments
> - order the patches that make review easy
> Changes for v5:
> - collect Rob, Acked-by
> - droped "Fix VBP size calculation" patch
> - updated vblk timing calculation.
> - droped techstar, bananapi dsi panel drivers which may require
>   bridge or other setup. it's under discussion.
> Changes for v4:
> - droppoed untested CCU_FEATURE_FIXED_POSTDIV check code in
>   nkm min, max rate patches
> - create two patches for "Add Allwinner A64 MIPI DSI support"
>   one for has_mod_clk quirk and other one for A64 support
> - use existing driver code construct for hblk computation
> - dropped "Increase hfp packet overhead" patch [2], though BSP added
>   this but we have no issues as of now.
>   (no issues on panel side w/o this change)
> - create separate function for vblk computation
> - enable vcc-dsi regulator in dsi_runtime_resume
> - collect Rob, Acked-by
> - update MAINTAINERS file for panel drivers
> - cleanup commit messages
> - fixed checkpatch warnings/errors
>
> [1] https://patchwork.kernel.org/cover/10779893/
>
> Any inputs?
> Jagan.
>
> Jagan Teki (23):
>   drm/sun4i: sun6i_mipi_dsi: Compute burst mode loop N1 instruction
>     delay
>   drm/sun4i: sun6i_mipi_dsi: Support instruction loop selection
>   drm/sun4i: sun6i_mipi_dsi: Setup burst mode timings
>   drm/sun4i: sun6i_mipi_dsi: Simplify drq to support all modes
>   drm/sun4i: tcon: Export get tcon0 routine
>   drm/sun4i: sun6i_mipi_dsi: Probe tcon0 during dsi_bind
>   drm/sun4i: sun6i_mipi_dsi: Setup burst mode
>   drm/sun4i: sun6i_mipi_dsi: Enable trail_inv and trail_fill controls
>   drm/sun4i: sun6i_mipi_dsi: Enable HBP, HSA_HSE for burst mode

Can you pick these burst changes which are generic to all SoCs. and
reset will send once we decide the tcon clock.

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
