Return-Path: <SRS0=pdKw=QA=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C441C282C3
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 12:39:54 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6D3BE21855
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 12:39:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Ek/Fpoyc";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="Xs+sILNw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6D3BE21855
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=LntlXMj//DZMhNG1/E+n8/qiAURw2FPWfsDb0nXvA1M=; b=Ek/FpoycLws7Re
	o09mUFXy6Nb5TTyo9+uaGc7FTNGnLAXMvlZK6Q3YkU6B41kUiZGoMCh3M50zaOntoez+3jLNOY0/6
	9TrAP5x/UJAFWvwgLVdOjVv1Dgr7y/3+/zwFqlH1ycLbSSXH5PA2gECXf5ap8M83BnUJ5pA6hUI2V
	gBn+uQilOQ/sQLDxDz7RPHbMiZ/SHd29prW93/t76P3dBU+fzAOaM/Mq0ghlIget/HK06VwHZFiLP
	wD4DufXZxwN+6MyO3GNTKj8BayxBUSnPnLrAxCEA2HhO3EjvcjHacN8ZYu+1Nfte4q+oqscJl88+k
	gVqs4xAEEK4zCrUpIA3g==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gmeIS-0004vw-PJ; Thu, 24 Jan 2019 12:39:52 +0000
Received: from mail-ed1-x542.google.com ([2a00:1450:4864:20::542])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gmeIN-0004sp-0M
 for linux-arm-kernel@lists.infradead.org; Thu, 24 Jan 2019 12:39:50 +0000
Received: by mail-ed1-x542.google.com with SMTP id d39so4420551edb.12
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 24 Jan 2019 04:39:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ffwll.ch; s=google;
 h=sender:date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=c1mNI5T4m20SpCB9OCXSFUEgo9wAKUIT7bb59B02sTo=;
 b=Xs+sILNwFnhsMsInizUcnZQT7V6t07Wg+2m5qm8T9+gfHD8JMXDGyRdXasDYGeBRu5
 jfY5eN5cBRzg5Km3phmLAArdGGj70YK8XC66ga0dLHTFYJi0rxT7RKfW0wqm/MaKA5Oi
 FmnqtX1mKk9fgUoAmJF4yfX9mLYc+pQLAInls=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
 :references:mime-version:content-disposition:in-reply-to:user-agent;
 bh=c1mNI5T4m20SpCB9OCXSFUEgo9wAKUIT7bb59B02sTo=;
 b=qxdSvCTy4ldYKHVcXaHof9dn7jWUoimh8ktfqJKHE4+S3Xps8ziu9EN8jalV2TI9ig
 ZjLN1p3/y9pkZaNn6RHKeGGs7By9pjhHSV3oZSsYRCxf3Rowmv6GTqfS6EY0rRJ6fu0B
 qwyxGFv1bsyrQ6tqgZiVRjeQIOJ6O0RQSSx8eQkyD18SEvfkGxBUwhrYmvrGGxQVF8B3
 dgEJC3DTBBCk7gMeROtBkOgUCW0MS4B9C6YDmFMXLKsY193w2APc92iBkH2lJKTdrTX6
 fHZ6SiUyuUs8D79jWsTix0oHGe0pMFWc9xKNxEfacdgTIDA02cUBF6u0WEUnpFX3I/cw
 rzBQ==
X-Gm-Message-State: AJcUukcUE9i5AHc6SNe7VccvGSCxh7Pe28lIRZV5u89kBkD9oePMrYmu
 Fu1IcYIdqqS6tRKjEwPitDh1tg==
X-Google-Smtp-Source: ALg8bN6QWswlzohggrLEqf84UNCuXug1KlzboVlv+Uh2BRu5bdykRE7vK7zKCjeeWxzlybhwkDdnrg==
X-Received: by 2002:a17:906:3281:: with SMTP id
 1-v6mr5845104ejw.103.1548333585024; 
 Thu, 24 Jan 2019 04:39:45 -0800 (PST)
Received: from phenom.ffwll.local ([2a02:168:569e:0:3106:d637:d723:e855])
 by smtp.gmail.com with ESMTPSA id x30sm10994617edd.30.2019.01.24.04.39.43
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Thu, 24 Jan 2019 04:39:44 -0800 (PST)
Date: Thu, 24 Jan 2019 13:39:41 +0100
From: Daniel Vetter <daniel@ffwll.ch>
To: Sam Ravnborg <sam@ravnborg.org>
Subject: Re: [PATCH] drm: Split out drm_probe_helper.h
Message-ID: <20190124123941.GW3271@phenom.ffwll.local>
References: <20190116181018.GA27364@ravnborg.org>
 <20190117210334.13234-1-daniel.vetter@ffwll.ch>
 <20190123170015.GA23138@ravnborg.org>
 <20190124094646.GR3271@phenom.ffwll.local>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190124094646.GR3271@phenom.ffwll.local>
X-Operating-System: Linux phenom 4.19.0-1-amd64 
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190124_043947_135629_7054146B 
X-CRM114-Status: GOOD (  14.62  )
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
Cc: Neil Armstrong <narmstrong@baylibre.com>,
 Daniel Vetter <daniel.vetter@ffwll.ch>, Liviu Dudau <liviu.dudau@arm.com>,
 DRI Development <dri-devel@lists.freedesktop.org>,
 virtualization@lists.linux-foundation.org,
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
 Benjamin Gaignard <benjamin.gaignard@linaro.org>,
 Daniel Vetter <daniel.vetter@intel.com>,
 linux-stm32@st-md-mailman.stormreply.com, linux-samsung-soc@vger.kernel.org,
 Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>,
 amd-gfx@lists.freedesktop.org, linux-rockchip@lists.infradead.org,
 nouveau@lists.freedesktop.org, CK Hu <ck.hu@mediatek.com>,
 spice-devel@lists.freedesktop.org, Jani Nikula <jani.nikula@intel.com>,
 linux-arm-msm@vger.kernel.org, intel-gfx@lists.freedesktop.org,
 etnaviv@lists.freedesktop.org, Jani Nikula <jani.nikula@linux.intel.com>,
 linux-mediatek@lists.infradead.org, Rodrigo Vivi <rodrigo.vivi@intel.com>,
 linux-tegra@vger.kernel.org, linux-amlogic@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org, xen-devel@lists.xen.org,
 linux-renesas-soc@vger.kernel.org, Alex Deucher <alexander.deucher@amd.com>,
 freedreno@lists.freedesktop.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Thu, Jan 24, 2019 at 10:46:47AM +0100, Daniel Vetter wrote:
> On Wed, Jan 23, 2019 at 06:00:15PM +0100, Sam Ravnborg wrote:
> > Hi Daniel.
> > 
> > On Thu, Jan 17, 2019 at 10:03:34PM +0100, Daniel Vetter wrote:
> > > Having the probe helper stuff (which pretty much everyone needs) in
> > > the drm_crtc_helper.h file (which atomic drivers should never need) is
> > > confusing. Split them out.
> > > 
> > > To make sure I actually achieved the goal here I went through all
> > > drivers. And indeed, all atomic drivers are now free of
> > > drm_crtc_helper.h includes.
> > 
> > How are the plans to get this patchset merged?
> > There were dependencies on onging drmP.h removal in i915 IIRC?
> > I guess my "Minimize drmP.h dependencies" patch-set also have a role in this.
> 
> Working on it, a pull request got lost. I originally wanted to get this
> all resolved this week, probably going to be next week now :-(

We're lucky, all sorted now & patch merged. I'm also merging your series,
correctly interleaved.
-Daniel
-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
