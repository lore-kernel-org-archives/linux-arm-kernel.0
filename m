Return-Path: <SRS0=7SPH=QW=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62044C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 08:44:10 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 366DB2190C
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 08:43:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="YVYrETv/";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TXYVnDJT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 366DB2190C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=jyfpPwSo7Cd4+m/c3wZlUejoICyLAC1D1OpG/ZgPfh0=; b=YVYrETv/Vnewpp
	ciCBIXNfJhfebUzshFPCkWM9x2+RbkubpB2KYW0SaB15e0yOZwo90Yl/BeTIutLfAfTVhXWjfx9ys
	R/rflen4OHaHFtI6p7P4ETxIphr02rJThozxJuxZmhEQgYuvJM2vkO3H6eYYAhydbhxZt5L5Icy2H
	TfYjMMtQOrvTk5F7w8+5DkGcw7thOYMb3z06DIlMuvkaaVpJ6EjHKojCFOJGpRUOOmcaLsGz3Sm7P
	AWq+Hedry12HUKfgeL7fpf0AMukh4XMAGQ/lqcF3MDYGsdqRQP4GB9xaB2IQY74u2bZd+PVQs0C7R
	O3YIBztnzXbRoeccCfmg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1guZ5s-0001el-U2; Fri, 15 Feb 2019 08:43:36 +0000
Received: from mail-ot1-x341.google.com ([2607:f8b0:4864:20::341])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1guZ5p-0001eM-Ht
 for linux-arm-kernel@lists.infradead.org; Fri, 15 Feb 2019 08:43:35 +0000
Received: by mail-ot1-x341.google.com with SMTP id n71so15246858ota.10
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 15 Feb 2019 00:43:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=KZwdBdXj+6/7xoeWytQeMbd4oICIIcE3oliGzGSC/DE=;
 b=TXYVnDJTyUa6KDvZbx+s0Xv/SAagFIowNo4MZPsOj0nTDkQMG8pz6dhWVAsAy16f23
 kzs4Ibcf0LVln7XBnPiv5ishrp8KI6uZwYcXSfaQwphgjCkWublnpTzSI//NZY4PfiIU
 vl+VGyfb9c94GOmPin4awvo9H1PWuTKWda59TRboWk9rn1vduBr4aaDBR6c2IGevPJ9Q
 iUZAtYZmLT4O74Db/wR7ATgDUL2N/HOgczC5uY7IfV07ieGNFy8FCT/Rx8WUiOWGzIq3
 GgXeNX7AXyQHliGc7AAVSfNMOGWCRNmDA88f9CuscVTSCaxTNEz52Odtoaf2e50NftaX
 z9ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=KZwdBdXj+6/7xoeWytQeMbd4oICIIcE3oliGzGSC/DE=;
 b=uGSepwyaqt2aJrx6H5uVoz2S2Vw1iggKq+ncvgdgG449NCRK+6tNzgpxfP0HRph/zT
 WvpLsN0zfVy+6mCv8dCs10DidRniUqa8dT8Ze+s+bzU6ZIkiKsgEPS6Jfc5mKcG4X+XW
 83B1Dnbq/WA4Jp4EoGH9sGh/EmPcxwYxvf8EJqD5POyANBXIa4Zi+qmZImEgVoN3r6yI
 sz8nG5R1OlPczT46G5YyOYsSKtCC/XFscll+CmeVLT8yjpOCerZt70ecKKwzVs9A7kBy
 t92M0BuHTE2oMu7KY0KgV6TRastM2Fpsz/3r3mLDE2eAKXwFPga9oH1AKINI6CB2u3wJ
 XzsQ==
X-Gm-Message-State: AHQUAubc6sBZE2UQvQMsLzNk3D2CDTDThEG4wlFGwUna675Q1hOk/Etg
 awFowQKaxB/wfkLOLrNheA13g8KnombUum977DE=
X-Google-Smtp-Source: AHgI3Iba8WjIZkzojNaiGgB3zFtrtGJmPZ4hL07wqlK+q5/NJ9swArfpRCj/08mPl11y6fV+Cw6FESAwYUQI3d0iRFA=
X-Received: by 2002:a9d:6195:: with SMTP id g21mr4959436otk.76.1550220211817; 
 Fri, 15 Feb 2019 00:43:31 -0800 (PST)
MIME-Version: 1.0
References: <20190213214052.2427-1-linux.amoon@gmail.com>
 <20190213214052.2427-3-linux.amoon@gmail.com>
 <CAJKOXPcor0PC-H73nTyVnPYSk+1raL5Q0WSdH-MLvzVz2+u+pA@mail.gmail.com>
 <CANAwSgQfarF9VAJwPuGgaM3T5WFPqSdxDU8OP_OLMb_GWCB=XQ@mail.gmail.com>
 <CAJKOXPdo8cVwL8kb4NzvvDUDaVgAgDf3OM=aJqVdkyPminPG2A@mail.gmail.com>
