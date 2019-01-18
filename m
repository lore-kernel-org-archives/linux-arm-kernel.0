Return-Path: <SRS0=p0aQ=P2=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1DFEC5AE5E
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 23:46:10 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AC21220652
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 23:46:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="nnV/CwkI";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Eypht+C9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AC21220652
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Cc:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=KvMNJDOXYVIaI9/AA9Cc8XLFW6ag+arERRQmxeAGHs4=; b=nnV/CwkIb6udVuTAd4qOH/62TB
	zvzfE652XEIURjCjLD9AdlSHMsfY5z6b16bVoVm/1A29iuCyI1YqOhDAScdvPTEnG7qhPhqstqbq4
	tRFS24LJn3mZf2vg4TOJVGC5RevLB9XXXgOweFxLTjQvJ2eYC4xk3PC88TdpEGKINOlS0LnmE/ajr
	/i7qrQ2jPpJHKtRxxay7FJHnjO/yRtTKAxhAVaUnsulwfmuS/7VprNj3yBtU699cNSf/KJac16nqn
	ou8gAUbRduT/NivZFvCTIL3U/+AM8IyE8QIhvCe4KkxpdZIp3kHSLW5y+oxDC9/solTlbj3zAN/BZ
	rHKRXq4w==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gkdpp-0007Sv-4h; Fri, 18 Jan 2019 23:46:01 +0000
Received: from mail-lf1-x141.google.com ([2a00:1450:4864:20::141])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gkdpk-0007Sa-T6
 for linux-arm-kernel@lists.infradead.org; Fri, 18 Jan 2019 23:45:58 +0000
Received: by mail-lf1-x141.google.com with SMTP id n18so11695738lfh.6
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 18 Jan 2019 15:45:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chromium.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
 bh=vyPa6RWp8yc0OiI1CZ1DDkVzWOCj5KcsnrJwE3e1pnY=;
 b=Eypht+C9rILThlmdKX62zVmVpWZ6K9ZnGyitFjNlHSFDCTESm3JSqW5sBO/rIM5K8x
 wLkd9DYL9tlcCY0MNzeIG+yD4C1VYDNhmze874voWkjf88FoMaJkSKAaacg2AKoLKHM+
 FXsKs2i5zZM/GZM7cD8leSL+9VAc2zUriwOls=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to;
 bh=vyPa6RWp8yc0OiI1CZ1DDkVzWOCj5KcsnrJwE3e1pnY=;
 b=E7cNg9yQDOSglJ6l7se1o4t78/xizU7nA2mTZWGIHX284acQFDID6CNjF5bnxfcmqo
 0Ng2o3sENHeqpNXIZ/vODwf4VAq4ITPL4AS9b/xIsrzjaVjom3421GN6NgMkz4tmeueq
 uPjZzsutTmwCRyxPD8Ar1Irp6Y57TmpV9zdfH0U0FMXIRCrZpUK7peKfCpMQSJMKg/7G
 UI/YFfhagS1Ln5tXPC2zwX9v+DbgiePFCSlCDlZzBaxf1bnTCTsP0Sdf8s4G9UNFVcZy
 j9C3A9tn+hto0WlG4BOeHLOUWohf0kkeiXTvwOcxslGKfJmy9KZGzdq3mzOp7UEpA7Ls
 T0Ng==
X-Gm-Message-State: AJcUukdM9UWNYZSgS32q63b0B9w4mSmHUuABr5Mh6L7/p1kMEiD2gLds
 JG0uzjb35541qNwDfZr7Tdz5HRiA+w8=
X-Google-Smtp-Source: ALg8bN746hTt3KMhRdQjeaTydqawTP1qrLsXiPfj0fZD9+VRRslKoUY/3flETNnvfyDkRcTs86nBfA==
X-Received: by 2002:a19:f115:: with SMTP id p21mr10250839lfh.20.1547855154484; 
 Fri, 18 Jan 2019 15:45:54 -0800 (PST)
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com.
 [209.85.208.177])
 by smtp.gmail.com with ESMTPSA id a20-v6sm968956ljf.28.2019.01.18.15.45.53
 for <linux-arm-kernel@lists.infradead.org>
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 18 Jan 2019 15:45:53 -0800 (PST)
Received: by mail-lj1-f177.google.com with SMTP id q2-v6so13019168lji.10
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 18 Jan 2019 15:45:53 -0800 (PST)
X-Received: by 2002:a2e:880a:: with SMTP id
 x10-v6mr14332410ljh.174.1547855152543; 
 Fri, 18 Jan 2019 15:45:52 -0800 (PST)
