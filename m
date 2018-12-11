Return-Path: <SRS0=rVA4=OU=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 082E0C5CFFE
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 10:50:52 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CEE5B2081B
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 10:50:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="hIcXBPyK";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vMksWFBA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CEE5B2081B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=CkW36kL/3+Z606Q3z6pxtfl43KOpXs9+8ECBDEWEMzM=; b=hIcXBPyKVT58aw
	HhFUzWZAGmLFgFQYRouKsxg3jQRd69xoaHipobcdsH+nHWp/IK0SjUq+dAsF8wo2E69yoEUqCDaNp
	h42rQsLCrdLMs+OEvUsxzY4gTCgibHT7kWgrp+T3Zb9NIwM2M+ujqETOKyqgRdnw4AOT9JBbjG3uY
	DQCvTnSKPK8lBeJ4jEkiQupBr7L7sjwacLEXhI/vnEOmlyi+q2A3N1QVBvt4NWwtmt4t9rXnvU9nB
	5JvgpR29IWX48Z05ibxHbXpPtL/L4Ss/XFeHCDSBc3qvz5UE11kO/3M4+MJJ91SMMBxQVxUWs6Btd
	VnCjmcuhze4F3pdZT+Gg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gWfcn-0007H9-4n; Tue, 11 Dec 2018 10:50:49 +0000
Received: from mail-pg1-x541.google.com ([2607:f8b0:4864:20::541])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gWfbd-0004oT-Gu
 for linux-arm-kernel@lists.infradead.org; Tue, 11 Dec 2018 10:49:49 +0000
Received: by mail-pg1-x541.google.com with SMTP id n2so6465888pgm.3
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 11 Dec 2018 02:49:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=Y71fcmnIB/o2dLTOTXKfTEal8/+afznMcpckDqtgyns=;
 b=vMksWFBAHwBc0pXp1sFSLtI+ME+0QKpVbwr9Z/EOXgrSnccl4JSc9cxtq6A/srw8/5
 Ps3HYz0J/nNJhZQq7Dnr26SxHveovarI9Mi2RzuPt5f3AZ8pQdvryWvHqYb8LgLDcRoh
 9odh+q3wsBwH93Gq+hyD246dO0soOtcssK4hhziRGGxVjL3PFcGQj+qIdJFKrqLqRI5W
 NBAM3ltY1wf7Q4nYdH6QzebQ0AyEq0ie10Dy+6I3pQMRFrNlm6AgC4uMI8vBzZOn+4T0
 /FNJfDhUPj7SEOzz4GbFcVP+fWS+S+JOXwK+6XcnowLsVuC4ipaB7lmQ8o3tJU5fkl41
 x+tA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=Y71fcmnIB/o2dLTOTXKfTEal8/+afznMcpckDqtgyns=;
 b=G2QnsP6qeSVlOV/lPnO/ReCcBFzWHsXCdwQx0vVNJe8mLmMjb6YhX3ewJhIrZIuPeg
 K3xGlPlUzo0D2xVSBkdEHoAFE/+V30YYczD+l1suBAyHM6H8//iSSBirHCbVhK/34Nke
 BlAa9mlzxevQfbt/hmB7skU/JDo/qDoQCZfg+FD/U9t5hnuHkEtvzAhTi5blS/BUY5tW
 JCMPo6OU2BB1xLlPPY+MY9poHP9WmfYBpOnZhigPE8x8+KVHACGjLL3VQCSMSJEN2Pnz
 IlKavdfOskkH+A8LplPh/yhD3030dIguEZA2BOHYkKGtdeJG1BRhNfAJKpK1JwHVJC+W
 yE9g==
X-Gm-Message-State: AA+aEWbYkaiRKzAh50OjBUs8eHsTxJ/hGQoiJjV5f38RCpUs0qEbmKwn
 02ZfdWqqvvFANw1clIiMhUs3hlsn/mYaqi6y0K68+6kh
X-Google-Smtp-Source: AFSGD/WBu92paH2SZyoTzt3yo/RqRBi7d/uR08RbDZSIoHJI0pTa68usFSltcewwV3KJZwKYehhpMWkP42mT8CX5s9U=
X-Received: by 2002:a63:4611:: with SMTP id t17mr14042870pga.119.1544525366276; 
 Tue, 11 Dec 2018 02:49:26 -0800 (PST)
MIME-Version: 1.0
References: <1518717288-123578-1-git-send-email-giulio.benetti@micronovasrl.com>
 <CANwerB3Zr9axz+1rwCnNpLsX-xcOhOKEY4MT53v1+vzd99KRMg@mail.gmail.com>
 <57d929cf-4458-dae4-36d4-4e89170eba4a@micronovasrl.com>
In-Reply-To: <57d929cf-4458-dae4-36d4-4e89170eba4a@micronovasrl.com>
From: Jonathan Liu <net147@gmail.com>
Date: Tue, 11 Dec 2018 21:49:13 +1100
Message-ID: <CANwerB1aUP4Rw-B_qmzOu0BWmkpr-LQ5b4FKQbzZeeYHPtGoqA@mail.gmail.com>
Subject: Re: [PATCH] drm/sun4i: fix HSYNC and VSYNC polarity
To: Giulio Benetti <giulio.benetti@micronovasrl.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181211_024937_805027_6223489F 
X-CRM114-Status: GOOD (  31.21  )
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

