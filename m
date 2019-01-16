Return-Path: <SRS0=Ql45=PY=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D523CC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 03:30:37 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 98E91204FD
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 03:30:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="AiVAUQR8";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uFLLHJdd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 98E91204FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=GDXXAqT0l+ShjnmOohEXGUFBuB+8fJ6CmElPmPqp1Us=; b=AiVAUQR8pNQkhF
	wcH4BNuutwvrlETGVX/SGbuUPe3FHhpzQAVofoPafpcF6JPzf0Rl6ERdwlwGUJkEwIAEaNu8h/kGd
	XbQEhT3eMmlHCWlmrKgJUMaMrBCIBUpc8MrJ/yZMuWjbIvmzMfjM2BAUAPC6g0Bf5zGgjAZGwzvkI
	TlMhvGyYsKkFCcNo366ddn32BKTVHHU7sTkfQ9N0NUgGnpgItCVPuQ+u5NzM7C224iXdQX4PgfCeZ
	KHyR//av3Y+0ccM139yZRRbpZzdjQWUPd42isxCjHmOPHeh4Uk43T/yFUXbL/oJZyKOPEx7Kt064D
	WN7yOf7AQrX/MH/lOSGA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gjbuS-0005Qv-Og; Wed, 16 Jan 2019 03:30:32 +0000
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gjbuM-0005OH-5T; Wed, 16 Jan 2019 03:30:27 +0000
Received: by mail-wr1-x442.google.com with SMTP id t6so5220857wrr.12;
 Tue, 15 Jan 2019 19:30:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=DAB7bOvCpjeEgqAU23iWSznTCf2WSBgkvOBydTcb6wI=;
 b=uFLLHJddp3hHH4nf6OgRarrAc4KoBIr18Rg8TI2mRyVZwatnUMvF8Oz2lx8HRiQ43K
 60CBvCl/+IJbH40zxdlD1OCusEm/kNHS1bLeKkz9ksUjPUIdF6EF0TvnHH3fRlJh9Mxi
 JFrGHdknEZWggYUo8qkgdxFvjcsDDsiPZsOq7xHrLN8gDyYX1SX8eN8l4nvSWhhBU+Jx
 vADM7lSxRTt9/G8iXSbxhnMMJHxGkLYUpi/UHI501Hgr6ZLNijXRqSPqr+wHTjoD02gn
 5T47olbOz3ahOnG/2xJgXfwJH1rTtVv5zLYfuJ1eZYWfHhOwRhgawQmxExSqitbHTpSK
 dpkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=DAB7bOvCpjeEgqAU23iWSznTCf2WSBgkvOBydTcb6wI=;
 b=Nbpa/GtwfQ1DCKtgiRclj3res4CWCQV3QDACHGLTi86COqsL1ry01jlMTWdNaa51JG
 /hafoCFa/cSHPoTkue9pa1pARRnrly75fVSqTCcms7u2Kx2IzYXMp9537cD0Nuj2v5y9
 ZyDPi7DbN74cm7e7+zWLaJKEWw7ChR3Qg0YYq5lrzu8B/5ly2J2GJBQICSBxawKpGZKg
 i8mCO5zljCe6aCzBvPTZhwBbrLpsVN07xetswy8NZwF+SEl8SVx6rn88M2KZPI+eYdzk
 DUGJ41Z1TWVSMK1JoZnyh5eFPOXfUBuhB5DyHKR1knOCgEJE2iL/y6owGf4ReaRz32V5
 pAWw==
X-Gm-Message-State: AJcUukfSAtFLNlnTxuDB87OaswpefIoj4H02K88FnWkG3JEWOlts3x+d
 YDLEof9xDC3bODFgJqMjhZ+KSXN8MIfp1yU9v8k=
X-Google-Smtp-Source: ALg8bN7cxSJGppag4xxGzhM4PxdbCoQCVPdZ0OtFy2Ew9NaqrdEByk31K9k1/6DgDg1uk9zX2XiehKYFhzIF7C9uslQ=
X-Received: by 2002:a5d:488f:: with SMTP id g15mr5564831wrq.15.1547609423651; 
 Tue, 15 Jan 2019 19:30:23 -0800 (PST)
