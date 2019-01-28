Return-Path: <SRS0=FIMe=QE=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 806BFC282C8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 07:32:14 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 517CE2148E
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 07:32:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="NVIB6SJv";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="FP0capNk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 517CE2148E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=geY8xnNQBkbpRIDlpo1OsM7OkZYAm4A0U1Z43fUElqM=; b=NVIB6SJv916i9p
	qmGhzBQIiQuSUPZ+FdpOR7LyeRnjvSKNnEKYz/s0ino7BUoAe48v2kRyXI1oF2EMGi0QXhor/ST9v
	KEp/g9oXpm5rLjw6jmq7vnb/D0ckUYwRdKHpbWIlt41Ibr5p8+oKNyfkpRQwLCu+keFmOubN9eBJ3
	KFTG8rBaFSZHmN1CuNvI9furJSjrXx/ToDoWG4MjiGIeiEObTA/yJDC9IIg8LQHdjUwJH9y3FfgWC
	+hiZjAarAk3WA6aDjm6G43zmUj9kg19V7IDrbYDVYGCz+UtHdJ+EL1r0woB8CRV4mG7u88m6z2eEU
	7Q/1jyQwr4MJkBYH27VQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1go1Ot-0006ef-QD; Mon, 28 Jan 2019 07:32:11 +0000
Received: from mail-it1-x144.google.com ([2607:f8b0:4864:20::144])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1go1Op-0006eG-Qc
 for linux-arm-kernel@lists.infradead.org; Mon, 28 Jan 2019 07:32:09 +0000
Received: by mail-it1-x144.google.com with SMTP id b5so17956107iti.2
 for <linux-arm-kernel@lists.infradead.org>;
 Sun, 27 Jan 2019 23:32:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=mTGnqD6HTlX/N8E4wtdR/Qhebt0GeL6pNgp0cAE+85Y=;
 b=FP0capNk5QGL+WcawuamdA068tY8dz/YSgCBFM9wrmlAr+8Ovb62IcfGcrdkVDEnii
 AoOnCkSMR3Qlq3MnJeEHdWeUkD6bjikyO0+hiEltNEu6QgvTgCvsOYoEagNyFDbKfCcY
 uGLxUXJpoAiWiehBtbwO1yhM+5xr2JnVni4yk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=mTGnqD6HTlX/N8E4wtdR/Qhebt0GeL6pNgp0cAE+85Y=;
 b=avktnCfo7hO3vxaMcCBzshYMtBfVycOKNiaaXKnJdtYBEwBdHMw7d+NBlTDXezAv9p
 o6FOs5ruCuNxnHSdr/2ikHR0SXDaDrfuwXPQNqTiW60FyBvWKyEuTdtdB9fKuESH2QVI
 pA8gszECStuJT4XnmZnmOEdrudrEmHYmdQ2sDzkr6hv2iSvgZqEOlEN9rLksBtqPvveW
 EzA/n9h/IphfUhN+cVjtFUIiRmFd16Bz+R+BhXhGkmTCejnYc2/IZeeBGNp4EJrv22/z
 qdmvC5YYNEtMa7c9uQLp2gF5kyruQwucW0IyGrNtUBysRmYiZvGsMY0RwHHiwi+Zqv7B
 0gUg==
X-Gm-Message-State: AJcUukf/05k6rsHLOlCTofgmTs34v50ymTGh6CP9TKtDKKEbjzAM2v6y
 UgItkC3+yKrHhotd2Hbgopvn1WSUjX7KKeT4N97bSg==
X-Google-Smtp-Source: ALg8bN6QzCMRMTALAsaeCJnY8PI/UAJdQmeNoWOiUVuzDFpjWtnFZx5kxTREQHLIXcvfFMd51PKAZLZHN+jH6dSj7cs=
X-Received: by 2002:a24:385:: with SMTP id e127mr9061780ite.32.1548660725998; 
 Sun, 27 Jan 2019 23:32:05 -0800 (PST)
MIME-Version: 1.0
References: <20190124180736.28408-1-jagan@amarulasolutions.com>
 <20190124180736.28408-3-jagan@amarulasolutions.com>
 <20190125154245.5wx2mwhzsjeaahi3@flea>
