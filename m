Return-Path: <SRS0=qRPW=OW=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BF89C67839
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 03:09:07 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5B8E520873
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 03:09:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="hYi/S/RQ";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B14On8VR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5B8E520873
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=k2ZspM5luh2M5mBiXm6kCaQW5X73S7LJ8/PqUz6DYno=; b=hYi/S/RQLbRrfb
	j5uWcKenbW+AIm4i26MwD4xJxrNqb0NJLKmCiP5uHky9X3AKqHBQ/qGUhaHvXkcR9f09Ljy6W5Dkk
	jMVT9+p6mQj169KKn/x+kmR0KDzQOXI/u1ppJhfcZH1i8V0D2e4mQX2fX+SMgoJ3z82l0nL5YXm66
	Oknonu+x96IAm0enCSGh5Zii5XUC1hUMO6QcGPZnvbpjDss+Hfovc68fJEbBLLFsamNU0OH3dXiz+
	5OkiODmN32y6tfARhsRO2dVs1qsQd45bnUzQPziKbhc1c2h2xmq5TF4Bef93vekvkbMK5hWxz8DwB
	gvg1OCPEJ/+PRWdEFOug==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gXHN2-0007xG-Uo; Thu, 13 Dec 2018 03:09:04 +0000
Received: from mail-pg1-x541.google.com ([2607:f8b0:4864:20::541])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gXHMy-0007wF-Pw
 for linux-arm-kernel@lists.infradead.org; Thu, 13 Dec 2018 03:09:02 +0000
Received: by mail-pg1-x541.google.com with SMTP id n2so332982pgm.3
 for <linux-arm-kernel@lists.infradead.org>;
 Wed, 12 Dec 2018 19:08:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=Pa3pitxVOIgccMX4WhlRVlf6/PcJdehLwmQVlxKOIC0=;
 b=B14On8VRotF6Py4iOBoKUhgHDv+qIx2hFkNfOFtWcDpSdDcTeUCWvSPRU7CChUWKaQ
 F8YUDI+eUdH+Nf+1zOehAzVDlbf7LATH7YNePclmpdVOfW6N8URyWxfUivTgRSI/yAjW
 01fHzcB/lEaPRC/S/UP+t62tWg+Ps/3WDkPgOpWRTGy49hHg8ioG6rtA+gctZGE9S+GL
 ret/r6mwNImVA/my0MdN59El7saYPg5BZpkC5h3uqqIfyfUJF1zOF2I5y4gYcNulI5yB
 k9KfCjNoK/6KZrtuC5BUo62diCoKG3CzkU5WykFq3o/C1Fd+urdFV4uHfKYUnt/V4wgD
 yhWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=Pa3pitxVOIgccMX4WhlRVlf6/PcJdehLwmQVlxKOIC0=;
 b=VaOrVeCvHtBojZBaYfrUBFsK8EaIzqfUIv1RHyREuU9V2mHhIUjQB71CkmALYG/J4w
 6bkwAhL0Fg9DU5YDJrll0cpo3BxDjuEtueMF4quf2hPUHmwAnTWqETv3bBDgk/CVjtn2
 F91BNIwfGRepjXGEw9CGuXpfMV28kdDYlqwMIlNf+fq3Q6tPvZ2J2GzHvwWFKzhfaMT0
 uba/BEPoI/2o2XhbRib+MtBo/DIH1xwyqMoNcOrN9fWt4/hDLVdOpRQn3osQNa2ysS/3
 bIsZTBAe6P+F/Qxs8lSLB8+bVGyxahif2cbHJtoGh/WV2ohEoIy+TZIt+5U3ZuMcqQQ6
 S/Pg==
X-Gm-Message-State: AA+aEWYpIjC5jsw+2yYRJsts4LDuLVkpoNP6nA9m56pHdrvzCxKjk5gb
 pniswdY3IjXZfJby9MO6nY/1XHG1jdZavn1aJxY=
X-Google-Smtp-Source: AFSGD/UpqfrHKBiLnaW6Owo02FkE8ACZ3WFuMgTeWwJ4hC0wNUnbjmSGSi8Bjyl/ZzOPP/z3zA3Hk9RlwBgZgvrBrFc=
X-Received: by 2002:a62:184e:: with SMTP id 75mr22138899pfy.28.1544670529717; 
 Wed, 12 Dec 2018 19:08:49 -0800 (PST)