MIME-Version: 1.0
References: <20190115104137.25695-1-daniel.vetter@ffwll.ch>
In-Reply-To: <20190115104137.25695-1-daniel.vetter@ffwll.ch>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 15 Jan 2019 22:30:11 -0500
Message-ID: <CADnq5_Oa0dj1+eOcAF6QxVxy0XRXNggZT+4K=Cm_=G80V-ejGQ@mail.gmail.com>
Subject: Re: [PATCH] drm: Split out drm_probe_helper.h
To: Daniel Vetter <daniel.vetter@ffwll.ch>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190115_193026_208512_99399BC6 
X-CRM114-Status: GOOD (  15.17  )
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
Cc: nouveau <nouveau@lists.freedesktop.org>,
 DRI Development <dri-devel@lists.freedesktop.org>, "open list:VIRTIO CORE,
 NET..." <virtualization@lists.linux-foundation.org>,
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
 Benjamin Gaignard <benjamin.gaignard@linaro.org>,
 Daniel Vetter <daniel.vetter@intel.com>, Sam Ravnborg <sam@ravnborg.org>,
 linux-stm32@st-md-mailman.stormreply.com, linux-samsung-soc@vger.kernel.org,
 amd-gfx list <amd-gfx@lists.freedesktop.org>,
 linux-rockchip@lists.infradead.org, spice-devel@lists.freedesktop.org,
 linux-arm-msm <linux-arm-msm@vger.kernel.org>,
 Intel Graphics Development <intel-gfx@lists.freedesktop.org>,
 etnaviv@lists.freedesktop.org, Jani Nikula <jani.nikula@linux.intel.com>,
 linux-mediatek@lists.infradead.org, Rodrigo Vivi <rodrigo.vivi@intel.com>,
 linux-tegra@vger.kernel.org, linux-amlogic@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org, xen-devel@lists.xen.org,
 linux-renesas-soc@vger.kernel.org, freedreno <freedreno@lists.freedesktop.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Tue, Jan 15, 2019 at 5:41 AM Daniel Vetter <daniel.vetter@ffwll.ch> wrote:
>
> Having the probe helper stuff (which pretty much everyone needs) in
> the drm_crtc_helper.h file (which atomic drivers should never need) is
> confusing. Split them out.
>
> To make sure I actually achieved the goal here I went through all
> drivers. And indeed, all atomic drivers are now free of
> drm_crtc_helper.h includes.
>
> v2: Make it compile. There was so much compile fail on arm drivers
> that I figured I'll better not include any of the acks on v1.
>
> v3: Massive rebase because i915 has lost a lot of drmP.h includes, but
> not all: Through drm_crtc_helper.h > drm_modeset_helper.h -> drmP.h
> there was still one, which this patch largely removes. Which means
> rolling out lots more includes all over.
>
> This will also conflict with ongoing drmP.h cleanup by others I
> expect.
>
> v3: Rebase on top of atomic bochs.
>
> Cc: Sam Ravnborg <sam@ravnborg.org>
> Cc: Jani Nikula <jani.nikula@linux.intel.com>
> Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> Acked-by: Rodrigo Vivi <rodrigo.vivi@intel.com> (v2)
> Acked-by: Benjamin Gaignard <benjamin.gaignard@linaro.org> (v2)
> Signed-off-by: Daniel Vetter <daniel.vetter@intel.com>
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: virtualization@lists.linux-foundation.org
> Cc: etnaviv@lists.freedesktop.org
> Cc: linux-samsung-soc@vger.kernel.org
> Cc: intel-gfx@lists.freedesktop.org
> Cc: linux-mediatek@lists.infradead.org
> Cc: linux-amlogic@lists.infradead.org
> Cc: linux-arm-msm@vger.kernel.org
> Cc: freedreno@lists.freedesktop.org
> Cc: nouveau@lists.freedesktop.org
> Cc: spice-devel@lists.freedesktop.org
> Cc: amd-gfx@lists.freedesktop.org
> Cc: linux-renesas-soc@vger.kernel.org
> Cc: linux-rockchip@lists.infradead.org
> Cc: linux-stm32@st-md-mailman.stormreply.com
> Cc: linux-tegra@vger.kernel.org
> Cc: xen-devel@lists.xen.org
> ---
> Merging this is going to be a bit a mess due to all the ongoing drmP.h
> cleanups. I think the following should work:
> - Apply Sam's prep patches for removing drmP.h from
>   drm_modeset_helper.h
> - Get the i915 drmP.h cleanup backmerged into drm-misc-next
> - Apply this patch.
> - Apply Sam's patch to remove drmP.h from drm_modeset_helper.h
> - All through drm-misc-next, which has some potential for trivial
>   conflicts around #includes with other drivers unfortunately.
>
> I hope there's no other driver who'll blow up accidentally because
> someone else is doing a drmP.h cleanup. Laurent maybe?
>
> Jani, ack on this?
> -Daniel

amdgpu and radeon:
Acked-by: Alex Deucher <alexander.deucher@amd.com>

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
