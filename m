Return-Path: <SRS0=niBm=QV=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06BD7C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 18:38:02 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CA37021B68
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 18:38:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="qM6Ehvlk";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RD8sJW0Z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CA37021B68
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=qwnwyArP94ouaEupzDGpN5FGoSpfN2Gg6FFFPXreXxs=; b=qM6Ehvlksf5wzS
	Ei/GbrdRA8CtPNQc6NGr0qW5ntF97EeWvk6lc/obKOBzskDYmFrzK7ODcXUD/46BHINGpJCJFuEY5
	PIOYPpnMh06YkMiVocf+liTgl+v4Oblnrj5pXRjZOq62wzXRasSFEqIP66kK7PTTObJEw6bscTe5n
	e3/xaffrwFz3t4/C/4ZnmWata1cG0lzkaUXrARn3uusfidUxJ2Nwa+ZD7u4xMs18IY33uFYitzOoK
	bIhHuelS1rIV0Vrd/zdtSquIDnMnrddBHIX1VQtuLlNMGPfXiKyNHr2BfEnSuLDdMjgGz0IOi2atg
	FpSPDwtltKfY/C+DvYxA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1guLtS-00011b-6n; Thu, 14 Feb 2019 18:37:54 +0000
Received: from mail-ot1-x341.google.com ([2607:f8b0:4864:20::341])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1guLtO-00011E-Nn
 for linux-arm-kernel@lists.infradead.org; Thu, 14 Feb 2019 18:37:52 +0000
Received: by mail-ot1-x341.google.com with SMTP id s5so12219300oth.7
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 14 Feb 2019 10:37:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=W5+9EDTQTOBtrNLbXbU9JH4u8DShwdU1NogeTl0stFw=;
 b=RD8sJW0Z+JUPpPaAWJv6yWI/5TvjbywVY+IRZDt9RPwlncTtOLG7uNTMcMasn9cQHn
 ThLhvs42R4M4AVQGBOcN2QpzTvkv/GovZ/9NIYJ4zrhob2BORiJwBAgA41JNTfMyaxJz
 TsoPc3dgO8k7rTqSo1jQVh6psOSz3LqibnPZyqaUjUJO9DGDfwF3Coy3fd+BpdBp+WOv
 R4YLkohzWeQdPz7Z8DhV7+eICRDeODxwwoJDrke0OO2F36VDKUVTwf2GEYzUbHA8SjsL
 tNWfy/09UzNHyMaYGOG5Ka+388fyJusOGQv9BLmjl9gKAKLslFWjGWn3GcDq3e9tzB+D
 0ujw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=W5+9EDTQTOBtrNLbXbU9JH4u8DShwdU1NogeTl0stFw=;
 b=jXdqqiMad+o18VT6MHUL3fxnYPZ8NSf5itcf/LzgAXEsRq5yr02EB9bGCm7jsDc0dr
 +g+lhuaXU57skhBP0yiMUVjXOE0vRvJbDQB6W9uUZm8MJbHzVwfclFdD4S0jtqwK/kCi
 ToHQs6cX44g6R1guvmw7EHLrVB3opM4GAc1n1z+6/31xiIjMvbymusihraReVDttbYn4
 zk50UJvp1PupdOz5hIHPf8qLeXJ9QYfHkyptjW2IriwayL8lGbMBQzUXrqgoq2w8QKkn
 aiC8u+676pTZ7Xq3LNAPciVaoY9jOGwXRNdH/6dkKNjbknyLJNgQDaNlRC3KfrYwOt2a
 xeBw==
X-Gm-Message-State: AHQUAubckqGt5Xn93H0lko5kSBFhxLWkmFlJkyPYE89o5VLZAxUt8ecQ
 4u9ppb4L222BderaGPvGeSPNumj3FDGMln8wxV53Yg==
X-Google-Smtp-Source: AHgI3Ib+bvSoBPhpf3tkX36m0HiGUqMeTe1aL4VmKlCRG/prFF9OSiljQWhcL6oPyXBwarrMHBbfqOElCp58wTuKuCg=
X-Received: by 2002:a9d:6195:: with SMTP id g21mr3135792otk.76.1550169469839; 
 Thu, 14 Feb 2019 10:37:49 -0800 (PST)
