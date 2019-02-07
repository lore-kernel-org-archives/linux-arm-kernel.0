Return-Path: <SRS0=LcWp=QO=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD364C282C2
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 21:43:10 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8AABB2175B
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 21:43:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="JQK359Hv";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="ScV3Ht47"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8AABB2175B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=3QOTU6ude3Jvva5alqcaKbQIrfonXkDgA2meYCBb4VY=; b=JQK359HvMcpkpX
	VMHO9hCzRP1eHHj1eH7esQ1PyhuFI7nqT7Lak8pbUKbmWl04TR4pR9numLslfXQIzBH0SJVuwFB+V
	Ehj/6N3w1I7iSjeynL4b7TAlX5hYPvG2eHcYPsGyrj+N+ZZrYkQjk7aHDRMh1EH9dutVvY5BvA6s6
	7EX2+vXhXC+RZFIIWq/ZZJSbk5p93RLt8z4ArbXAvN0X8B8J50wVfI2vOTrWIagB+q5hcI0hacQFE
	mQF619KTcGyXhmzGx/ju/LrVyNUhJBGvGCZFWzZcayNU+gpkIrqe/NjxtXG368UafWJdlNOozLvXf
	jvnsV+FmyX2WQ4SiOj8w==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1grrRt-0004Dw-Dc; Thu, 07 Feb 2019 21:43:09 +0000
Received: from mail-ed1-x542.google.com ([2a00:1450:4864:20::542])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1grrRq-0004Dc-Ap
 for linux-arm-kernel@lists.infradead.org; Thu, 07 Feb 2019 21:43:08 +0000
Received: by mail-ed1-x542.google.com with SMTP id d12so1155481edy.3
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 07 Feb 2019 13:43:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ffwll.ch; s=google;
 h=sender:date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=Mg5ydhu8VRGdtv8bKvpmBPd0T4WeQxylSs165lDpiyU=;
 b=ScV3Ht47Ci1EM27e7/QKxYE769uMy+uEXhselJygP9owOa7eMlkvW6x0ByJOVX0Xx5
 c54ZWh5+S1TX+9ZYLbxV3xnoNNndMrVoN+uoliiWjbm+daliJXts49Z2ZLfRZIV/S9ur
 vRkkPTgcQ9TQ6mLQdzBXiARsAJdF3ZIVjM5m0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
 :references:mime-version:content-disposition:in-reply-to:user-agent;
 bh=Mg5ydhu8VRGdtv8bKvpmBPd0T4WeQxylSs165lDpiyU=;
 b=LHzrZMJ8NcIbO+yx6eEBKZwhANeyPyxYhhTjRlUT120SkUaN1UJe3Vc/sBc+lPA67t
 xaBVihWHCbRVeGTO6MLTy6+2i1t+3S5FhH8TzOJ7gtdO5HfPx9rKtqNOsqjrkJ20X+iY
 wAmjGsnrZJq7Gil84oE9nKuajUogCFGWI65WkkRDeYPjiVfQ9EE+O+LSwblxcKUg4drT
 oPg5ZJiY0UeP3SGls/skBZUQ4WMIm3jP47wqoVO98eiONdT7gdag/KEn+r7HvZCI0E/o
 aVd+gX0jIVncC+z1d13Go6LR8lU0WjGTWltr2DUBj3EroM13PXbeN1uyPbAJhiQ34Ung
 RHqA==
X-Gm-Message-State: AHQUAuaNJuzF/56WVEP/1HGQp5u+OedUh7bubsxi4NFxJs9TIr7ml0iC
 nLJ+FTi5Mg6JwNWdf/iAnP3o5A==
X-Google-Smtp-Source: AHgI3IZCtdEINaScVEEyQdbhaL4Jlc+Xq2zZrB37B9Jt0v3/zDnVb9V5dSMRIcbjfVryP9vdZDLj6Q==
X-Received: by 2002:a17:906:68c8:: with SMTP id
 y8mr13234572ejr.87.1549575783816; 
 Thu, 07 Feb 2019 13:43:03 -0800 (PST)
