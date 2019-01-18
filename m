Return-Path: <SRS0=p0aQ=P2=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A71AAC5AE5E
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 23:28:03 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7232E20823
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 23:28:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="kayfYOQJ";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="eLRvCfr9";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="SpS1WvEK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7232E20823
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=PcitQJLXIS00Pn1QisWalpIh2+fUKl+zLBA07V6HZ1Q=; b=kayfYOQJEfTzZr
	eCGxmj+B2Q1ANIiv6tWw6Df2c4fCe8V2AUTU7KTraWsig1TsnwuhddV5+dMlV78BGDZ8MhqxnxByV
	wHBoeHl5vCkL6LLiPvKTZe8VQgg2NqbYb+0fl8WlgEcTOVJEMzGwpHg1OnAzQ0ezpIDjI8T48O0bO
	XllmXyEDhf+EmHFKYH9NLwNN/E7ByqWYtVXoB3znpe0p5G+uMKBjbL4KeIBRRCFzrHpf9cqzPDOSB
	nFI2ZJv4cF29QGU/swhV7oOe3qLxnVaYBK0ERg5+nOdXqRsaZX5v0VpxWEvcdLtJRQhOd33JwddtB
	3kJfSho0KBDkVGoo4Ncg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gkdYJ-00085v-WA; Fri, 18 Jan 2019 23:27:56 +0000
Received: from smtp.codeaurora.org ([198.145.29.96])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gkdYG-00083b-7H
 for linux-arm-kernel@lists.infradead.org; Fri, 18 Jan 2019 23:27:53 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
 id 99A426079B; Fri, 18 Jan 2019 23:27:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
 s=default; t=1547854071;
 bh=OiUV1qeagEbwOeJE3C1sCGOlMM6LWQBJhQHXXsYtRFs=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=eLRvCfr9ftUObVweJ801Yjlv70KT7H2h/exnMXChRnbgm6WjjZBV4WG2YMqj0TruQ
 x0wLIG+pjOkxbn436CozPw4FK+DwVcbnbRZCKditQMIr15cy1805E2BueEHSZP3ZKc
 qLmjOoo0Mgvz3b+96yY7Aj8cejzT6Q0FHgsY8zaA=
Received: from jcrouse1-lnx.qualcomm.com (i-global254.qualcomm.com
 [199.106.103.254])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 (Authenticated sender: jcrouse@smtp.codeaurora.org)
 by smtp.codeaurora.org (Postfix) with ESMTPSA id CC5B360388;
 Fri, 18 Jan 2019 23:27:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
 s=default; t=1547854070;
 bh=OiUV1qeagEbwOeJE3C1sCGOlMM6LWQBJhQHXXsYtRFs=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=SpS1WvEKvVoFvCwQhhSk4e3sGGKz/NuiykcYLlyOY8WTJYMZdPcrzDVQa9mc/VaFv
 b0GOva/xJI/8vQKgLp1CO1XULTPNxFVB51FY0OBexEnjlakph0iwzCfzr2q7LU71TT
 zwQ8MBpon+CcohCok8SNflLlData2nsqO+LOvFl8=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org CC5B360388
Authentication-Results: pdx-caf-mail.web.codeaurora.org;
 dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org;
 spf=none smtp.mailfrom=jcrouse@codeaurora.org
Date: Fri, 18 Jan 2019 16:27:47 -0700
From: Jordan Crouse <jcrouse@codeaurora.org>
To: Evan Green <evgreen@chromium.org>
Subject: Re: [PATCH v6] drm/msm/a6xx: Add support for an interconnect path
Message-ID: <20190118232746.GF4140@jcrouse1-lnx.qualcomm.com>
Mail-Followup-To: Evan Green <evgreen@chromium.org>,
 freedreno@lists.freedesktop.org,
 linux-arm-msm <linux-arm-msm@vger.kernel.org>,
 Doug Anderson <dianders@chromium.org>,
 Bjorn Andersson <bjorn.andersson@linaro.org>,
 Andy Gross <andy.gross@linaro.org>,
 Georgi Djakov <georgi.djakov@linaro.org>,
 linux-arm-kernel@lists.infradead.org,
 Stephen Boyd <swboyd@chromium.org>,
 Kees Cook <keescook@chromium.org>,
 Colin Ian King <colin.king@canonical.com>,
 Sharat Masetty <smasetty@codeaurora.org>,
 dri-devel@lists.freedesktop.org,
 LKML <linux-kernel@vger.kernel.org>,
 Rob Clark <robdclark@gmail.com>, David Airlie <airlied@linux.ie>,
 Jonathan Marek <jonathan@marek.ca>,
 Mamta Shukla <mamtashukla555@gmail.com>,
 Daniel Vetter <daniel@ffwll.ch>