In-Reply-To: <CAJKOXPdo8cVwL8kb4NzvvDUDaVgAgDf3OM=aJqVdkyPminPG2A@mail.gmail.com>
From: Anand Moon <linux.amoon@gmail.com>
Date: Fri, 15 Feb 2019 14:13:21 +0530
Message-ID: <CANAwSgRXUgykeiPgvBtx63ffFhqoswru7ObNFrnPXF9niZWyhA@mail.gmail.com>
Subject: Re: [RFC 2/2] soc: samsung: pmu: Add the PMU data of exynos4412 to
 support low-power state
To: Krzysztof Kozlowski <krzk@kernel.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190215_004333_618815_31B9524F 
X-CRM114-Status: GOOD (  40.80  )
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

Hi Krzysztof,

On Fri, 15 Feb 2019 at 13:03, Krzysztof Kozlowski <krzk@kernel.org> wrote:
>
> On Thu, 14 Feb 2019 at 19:37, Anand Moon <linux.amoon@gmail.com> wrote:
> >
> > Hi Krzysztof,
> >
> > Thanks for your review comments.
> >
> > On Thu, 14 Feb 2019 at 18:29, Krzysztof Kozlowski <krzk@kernel.org> wrote:
> > >
> > > On Wed, 13 Feb 2019 at 22:41, Anand Moon <linux.amoon@gmail.com> wrote:
> > > >
> > > > This patch adds configration for PMU (Power Management Unit) state
> > > > tuning for exynos4412 SoC in order to enter low-power mode during
> > > > suspend power modes and help resume from suspend state.
> > >
> > > The U3 and Trats2 already enter STOP/S2R so please describe what
> > > exactly you change.
> > >
> > > > Fixes: bfce552d0b1 ("drivers: soc: Add support for Exynos PMU driver")
> > >
> > > How it fixes it? What was broken in that commit?
> >
> > * I was not aware on their is common framework for suspend and resume
> > other than setting this here.I only look in to some the other exynos
> > pmu architecture
> > and referring 3.10.x kernel to model my changes.*
>
> Suspend in general should be working already so adding this code just
> because is not a valid reason. Please specify what is not working
> first.
>

Please accept *my apology* for not studying the code changes required.
Sorry for wasting your precious time in review.

My only intention with this patch was to correctly initialize some PMU
parameters.
which might be wrong. so lets drop this.