Received: from phenom.ffwll.local ([2a02:168:569e:0:3106:d637:d723:e855])
 by smtp.gmail.com with ESMTPSA id s7sm101274ejm.11.2019.02.07.13.43.02
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Thu, 07 Feb 2019 13:43:03 -0800 (PST)
Date: Thu, 7 Feb 2019 22:43:01 +0100
From: Daniel Vetter <daniel@ffwll.ch>
To: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH 1/4] drm/simple_kms_helper: enable use of external encoder
Message-ID: <20190207214301.GB23159@phenom.ffwll.local>
References: <20190207083647.20615-1-linus.walleij@linaro.org>
 <20190207083647.20615-2-linus.walleij@linaro.org>
 <20190207091706.GQ3271@phenom.ffwll.local>
 <CACRpkda4Ts_Hemg_sWXG5AK4Ht7UmA7=SAtXvg8KDw2-0SdYBQ@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CACRpkda4Ts_Hemg_sWXG5AK4Ht7UmA7=SAtXvg8KDw2-0SdYBQ@mail.gmail.com>
X-Operating-System: Linux phenom 4.19.0-1-amd64 
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190207_134306_376004_55E051A9 
X-CRM114-Status: GOOD (  23.91  )
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
 "open list:DRM PANEL DRIVERS" <dri-devel@lists.freedesktop.org>,
 Daniel Vetter <daniel@ffwll.ch>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Thu, Feb 07, 2019 at 10:02:17PM +0100, Linus Walleij wrote:
> On Thu, Feb 7, 2019 at 10:17 AM Daniel Vetter <daniel@ffwll.ch> wrote:
> > On Thu, Feb 07, 2019 at 09:36:44AM +0100, Linus Walleij wrote:
> 
> > > This makes it possible to pass a connector with an already
> > > attached external encoder into the simple KMS helper.
> > >
> > > This is helpful for my MCDE drivers, as it is pretty simple
> > > but uses DSI to communicate with the displays and bridges.
> > > DSI requires the use of the DSI bus which in turn requires
> > > us to set up a custom connector from the display driver.
> >
> > So the idea was that you'd just use a bridge for this, if you need more
> > than a dummy encoder. I'm a bit worried about mission creep for the simple
> > helpers, sooner or later we'll add extensions and then we're back to full
> > kms, except it's a hairball of classic midlayer mistake ...
> >
> > See drm_simple_display_pipe_attach_bridge().
> 
> Attaching bridges usually work fine for simple KMS drivers,
> like the panel bridge, or the dumb VGA bridge or even
> the HDMI encoder bridges so I'm on board with that.
> 
> The thing is that the DSI driver is using the panel bridge
> (and has a placeholder for using other bridges) already.
> So we end up wrapping the DSI host device(s) with a
> "my DSI bridge" using another
> bridge (panel) IIUC.
> 
> display driver -> custom DSI bridge -> panel bridge -> panel
> 
> The endpoint bridge (the panel) has all information on
> resolution etc. So this means we will need to just pass this
> information through to the next step in the pipe I
> suppose.

Hm, if you have you're mode_check functions working correctly (i.e. make
sure the mode userspace asks for is the one the panel ones), then the mode
will be in the crtc_state->requested_mode that the atomic helpers already
hand to all the bridges. Or well would, if bridge wouldn't have predated
atomic, so this is all a bit a more a mess than strictly needed. But you
should be getting the right mode already.

> I just want to confirm that I'm on the right track here before
> I code another thousand lines of code for this :)

bridges are supposed to be stackable, but I think you're the first to find
out whether that actually works. Afaiui the real stacking fun is if you
need to have some state between the bridges, because you e.g. have a
scaler or transcoder or something like that in-between.

Looking at your patch, converting the encoder into a bridge, and chaining
up the bridges in the right order, is all that should be needed really.
Not retyping the 1k lines of code that actually does stuff.
-Daniel
-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
