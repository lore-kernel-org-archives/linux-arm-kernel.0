Return-Path: <SRS0=ikCU=PO=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9874C43444
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun,  6 Jan 2019 16:31:16 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9648820868
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun,  6 Jan 2019 16:31:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="iAoIOw2f";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="kafZP4HN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9648820868
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Aukh7LXtgUx3fktlLuV+CEyWG7dlkBSf0VK2KD0QITo=; b=iAoIOw2fgofnvp
	aDpsT4R8HacxeplT4xL3C2VJxjlTa1pSSk8hHU7Ivs2KrGhdJwwVv0Y2wLEZdATeuHe9JajZy4jBj
	nMYUcIlu9px/xRvyOkKVcnynBf83SxLTKxsxibWfNDp3gng299ow5Fn8A++fenINjjv2haykAuyYA
	cFjc7wTerJiy2qkdMTIGphltKCaFq0KtkOyCFOzn+wLaF68/riPC6UptpXQ6nl1kucSexEUl4RoAE
	aOg0JWs65N70pod2QTvV7DOerXgSrmPWByOtGLQFCa/oZkC7833QyNwXer4Wc5gSW1WG19zcK25KK
	9oWGCbbLGLGdUlJlwScA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1ggBKS-00067L-LY; Sun, 06 Jan 2019 16:31:12 +0000
Received: from mail-it1-x144.google.com ([2607:f8b0:4864:20::144])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1ggBKO-00066t-QL
 for linux-arm-kernel@lists.infradead.org; Sun, 06 Jan 2019 16:31:10 +0000
Received: by mail-it1-x144.google.com with SMTP id z7so7672430iti.0
 for <linux-arm-kernel@lists.infradead.org>;
 Sun, 06 Jan 2019 08:31:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=RpNm2IaOF3siha2bkIDP1P0vfouRYq2qejSlkkMzJKo=;
 b=kafZP4HNAEAQnx+wui8iHMPWYPay7xwNwbhhoR1///YTISjQRDlYNGiRDAxAdFp0fE
 qNRrcKZ/Ct1QQ+ebCLVk4NZiQSfQb20+rukN5pgkKKKkxn4PoC1max4MsgCYvgXtlqA9
 H29tuvlHAYzTkmMwMuuCi0+5Gdn4jT84Xnzgo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=RpNm2IaOF3siha2bkIDP1P0vfouRYq2qejSlkkMzJKo=;
 b=NracZt1ljtRBKGaRKCm7qAwx45ORY/Uj3zSM5eWFMwGq0Gl0ACb4yvSDdDiSSs8ZdG
 1yoyGzls9QEmkJJDjJWRqQhuIfr9UgxW38BYtgE/ITzD6g8lDQZO54mnLJNPVPgqIASF
 WJuPWtslW8zk2OFqapAmNXVHkoLHOufTLxxmvEzzG6lUqWzx59xG2hHKjzMkovVZy2fH
 nsF8XEFIjnjokdbF1oqKdiJ3Y2P+70lMWMlPIn/zU3VwZ8it+tycg3ORHaFwFT+FaBWY
 7ALdcqq7JpFNcRp8M+7UCZZPriViVVtVyUXb+m+kOQU2T8GhKRIDLol8vODJEbhSeCss
 GLkw==
X-Gm-Message-State: AA+aEWYm/fXTtkpufcYEHh3hxKp+iOLzXausrPnTTp+qW9akrCnlN6X0
 bJvVILTjiJqvmF0+UFnZ0hXeZEd2SoFESesqvM9Dog==
X-Google-Smtp-Source: AFSGD/VmUsm1CGUrMdpHtObGhn5j8zdXwFc8djaRxi4UBlCC4gL55AIaDKBzNkf/T+fDSKH7wLr98CfHH/FjMHkxqWk=
X-Received: by 2002:a02:781e:: with SMTP id p30mr40814158jac.85.1546792268054; 
 Sun, 06 Jan 2019 08:31:08 -0800 (PST)
