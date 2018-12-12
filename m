Return-Path: <SRS0=fRgi=OV=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16F61C67839
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 19:44:13 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DA6FE20811
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 19:44:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="d/qtA9jc";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="Sb05uGfb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DA6FE20811
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=CKYneDRnsUzdUqyN8K5zgDhRiaiLmUrM5D4mK+FEKEU=; b=d/qtA9jcEvK3UY
	NqcwbhRzI/1sUfEBImunjdErPR+d67QOICKeYxlpEhUcFmVJ2KJ/x32gaU9QX8uA+3n2D4/BnSI62
	RY1mpfxLQ60FfLZ3uZwH8SqPG/TMZs1dcA3IDrxKDYkDEURLheq0OvLmZ9S93ZXuZfBGgoHVTs7Bp
	kZZAPfm22ECVgjZhKgStxr0URyCxp75abWuvHta5mZo587zrsDNW8Q1wie0AZ7H6rj0MzjLbQ/WWj
	ZPJlZcWcdWwORiCUvHy2geNZ3o5ysFB2FsKiovEPhIbUWtqptHEpGVClA8U6FlUcGhC//5q7s8rND
	4379r1RU/elezxz5pCyg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gXAQT-0004LG-G8; Wed, 12 Dec 2018 19:44:09 +0000
Received: from mail-it1-x143.google.com ([2607:f8b0:4864:20::143])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gXAQP-00048O-Mr
 for linux-arm-kernel@lists.infradead.org; Wed, 12 Dec 2018 19:44:07 +0000
Received: by mail-it1-x143.google.com with SMTP id h193so85807ita.5
 for <linux-arm-kernel@lists.infradead.org>;
 Wed, 12 Dec 2018 11:43:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=4O6JG1fVoPe87+m+7CKj+JrKSi1kqsDwdZDPItQ/pA0=;
 b=Sb05uGfbdr7z4FnGnb4D/kUUmIfzmo3odrVflDV1XVuhnZJPmNva5KvEQwonoUjaiB
 cwUNLq26JgT+KV7RJnvSOp0BHkRj5uFypzqd8Bt49rWLi+riB8+/okVk7ia6P+BsLNoF
 Y7Zxygg5zGL82coTqYvBobiDl6bdxOyA72YTI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=4O6JG1fVoPe87+m+7CKj+JrKSi1kqsDwdZDPItQ/pA0=;
 b=tatIXSN1TbUJoXXOouMOXFsSpXqz00g40BDkk+44LmYZT73qDANUGcneRxz6/GS9nS
 DE+zhs/FYhCHzOse+ziEavArqhVjFieZjWqdyaIQVmZ39mUP43iLQMrsMPY3HXRpp6iw
 B9gbVdGW1FXfZG6P/6tfNNzQg4X6T3gKydXCe4fnj9AO5+zOFpggKees3VM1cQIy+KQx
 vakSdGZCM36fFqH6wf134xedGqSd1lq9hG6xGGMailDrIIKjvG+iFTl1gjPlHgmcaTnz
 evRJDJkW6cDheWCruRlWMrMSJRkO3lr1DLzy9xiKNe4oakirmfv6SjjKE/tvYn/K5jqf
 4gWQ==
X-Gm-Message-State: AA+aEWZctOmjUF88duFwjhJgCly++4dA4MKsoDWFWprsC3RITlotJ2zG
 IOqxhgs1AUqYL71UXBME82nGHqH9B/pLcs3jLlzqHA==
X-Google-Smtp-Source: AFSGD/WW7e7ICAd+v20UL5gdUicwYrot3Fa4beMJiVhdcY5ooGvbDA8745sOnShAYWDncU9ioD1jjIVU7VpW9Xhq5ps=
X-Received: by 2002:a24:4f07:: with SMTP id c7mr7161579itb.107.1544643833171; 
 Wed, 12 Dec 2018 11:43:53 -0800 (PST)
MIME-Version: 1.0
References: <20181210161729.29720-1-jagan@amarulasolutions.com>
 <20181210161729.29720-8-jagan@amarulasolutions.com>
 <20181211164900.wfmkmbrbj3nmlb3h@flea>
 <CAMty3ZBzOyAGwgOZwArbvnqtcvwMkJrqwGQ-q7+XFX-BVs34RQ@mail.gmail.com>
