Return-Path: <SRS0=6Gta=PZ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6746FC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 16:45:56 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 25C0720856
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 16:45:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="K+DdahGT";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="XpIqV969"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 25C0720856
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Nwqb1ya0pDx5CRwSBM/FlbmHCIvOOtPrXNO8ZcIZoTQ=; b=K+DdahGTzrFpb/
	FyaQjsYEQWQbXr6hxiMAeUIokRbkSgbFFipf6yQzAfSptJH8TA5F8jaO5Wxv77Fr1rg1Ri2jfMEI4
	aGGKFQJW1++++XchHo6o6b0pa8DwpvZlH3/0htfDbJTKLNgUmJteEi1fZXVQTBnWKoU6HLcupfYiK
	RITXZElhu4p8tlCGpO00PBPiVmOpn+DOQbz2KuRj23CEY5Grym7tt2KkDgMayH4jmN4DiD1S8h9Wx
	I6bLyN+9jN1DLyfamIY49Nmx61mquPraMZq0hk3WF5pjrV8O4NNIupdSQs2iA9rTvd14cvWwt6B+P
	m34PWttpXcJssSETYNJg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gkAni-000879-R2; Thu, 17 Jan 2019 16:45:54 +0000
Received: from mail-ed1-x541.google.com ([2a00:1450:4864:20::541])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gkAnb-00083n-IZ
 for linux-arm-kernel@lists.infradead.org; Thu, 17 Jan 2019 16:45:50 +0000
Received: by mail-ed1-x541.google.com with SMTP id f9so8856191eds.10
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 17 Jan 2019 08:45:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ffwll.ch; s=google;
 h=sender:date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=G44vzWv8v93dtiLWgCKhFpfQv+w1VJ2+/PDzCiGfXJg=;
 b=XpIqV969SvphAZ4y55B9XsKLgH5TOJSk0+trqqG8gDbFtpm4Avk64xaCR7WNFFsl5S
 JMleF9lJImURSKKsp62Ic+TwgHzTXVrtXdZPwnZwJH3YhEsrURl89JNSvJGmelZGHx2G
 5Z521lKbdU6z8w08x0T017vudJpBi/+iK7KBk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
 :references:mime-version:content-disposition:in-reply-to:user-agent;
 bh=G44vzWv8v93dtiLWgCKhFpfQv+w1VJ2+/PDzCiGfXJg=;
 b=csqu2ALk9Z/uWQhtQHh432X3i7zItiPItyER1WyvM6gjyXwMglSszwhytSHBJL4zER
 ueZKP+tLco62ghTzMrqyHU6JVcnCjwGAnZ7GSP+/JZP61RRedOC+wfMQkO//ni1EJtCe
 h/wD35b3qe1SBK7Cf59qak3Ar8LFXiEf+nsNbs5Y0wAHQG41qVWLqV1t8L+jI1CHpq/G
 1QCLJjyUkCZVtMbqyZeXxOVo1yQ++7w3DBaApgEYZVJ3mmDlteDerc1C4edzJnB4sUc2
 me8vz0yDBWVSPglLkgWet9UhnCTdVS2RsRm4yqi03071M/F9189pmxrqk9byqGEs7HsX
 whaw==
X-Gm-Message-State: AJcUukcfzVdPahksXwUZsXFgaLEx1zJONvLN7u59e0zsa+LPxVAEQFgq
 DH/yW2C+xpTK0avE5+kkNsIpIw==
X-Google-Smtp-Source: ALg8bN48Ho/mM8Q7a3cuSaUxZAOeetJgITKLeb5lpfoqSNcRkQ2JHWoWIcrUFnFvvuK4Y1nyvIf4ig==
X-Received: by 2002:a17:906:3105:: with SMTP id
 5-v6mr11397796ejx.122.1547743544951; 
 Thu, 17 Jan 2019 08:45:44 -0800 (PST)
Received: from phenom.ffwll.local ([2a02:168:569e:0:3106:d637:d723:e855])
 by smtp.gmail.com with ESMTPSA id g37sm6730501edb.85.2019.01.17.08.45.43
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Thu, 17 Jan 2019 08:45:44 -0800 (PST)
Date: Thu, 17 Jan 2019 17:45:41 +0100
From: Daniel Vetter <daniel@ffwll.ch>
To: Sam Ravnborg <sam@ravnborg.org>
Subject: Re: [PATCH] drm: Split out drm_probe_helper.h
Message-ID: <20190117164541.GE3271@phenom.ffwll.local>
References: <20190116163442.12622-1-daniel.vetter@ffwll.ch>
 <20190116181018.GA27364@ravnborg.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190116181018.GA27364@ravnborg.org>
X-Operating-System: Linux phenom 4.19.0-1-amd64 
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190117_084547_694701_CDAE0D44 
X-CRM114-Status: GOOD (  18.15  )
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

On Wed, Jan 16, 2019 at 07:10:18PM +0100, Sam Ravnborg wrote:
> Hi Daniel.
> 
> > v5: Actually try to sort them, and while at it, sort all the ones I
> > touch.
> 
> Applied this variant on top of drm-misc and did a build test.
> Looked good for ia64, x86 and alpha.
> 
> Took a closer look at the changes to atmel_hlcd - and they looked OK.
> 
> But I noticed that atmel_hlcdc uses only drm_kms_helper_poll_init() and
> drm_kms_helper_poll_fini().
> But there are no hits on DRM_CONNECTOR_POLL - so I think we maybe
> have a driver here where we have plugged the drm_poll infrastructure,
> but it is not in use.
> 
> >  include/drm/drm_crtc_helper.h                 | 16 -----------
> 
> The list of include files in this file could be dropped and replaced by:
> struct drm_connector;
> struct drm_device;
> struct drm_display_mode;
> struct drm_encoder;
> struct drm_framebuffer;
> struct drm_mode_set;
> struct drm_modeset_acquire_ctx;
> 
> I tried to do so on top of your patch.
> But there were too many build errros and I somehow lost the motivation.

Yeah the drm_crtc_helper.h header is a bit the miniature drmP.h for legacy
kms drivers. Just removing it from all the atomic drivers caused lots of
fallout, I expect even more if you entirely remove the includes it has.
Maybe a todo, care to pls create that patch since it's your idea?
-Daniel

> 
> 
> >  include/drm/drm_probe_helper.h                | 27 +++++++++++++++++++
> This on the other hand is fine - as expected as this is a new file.
> 
> But the above is just some random comments so:
> 
> Acked-by: Sam Ravnborg <sam@ravnborg.org>

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