MIME-Version: 1.0
References: <20190213214052.2427-1-linux.amoon@gmail.com>
 <20190213214052.2427-3-linux.amoon@gmail.com>
 <CAJKOXPcor0PC-H73nTyVnPYSk+1raL5Q0WSdH-MLvzVz2+u+pA@mail.gmail.com>
In-Reply-To: <CAJKOXPcor0PC-H73nTyVnPYSk+1raL5Q0WSdH-MLvzVz2+u+pA@mail.gmail.com>
From: Anand Moon <linux.amoon@gmail.com>
Date: Fri, 15 Feb 2019 00:07:39 +0530
Message-ID: <CANAwSgQfarF9VAJwPuGgaM3T5WFPqSdxDU8OP_OLMb_GWCB=XQ@mail.gmail.com>
Subject: Re: [RFC 2/2] soc: samsung: pmu: Add the PMU data of exynos4412 to
 support low-power state
To: Krzysztof Kozlowski <krzk@kernel.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190214_103750_780663_1ED12480 
X-CRM114-Status: GOOD (  35.14  )
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

Thanks for your review comments.

On Thu, 14 Feb 2019 at 18:29, Krzysztof Kozlowski <krzk@kernel.org> wrote:
>
> On Wed, 13 Feb 2019 at 22:41, Anand Moon <linux.amoon@gmail.com> wrote:
> >
> > This patch adds configration for PMU (Power Management Unit) state
> > tuning for exynos4412 SoC in order to enter low-power mode during
> > suspend power modes and help resume from suspend state.
>
> The U3 and Trats2 already enter STOP/S2R so please describe what
> exactly you change.
>
> > Fixes: bfce552d0b1 ("drivers: soc: Add support for Exynos PMU driver")
>
> How it fixes it? What was broken in that commit?

* I was not aware on their is common framework for suspend and resume
other than setting this here.I only look in to some the other exynos
pmu architecture
and referring 3.10.x kernel to model my changes.*

>
> > Cc: Marek Szyprowski <m.szyprowski@samsung.com>
> > Cc: Krzysztof Kozlowski <krzk@kernel.org>
> > Cc: Chanwoo Choi <cw00.choi@samsung.com>
> > Signed-off-by: Anand Moon <linux.amoon@gmail.com>
> > ---
> >
> > Changes from previous patch.
> > New patch to this series to support suspend and resume state
> >
> > Changes have been tested on microSD card but fails to resume on cMMC.
> > It need to be investigated and more debuging
> > ---
> >  drivers/soc/samsung/exynos4-pmu.c           | 83 +++++++++++++++++++++
> >  include/linux/soc/samsung/exynos-regs-pmu.h | 21 ++++++
> >  2 files changed, 104 insertions(+)
> >
> > diff --git a/drivers/soc/samsung/exynos4-pmu.c b/drivers/soc/samsung/exynos4-pmu.c
> > index a7cdbf1aac0c..d261a0d2371e 100644
> > --- a/drivers/soc/samsung/exynos4-pmu.c
> > +++ b/drivers/soc/samsung/exynos4-pmu.c
> > @@ -200,10 +200,93 @@ static const struct exynos_pmu_conf exynos4412_pmu_config[] = {
> >         { PMU_TABLE_END,},
> >  };
> >
> > +static unsigned int const exynos4412_list_feed[] = {
> > +       EXYNOS4_ARM_CORE0_OPTION,
> > +       EXYNOS4_ARM_CORE1_OPTION,
> > +       EXYNOS4_ARM_CORE2_OPTION,
> > +       EXYNOS4_ARM_CORE3_OPTION,
> > +       EXYNOS4_ARM_COMMON_OPTION,
> > +       EXYNOS4_CAM_OPTION,
> > +       EXYNOS4_TV_OPTION,
> > +       EXYNOS4_MFC_OPTION,
> > +       EXYNOS4_G3D_OPTION,
> > +       EXYNOS4_LCD0_OPTION,
> > +       EXYNOS4_ISP_OPTION,
> > +       EXYNOS4_MAUDIO_OPTION,
> > +       EXYNOS4_GPS_OPTION,
> > +       EXYNOS4_GPS_ALIVE_OPTION,
> > +};
> > +
> > +static void exynos4412_pmu_central_seq(bool enable)
>
> You name the argument as "enable"  but during initialization and
> system running you pass here false. It confuses me. What do you enable
> here?
>

