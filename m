Return-Path: <SRS0=7SPH=QW=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7372C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 07:34:29 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7C1A0222DF
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 07:34:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="MEpp8eFO";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="uY2v/mGO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7C1A0222DF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=8eXYPvA59zwTBo3dy6gZBf4P3HtGGUnCo4Hql3zL9/M=; b=MEpp8eFOFTJm5L
	+gMZzKxENj7Pu5CXAFlTH3GZqbKQl2CUhHi1IVwYUMPvss9b+3ciI74cdHP5FIoBgswIsLi8qBvNG
	S+5GA8nvWcXjjSwLUi+dILq2IuzNycFn0op8Sxec/30n2NkIjo1wyKPTWSQuiX0q88Ws8YLrgIqKF
	HNJNxRwuDW451c/+ZUOV+GwJilqHwql9R2YnzrFjWg7sFkeVCUHZTdARZHWL/ZnAIeQI+jb+Ivzro
	h7O6T3L3ndJNOjhLqOPRQMVhDwVN8jI0OWIQKk4yDwQjPnzAA37IDNzGn5LDgjMpLsE6C29QUYJhz
	jlSAA3cU9L5WByetb7lQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1guY0M-00037O-Gr; Fri, 15 Feb 2019 07:33:50 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1guY0J-00036e-1M
 for linux-arm-kernel@lists.infradead.org; Fri, 15 Feb 2019 07:33:48 +0000
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com
 [209.85.208.182])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 6047E2192C
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 15 Feb 2019 07:33:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1550216020;
 bh=JkhbJfajx4kyFLGB7PsgIReCSXxq0iFyncDlgujLKJg=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
 b=uY2v/mGOm8RsH0rxl5SeKdSN6Lwr4+c63cqApaPZED4/nqfyMMCNigZ+vG3UlS1cw
 BxBwkkRfiocFn+hUCKNxK+ocq7evDhqOar/diDN3ZxTTU+VP3rPpqnO0LhSMTkrre5
 b5tZd88FXNWnnYxlKA6jiI8/PpW7cyVfGf+dBCkM=
Received: by mail-lj1-f182.google.com with SMTP id z20so6485560ljj.10
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 14 Feb 2019 23:33:40 -0800 (PST)
X-Gm-Message-State: AHQUAuZgjhrQbv4HqexKSJZmBVGISRdd1xsRDPyCa4Et5Pxcx6AGNsQC
 i3t/jB2Uh2/kP8Uk49lELCba4t3Lox3q3tSLQPU=
X-Google-Smtp-Source: AHgI3IYkDgnyQUqHISHOogrtMOrDslgT64XdtsJ4cKrWuIJNk7cS5KVUORS1JPx8a3gnPq9WJF9CTeNpuuB8j4bRTAs=
X-Received: by 2002:a2e:999a:: with SMTP id
 w26-v6mr4802715lji.169.1550216008502; 
 Thu, 14 Feb 2019 23:33:28 -0800 (PST)
MIME-Version: 1.0
References: <20190213214052.2427-1-linux.amoon@gmail.com>
 <20190213214052.2427-3-linux.amoon@gmail.com>
 <CAJKOXPcor0PC-H73nTyVnPYSk+1raL5Q0WSdH-MLvzVz2+u+pA@mail.gmail.com>
 <CANAwSgQfarF9VAJwPuGgaM3T5WFPqSdxDU8OP_OLMb_GWCB=XQ@mail.gmail.com>
In-Reply-To: <CANAwSgQfarF9VAJwPuGgaM3T5WFPqSdxDU8OP_OLMb_GWCB=XQ@mail.gmail.com>
From: Krzysztof Kozlowski <krzk@kernel.org>
Date: Fri, 15 Feb 2019 08:33:17 +0100
X-Gmail-Original-Message-ID: <CAJKOXPdo8cVwL8kb4NzvvDUDaVgAgDf3OM=aJqVdkyPminPG2A@mail.gmail.com>
Message-ID: <CAJKOXPdo8cVwL8kb4NzvvDUDaVgAgDf3OM=aJqVdkyPminPG2A@mail.gmail.com>
Subject: Re: [RFC 2/2] soc: samsung: pmu: Add the PMU data of exynos4412 to
 support low-power state