MIME-Version: 1.0
References: <1518717288-123578-1-git-send-email-giulio.benetti@micronovasrl.com>
 <CANwerB3Zr9axz+1rwCnNpLsX-xcOhOKEY4MT53v1+vzd99KRMg@mail.gmail.com>
 <57d929cf-4458-dae4-36d4-4e89170eba4a@micronovasrl.com>
 <CANwerB1aUP4Rw-B_qmzOu0BWmkpr-LQ5b4FKQbzZeeYHPtGoqA@mail.gmail.com>
 <05786c98-6bc9-44f1-91ea-14452448cced@micronovasrl.com>
In-Reply-To: <05786c98-6bc9-44f1-91ea-14452448cced@micronovasrl.com>
From: Jonathan Liu <net147@gmail.com>
Date: Thu, 13 Dec 2018 14:08:18 +1100
Message-ID: <CANwerB0mR3NK8488g4bWCroEzoEQkoE+btVivq9m_TzHctTfuQ@mail.gmail.com>
Subject: Re: [PATCH] drm/sun4i: fix HSYNC and VSYNC polarity
To: Giulio Benetti <giulio.benetti@micronovasrl.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181212_190900_842274_EE8CD259 
X-CRM114-Status: GOOD (  32.45  )
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
Cc: dri-devel <dri-devel@lists.freedesktop.org>,
 Maxime Ripard <maxime.ripard@free-electrons.com>, Chen-Yu Tsai <wens@csie.org>,
 linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
 linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi Giulio,

