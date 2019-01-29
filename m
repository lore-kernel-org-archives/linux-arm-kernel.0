Return-Path: <SRS0=P47x=QF=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03E05C282C7
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 09:58:54 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C5F342177E
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 09:58:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="l9fRqCbl";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="SBSp1SW4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C5F342177E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=55OypFimTSDiQzzkwfj8tBxWGmMUHnI0unXdXMFgtZ8=; b=l9fRqCblArnlpp
	FXTTwxMk/Sg06BZoIpDJqLrKAo7/8wr3Fo31AEjYoAUcg3ayO3I2OYZpr/JzqYqSomch77miqnVM9
	vfaJC7sfwGWFJmQdK0J71tfl7tjED4ZFNTIBVr9rEp4B3C4vGCDZUJ1IiRrWXrha+1g6fgGLmyJpN
	dMAoeUZVBdK1QV7L5FQLK5/Lx54tcfELAaAxlGoMvQ8Q67NBNe88jmQKMWnbFzWl+Rf+qCwjX1oii
	AYjRS0XpcUbt5R31IRCDGR+JDePd6PUnymtPOjrJfR+SBfzi1sJ0G0dJb2sI42vLql7QUmXs7SpU/
	Yx6IIhvonG4Ih7LxCwVA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1goQAO-0006ih-K1; Tue, 29 Jan 2019 09:58:52 +0000
Received: from mail-ed1-x544.google.com ([2a00:1450:4864:20::544])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1goQAC-0006e0-Bp
 for linux-arm-kernel@lists.infradead.org; Tue, 29 Jan 2019 09:58:44 +0000
Received: by mail-ed1-x544.google.com with SMTP id p6so15527463eds.0
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 29 Jan 2019 01:58:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ffwll.ch; s=google;
 h=sender:date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=aoCf9KgrGLKZxVkHKY1rsO7u8nHmHozVbuBO+d7hwEY=;
 b=SBSp1SW4qfVQED1EGR0IUgVRnqhQVnxWa0+JwLLvQA/pR5pO3RndUcavCyxoTAi2K/
 VE6M59Ym7LhdkqvYH49OGV7FTYzE0OsL3+2UctEidG3SD5U142vnxg8GLbv+4xDf6bka
 fl842Qr6tMTDhSNKIgWmUq0JZdlUCT7B/799A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
 :references:mime-version:content-disposition:in-reply-to:user-agent;
 bh=aoCf9KgrGLKZxVkHKY1rsO7u8nHmHozVbuBO+d7hwEY=;
 b=OWFxsYXWX9TK+TTKLxX8OboW/NzioE/0ApXJrVlHZEwmxOXDHZ5e+hf5xeqvP5Hy44
 htnrGyAra8PHIC16TkCj0jmFsBcvOC0c8Q3hoRo12lLDx9ar2ZhiWORTLm5/lD4WSeIO
 ELljAQJx+lOIWnYf1F1mQW8iEwXA0zFWmpPxjY/iJOm9iQM8fhl4gGJQEWoTtYLil2fA
 2VMCUuoI6+b7DKnUjI80LNoWHFpsblcFYW5TTOMPOHyliR+tUi/0PW4qF/AQltOecyPN
 nSCJCEOgqt8jlykBm9Oow4FPzEGr4DwRmEHwWOoEg5YNscrzG0tJ+35cB/ydqoE9zqt8
 afKw==
X-Gm-Message-State: AJcUuke7HFuuCE+KTHy2/tw+tuP9tKp0/E50cSNR+mGnp6lLjRbL4sZH
 wF6er3/fKrc/7rW0BPTvcSq3Lw==
X-Google-Smtp-Source: ALg8bN4LJ6xDRM64YHT5XEqYMobIjQTn36J5FiNgIrdO4ANbQUCh7S0uxB6bsmlpVT2l16HSEI6lUA==
X-Received: by 2002:a17:906:1591:: with SMTP id
 k17-v6mr22206431ejd.19.1548755918116; 
 Tue, 29 Jan 2019 01:58:38 -0800 (PST)
Received: from phenom.ffwll.local ([2a02:168:569e:0:3106:d637:d723:e855])
 by smtp.gmail.com with ESMTPSA id v5sm3352558eju.37.2019.01.29.01.58.36
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Tue, 29 Jan 2019 01:58:37 -0800 (PST)
Date: Tue, 29 Jan 2019 10:58:34 +0100
From: Daniel Vetter <daniel@ffwll.ch>
To: Emil Velikov <emil.l.velikov@gmail.com>
Subject: Re: [Intel-gfx] [PATCH 26/26] drm/<drivers>: Don't set
 FBINFO_(FLAG_)DEFAULT
Message-ID: <20190129095834.GP3271@phenom.ffwll.local>
References: <20190124165831.16427-1-daniel.vetter@ffwll.ch>
 <20190124165831.16427-27-daniel.vetter@ffwll.ch>
 <CACvgo52YJ0kSBVJryELvZn70--4rbPr7R=TJdRgbVr1fEVr2yw@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CACvgo52YJ0kSBVJryELvZn70--4rbPr7R=TJdRgbVr1fEVr2yw@mail.gmail.com>
X-Operating-System: Linux phenom 4.19.0-1-amd64 
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190129_015840_637471_FC6F3A0F 
X-CRM114-Status: GOOD (  12.54  )
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
Cc: Heiko =?iso-8859-1?Q?St=FCbner?= <heiko@sntech.de>,
 Daniel Vetter <daniel.vetter@ffwll.ch>,
 DRI Development <dri-devel@lists.freedesktop.org>,
 Daniel Vetter <daniel.vetter@intel.com>,
 "moderated list:ARM/S5P EXYNOS AR..." <linux-samsung-soc@vger.kernel.org>,
 Joonyoung Shim <jy0922.shim@samsung.com>,
 Krzysztof Kozlowski <krzk@kernel.org>, Jonathan Hunter <jonathanh@nvidia.com>,
 linux-rockchip <linux-rockchip@lists.infradead.org>,
 Kukjin Kim <kgene@kernel.org>, Ben Skeggs <bskeggs@redhat.com>,
 ML nouveau <nouveau@lists.freedesktop.org>,
 Alexander Kapshuk <alexander.kapshuk@gmail.com>,
 Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
 Intel Graphics Development <intel-gfx@lists.freedesktop.org>,
 Inki Dae <inki.dae@samsung.com>, linux-tegra@vger.kernel.org,
 LAKML <linux-arm-kernel@lists.infradead.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Seung-Woo Kim <sw0312.kim@samsung.com>, Sandy Huang <hjc@rock-chips.com>,
 Kyungmin Park <kyungmin.park@samsung.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Fri, Jan 25, 2019 at 03:02:46PM +0000, Emil Velikov wrote:
> On Thu, 24 Jan 2019 at 17:00, Daniel Vetter <daniel.vetter@ffwll.ch> wrote:
> >
> > It's 0.
> >
> I'd add a bit more information here. Feel free to reuse as much/little
> of the following:
> 
> Both macros evaluate to 0. At the same time flag is already set to
> zero since the struct is kzalloc'd in framebuffer_alloc().
> As called by drm_fb_helper_alloc_fbi() in the DRM drivers.

Added&merged, thanks for your review.
-Daniel
-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