Yep your are correct need to drop this function as already done in
common frame work.

> > +{
> > +       unsigned int value;
> > +
> > +       value = pmu_raw_readl(S5P_CENTRAL_SEQ_CONFIGURATION);
> > +       if (enable)
> > +               value &= ~S5P_CENTRAL_LOWPWR_CFG;
> > +       else
> > +               value |= S5P_CENTRAL_LOWPWR_CFG;
> > +       pmu_raw_writel(value, S5P_CENTRAL_SEQ_CONFIGURATION);
>
> You duplicate exynos_pm_central_suspend() without removing the original code.
>
> > +
> > +       value = pmu_raw_readl(S5P_CENTRAL_SEQ_CONFIGURATION_COREBLK);
> > +       if (enable)
> > +               value &= ~S5P_CENTRAL_LOWPWR_CFG;
> > +       else
> > +               value |= S5P_CENTRAL_LOWPWR_CFG;
>
> As manual says - set this register only if you disable C2C. Our entire
> low power configuration for STOP mode is for C2C enabled case so you
> add inconsistent configuration.

Ok Sorry I overlook this code change.

Enable system power down. Set only CENTRAL_SEQ_CONFIGURATION register
if you disable C2C.
Set both CENTRAL_SEQ_CONFIGURATION and
CENTRAL_SEQ_CONFIGURATION_COREBLK registers if you enable C2C.

> > +       pmu_raw_writel(value, S5P_CENTRAL_SEQ_CONFIGURATION_COREBLK);
> > +}
> > +
> > +static void exynos4412_pmu_init(void)
> > +{
> > +       unsigned int value;
> > +       int i;
> > +
> > +       /* Enable USE_STANDBY_WFI for all CORE */
> > +       pmu_raw_writel(S5P_USE_STANDBY_WFI_ALL, S5P_CENTRAL_SEQ_OPTION);
>
> This does not look related to improving suspend... it looks unrelated.
>

Ok  yes your are correct all ready done in comment frame work.

"Execute WFI/WFE for all CPU cores. As soon as all the CPU cores in
Exynos 4412 SCP enter STANDBY mode"
> > +
> > +       /* Decides whether to use retention capability */
> > +       value  = pmu_raw_readl(S5P_ARM_L2_0_OPTION);
> > +       value &= ~EXYNOS_L2_USE_RETENTION;
> > +       pmu_raw_writel(value, S5P_ARM_L2_0_OPTION);
> > +
> > +       value = pmu_raw_readl(S5P_ARM_L2_1_OPTION);
> > +       value &= ~EXYNOS_L2_USE_RETENTION;
> > +       pmu_raw_writel(value, S5P_ARM_L2_1_OPTION);
> > +
> > +       /* Set PSHOLD port for output high */
> > +       value = pmu_raw_readl(S5P_PS_HOLD_CONTROL);
> > +       value |= S5P_PS_HOLD_OUTPUT_HIGH;
> > +       pmu_raw_writel(value, S5P_PS_HOLD_CONTROL);
> > +
> > +       /* Enable signal for PSHOLD port */
> > +       value = pmu_raw_readl(S5P_PS_HOLD_CONTROL);
> > +       value |= S5P_PS_HOLD_EN;
> > +       pmu_raw_writel(value, S5P_PS_HOLD_CONTROL);
> > +
>
> The same - not related.

PS_HOLD_CONTROL need to be set under following set
Hardware reset                             Reset
Watchdog timer reset                   Keep its value
Software reset                              Keep its value
Warm reset                                   Keep its value
Wakeup reset                               Keep its value

>
> > +       /* Enable only SC_FEEDBACK */
> > +       for (i = 0; i < ARRAY_SIZE(exynos4412_list_feed); i++) {
> > +               value =  pmu_raw_readl(exynos4412_list_feed[i]);
> > +               value &= ~(EXYNOS_USE_SC_COUNTER);
> > +               value |= EXYNOS_USE_SC_FEEDBACK;
> > +               pmu_raw_writel(value, exynos4412_list_feed[i]);
>
> Why do you prefer to use feedback instead of counter?
>

Their is a note below if we use this setting.
NOTE: Either one of USE_SC_FEEDBACK and USE_SC_COUNTER should be activated.

> > +       }
> > +
> > +       exynos4412_pmu_central_seq(false);
> > +
> > +       pr_info("EXYNOS4x12 PMU Initialize\n");
> > +}
> > +
> > +static void exynos4412_powerdown_conf(enum sys_powerdown mode)
> > +{
> > +       exynos4412_pmu_central_seq(true);
> > +}
> > +
> >  const struct exynos_pmu_data exynos4210_pmu_data = {
> >         .pmu_config     = exynos4210_pmu_config,
> >  };
> >
> >  const struct exynos_pmu_data exynos4412_pmu_data = {
> >         .pmu_config             = exynos4412_pmu_config,
> > +       .pmu_init               = exynos4412_pmu_init,
> > +       .powerdown_conf         = exynos4412_powerdown_conf,
> >  };
> > diff --git a/include/linux/soc/samsung/exynos-regs-pmu.h b/include/linux/soc/samsung/exynos-regs-pmu.h
> > index 5addaf5ccbce..6beed3e669d2 100644
> > --- a/include/linux/soc/samsung/exynos-regs-pmu.h
> > +++ b/include/linux/soc/samsung/exynos-regs-pmu.h
> > @@ -16,6 +16,8 @@
> >
> >  #define S5P_CENTRAL_SEQ_CONFIGURATION          0x0200
> >
> > +#define S5P_CENTRAL_SEQ_CONFIGURATION_COREBLK   0x0240
> > +
> >  #define S5P_CENTRAL_LOWPWR_CFG                 (1 << 16)
> >
> >  #define S5P_CENTRAL_SEQ_OPTION                 0x0208
> > @@ -347,6 +349,25 @@
> >  #define EXYNOS3_OPTION_USE_SC_FEEDBACK                 (1 << 1)
> >  #define EXYNOS3_OPTION_SKIP_DEACTIVATE_ACEACP_IN_PWDN  (1 << 7)
> >
> > +/* EXYNOS4 */
> > +#define EXYNOS_USE_SC_FEEDBACK                                 BIT(1)
> > +#define EXYNOS_USE_SC_COUNTER                                  BIT(0)
>
> Instead of adding third set of these defines, I would prefer to
> cleanup existing and squash all into one (exynos3 and exynos5).
>