In-Reply-To: <CAMty3ZBzOyAGwgOZwArbvnqtcvwMkJrqwGQ-q7+XFX-BVs34RQ@mail.gmail.com>
From: Jagan Teki <jagan@amarulasolutions.com>
Date: Thu, 13 Dec 2018 01:13:40 +0530
Message-ID: <CAMty3ZAKAOypCFNnoKNvgoZurS4+q1PLRjT_aA-zXh+h5MygvA@mail.gmail.com>
Subject: Re: [PATCH v5 07/17] drm/sun4i: sun6i_mipi_dsi: Refactor vertical
 video start delay
To: Maxime Ripard <maxime.ripard@bootlin.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181212_114405_911907_28F22228 
X-CRM114-Status: GOOD (  21.22  )
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

Hi Maxime,

On Tue, Dec 11, 2018 at 10:30 PM Jagan Teki <jagan@amarulasolutions.com> wrote:
>
> On Tue, Dec 11, 2018 at 10:19 PM Maxime Ripard
> <maxime.ripard@bootlin.com> wrote:
> >
> > On Mon, Dec 10, 2018 at 09:47:19PM +0530, Jagan Teki wrote:
> > > Video start delay can be computed by subtracting total vertical
> > > timing with front porch timing and with adding 1 delay line for TCON.
> > >
> > > BSP code form BPI-M64-bsp is computing video start delay as
> > > (from linux-sunxi/
> > > drivers/video/sunxi/disp2/disp/de/lowlevel_sun50iw1/de_dsi.c)
> > >
> > > u32 vfp = panel->lcd_vt - panel->lcd_y - panel->lcd_vbp;
> > > => (panel->lcd_vt) - panel->lcd_y - (panel->lcd_vbp)
> > > => (timmings->ver_front_porch + panel->lcd_vbp + panel->lcd_y)
> > >    - panel->lcd_y - (panel->lcd_vbp)
> > > => timmings->ver_front_porch + panel->lcd_vbp + panel->lcd_y
> > >                            - panel->lcd_y - panel->lcd_vbp
> > > => timmings->ver_front_porch
> > >
> > > So, update the start delay computation accordingly.
> > >
> > > Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
> >
> > Even though it's a bit better now on my A33 board and I don't have the
> > white stripes on the bottom of the display, there's still some
> > flickering with your patches applied.
> >
> > Bisecting it seems to point at that patch, but reverting it doesn't
> > make the issue go away, so it's not really clear which one exactly is
> > at fault.
> >
> > So, just like I asked in your v4, twice,
> >
> > http://lists.infradead.org/pipermail/linux-arm-kernel/2018-November/615339.html
>
> I don't know how can I comment here. Not quite clearly understand your
> setup, because I have verified 3 different panels from different
> vendors one with 2-lane, another with 4-lane and one with video format
> and another one is burstmode format. I even verified with the clock
> rate and register details.
>
> Please suggest me, what can look further on this.

From the BSP point-of-view I couldn't find have any difference in
start_delay computation between A64, and A33[1]. In fact the driver
initialization code is same, here is A64 dsi driver[2].

1) The only difference that I observe is dsi_gen_wr in BSP [3], the
A33 is right shifting message tx length to 0, 8 for first and next
packet where as A64 did the same by adding +1 before.  Please try to
check that If your panel is using long write.  and
2) Also every dsi transaction in A33 occupy some delay code in
dsi_gen_wr[4], please check the same. and
3) Also If possible please check your panel timings or initialization
sequence, because I don't have any panel with A33.
4) other than these I have didn't notice any differences atleast from
my knowledge, Please suggest me where can I look further.

[1] https://github.com/BPI-SINOVOIP/BPI-M2M-bsp/blob/master/linux-sunxi/drivers/video/sunxi/disp/de/lowlevel_sun8iw5/de_dsi.c#L813
[2] https://github.com/BPI-SINOVOIP/BPI-M64-bsp/blob/master/linux-sunxi/drivers/video/sunxi/disp2/disp/de/lowlevel_sun50iw1/de_dsi.c
[3] https://github.com/BPI-SINOVOIP/BPI-M2M-bsp/blob/master/linux-sunxi/drivers/video/sunxi/disp/de/lowlevel_sun8iw5/de_dsi.c#L402
[4] https://github.com/BPI-SINOVOIP/BPI-M2M-bsp/blob/master/linux-sunxi/drivers/video/sunxi/disp/de/lowlevel_sun8iw5/de_dsi.c#L378

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
