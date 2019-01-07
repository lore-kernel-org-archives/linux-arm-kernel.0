Return-Path: <SRS0=txfi=PP=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8EBCC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 15:18:46 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 87B462087F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 15:18:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Lmu071gx";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="qmutbevC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 87B462087F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=PtHNDmONmTd2LUnAY9EXEE4iWyGz2Ueej91RMYpQ8eE=; b=Lmu071gxRoCYlI
	qQD99YW2ihvXGXa660Km+gCcjXO9XpauwGmm1kKlUh5UkqZCjhhRpu9H5z/MsjbPwMBJ7YqTF47e8
	U0ycVk3IGbClkYp6By9gttluxMroFf44/cBKfbXGb1PS+LSGCjKD9KwMSWt+fd9eA30/W2be7yZqz
	pOHTlkXB72oclYEHIBKlTMV2fUF/60DFmcx6yWwCVVMe0gjlPL75k/hXVMf3KddtjhsWOUhJbnIX/
	QTpJGEkU+YuMc/ukEjJhnhQLsgZSEoRDcTPXTlclVxRSIMpGhtWu8prdz7pke/jwUhBgr6lYgWZuJ
	40onPNe79EEfif4MEmWg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1ggWfn-0002kK-P4; Mon, 07 Jan 2019 15:18:39 +0000
Received: from mail-it1-x144.google.com ([2607:f8b0:4864:20::144])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1ggWfi-0002jX-RV
 for linux-arm-kernel@lists.infradead.org; Mon, 07 Jan 2019 15:18:38 +0000
Received: by mail-it1-x144.google.com with SMTP id w18so1607230ite.1
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 07 Jan 2019 07:18:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=etMmqBlvtlnxJHZTXcYc6nrcGcV1CQ7x663xqo72vJQ=;
 b=qmutbevCZWxhmrdmuvkLV9C7Rq2GXSMqc/AGZ4x7X00/aidgXNAH4n8IOqB2VfyJ8j
 7Fjc8Fl0T5D2hQfWDJIPrl4az+cGnvYGnFUEmxnPOJoKHYdfHN/7p8zn06FB/J7T3aYq
 eyEOMlsAnPSa+Xpyo9YyQiEuqAyF5zNnmFO48=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=etMmqBlvtlnxJHZTXcYc6nrcGcV1CQ7x663xqo72vJQ=;
 b=MngZAjOTykz5yHNlMgnm6Q58Ja2yj12HTECFAR0qo9/UVeaEKrq3vdA6IqJAdbmCL2
 jpM/nO1VcFqkATwLUAZza1DTEhtdMVz1aq2MZ7ZrQmUEqOIvxxHfVyeaf8Sws2wAOVWj
 7ErnsGePa+Z3bwAhOCgyTKCiFwKZkBnfz5L4+Egs290EDQgYkSU88QxsXNYf39cAv6v9
 VojpiIULbXnmOMunP5qLNC86zmIJJzPEFXJ5sP3hf+IUjzXqVV1DhN8Tv0sCBvG8Ony8
 T5R5ia/72HdBbW6/WG3xCZdwgMiX8vPP5+FN+KL4QN7L7qlT45Qj5fW115HKfQZSt8Ww
 un1Q==
X-Gm-Message-State: AJcUukcYuU5BCbEZFVlU8uo24JxKBSYJE5LDdJAabhEQfwY1TFKsqKv7
 PuF0ZBJshvf5B+FD1EktytqVQ8P38mvh6shegCgZlg==
X-Google-Smtp-Source: ALg8bN41ZqL8iO66URwEiSpaZ74jg0B+MTzxJaV4r8IGMSJ6GjR5eoDT7oRbie8D53VRvEXYr1UMLQ0q99hNvgqLFnw=
X-Received: by 2002:a24:5411:: with SMTP id t17mr7083194ita.32.1546874313737; 
 Mon, 07 Jan 2019 07:18:33 -0800 (PST)
MIME-Version: 1.0
References: <20181210161729.29720-1-jagan@amarulasolutions.com>
 <20181210161729.29720-8-jagan@amarulasolutions.com>
 <20181211164900.wfmkmbrbj3nmlb3h@flea>
 <CAMty3ZB5F5jD9iJT1soXSA5HtQOf5W9rKO9nCdGFUfVo0hpO4Q@mail.gmail.com>
 <20190107141158.zaimizk4rlqa6xli@flea>
In-Reply-To: <20190107141158.zaimizk4rlqa6xli@flea>
From: Jagan Teki <jagan@amarulasolutions.com>
Date: Mon, 7 Jan 2019 20:48:21 +0530
Message-ID: <CAMty3ZBb8byOwh=_W83Ta0Dse1qkoqccOeaBEY9oHPaxDxe9QA@mail.gmail.com>
Subject: Re: [PATCH v5 07/17] drm/sun4i: sun6i_mipi_dsi: Refactor vertical
 video start delay
To: Maxime Ripard <maxime.ripard@bootlin.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190107_071835_513774_EDD8F765 
X-CRM114-Status: GOOD (  21.00  )
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

On Mon, Jan 7, 2019 at 7:42 PM Maxime Ripard <maxime.ripard@bootlin.com> wrote:
>
> On Fri, Dec 21, 2018 at 02:26:11AM +0530, Jagan Teki wrote:
> > On Tue, Dec 11, 2018 at 10:19 PM Maxime Ripard
> > <maxime.ripard@bootlin.com> wrote:
> > >
> > > On Mon, Dec 10, 2018 at 09:47:19PM +0530, Jagan Teki wrote:
> > > > Video start delay can be computed by subtracting total vertical
> > > > timing with front porch timing and with adding 1 delay line for TCON.
> > > >
> > > > BSP code form BPI-M64-bsp is computing video start delay as
> > > > (from linux-sunxi/
> > > > drivers/video/sunxi/disp2/disp/de/lowlevel_sun50iw1/de_dsi.c)
> > > >
> > > > u32 vfp = panel->lcd_vt - panel->lcd_y - panel->lcd_vbp;
> > > > => (panel->lcd_vt) - panel->lcd_y - (panel->lcd_vbp)
> > > > => (timmings->ver_front_porch + panel->lcd_vbp + panel->lcd_y)
> > > >    - panel->lcd_y - (panel->lcd_vbp)
> > > > => timmings->ver_front_porch + panel->lcd_vbp + panel->lcd_y
> > > >                            - panel->lcd_y - panel->lcd_vbp
> > > > => timmings->ver_front_porch
> > > >
> > > > So, update the start delay computation accordingly.
> > > >
> > > > Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
> > >
> > > Even though it's a bit better now on my A33 board and I don't have the
> > > white stripes on the bottom of the display, there's still some
> > > flickering with your patches applied.
> > >
> > > Bisecting it seems to point at that patch, but reverting it doesn't
> > > make the issue go away, so it's not really clear which one exactly is
> > > at fault.
> >
> > Is reverting this patch, work fine or not?
>
> As I was saying, it doesn't.
>
> > This patch is trying to make use of front porch instead of existing
> > back porch to compute the delay. Since we revert the VBP fix patch[1]
> > to assume VBP as VFP value look like your setup would also require to
> > revert this change. But as per BSP or drm_mode details all of my
> > displays even work with and w/o reverting these two.
>
> Again, I cannot help you without the datasheet for the panels you're
> trying to submit.

The panel bound with Sitronix ST7701 IC
http://www.startek-lcd.com/res/starteklcd/pdres/201705/20170512144242904.pdf

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