Ok I will try to do this changes or use the existing one.

> > +
> > +#define EXYNOS4_ARM_CORE0_OPTION                               0x2008
> > +#define EXYNOS4_ARM_CORE1_OPTION                               0x2088
> > +#define EXYNOS4_ARM_CORE2_OPTION                               0x2108
> > +#define EXYNOS4_ARM_CORE3_OPTION                               0x2188
>
> The same.
>
> > +#define EXYNOS4_ARM_COMMON_OPTION                              0x2408
> > +#define EXYNOS4_CAM_OPTION                                     0x3C08
> > +#define EXYNOS4_TV_OPTION                                      0x3C28
> > +#define EXYNOS4_MFC_OPTION                                     0x3C48
> > +#define EXYNOS4_G3D_OPTION                                     0x3C68
> > +#define EXYNOS4_LCD0_OPTION                                    0x3C88
> > +#define EXYNOS4_ISP_OPTION                                     0x3CA8
> > +#define EXYNOS4_MAUDIO_OPTION                                  0x3CC8
> > +#define EXYNOS4_GPS_OPTION                                     0x3CE8
> > +#define EXYNOS4_GPS_ALIVE_OPTION                               0x3D08
>
> Do you need them? I think the are already defined and used by Exynos3.

Ok  I will uses these form Exynos3.

>
> Best regards,
> Krzysztof
>
> > +
> >  /* For EXYNOS5 */
> >
> >  #define EXYNOS5_AUTO_WDTRESET_DISABLE                          0x0408
> > --
> > 2.20.1
> >

Best Regards


-Anand

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