On Thu, 6 Dec 2018 at 22:00, Giulio Benetti
<giulio.benetti@micronovasrl.com> wrote:
>
> Hi Jonathan,
>
> Il 06/12/2018 08:29, Jonathan Liu ha scritto:
> > Hi Giulio,
> >
> > On Thu, 15 Feb 2018 at 17:54, Giulio Benetti
> > <giulio.benetti@micronovasrl.com> wrote:
> >>
> >> Differently from other Lcd signals, HSYNC and VSYNC signals
> >> result inverted if their bits are cleared to 0.
> >>
> >> Invert their settings of IO_POL register.
> >>
> >> Signed-off-by: Giulio Benetti <giulio.benetti@micronovasrl.com>
> >> ---
> >>   drivers/gpu/drm/sun4i/sun4i_tcon.c | 4 ++--
> >>   1 file changed, 2 insertions(+), 2 deletions(-)
> >>
> >> diff --git a/drivers/gpu/drm/sun4i/sun4i_tcon.c b/drivers/gpu/drm/sun4i/sun4i_tcon.c
> >> index 3c15cf2..aaf911a 100644
> >> --- a/drivers/gpu/drm/sun4i/sun4i_tcon.c
> >> +++ b/drivers/gpu/drm/sun4i/sun4i_tcon.c
> >> @@ -389,10 +389,10 @@ static void sun4i_tcon0_mode_set_rgb(struct sun4i_tcon *tcon,
> >>                       SUN4I_TCON0_BASIC3_H_SYNC(hsync));
> >>
> >>          /* Setup the polarity of the various signals */
> >> -       if (!(mode->flags & DRM_MODE_FLAG_PHSYNC))
> >> +       if (mode->flags & DRM_MODE_FLAG_PHSYNC)
> >>                  val |= SUN4I_TCON0_IO_POL_HSYNC_POSITIVE;
> >>
> >> -       if (!(mode->flags & DRM_MODE_FLAG_PVSYNC))
> >> +       if (mode->flags & DRM_MODE_FLAG_PVSYNC)
> >>                  val |= SUN4I_TCON0_IO_POL_VSYNC_POSITIVE;
> >>
> >>          regmap_update_bits(tcon->regs, SUN4I_TCON0_IO_POL_REG,
> >
> > I am running Linux 4.19.6 and noticed with Olimex LCD-OLinuXino-7TS 7"
> > LCD touchscreen (Innolux AT070TN92) connected to Olimex
> > A20-OLinuXino-MICRO that the image does not display correctly after
> > this change.
> > The image is shifted to the right.
> >
> > Reverting the change results in the image being displayed correctly on
> > the screen.
> >
> > I have in the device tree a "panel" node with compatible =
> > "innolux,at070tn92" which uses the timings in
> > drivers/gpu/drm/panel/panel-simple.c.
> >
> > Any ideas?

>
> Checking Display Datasheet:
> https://www.olimex.com/Products/Retired/A13-LCD7-TS/resources/S700-AT070TN92.pdf
>
> Page 13 section 3.3.2 you can see it needs active low VS and HS.
>
> You can refer to this Thread and check scope captures about VS and HS
> versus TCON0_IOPOL register:
> https://lists.freedesktop.org/archives/dri-devel/2018-January/163874.html
>
> There should be something that wrongly sets one of these or both:
> mode->flags |= DRM_MODE_FLAG_PHSYNC;
> and/or
> mode->flags |= DRM_MODE_FLAG_PVSYNC;
>
> Checked in panel-simple.c but it's not there.

flags is 0 because it is not assigned in the struct definition for the panel.
Before this change, TCON0_IO_POL_REG would be 0x03000000 (both bits
set to 1) and image displays correctly.
After this change, TCON0_IO_POL_REG is 0x00000000 (both bits set to 0)
and image doesn't display correctly.

Checked using "devmem2 0x01c0c088" on A20-OLinuXino-MICRO Rev J.

>
> At the moment I don't have a board to check it with me, I'll try to do
> it soon, but I'm full with other work at the moment.
>
> If you have the chance to debug you could try to find in which point
> mode->flags gets changed with those 2 flags.
>
> When the problem came out I've noticed the same thing for u-boot too but
> it's been decided to not patch it because in that case every single
> sunxi defconfig had to be changed from:
> CONFIG_VIDEO_LCD_MODE="...,sync:3,..."
> to:
> CONFIG_VIDEO_LCD_MODE="...,sync:0,..."
> and it would have been a great mess, probably not worth it:
> https://lists.denx.de/pipermail/u-boot/2018-February/321405.html
>
> So keep in mind that TCON driver works differently for HS and
> VS(inverted) polarity in u-boot and linux.
>
> Hope to work this out soon.

Regards,
Jonathan

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