MIME-Version: 1.0
References: <1547843058-27933-1-git-send-email-jcrouse@codeaurora.org>
 <CAE=gft6RWRkSZCOrKu=qqTerfmXRW5_kNt2NG4xdfxtTn6KxYA@mail.gmail.com>
 <20190118232746.GF4140@jcrouse1-lnx.qualcomm.com>
In-Reply-To: <20190118232746.GF4140@jcrouse1-lnx.qualcomm.com>
From: Evan Green <evgreen@chromium.org>
Date: Fri, 18 Jan 2019 15:45:16 -0800
X-Gmail-Original-Message-ID: <CAE=gft4OAMztQ0CE4wz3_fNr0K0UqNP8DOm5=TRaVvcpTefPTw@mail.gmail.com>
Message-ID: <CAE=gft4OAMztQ0CE4wz3_fNr0K0UqNP8DOm5=TRaVvcpTefPTw@mail.gmail.com>
Subject: Re: [PATCH v6] drm/msm/a6xx: Add support for an interconnect path
To: Evan Green <evgreen@chromium.org>, freedreno@lists.freedesktop.org, 
 linux-arm-msm <linux-arm-msm@vger.kernel.org>,
 Doug Anderson <dianders@chromium.org>, 
 Bjorn Andersson <bjorn.andersson@linaro.org>,
 Andy Gross <andy.gross@linaro.org>, 
 Georgi Djakov <georgi.djakov@linaro.org>, linux-arm-kernel@lists.infradead.org,
 Stephen Boyd <swboyd@chromium.org>, Kees Cook <keescook@chromium.org>, 
 Colin Ian King <colin.king@canonical.com>,
 Sharat Masetty <smasetty@codeaurora.org>, 
 dri-devel@lists.freedesktop.org, LKML <linux-kernel@vger.kernel.org>, 
 Rob Clark <robdclark@gmail.com>, David Airlie <airlied@linux.ie>, 
 Jonathan Marek <jonathan@marek.ca>, Mamta Shukla <mamtashukla555@gmail.com>, 
 Daniel Vetter <daniel@ffwll.ch>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190118_154556_976210_36295C83 