To: Anand Moon <linux.amoon@gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190214_233347_122037_CBC2D084 
X-CRM114-Status: GOOD (  39.93  )
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
Cc: devicetree <devicetree@vger.kernel.org>,
 "linux-samsung-soc@vger.kernel.org" <linux-samsung-soc@vger.kernel.org>,
 Pankaj Dubey <pankaj.dubey@samsung.com>,
 Linux Kernel <linux-kernel@vger.kernel.org>,
 Tomasz Figa <tomasz.figa@gmail.com>, Chanwoo Choi <cw00.choi@samsung.com>,
 Rob Herring <robh+dt@kernel.org>, Kukjin Kim <kgene@kernel.org>,
 linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
 Marek Szyprowski <m.szyprowski@samsung.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Thu, 14 Feb 2019 at 19:37, Anand Moon <linux.amoon@gmail.com> wrote:
>
> Hi Krzysztof,
>
> Thanks for your review comments.
>
> On Thu, 14 Feb 2019 at 18:29, Krzysztof Kozlowski <krzk@kernel.org> wrote:
> >
> > On Wed, 13 Feb 2019 at 22:41, Anand Moon <linux.amoon@gmail.com> wrote:
> > >
> > > This patch adds configration for PMU (Power Management Unit) state
> > > tuning for exynos4412 SoC in order to enter low-power mode during
> > > suspend power modes and help resume from suspend state.
> >
> > The U3 and Trats2 already enter STOP/S2R so please describe what
> > exactly you change.
> >
> > > Fixes: bfce552d0b1 ("drivers: soc: Add support for Exynos PMU driver")
> >
> > How it fixes it? What was broken in that commit?
>
> * I was not aware on their is common framework for suspend and resume
> other than setting this here.I only look in to some the other exynos
> pmu architecture
> and referring 3.10.x kernel to model my changes.*

Suspend in general should be working already so adding this code just
because is not a valid reason. Please specify what is not working
first.

