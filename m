Return-Path: <SRS0=DN+v=OP=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFC9FC04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 07:29:47 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8FB4A20989
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 07:29:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="uoXNRvLP";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O3cknnJY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8FB4A20989
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=6ez4bCSzV4pbptYogz60UKtSToXc5yXXw7MxB+8TGwk=; b=uoXNRvLPfykGvt
	O4R1pVtsr7889B9jMas0lHprCuH6HLtRj0XLrUEoJBzAy4pCosRLkVkyFCK5++LCTm7RYA4wP2Prc
	2Sj6l2m3F9a718T2EsSs4LvRGj9k5ugpV81QwsAO2WjhXx/APAWSbu8vPGkS1EzRWoHZtigvnbLfj
	AI28ftz182UGdSXo68JshlApjyVkwGTRWJMcyW/7anfVlTuBa5UFImzlkqGudD8BxPJ4u9HJTH8q2
	npCN3ybIJrEE3CK8KGXSWnoXu6KatKwB8FSIeDnADFFPdGH443iqPE6/ifpkIn6P/ik32Ewq/bVsx
	1MUFN2CFrN2jXvthnjZw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gUo6Q-0003mF-U1; Thu, 06 Dec 2018 07:29:42 +0000
Received: from mail-pl1-x644.google.com ([2607:f8b0:4864:20::644])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gUo6L-0003lF-NH
 for linux-arm-kernel@lists.infradead.org; Thu, 06 Dec 2018 07:29:41 +0000
Received: by mail-pl1-x644.google.com with SMTP id t13so11357309ply.13
 for <linux-arm-kernel@lists.infradead.org>;
 Wed, 05 Dec 2018 23:29:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=9URZ+wcpgMphsBNvFO+OztPEZ7JTHqRcySRnbHG7IMg=;
 b=O3cknnJYAt+SUQQDN1JH/t5GEh4cu6hKP4za5JTn4d1kJBkXuPNlUsR8/owqlKYpNE
 Hk+A+VrgenAXV9Uxjn6IF/+nFVYBH4mgSu03P5EvL0Tdi0vLRVEhsoZK083thkgKLWvX
 s8JGQ+OYQAXyY16W60me0XdZN8UM/SbRwnLjTCW13lE/z/nLQ+qI7rBI6g8LQbVTE8WU
 ymEHkaEFMmaU/Hvp4XM8ABOho6069+ECVmQHCDzbOxDQyXBc43VMaAiDw1l42gsVhbo4
 sIuf/6kYhSxr3rzgFO+XJnFgHdvXJKbDEhd+LOxkNXxTOW2w2J3+n999QDSvret7cEnv
 3tQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=9URZ+wcpgMphsBNvFO+OztPEZ7JTHqRcySRnbHG7IMg=;
 b=SQ/8l6uSKIVifnECsoL3oAwQRIQcc5CmsC4rfVtgHyI1uspWS1LQyrSzmsDPP3FVaf
 oPRtNqRTH2v1MwA3JXATmNIy2iKWi2JGp94QyLKbKDPvi47Jl344PSJUnitC7MwtYUMk
 YQRlapl2ROIWNh7RGEOMdmZhsmY9AI3TpwkggQayEPZtUNcsF2g8gXf1ooAwJRhvXg1W
 KR0gTVONiLTE10uBxmGd7hNa4eFOdI0dTaNwJB+FM4rvxCHWGfKApJzOs7oCM1nmzzqF
 OJFXOzGC2pJ/2rbBW0/fq6b4v7TvqoQmyrmohRfAJJjRY2CtAf0lZxdkK5bEMkNUsHhh
 3+2A==
X-Gm-Message-State: AA+aEWaTm5jBN65iEZK538NwfRIU+zxAbOxZPl15HvJGFAZHVEqeVpKI
 mh7AtAVdZiMJsNuvZGtJ1lmAHJEDQBNarnNyr1Q=
X-Google-Smtp-Source: AFSGD/U+qUFPwro6s+6xJ3AXXRoi8m+YPUzLn7SyTq6AlZDlz1sXcOpT16M9VR3K2kFvzITzFEEcWyKGtMGr+v8k5jc=
X-Received: by 2002:a17:902:780a:: with SMTP id
 p10mr27896073pll.54.1544081366249; 
 Wed, 05 Dec 2018 23:29:26 -0800 (PST)
MIME-Version: 1.0
References: <1518717288-123578-1-git-send-email-giulio.benetti@micronovasrl.com>
In-Reply-To: <1518717288-123578-1-git-send-email-giulio.benetti@micronovasrl.com>
From: Jonathan Liu <net147@gmail.com>
Date: Thu, 6 Dec 2018 18:29:00 +1100
Message-ID: <CANwerB3Zr9axz+1rwCnNpLsX-xcOhOKEY4MT53v1+vzd99KRMg@mail.gmail.com>
Subject: Re: [PATCH] drm/sun4i: fix HSYNC and VSYNC polarity
To: Giulio Benetti <giulio.benetti@micronovasrl.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181205_232937_762521_6DE693B9 
X-CRM114-Status: GOOD (  18.45  )
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

On Thu, 15 Feb 2018 at 17:54, Giulio Benetti
<giulio.benetti@micronovasrl.com> wrote:
>
> Differently from other Lcd signals, HSYNC and VSYNC signals
> result inverted if their bits are cleared to 0.
>
> Invert their settings of IO_POL register.
>
> Signed-off-by: Giulio Benetti <giulio.benetti@micronovasrl.com>
> ---
>  drivers/gpu/drm/sun4i/sun4i_tcon.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/sun4i/sun4i_tcon.c b/drivers/gpu/drm/sun4i/sun4i_tcon.c
> index 3c15cf2..aaf911a 100644
> --- a/drivers/gpu/drm/sun4i/sun4i_tcon.c
> +++ b/drivers/gpu/drm/sun4i/sun4i_tcon.c
> @@ -389,10 +389,10 @@ static void sun4i_tcon0_mode_set_rgb(struct sun4i_tcon *tcon,
>                      SUN4I_TCON0_BASIC3_H_SYNC(hsync));
>
>         /* Setup the polarity of the various signals */
> -       if (!(mode->flags & DRM_MODE_FLAG_PHSYNC))
> +       if (mode->flags & DRM_MODE_FLAG_PHSYNC)
>                 val |= SUN4I_TCON0_IO_POL_HSYNC_POSITIVE;
>
> -       if (!(mode->flags & DRM_MODE_FLAG_PVSYNC))
> +       if (mode->flags & DRM_MODE_FLAG_PVSYNC)
>                 val |= SUN4I_TCON0_IO_POL_VSYNC_POSITIVE;
>
>         regmap_update_bits(tcon->regs, SUN4I_TCON0_IO_POL_REG,

I am running Linux 4.19.6 and noticed with Olimex LCD-OLinuXino-7TS 7"
LCD touchscreen (Innolux AT070TN92) connected to Olimex
A20-OLinuXino-MICRO that the image does not display correctly after
this change.
The image is shifted to the right.

Reverting the change results in the image being displayed correctly on
the screen.

I have in the device tree a "panel" node with compatible =
"innolux,at070tn92" which uses the timings in
drivers/gpu/drm/panel/panel-simple.c.

Any ideas?

Thanks.

Regards,
Jonathan

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