In-Reply-To: <20190125154245.5wx2mwhzsjeaahi3@flea>
From: Jagan Teki <jagan@amarulasolutions.com>
Date: Mon, 28 Jan 2019 13:01:54 +0530
Message-ID: <CAMty3ZB6Es45D=fcCLrv4dAxJAgMDr3aLbbc4hF87ZC4UizBpQ@mail.gmail.com>
Subject: Re: [PATCH v7 2/5] media: sun6i: Add A64 CSI block support
To: Maxime Ripard <maxime.ripard@bootlin.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190127_233208_325516_8C3A0175 
X-CRM114-Status: GOOD (  20.63  )
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
 Michael Trimarchi <michael@amarulasolutions.com>,
 linux-sunxi <linux-sunxi@googlegroups.com>,
 linux-kernel <linux-kernel@vger.kernel.org>, Chen-Yu Tsai <wens@csie.org>,
 Rob Herring <robh+dt@kernel.org>, Yong Deng <yong.deng@magewell.com>,
 Mauro Carvalho Chehab <mchehab@kernel.org>, linux-amarula@amarulasolutions.com,
 linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
 linux-media <linux-media@vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Fri, Jan 25, 2019 at 9:12 PM Maxime Ripard <maxime.ripard@bootlin.com> wrote:
>
> On Thu, Jan 24, 2019 at 11:37:33PM +0530, Jagan Teki wrote:
> > CSI block in Allwinner A64 has similar features as like in H3,
> > but the default CSI_SCLK rate cannot work properly to drive the
> > connected sensor interface.
> >
> > The tested mod cock rate is 300 MHz and BSP vfe media driver is also
> > using the same rate. Unfortunately there is no valid information about
> > clock rate in manual or any other sources except the BSP driver. so more
> > faith on BSP code, because same has tested in mainline.
> >
> > So, add support for A64 CSI block by setting updated mod clock rate.
> >
> > Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
> > ---
> >  drivers/media/platform/sunxi/sun6i-csi/sun6i_csi.c | 13 ++++++++++++-
> >  1 file changed, 12 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi.c b/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi.c
> > index ee882b66a5ea..cd2d33242c17 100644
> > --- a/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi.c
> > +++ b/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi.c
> > @@ -15,6 +15,7 @@
> >  #include <linux/ioctl.h>
> >  #include <linux/module.h>
> >  #include <linux/of.h>
> > +#include <linux/of_device.h>
> >  #include <linux/platform_device.h>
> >  #include <linux/pm_runtime.h>
> >  #include <linux/regmap.h>
> > @@ -154,6 +155,7 @@ bool sun6i_csi_is_format_supported(struct sun6i_csi *csi,
> >  int sun6i_csi_set_power(struct sun6i_csi *csi, bool enable)
> >  {
> >       struct sun6i_csi_dev *sdev = sun6i_csi_to_dev(csi);
> > +     struct device *dev = sdev->dev;
> >       struct regmap *regmap = sdev->regmap;
> >       int ret;
> >
> > @@ -161,15 +163,20 @@ int sun6i_csi_set_power(struct sun6i_csi *csi, bool enable)
> >               regmap_update_bits(regmap, CSI_EN_REG, CSI_EN_CSI_EN, 0);
> >
> >               clk_disable_unprepare(sdev->clk_ram);
> > +             if (of_device_is_compatible(dev->of_node, "allwinner,sun50i-a64-csi"))
> > +                     clk_rate_exclusive_put(sdev->clk_mod);
> >               clk_disable_unprepare(sdev->clk_mod);
> >               reset_control_assert(sdev->rstc_bus);
> >               return 0;
> >       }
> >
> > +     if (of_device_is_compatible(dev->of_node, "allwinner,sun50i-a64-csi"))
> > +             clk_set_rate_exclusive(sdev->clk_mod, 300000000);
> > +
> >       ret = clk_prepare_enable(sdev->clk_mod);
> >       if (ret) {
> >               dev_err(sdev->dev, "Enable csi clk err %d\n", ret);
> > -             return ret;
> > +             goto clk_mod_put;
> >       }
> >
> >       ret = clk_prepare_enable(sdev->clk_ram);
> > @@ -192,6 +199,9 @@ int sun6i_csi_set_power(struct sun6i_csi *csi, bool enable)
> >       clk_disable_unprepare(sdev->clk_ram);
> >  clk_mod_disable:
> >       clk_disable_unprepare(sdev->clk_mod);
> > +clk_mod_put:
> > +     if (of_device_is_compatible(dev->of_node, "allwinner,sun50i-a64-csi"))
> > +             clk_rate_exclusive_put(sdev->clk_mod);
> >       return ret;
>
> The sequence in the error path and in the disable path aren't the same, why?

True, it should be similar sequence, will fix and send next version. thanks!

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