MIME-Version: 1.0
References: <20181220125438.11700-1-jagan@amarulasolutions.com>
 <20181220125438.11700-3-jagan@amarulasolutions.com>
 <20181221130025.lbvw7yvy74brf3jn@flea>
 <CAMty3ZCG5cF3tP2mid5xyS=yhtxkY+TOcGkwRkv+vrZt1=0iQg@mail.gmail.com>
In-Reply-To: <CAMty3ZCG5cF3tP2mid5xyS=yhtxkY+TOcGkwRkv+vrZt1=0iQg@mail.gmail.com>
From: Jagan Teki <jagan@amarulasolutions.com>
Date: Sun, 6 Jan 2019 22:00:56 +0530
Message-ID: <CAMty3ZBeopJTm7kUzqarSfqYAJup7B5eqVWPg4aRpgFJOWP7XA@mail.gmail.com>
Subject: Re: [PATCH v5 2/6] media: sun6i: Add mod_rate quirk
To: Maxime Ripard <maxime.ripard@bootlin.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190106_083108_853640_07F589D1 
X-CRM114-Status: GOOD (  22.38  )
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

On Mon, Dec 24, 2018 at 8:57 PM Jagan Teki <jagan@amarulasolutions.com> wrote:
>
> On Fri, Dec 21, 2018 at 6:30 PM Maxime Ripard <maxime.ripard@bootlin.com> wrote:
> >
> > On Thu, Dec 20, 2018 at 06:24:34PM +0530, Jagan Teki wrote:
> > > Unfortunately default CSI_SCLK rate cannot work properly to
> > > drive the connected sensor interface, particularly on few
> > > Allwinner SoC's like A64.
> > >
> > > So, add mod_rate quirk via driver data so-that the respective
> > > SoC's which require to alter the default mod clock rate can assign
> > > the operating clock rate.
> > >
> > > Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
> > > ---
> > >  .../platform/sunxi/sun6i-csi/sun6i_csi.c      | 34 +++++++++++++++----
> > >  1 file changed, 28 insertions(+), 6 deletions(-)
> > >
> > > diff --git a/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi.c b/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi.c
> > > index ee882b66a5ea..fe002beae09c 100644
> > > --- a/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi.c
> > > +++ b/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi.c
> > > @@ -15,6 +15,7 @@
> > >  #include <linux/ioctl.h>
> > >  #include <linux/module.h>
> > >  #include <linux/of.h>
> > > +#include <linux/of_device.h>
> > >  #include <linux/platform_device.h>
> > >  #include <linux/pm_runtime.h>
> > >  #include <linux/regmap.h>
> > > @@ -28,8 +29,13 @@
> > >
> > >  #define MODULE_NAME  "sun6i-csi"
> > >
> > > +struct sun6i_csi_variant {
> > > +     unsigned long                   mod_rate;
> > > +};
> > > +
> > >  struct sun6i_csi_dev {
> > >       struct sun6i_csi                csi;
> > > +     const struct sun6i_csi_variant  *variant;
> > >       struct device                   *dev;
> > >
> > >       struct regmap                   *regmap;
> > > @@ -822,33 +828,43 @@ static int sun6i_csi_resource_request(struct sun6i_csi_dev *sdev,
> > >               return PTR_ERR(sdev->clk_mod);
> > >       }
> > >
> > > +     if (sdev->variant->mod_rate)
> > > +             clk_set_rate_exclusive(sdev->clk_mod, sdev->variant->mod_rate);
> > > +
> >
> > It still doesn't make any sense to do it in the probe function...
>
> I'm not sure we discussed about the context wrt probe, we discussed
> about exclusive put clock. Since clocks were enabling in set_power and
> clock rate can be set during probe in single time instead of setting
> it in set_power for every power enablement. anything wrong with that.
>
> >
> > We discussed this in the previous iteration already.
> >
> > What we didn't discuss is the variant function that you introduce,
> > while the previous approach was enough.
>
> We discussed about clk_rate_exclusive_put, and that even handle it in
> .remove right? so I have variant to handle it in sun6i_csi_remove.

Any comments?

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
