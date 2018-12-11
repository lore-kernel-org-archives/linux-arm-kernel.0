Return-Path: <SRS0=rVA4=OU=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72B43C07E85
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 15:51:09 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 415DC2084E
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 15:51:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="DI9w2lfm";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="OILqvrq0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 415DC2084E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=oVFD6iKXtdhlO4D07rV+uCmBa9RPH3AzOYNV1TbIcrc=; b=DI9w2lfmb9SF91
	x1hKVJ/Mhj6NaYOG1sqdUMhw/UbCRIga2Y8y+QBCJh3JFkbKSOhHp58apQgiBuRZJj222MuwuMtJQ
	3zM5OpLRlXzT6zQ0kZ18ppZKBgWmmkrRRm70LETx8sY7DDba9F7bq1BAXL86RqZa+HxXJI/Rv+5Zl
	ZUumkXtCoU5yompwRFdUalzFMhvs6Ozp7k/TkUnCAr28vN6DBmmqnDf7sfdMQhvFMrbVXRO93kSMm
	HWrV4XxOxBcgA1tnwEJuu/0A9NX4EQtk3Vfjvt2r1dyOFSIt8Vbyh35u11mU4furC2oIy1uQAOwjh
	QF8zcBbIma3YqVRFgASA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gWkJP-0003RC-3O; Tue, 11 Dec 2018 15:51:07 +0000
Received: from mail-it1-x144.google.com ([2607:f8b0:4864:20::144])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gWkJL-0003Pb-VO
 for linux-arm-kernel@lists.infradead.org; Tue, 11 Dec 2018 15:51:05 +0000
Received: by mail-it1-x144.google.com with SMTP id a6so4542256itl.4
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 11 Dec 2018 07:50:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=buhmTM0IOM9w1CVo9f0D+FK2hv5Q2ihC95BTHKVk+CM=;
 b=OILqvrq0DNpN1vlBUSHb/zLGMGmRnRpAG5smli+3AnBDdZNgidTpFyf6CPwwza7jdA
 /wm9kGIc2lpX1VjkaAo+kEGhCqBARLu9SAGLPdoGHmgshhlta5OuQs69/871fFwcx1G7
 BWviVDJDwRqTXD1buykZ+fsVIanjqEXAtB5xY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=buhmTM0IOM9w1CVo9f0D+FK2hv5Q2ihC95BTHKVk+CM=;
 b=GwooQgKYjsTghPRKz/Wvml/ohM4HQoudYssC92OKasdMeeNZmGOTTGFXW36qAtCrhA
 5mrqzQWUXJitFSi6HjvTzSz90Vox9D5185kwJiMg1lLFD8KgEkk7TM6VGPJAceGp1i8a
 dhYFPh4IuA6wDhuYhj9krRrROjXqSDx4Rb+KQR4DFKfwHe1+Ye1y+qx8xY6xAWE1Xnni
 Gpdz0n+h7vMaaaCJX0hCeV7uJoORYzoinBVcWp+PZbfIY9qFcC6XyXsXMOjN0DGwdap3
 tKGarCL2MEOW4uFI6cSGsBO+X4WCl17Tugb0/mFeGVoFBacsywJ2mNZHUwJ9TbJbHHHE
 VIUg==
X-Gm-Message-State: AA+aEWZeWE1OblnsVRC3rlB6eMWzP3ymWyrnARPexArG53sOcmU3CsMG
 rqbsEQFMLaseYK3Atb94VPsAGdrKSUZLpQARSIEePQ==
X-Google-Smtp-Source: AFSGD/VP7tV2YVL5Fmxinos7XNSnNENKGBABy1AYLIaNFeidzWg3LW+R+qQcmtXzftx8/7fXpYDnONHEPvyA6QLafAk=
X-Received: by 2002:a24:10cb:: with SMTP id 194mr2707952ity.173.1544543452537; 
 Tue, 11 Dec 2018 07:50:52 -0800 (PST)
MIME-Version: 1.0
References: <20181210115246.8188-1-jagan@amarulasolutions.com>
 <20181210115246.8188-4-jagan@amarulasolutions.com>
 <20181211154427.uekytnmp2wlgxwm2@flea>
In-Reply-To: <20181211154427.uekytnmp2wlgxwm2@flea>
From: Jagan Teki <jagan@amarulasolutions.com>
Date: Tue, 11 Dec 2018 21:20:40 +0530
Message-ID: <CAMty3ZBA9W0MA7BR=Cn73KbE-fSs=WXe_47c_69JpizhbsXa-g@mail.gmail.com>
Subject: Re: [PATCH v3 3/6] media: sun6i: Set 300MHz mod clock for A64
To: Maxime Ripard <maxime.ripard@bootlin.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181211_075104_159652_7A4D3CCE 
X-CRM114-Status: GOOD (  17.44  )
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

On Tue, Dec 11, 2018 at 9:14 PM Maxime Ripard <maxime.ripard@bootlin.com> wrote:
>
> On Mon, Dec 10, 2018 at 05:22:43PM +0530, Jagan Teki wrote:
> > The default CSI_SCLK seems unable to drive the sensor to capture
> > the image, so update it to working clock rate 300MHz for A64.
> >
> > Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
> > ---
> >  drivers/media/platform/sunxi/sun6i-csi/sun6i_csi.c | 5 +++++
> >  1 file changed, 5 insertions(+)
> >
> > diff --git a/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi.c b/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi.c
> > index bbe45e893722..4b872800b244 100644
> > --- a/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi.c
> > +++ b/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi.c
> > @@ -822,6 +822,11 @@ static int sun6i_csi_resource_request(struct sun6i_csi_dev *sdev,
> >               return PTR_ERR(sdev->clk_mod);
> >       }
> >
> > +     /* A64 need 300MHz mod clock to operate properly */
> > +     if (of_device_is_compatible(pdev->dev.of_node,
> > +                                 "allwinner,sun50i-a64-csi"))
> > +             clk_set_rate_exclusive(sdev->clk_mod, 300000000);
> > +
>
> Where is that 300MHz coming from? You claim in your comment that it

from BSP, even "Chen-Yu Tsai" mentioned the same. (Chen-Yu, can you
comment here)

> "operates properly", yet in your previous mail about this, you were
> saying that 1080p @30Hz is broken. Which one is it?

1080p is broken from sensor end, ie what I mentioned on the respective mail.

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