X-CRM114-Status: GOOD (  32.75  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Fri, Jan 18, 2019 at 3:27 PM Jordan Crouse <jcrouse@codeaurora.org> wrote:
>
> On Fri, Jan 18, 2019 at 03:04:34PM -0800, Evan Green wrote:
> > On Fri, Jan 18, 2019 at 12:24 PM Jordan Crouse <jcrouse@codeaurora.org> wrote:
> > >
> > > Try to get the interconnect path for the GPU and vote for the maximum
> > > bandwidth to support all frequencies. This is needed for performance.
> > > Later we will want to scale the bandwidth based on the frequency to
> > > also optimize for power but that will require some device tree
> > > infrastructure that does not yet exist.
> > >
> > > v6: use icc_set_bw() instead of icc_set()
> > > v5: Remove hardcoded interconnect name and just use the default
> > > v4: Don't use a port string at all to skip the need for names in the DT
> > > v3: Use macros and change port string per Georgi Djakov
> > >
> > > Signed-off-by: Jordan Crouse <jcrouse@codeaurora.org>
> > > ---
> > >
> > >  drivers/gpu/drm/msm/Kconfig             |  1 +
> > >  drivers/gpu/drm/msm/adreno/a6xx_gmu.c   | 20 ++++++++++++++++++++
> > >  drivers/gpu/drm/msm/adreno/adreno_gpu.c |  9 +++++++++
> > >  drivers/gpu/drm/msm/msm_gpu.h           |  3 +++
> > >  4 files changed, 33 insertions(+)
> > >
> > > diff --git a/drivers/gpu/drm/msm/Kconfig b/drivers/gpu/drm/msm/Kconfig
> > > index cf549f1..78c9e5a5 100644
> > > --- a/drivers/gpu/drm/msm/Kconfig
> > > +++ b/drivers/gpu/drm/msm/Kconfig
> > > @@ -5,6 +5,7 @@ config DRM_MSM
> > >         depends on ARCH_QCOM || SOC_IMX5 || (ARM && COMPILE_TEST)
> > >         depends on OF && COMMON_CLK
> > >         depends on MMU
> > > +       depends on INTERCONNECT || !INTERCONNECT
> > >         select QCOM_MDT_LOADER if ARCH_QCOM
> > >         select REGULATOR
> > >         select DRM_KMS_HELPER
> > > diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gmu.c b/drivers/gpu/drm/msm/adreno/a6xx_gmu.c
> > > index 5beb83d..c48fe46 100644
> > > --- a/drivers/gpu/drm/msm/adreno/a6xx_gmu.c
> > > +++ b/drivers/gpu/drm/msm/adreno/a6xx_gmu.c
> > > @@ -2,6 +2,7 @@
> > >  /* Copyright (c) 2017-2018 The Linux Foundation. All rights reserved. */
> > >
> > >  #include <linux/clk.h>
> > > +#include <linux/interconnect.h>
> > >  #include <linux/pm_opp.h>
> > >  #include <soc/qcom/cmd-db.h>
> > >
> > > @@ -84,6 +85,9 @@ bool a6xx_gmu_gx_is_on(struct a6xx_gmu *gmu)
> > >
> > >  static void __a6xx_gmu_set_freq(struct a6xx_gmu *gmu, int index)
> > >  {
> > > +       struct a6xx_gpu *a6xx_gpu = container_of(gmu, struct a6xx_gpu, gmu);
> > > +       struct adreno_gpu *adreno_gpu = &a6xx_gpu->base;
> > > +       struct msm_gpu *gpu = &adreno_gpu->base;
> > >         int ret;
> > >
> > >         gmu_write(gmu, REG_A6XX_GMU_DCVS_ACK_OPTION, 0);
> > > @@ -106,6 +110,12 @@ static void __a6xx_gmu_set_freq(struct a6xx_gmu *gmu, int index)
> > >                 dev_err(gmu->dev, "GMU set GPU frequency error: %d\n", ret);
> > >
> > >         gmu->freq = gmu->gpu_freqs[index];
> > > +
> > > +       /*
> > > +        * Eventually we will want to scale the path vote with the frequency but
> > > +        * for now leave it at max so that the performance is nominal.
> > > +        */
> > > +       icc_set_bw(gpu->icc_path, 0, MBps_to_icc(7216));
> > >  }
> > >
> > >  void a6xx_gmu_set_freq(struct msm_gpu *gpu, unsigned long freq)
> > > @@ -705,6 +715,8 @@ int a6xx_gmu_reset(struct a6xx_gpu *a6xx_gpu)
> > >
> > >  int a6xx_gmu_resume(struct a6xx_gpu *a6xx_gpu)
> > >  {
> > > +       struct adreno_gpu *adreno_gpu = &a6xx_gpu->base;
> > > +       struct msm_gpu *gpu = &adreno_gpu->base;
> > >         struct a6xx_gmu *gmu = &a6xx_gpu->gmu;
> > >         int status, ret;
> > >
> > > @@ -720,6 +732,9 @@ int a6xx_gmu_resume(struct a6xx_gpu *a6xx_gpu)
> > >         if (ret)
> > >                 goto out;
> > >
> > > +       /* Set the bus quota to a reasonable value for boot */
> > > +       icc_set_bw(gpu->icc_path, 0, MBps_to_icc(3072));
> >
> > Does the comment mention boot because this resume call happens during
> > init?
>
> Correct. Boot refers to the GMU in this context.
>
> > How come this number is different from the one in __a6xx_gmu_set_freq?
>
> If you never request a bus quota from the kernel the sucker is horribly
> painfully slow. I'm not sure if that is just the default reset value of
> the registers or if the bootloader is doing something. In any event
> the GMU doesn't always initialize if you try to bring it up with the
> default bus settings so we set it to a "reasonable" quota for the
> init sequence. I admit I didn't come up with these numbers on my own;
> some poor anonymous soul debugged this on the downstream kernel and
> I just stole the same parameters.
>
> As for _a6xx_gmu_set_freq() eventually we'll agree on a way to communicate
> the bus bandwidth in the opp settings and we'll be able to adjust the quota
> based on the frequency to save power so that's why the code is organized the way
> it is so that a6xx_gmu_set_freq() won't have to be massively changed later.

Oh I see, so it's just a placeholder to max for now until the OPP part
gets figured out. That makes sense.

Reviewed-by: Evan Green <evgreen@chromium.org>

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