On Wed, 12 Dec 2018 at 04:20, Giulio Benetti
<giulio.benetti@micronovasrl.com> wrote:
>
> Hi Jonathan,
>
> Il 11/12/2018 11:49, Jonathan Liu ha scritto:
> > Hi Giulio,
> >
> > On Thu, 6 Dec 2018 at 22:00, Giulio Benetti
> > <giulio.benetti@micronovasrl.com> wrote:
> >>
> >> Hi Jonathan,
> >>
> >> Il 06/12/2018 08:29, Jonathan Liu ha scritto:
> >>> Hi Giulio,
> >>>
> >>> On Thu, 15 Feb 2018 at 17:54, Giulio Benetti
> >>> <giulio.benetti@micronovasrl.com> wrote:
> >>>>
> >>>> Differently from other Lcd signals, HSYNC and VSYNC signals
> >>>> result inverted if their bits are cleared to 0.
> >>>>
> >>>> Invert their settings of IO_POL register.
> >>>>
> >>>> Signed-off-by: Giulio Benetti <giulio.benetti@micronovasrl.com>
> >>>> ---
> >>>>    drivers/gpu/drm/sun4i/sun4i_tcon.c | 4 ++--
> >>>>    1 file changed, 2 insertions(+), 2 deletions(-)
> >>>>
> >>>> diff --git a/drivers/gpu/drm/sun4i/sun4i_tcon.c b/drivers/gpu/drm/sun4i/sun4i_tcon.c
> >>>> index 3c15cf2..aaf911a 100644
> >>>> --- a/drivers/gpu/drm/sun4i/sun4i_tcon.c
> >>>> +++ b/drivers/gpu/drm/sun4i/sun4i_tcon.c
> >>>> @@ -389,10 +389,10 @@ static void sun4i_tcon0_mode_set_rgb(struct sun4i_tcon *tcon,
> >>>>                        SUN4I_TCON0_BASIC3_H_SYNC(hsync));
> >>>>
> >>>>           /* Setup the polarity of the various signals */
> >>>> -       if (!(mode->flags & DRM_MODE_FLAG_PHSYNC))
> >>>> +       if (mode->flags & DRM_MODE_FLAG_PHSYNC)
> >>>>                   val |= SUN4I_TCON0_IO_POL_HSYNC_POSITIVE;
> >>>>
> >>>> -       if (!(mode->flags & DRM_MODE_FLAG_PVSYNC))
> >>>> +       if (mode->flags & DRM_MODE_FLAG_PVSYNC)
> >>>>                   val |= SUN4I_TCON0_IO_POL_VSYNC_POSITIVE;
> >>>>
> >>>>           regmap_update_bits(tcon->regs, SUN4I_TCON0_IO_POL_REG,
> >>>
> >>> I am running Linux 4.19.6 and noticed with Olimex LCD-OLinuXino-7TS 7"
> >>> LCD touchscreen (Innolux AT070TN92) connected to Olimex
> >>> A20-OLinuXino-MICRO that the image does not display correctly after
> >>> this change.
> >>> The image is shifted to the right.
> >>>
> >>> Reverting the change results in the image being displayed correctly on
> >>> the screen.
> >>>
> >>> I have in the device tree a "panel" node with compatible =
> >>> "innolux,at070tn92" which uses the timings in
> >>> drivers/gpu/drm/panel/panel-simple.c.
> >>>
> >>> Any ideas?
> >
> >>
> >> Checking Display Datasheet:
> >> https://www.olimex.com/Products/Retired/A13-LCD7-TS/resources/S700-AT070TN92.pdf
> >>
> >> Page 13 section 3.3.2 you can see it needs active low VS and HS.
> >>
> >> You can refer to this Thread and check scope captures about VS and HS
> >> versus TCON0_IOPOL register:
> >> https://lists.freedesktop.org/archives/dri-devel/2018-January/163874.html
> >>
> >> There should be something that wrongly sets one of these or both:
> >> mode->flags |= DRM_MODE_FLAG_PHSYNC;
> >> and/or
> >> mode->flags |= DRM_MODE_FLAG_PVSYNC;
> >>
> >> Checked in panel-simple.c but it's not there.

> >
> > flags is 0 because it is not assigned in the struct definition for the panel.
>
> I don't think it is 0, because otherwise IO_POL_REG wouldn't be set to
> 0x03000000 but to 0.
> What is checked is exactly mode->flags, so the problem seems to be upstream.
>
> This is my doubt, it seems mode->flags is not initialized or overriden
> at a certain point, this is why I want to debug it with Jtag tomorrow.
>

If you look at the change made by your patch:
--- a/drivers/gpu/drm/sun4i/sun4i_tcon.c
+++ b/drivers/gpu/drm/sun4i/sun4i_tcon.c
@@ -389,10 +389,10 @@ static void sun4i_tcon0_mode_set_rgb(struct
sun4i_tcon *tcon,
                     SUN4I_TCON0_BASIC3_H_SYNC(hsync));

        /* Setup the polarity of the various signals */
-       if (!(mode->flags & DRM_MODE_FLAG_PHSYNC))
+       if (mode->flags & DRM_MODE_FLAG_PHSYNC)
                val |= SUN4I_TCON0_IO_POL_HSYNC_POSITIVE;

-       if (!(mode->flags & DRM_MODE_FLAG_PVSYNC))
+       if (mode->flags & DRM_MODE_FLAG_PVSYNC)
                val |= SUN4I_TCON0_IO_POL_VSYNC_POSITIVE;

        regmap_update_bits(tcon->regs, SUN4I_TCON0_IO_POL_REG,

If mode->flags is 0, then before your change it would set
SUN4I_TCON0_IO_POL_HSYNC_POSITIVE and
SUN4I_TCON0_IO_POL_VSYNC_POSITIVE bits to 1 (resulting in 0x03000000).
If mode->flags is not 0, then after your change it would not set
SUN4I_TCON0_IO_POL_HSYNC_POSITIVE and
SUN4I_TCON0_IO_POL_VSYNC_POSITIVE bits to 1 (resulting in 0x00000000).

> > Before this change, TCON0_IO_POL_REG would be 0x03000000 (both bits
> > set to 1) and image displays correctly > After this change, TCON0_IO_POL_REG is 0x00000000 (both bits set to 0)
> > and image doesn't display correctly.
> >
> > Checked using "devmem2 0x01c0c088" on A20-OLinuXino-MICRO Rev J.
>
> 0x03000000 as I've triple checked with scope means Positive H/Vsync,
> and 0x00000000 Negative H/VSync.
>
> Please check on the Thread I've pointed you above where there are all
> the links to the scope captures.
>
> Are you completely sure you're using the correct panel?

Yes, I am sure I am using the correct panel. It has the following
marking on sticker:
AT070TN92V.X 89A070ZZ-0K1

> This is because if with 0x03000000 it works correctly, it means that
> you're using Positive VS and HS but on datasheet on Figure 3.2 it shows
> that they must be negative.
>
> Do you have any chance to measure those signals with a scope?

No.

>
> Tomorrow, while debugging, I'll re-check H/Vsync signals again.
>

Thanks.

Regards,
Jonathan

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