References: <1547843058-27933-1-git-send-email-jcrouse@codeaurora.org>
 <CAE=gft6RWRkSZCOrKu=qqTerfmXRW5_kNt2NG4xdfxtTn6KxYA@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAE=gft6RWRkSZCOrKu=qqTerfmXRW5_kNt2NG4xdfxtTn6KxYA@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190118_152752_308797_7BE6B71F 
X-CRM114-Status: GOOD (  33.19  )
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
Cc: LKML <linux-kernel@vger.kernel.org>, Kees Cook <keescook@chromium.org>,
 Jonathan Marek <jonathan@marek.ca>, David Airlie <airlied@linux.ie>,
 linux-arm-msm <linux-arm-msm@vger.kernel.org>,
 Sharat Masetty <smasetty@codeaurora.org>,
 Doug Anderson <dianders@chromium.org>, dri-devel@lists.freedesktop.org,
 Bjorn Andersson <bjorn.andersson@linaro.org>, Rob Clark <robdclark@gmail.com>,
 Mamta Shukla <mamtashukla555@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
 Andy Gross <andy.gross@linaro.org>, Colin Ian King <colin.king@canonical.com>,
 Stephen Boyd <swboyd@chromium.org>, freedreno@lists.freedesktop.org,
 Georgi Djakov <georgi.djakov@linaro.org>, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Fri, Jan 18, 2019 at 03:04:34PM -0800, Evan Green wrote:
