Return-Path: <SRS0=LcWp=QO=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CA5FC282C2
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 21:02:39 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DB2222175B
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 21:02:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="sb5B2bOl";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ETiqm+nK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DB2222175B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=u7jbvAIULcSXDzLpul6Wdxc6wYger26qARgAeRv3zQY=; b=sb5B2bOlShLLt1
	neYsRr3g2mI3febnYtc8L4zNbFiRZFlmbGWAgCNcb7Xfdsj0hCdvAAmI2V5AMIJXldt8U20Uv62Nk
	2UKO/ugbgYnnpxeV5myPBOn3yGtddajqJUJ+42gCOiJqHPHUmLUcMk6/ABkKHjWZ9iIh5d0Cb/OWt
	7O16yRlmNRXd1e7Qq2Rd4cM1I5JgGp2m0oJ3IBtewENrTFvOaT57z5afBR9PxINWipvYtXliFWIhH
	vWgZ7HCB8lE0lH0lkDCKXEvi6tBHDm5aKQIizObsHfmN4Tqc/PRb84j//BmNaxeHv5xzwdjEFKahE
	Hpe78+VflTWh3f6l0Qyg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1grqod-0003m2-UG; Thu, 07 Feb 2019 21:02:35 +0000
Received: from mail-lj1-x242.google.com ([2a00:1450:4864:20::242])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1grqob-0003lW-9F
 for linux-arm-kernel@lists.infradead.org; Thu, 07 Feb 2019 21:02:34 +0000
Received: by mail-lj1-x242.google.com with SMTP id s5-v6so1083879ljd.12
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 07 Feb 2019 13:02:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=RPcqfJ6018DTiZiVgb9SE/lxTqA0els9awdMkRxfAdw=;
 b=ETiqm+nKJJCJgEL+9oD0jnHBkQmyXp/Ulf9/0fj2Wh1sdWrI2gRFN5xTI07SvFSg4l
 w4czI/4wni9oSTU8B0vPuUtCrchXBkRAfksm/52CVAjgU0Yapoes5MgjHimuPu3Nzgzj
 ydoKHMEfwuWAIk6xc8Aky4MWnGfOEE2t2s/y2HfrMC1drq1b3M9d7Zk/I4lu1JqO8A1s
 k4D9iqpwkzMgCGAZGheokQV6fgDCr8rV0qdNrGwPlI+3Xd667Yuq3rRNOncKa6u/3cFk
 QM5WhGUIeqVw91r7iPp/oNDSaULe9u3Pa9gwaMT0NYp59TX3ZBcnAZNHTwyL/lV/GNrd
 jfWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=RPcqfJ6018DTiZiVgb9SE/lxTqA0els9awdMkRxfAdw=;
 b=D11hZhmIYQigoi31cqK1oRhAUrKyDtTI7nbx9Pj6quW3n8jAANq0n+zbrnsKXSVlqe
 KkvW9/uaxkViadrG5ySSqgygZMoHM9yItfWMj+v0AGAkxEBG6ZQ1096rvU1NmZtd8jCG
 8E55mmd8Dln8WXw04P+1dhyAbfxJ71xEzEUp8zF0iuAKnE9iFSnOr0lovgmwR4uplYPh
 Kw4MFO5jsunw/pEtxqXNNWHp38MeQ+qriBE7/88h+9HMSr5YfmFdZTfjOifg3q3zIKPE
 YvpXtO7wo+0BFf+BiY9NsLjoZ09CQfF7qTJBn91RdhwCaPuzcsCVCBOC21jP0k30nRBi
 ks0Q==
X-Gm-Message-State: AHQUAubHKDUD1uUaEarjvEdluihJWrMdjNgmQB4pT6Q6ezwsCDL7OwbL
 F4y7/qPmIiqtHrEh8VfnR73cr4SbmnUt9M3cSOS6dA==
X-Google-Smtp-Source: AHgI3Ibi9vEI5VuW17s6atk0ll5+AJGQcxQ/tuwEi0lILBdcEe8JAmLFZHIq4WLloz3bcFmVhL6zThcDA5i+skJyG+M=
X-Received: by 2002:a2e:2d11:: with SMTP id
 t17-v6mr11098489ljt.159.1549573350664; 
 Thu, 07 Feb 2019 13:02:30 -0800 (PST)
MIME-Version: 1.0
References: <20190207083647.20615-1-linus.walleij@linaro.org>
 <20190207083647.20615-2-linus.walleij@linaro.org>
 <20190207091706.GQ3271@phenom.ffwll.local>
In-Reply-To: <20190207091706.GQ3271@phenom.ffwll.local>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Thu, 7 Feb 2019 22:02:17 +0100
Message-ID: <CACRpkda4Ts_Hemg_sWXG5AK4Ht7UmA7=SAtXvg8KDw2-0SdYBQ@mail.gmail.com>
Subject: Re: [PATCH 1/4] drm/simple_kms_helper: enable use of external encoder
To: Daniel Vetter <daniel@ffwll.ch>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190207_130233_331566_A63C6175 
X-CRM114-Status: GOOD (  17.71  )
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
Cc: David Airlie <airlied@linux.ie>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>,
 "open list:DRM PANEL DRIVERS" <dri-devel@lists.freedesktop.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Thu, Feb 7, 2019 at 10:17 AM Daniel Vetter <daniel@ffwll.ch> wrote:
> On Thu, Feb 07, 2019 at 09:36:44AM +0100, Linus Walleij wrote:

> > This makes it possible to pass a connector with an already
> > attached external encoder into the simple KMS helper.
> >
> > This is helpful for my MCDE drivers, as it is pretty simple
> > but uses DSI to communicate with the displays and bridges.
> > DSI requires the use of the DSI bus which in turn requires
> > us to set up a custom connector from the display driver.
>
> So the idea was that you'd just use a bridge for this, if you need more
> than a dummy encoder. I'm a bit worried about mission creep for the simple
> helpers, sooner or later we'll add extensions and then we're back to full
> kms, except it's a hairball of classic midlayer mistake ...
>
> See drm_simple_display_pipe_attach_bridge().

Attaching bridges usually work fine for simple KMS drivers,
like the panel bridge, or the dumb VGA bridge or even
the HDMI encoder bridges so I'm on board with that.

The thing is that the DSI driver is using the panel bridge
(and has a placeholder for using other bridges) already.
So we end up wrapping the DSI host device(s) with a
"my DSI bridge" using another
bridge (panel) IIUC.

display driver -> custom DSI bridge -> panel bridge -> panel

The endpoint bridge (the panel) has all information on
resolution etc. So this means we will need to just pass this
information through to the next step in the pipe I
suppose.

I just want to confirm that I'm on the right track here before
I code another thousand lines of code for this :)

Yours,
Linus Walleij

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