> >
> > > Cc: Marek Szyprowski <m.szyprowski@samsung.com>
> > > Cc: Krzysztof Kozlowski <krzk@kernel.org>
> > > Cc: Chanwoo Choi <cw00.choi@samsung.com>
> > > Signed-off-by: Anand Moon <linux.amoon@gmail.com>
> > > ---
> > >
> > > Changes from previous patch.
> > > New patch to this series to support suspend and resume state
> > >
> > > Changes have been tested on microSD card but fails to resume on cMMC.
> > > It need to be investigated and more debuging
> > > ---
> > >  drivers/soc/samsung/exynos4-pmu.c           | 83 +++++++++++++++++++++
> > >  include/linux/soc/samsung/exynos-regs-pmu.h | 21 ++++++
> > >  2 files changed, 104 insertions(+)
> > >
> > > diff --git a/drivers/soc/samsung/exynos4-pmu.c b/drivers/soc/samsung/exynos4-pmu.c
> > > index a7cdbf1aac0c..d261a0d2371e 100644
> > > --- a/drivers/soc/samsung/exynos4-pmu.c
> > > +++ b/drivers/soc/samsung/exynos4-pmu.c
> > > @@ -200,10 +200,93 @@ static const struct exynos_pmu_conf exynos4412_pmu_config[] = {
> > >         { PMU_TABLE_END,},
> > >  };
> > >
> > > +static unsigned int const exynos4412_list_feed[] = {
> > > +       EXYNOS4_ARM_CORE0_OPTION,
> > > +       EXYNOS4_ARM_CORE1_OPTION,
> > > +       EXYNOS4_ARM_CORE2_OPTION,
> > > +       EXYNOS4_ARM_CORE3_OPTION,
> > > +       EXYNOS4_ARM_COMMON_OPTION,
> > > +       EXYNOS4_CAM_OPTION,
> > > +       EXYNOS4_TV_OPTION,
> > > +       EXYNOS4_MFC_OPTION,
> > > +       EXYNOS4_G3D_OPTION,
> > > +       EXYNOS4_LCD0_OPTION,
> > > +       EXYNOS4_ISP_OPTION,
> > > +       EXYNOS4_MAUDIO_OPTION,
> > > +       EXYNOS4_GPS_OPTION,
> > > +       EXYNOS4_GPS_ALIVE_OPTION,
> > > +};
> > > +
> > > +static void exynos4412_pmu_central_seq(bool enable)
> >
> > You name the argument as "enable"  but during initialization and
> > system running you pass here false. It confuses me. What do you enable
> > here?
> >
>
> Yep your are correct need to drop this function as already done in
> common frame work.
>
> > > +{
> > > +       unsigned int value;
> > > +
> > > +       value = pmu_raw_readl(S5P_CENTRAL_SEQ_CONFIGURATION);
> > > +       if (enable)
> > > +               value &= ~S5P_CENTRAL_LOWPWR_CFG;
> > > +       else
> > > +               value |= S5P_CENTRAL_LOWPWR_CFG;
> > > +       pmu_raw_writel(value, S5P_CENTRAL_SEQ_CONFIGURATION);
> >
> > You duplicate exynos_pm_central_suspend() without removing the original code.
> >
> > > +
> > > +       value = pmu_raw_readl(S5P_CENTRAL_SEQ_CONFIGURATION_COREBLK);
> > > +       if (enable)
> > > +               value &= ~S5P_CENTRAL_LOWPWR_CFG;
> > > +       else
> > > +               value |= S5P_CENTRAL_LOWPWR_CFG;
> >
> > As manual says - set this register only if you disable C2C. Our entire
> > low power configuration for STOP mode is for C2C enabled case so you
> > add inconsistent configuration.
>
> Ok Sorry I overlook this code change.
>
> Enable system power down. Set only CENTRAL_SEQ_CONFIGURATION register
> if you disable C2C.
> Set both CENTRAL_SEQ_CONFIGURATION and
> CENTRAL_SEQ_CONFIGURATION_COREBLK registers if you enable C2C.
>
> > > +       pmu_raw_writel(value, S5P_CENTRAL_SEQ_CONFIGURATION_COREBLK);
> > > +}
> > > +
> > > +static void exynos4412_pmu_init(void)
> > > +{
> > > +       unsigned int value;
> > > +       int i;
> > > +
> > > +       /* Enable USE_STANDBY_WFI for all CORE */
> > > +       pmu_raw_writel(S5P_USE_STANDBY_WFI_ALL, S5P_CENTRAL_SEQ_OPTION);
> >
> > This does not look related to improving suspend... it looks unrelated.
> >
>
> Ok  yes your are correct all ready done in comment frame work.
>
> "Execute WFI/WFE for all CPU cores. As soon as all the CPU cores in
> Exynos 4412 SCP enter STANDBY mode"
> > > +
> > > +       /* Decides whether to use retention capability */
> > > +       value  = pmu_raw_readl(S5P_ARM_L2_0_OPTION);
> > > +       value &= ~EXYNOS_L2_USE_RETENTION;
> > > +       pmu_raw_writel(value, S5P_ARM_L2_0_OPTION);
> > > +
> > > +       value = pmu_raw_readl(S5P_ARM_L2_1_OPTION);
> > > +       value &= ~EXYNOS_L2_USE_RETENTION;
> > > +       pmu_raw_writel(value, S5P_ARM_L2_1_OPTION);
> > > +
> > > +       /* Set PSHOLD port for output high */
> > > +       value = pmu_raw_readl(S5P_PS_HOLD_CONTROL);
> > > +       value |= S5P_PS_HOLD_OUTPUT_HIGH;
> > > +       pmu_raw_writel(value, S5P_PS_HOLD_CONTROL);
> > > +
> > > +       /* Enable signal for PSHOLD port */
> > > +       value = pmu_raw_readl(S5P_PS_HOLD_CONTROL);
> > > +       value |= S5P_PS_HOLD_EN;
> > > +       pmu_raw_writel(value, S5P_PS_HOLD_CONTROL);
> > > +
> >
> > The same - not related.
>
> PS_HOLD_CONTROL need to be set under following set
> Hardware reset                             Reset
> Watchdog timer reset                   Keep its value
> Software reset                              Keep its value
> Warm reset                                   Keep its value
> Wakeup reset                               Keep its value

Which is not related to suspend...

>
> >
> > > +       /* Enable only SC_FEEDBACK */
> > > +       for (i = 0; i < ARRAY_SIZE(exynos4412_list_feed); i++) {
> > > +               value =  pmu_raw_readl(exynos4412_list_feed[i]);
> > > +               value &= ~(EXYNOS_USE_SC_COUNTER);
> > > +               value |= EXYNOS_USE_SC_FEEDBACK;
> > > +               pmu_raw_writel(value, exynos4412_list_feed[i]);
> >
> > Why do you prefer to use feedback instead of counter?
> >
>
> Their is a note below if we use this setting.
> NOTE: Either one of USE_SC_FEEDBACK and USE_SC_COUNTER should be activated.

This is not the answer to my question at all.

Best regards,
Krzysztof

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