> > >
> > > > Cc: Marek Szyprowski <m.szyprowski@samsung.com>
> > > > Cc: Krzysztof Kozlowski <krzk@kernel.org>
> > > > Cc: Chanwoo Choi <cw00.choi@samsung.com>
> > > > Signed-off-by: Anand Moon <linux.amoon@gmail.com>
> > > > ---
> > > >
> > > > Changes from previous patch.
> > > > New patch to this series to support suspend and resume state
> > > >
> > > > Changes have been tested on microSD card but fails to resume on cMMC.
> > > > It need to be investigated and more debuging
> > > > ---
> > > >  drivers/soc/samsung/exynos4-pmu.c           | 83 +++++++++++++++++++++
> > > >  include/linux/soc/samsung/exynos-regs-pmu.h | 21 ++++++
> > > >  2 files changed, 104 insertions(+)
> > > >
> > > > diff --git a/drivers/soc/samsung/exynos4-pmu.c b/drivers/soc/samsung/exynos4-pmu.c
> > > > index a7cdbf1aac0c..d261a0d2371e 100644
> > > > --- a/drivers/soc/samsung/exynos4-pmu.c
> > > > +++ b/drivers/soc/samsung/exynos4-pmu.c
> > > > @@ -200,10 +200,93 @@ static const struct exynos_pmu_conf exynos4412_pmu_config[] = {
> > > >         { PMU_TABLE_END,},
> > > >  };
> > > >
> > > > +static unsigned int const exynos4412_list_feed[] = {
> > > > +       EXYNOS4_ARM_CORE0_OPTION,
> > > > +       EXYNOS4_ARM_CORE1_OPTION,
> > > > +       EXYNOS4_ARM_CORE2_OPTION,
> > > > +       EXYNOS4_ARM_CORE3_OPTION,
> > > > +       EXYNOS4_ARM_COMMON_OPTION,
> > > > +       EXYNOS4_CAM_OPTION,
> > > > +       EXYNOS4_TV_OPTION,
> > > > +       EXYNOS4_MFC_OPTION,
> > > > +       EXYNOS4_G3D_OPTION,
> > > > +       EXYNOS4_LCD0_OPTION,
> > > > +       EXYNOS4_ISP_OPTION,
> > > > +       EXYNOS4_MAUDIO_OPTION,
> > > > +       EXYNOS4_GPS_OPTION,
> > > > +       EXYNOS4_GPS_ALIVE_OPTION,
> > > > +};
> > > > +
> > > > +static void exynos4412_pmu_central_seq(bool enable)
> > >
> > > You name the argument as "enable"  but during initialization and
> > > system running you pass here false. It confuses me. What do you enable
> > > here?
> > >
> >
> > Yep your are correct need to drop this function as already done in
> > common frame work.
> >
> > > > +{
> > > > +       unsigned int value;
> > > > +
> > > > +       value = pmu_raw_readl(S5P_CENTRAL_SEQ_CONFIGURATION);
> > > > +       if (enable)
> > > > +               value &= ~S5P_CENTRAL_LOWPWR_CFG;
> > > > +       else
> > > > +               value |= S5P_CENTRAL_LOWPWR_CFG;
> > > > +       pmu_raw_writel(value, S5P_CENTRAL_SEQ_CONFIGURATION);
> > >
> > > You duplicate exynos_pm_central_suspend() without removing the original code.
> > >
> > > > +
> > > > +       value = pmu_raw_readl(S5P_CENTRAL_SEQ_CONFIGURATION_COREBLK);
> > > > +       if (enable)
> > > > +               value &= ~S5P_CENTRAL_LOWPWR_CFG;
> > > > +       else
> > > > +               value |= S5P_CENTRAL_LOWPWR_CFG;
> > >
> > > As manual says - set this register only if you disable C2C. Our entire
> > > low power configuration for STOP mode is for C2C enabled case so you
> > > add inconsistent configuration.
> >
> > Ok Sorry I overlook this code change.
> >
> > Enable system power down. Set only CENTRAL_SEQ_CONFIGURATION register
> > if you disable C2C.
> > Set both CENTRAL_SEQ_CONFIGURATION and
> > CENTRAL_SEQ_CONFIGURATION_COREBLK registers if you enable C2C.
> >
> > > > +       pmu_raw_writel(value, S5P_CENTRAL_SEQ_CONFIGURATION_COREBLK);
> > > > +}
> > > > +
> > > > +static void exynos4412_pmu_init(void)
> > > > +{
> > > > +       unsigned int value;
> > > > +       int i;
> > > > +
> > > > +       /* Enable USE_STANDBY_WFI for all CORE */
> > > > +       pmu_raw_writel(S5P_USE_STANDBY_WFI_ALL, S5P_CENTRAL_SEQ_OPTION);
> > >
> > > This does not look related to improving suspend... it looks unrelated.
> > >
> >
> > Ok  yes your are correct all ready done in comment frame work.
> >
> > "Execute WFI/WFE for all CPU cores. As soon as all the CPU cores in
> > Exynos 4412 SCP enter STANDBY mode"
> > > > +
> > > > +       /* Decides whether to use retention capability */
> > > > +       value  = pmu_raw_readl(S5P_ARM_L2_0_OPTION);
> > > > +       value &= ~EXYNOS_L2_USE_RETENTION;
> > > > +       pmu_raw_writel(value, S5P_ARM_L2_0_OPTION);
> > > > +
> > > > +       value = pmu_raw_readl(S5P_ARM_L2_1_OPTION);
> > > > +       value &= ~EXYNOS_L2_USE_RETENTION;
> > > > +       pmu_raw_writel(value, S5P_ARM_L2_1_OPTION);
> > > > +
> > > > +       /* Set PSHOLD port for output high */
> > > > +       value = pmu_raw_readl(S5P_PS_HOLD_CONTROL);
> > > > +       value |= S5P_PS_HOLD_OUTPUT_HIGH;
> > > > +       pmu_raw_writel(value, S5P_PS_HOLD_CONTROL);
> > > > +
> > > > +       /* Enable signal for PSHOLD port */
> > > > +       value = pmu_raw_readl(S5P_PS_HOLD_CONTROL);
> > > > +       value |= S5P_PS_HOLD_EN;
> > > > +       pmu_raw_writel(value, S5P_PS_HOLD_CONTROL);
> > > > +
> > >
> > > The same - not related.
> >
> > PS_HOLD_CONTROL need to be set under following set
> > Hardware reset                             Reset
> > Watchdog timer reset                   Keep its value
> > Software reset                              Keep its value
> > Warm reset                                   Keep its value
> > Wakeup reset                               Keep its value
>
> Which is not related to suspend...
>
> >
> > >
> > > > +       /* Enable only SC_FEEDBACK */
> > > > +       for (i = 0; i < ARRAY_SIZE(exynos4412_list_feed); i++) {
> > > > +               value =  pmu_raw_readl(exynos4412_list_feed[i]);
> > > > +               value &= ~(EXYNOS_USE_SC_COUNTER);
> > > > +               value |= EXYNOS_USE_SC_FEEDBACK;
> > > > +               pmu_raw_writel(value, exynos4412_list_feed[i]);
> > >
> > > Why do you prefer to use feedback instead of counter?
> > >
> >
> > Their is a note below if we use this setting.
> > NOTE: Either one of USE_SC_FEEDBACK and USE_SC_COUNTER should be activated.
>
> This is not the answer to my question at all.
>
> Best regards,
> Krzysztof

Once again sorry for wasting your time.
I know I have the improve a lot of things.

Best Regards

-Anand

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