> On Fri, Jan 18, 2019 at 12:24 PM Jordan Crouse <jcrouse@codeaurora.org> wrote:
> >
> > Try to get the interconnect path for the GPU and vote for the maximum
> > bandwidth to support all frequencies. This is needed for performance.
> > Later we will want to scale the bandwidth based on the frequency to
> > also optimize for power but that will require some device tree
> > infrastructure that does not yet exist.
> >
> > v6: use icc_set_bw() instead of icc_set()
> > v5: Remove hardcoded interconnect name and just use the default
> > v4: Don't use a port string at all to skip the need for names in the DT
> > v3: Use macros and change port string per Georgi Djakov
> >
> > Signed-off-by: Jordan Crouse <jcrouse@codeaurora.org>
> > ---
> >
> >  drivers/gpu/drm/msm/Kconfig             |  1 +
> >  drivers/gpu/drm/msm/adreno/a6xx_gmu.c   | 20 ++++++++++++++++++++
> >  drivers/gpu/drm/msm/adreno/adreno_gpu.c |  9 +++++++++
> >  drivers/gpu/drm/msm/msm_gpu.h           |  3 +++
> >  4 files changed, 33 insertions(+)
> >
> > diff --git a/drivers/gpu/drm/msm/Kconfig b/drivers/gpu/drm/msm/Kconfig
> > index cf549f1..78c9e5a5 100644
> > --- a/drivers/gpu/drm/msm/Kconfig
> > +++ b/drivers/gpu/drm/msm/Kconfig
> > @@ -5,6 +5,7 @@ config DRM_MSM
> >         depends on ARCH_QCOM || SOC_IMX5 || (ARM && COMPILE_TEST)
> >         depends on OF && COMMON_CLK
> >         depends on MMU
> > +       depends on INTERCONNECT || !INTERCONNECT
> >         select QCOM_MDT_LOADER if ARCH_QCOM
> >         select REGULATOR
> >         select DRM_KMS_HELPER
> > diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gmu.c b/drivers/gpu/drm/msm/adreno/a6xx_gmu.c
> > index 5beb83d..c48fe46 100644
> > --- a/drivers/gpu/drm/msm/adreno/a6xx_gmu.c
> > +++ b/drivers/gpu/drm/msm/adreno/a6xx_gmu.c
> > @@ -2,6 +2,7 @@
> >  /* Copyright (c) 2017-2018 The Linux Foundation. All rights reserved. */
> >
> >  #include <linux/clk.h>
> > +#include <linux/interconnect.h>
> >  #include <linux/pm_opp.h>
> >  #include <soc/qcom/cmd-db.h>
> >
> > @@ -84,6 +85,9 @@ bool a6xx_gmu_gx_is_on(struct a6xx_gmu *gmu)
> >
> >  static void __a6xx_gmu_set_freq(struct a6xx_gmu *gmu, int index)
> >  {
> > +       struct a6xx_gpu *a6xx_gpu = container_of(gmu, struct a6xx_gpu, gmu);
> > +       struct adreno_gpu *adreno_gpu = &a6xx_gpu->base;
> > +       struct msm_gpu *gpu = &adreno_gpu->base;
> >         int ret;
> >
> >         gmu_write(gmu, REG_A6XX_GMU_DCVS_ACK_OPTION, 0);
> > @@ -106,6 +110,12 @@ static void __a6xx_gmu_set_freq(struct a6xx_gmu *gmu, int index)
> >                 dev_err(gmu->dev, "GMU set GPU frequency error: %d\n", ret);
> >
> >         gmu->freq = gmu->gpu_freqs[index];
> > +
> > +       /*
> > +        * Eventually we will want to scale the path vote with the frequency but
> > +        * for now leave it at max so that the performance is nominal.
> > +        */
> > +       icc_set_bw(gpu->icc_path, 0, MBps_to_icc(7216));
> >  }
> >
> >  void a6xx_gmu_set_freq(struct msm_gpu *gpu, unsigned long freq)
> > @@ -705,6 +715,8 @@ int a6xx_gmu_reset(struct a6xx_gpu *a6xx_gpu)
> >
> >  int a6xx_gmu_resume(struct a6xx_gpu *a6xx_gpu)
> >  {
> > +       struct adreno_gpu *adreno_gpu = &a6xx_gpu->base;
> > +       struct msm_gpu *gpu = &adreno_gpu->base;
> >         struct a6xx_gmu *gmu = &a6xx_gpu->gmu;
> >         int status, ret;
> >
> > @@ -720,6 +732,9 @@ int a6xx_gmu_resume(struct a6xx_gpu *a6xx_gpu)
> >         if (ret)
> >                 goto out;
> >
> > +       /* Set the bus quota to a reasonable value for boot */
> > +       icc_set_bw(gpu->icc_path, 0, MBps_to_icc(3072));
> 
> Does the comment mention boot because this resume call happens during
> init?

Correct. Boot refers to the GMU in this context.

> How come this number is different from the one in __a6xx_gmu_set_freq?

If you never request a bus quota from the kernel the sucker is horribly
painfully slow. I'm not sure if that is just the default reset value of
the registers or if the bootloader is doing something. In any event
the GMU doesn't always initialize if you try to bring it up with the
default bus settings so we set it to a "reasonable" quota for the 
init sequence. I admit I didn't come up with these numbers on my own;
some poor anonymous soul debugged this on the downstream kernel and
I just stole the same parameters.

As for _a6xx_gmu_set_freq() eventually we'll agree on a way to communicate
the bus bandwidth in the opp settings and we'll be able to adjust the quota
based on the frequency to save power so that's why the code is organized the way
it is so that a6xx_gmu_set_freq() won't have to be massively changed later.

> Also, you're setting an average bandwidth of 0, I
> guess you don't know really what your average is, and the hardware is
> fine with that setting. Is that true?

Yes, we only set the instantaneous bandwidth.

> -Evan

Jordan

-- 
The Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
