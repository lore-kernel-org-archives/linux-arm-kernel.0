Return-Path: <SRS0=niBm=QV=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99ED6C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 12:59:50 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 69A18222B6
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 12:59:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="D8H+I7gV";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="rWsMX2bb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 69A18222B6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=bVGVByzam/PdlcsbuoyQYw4ecDOTsgdY50N2r9natk8=; b=D8H+I7gVp2Ryfk
	uUXMA5ffl+rESV2ZQBakWy5YdKl5k5hCgwdbH6cAs3jMmZl0xUwMym2nC56Kk5BY1IQC+lO5DD77L
	AzkkPTBUOnEjfHiSGHjH40xycq7f2OgSRcG37bvqsIccmrqzsnkreSHABJ+LyzuOE3RbJAkshoW38
	zsrAkzs6HEZBHyxzMxK/AwZmD3T64Pk76Y8Oj9W17KVVjjNLBfwwpTr9Pz+DgPQvv7AIYBcvrnv4V
	OrSRxd2Xq5+jntV0vjaYY5zCITMCKaaEK25cIPKqLDaSsQVOoao5WCwXSpLwMoAVf+tvnjZ/EHvIF
	NofDv1huW9mxcYObWdKg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1guGcH-0004ms-7E; Thu, 14 Feb 2019 12:59:49 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1guGcC-0004j6-QB
 for linux-arm-kernel@lists.infradead.org; Thu, 14 Feb 2019 12:59:46 +0000
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com
 [209.85.208.174])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 0C42A222D7
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 14 Feb 2019 12:59:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1550149184;
 bh=qkkGjogflQGw8aC0e7FKpP308yejD72QYuyBfuWOXyU=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
 b=rWsMX2bbBbB9H+ITSv9rjj/dBhmXWiDrWrsMR2FpGKPTQjJqF3JJbq+3xzdO9SHEZ
 fl2Bl270DLZuFfxHQ+jEOEX/XzaR47YO1K+M3DJqinwOxO4T90GQZ+H/LPClnEt9/Q
 Yug9V+oteIldxXMwbl8aK4jEvqr3ep8DtPAstq7E=
Received: by mail-lj1-f174.google.com with SMTP id j19so4359049ljg.5
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 14 Feb 2019 04:59:43 -0800 (PST)
X-Gm-Message-State: AHQUAuZ1u+BC6EB3PXIuNCLXCvTohOFitkAiH/jW9ExxGaDHlN+nBhRx
 xV00iMCPA13sCirTHajnth48TKplSZ4C6L/KR1s=
X-Google-Smtp-Source: AHgI3IYm4pWyAzIveyQ/CVqof0g3iY+AofjyVUqhg1QpCvDDjIY4fPscqfs7/VGnrL5T+2zTXq0OMaLB+ndqsH6Ypug=
X-Received: by 2002:a2e:4a19:: with SMTP id
 x25-v6mr2070864lja.19.1550149182108; 
 Thu, 14 Feb 2019 04:59:42 -0800 (PST)
MIME-Version: 1.0
References: <20190213214052.2427-1-linux.amoon@gmail.com>
 <20190213214052.2427-3-linux.amoon@gmail.com>
In-Reply-To: <20190213214052.2427-3-linux.amoon@gmail.com>
From: Krzysztof Kozlowski <krzk@kernel.org>
Date: Thu, 14 Feb 2019 13:59:30 +0100
X-Gmail-Original-Message-ID: <CAJKOXPcor0PC-H73nTyVnPYSk+1raL5Q0WSdH-MLvzVz2+u+pA@mail.gmail.com>
Message-ID: <CAJKOXPcor0PC-H73nTyVnPYSk+1raL5Q0WSdH-MLvzVz2+u+pA@mail.gmail.com>
Subject: Re: [RFC 2/2] soc: samsung: pmu: Add the PMU data of exynos4412 to
 support low-power state
To: Anand Moon <linux.amoon@gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190214_045944_900393_BB8A6773 
X-CRM114-Status: GOOD (  27.12  )
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
Cc: devicetree@vger.kernel.org,
 "linux-samsung-soc@vger.kernel.org" <linux-samsung-soc@vger.kernel.org>,
 Pankaj Dubey <pankaj.dubey@samsung.com>, linux-kernel@vger.kernel.org,
 Tomasz Figa <tomasz.figa@gmail.com>, Chanwoo Choi <cw00.choi@samsung.com>,
 Rob Herring <robh+dt@kernel.org>, Kukjin Kim <kgene@kernel.org>,
 linux-arm-kernel@lists.infradead.org,
 Marek Szyprowski <m.szyprowski@samsung.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Wed, 13 Feb 2019 at 22:41, Anand Moon <linux.amoon@gmail.com> wrote:
>
> This patch adds configration for PMU (Power Management Unit) state
> tuning for exynos4412 SoC in order to enter low-power mode during
> suspend power modes and help resume from suspend state.

The U3 and Trats2 already enter STOP/S2R so please describe what
exactly you change.

> Fixes: bfce552d0b1 ("drivers: soc: Add support for Exynos PMU driver")

How it fixes it? What was broken in that commit?

> Cc: Marek Szyprowski <m.szyprowski@samsung.com>
> Cc: Krzysztof Kozlowski <krzk@kernel.org>
> Cc: Chanwoo Choi <cw00.choi@samsung.com>
> Signed-off-by: Anand Moon <linux.amoon@gmail.com>
> ---
>
> Changes from previous patch.
> New patch to this series to support suspend and resume state
>
> Changes have been tested on microSD card but fails to resume on cMMC.
> It need to be investigated and more debuging
> ---
>  drivers/soc/samsung/exynos4-pmu.c           | 83 +++++++++++++++++++++
>  include/linux/soc/samsung/exynos-regs-pmu.h | 21 ++++++
>  2 files changed, 104 insertions(+)
>
> diff --git a/drivers/soc/samsung/exynos4-pmu.c b/drivers/soc/samsung/exynos4-pmu.c
> index a7cdbf1aac0c..d261a0d2371e 100644
> --- a/drivers/soc/samsung/exynos4-pmu.c
> +++ b/drivers/soc/samsung/exynos4-pmu.c
> @@ -200,10 +200,93 @@ static const struct exynos_pmu_conf exynos4412_pmu_config[] = {
>         { PMU_TABLE_END,},
>  };
>
> +static unsigned int const exynos4412_list_feed[] = {
> +       EXYNOS4_ARM_CORE0_OPTION,
> +       EXYNOS4_ARM_CORE1_OPTION,
> +       EXYNOS4_ARM_CORE2_OPTION,
> +       EXYNOS4_ARM_CORE3_OPTION,
> +       EXYNOS4_ARM_COMMON_OPTION,
> +       EXYNOS4_CAM_OPTION,
> +       EXYNOS4_TV_OPTION,
> +       EXYNOS4_MFC_OPTION,
> +       EXYNOS4_G3D_OPTION,
> +       EXYNOS4_LCD0_OPTION,
> +       EXYNOS4_ISP_OPTION,
> +       EXYNOS4_MAUDIO_OPTION,
> +       EXYNOS4_GPS_OPTION,
> +       EXYNOS4_GPS_ALIVE_OPTION,
> +};
> +
> +static void exynos4412_pmu_central_seq(bool enable)

You name the argument as "enable"  but during initialization and
system running you pass here false. It confuses me. What do you enable
here?

> +{
> +       unsigned int value;
> +
> +       value = pmu_raw_readl(S5P_CENTRAL_SEQ_CONFIGURATION);
> +       if (enable)
> +               value &= ~S5P_CENTRAL_LOWPWR_CFG;
> +       else
> +               value |= S5P_CENTRAL_LOWPWR_CFG;
> +       pmu_raw_writel(value, S5P_CENTRAL_SEQ_CONFIGURATION);

You duplicate exynos_pm_central_suspend() without removing the original code.

> +
> +       value = pmu_raw_readl(S5P_CENTRAL_SEQ_CONFIGURATION_COREBLK);
> +       if (enable)
> +               value &= ~S5P_CENTRAL_LOWPWR_CFG;
> +       else
> +               value |= S5P_CENTRAL_LOWPWR_CFG;

As manual says - set this register only if you disable C2C. Our entire
low power configuration for STOP mode is for C2C enabled case so you
add inconsistent configuration.

> +       pmu_raw_writel(value, S5P_CENTRAL_SEQ_CONFIGURATION_COREBLK);
> +}
> +
> +static void exynos4412_pmu_init(void)
> +{
> +       unsigned int value;
> +       int i;
> +
> +       /* Enable USE_STANDBY_WFI for all CORE */
> +       pmu_raw_writel(S5P_USE_STANDBY_WFI_ALL, S5P_CENTRAL_SEQ_OPTION);

This does not look related to improving suspend... it looks unrelated.

> +
> +       /* Decides whether to use retention capability */
> +       value  = pmu_raw_readl(S5P_ARM_L2_0_OPTION);
> +       value &= ~EXYNOS_L2_USE_RETENTION;
> +       pmu_raw_writel(value, S5P_ARM_L2_0_OPTION);
> +
> +       value = pmu_raw_readl(S5P_ARM_L2_1_OPTION);
> +       value &= ~EXYNOS_L2_USE_RETENTION;
> +       pmu_raw_writel(value, S5P_ARM_L2_1_OPTION);
> +
> +       /* Set PSHOLD port for output high */
> +       value = pmu_raw_readl(S5P_PS_HOLD_CONTROL);
> +       value |= S5P_PS_HOLD_OUTPUT_HIGH;
> +       pmu_raw_writel(value, S5P_PS_HOLD_CONTROL);
> +
> +       /* Enable signal for PSHOLD port */
> +       value = pmu_raw_readl(S5P_PS_HOLD_CONTROL);
> +       value |= S5P_PS_HOLD_EN;
> +       pmu_raw_writel(value, S5P_PS_HOLD_CONTROL);
> +

The same - not related.

> +       /* Enable only SC_FEEDBACK */
> +       for (i = 0; i < ARRAY_SIZE(exynos4412_list_feed); i++) {
> +               value =  pmu_raw_readl(exynos4412_list_feed[i]);
> +               value &= ~(EXYNOS_USE_SC_COUNTER);
> +               value |= EXYNOS_USE_SC_FEEDBACK;
> +               pmu_raw_writel(value, exynos4412_list_feed[i]);

Why do you prefer to use feedback instead of counter?

> +       }
> +
> +       exynos4412_pmu_central_seq(false);
> +
> +       pr_info("EXYNOS4x12 PMU Initialize\n");
> +}
> +
> +static void exynos4412_powerdown_conf(enum sys_powerdown mode)
> +{
> +       exynos4412_pmu_central_seq(true);
> +}
> +
>  const struct exynos_pmu_data exynos4210_pmu_data = {
>         .pmu_config     = exynos4210_pmu_config,
>  };
>
>  const struct exynos_pmu_data exynos4412_pmu_data = {
>         .pmu_config             = exynos4412_pmu_config,
> +       .pmu_init               = exynos4412_pmu_init,
> +       .powerdown_conf         = exynos4412_powerdown_conf,
>  };
> diff --git a/include/linux/soc/samsung/exynos-regs-pmu.h b/include/linux/soc/samsung/exynos-regs-pmu.h
> index 5addaf5ccbce..6beed3e669d2 100644
> --- a/include/linux/soc/samsung/exynos-regs-pmu.h
> +++ b/include/linux/soc/samsung/exynos-regs-pmu.h
> @@ -16,6 +16,8 @@
>
>  #define S5P_CENTRAL_SEQ_CONFIGURATION          0x0200
>
> +#define S5P_CENTRAL_SEQ_CONFIGURATION_COREBLK   0x0240
> +
>  #define S5P_CENTRAL_LOWPWR_CFG                 (1 << 16)
>
>  #define S5P_CENTRAL_SEQ_OPTION                 0x0208
> @@ -347,6 +349,25 @@
>  #define EXYNOS3_OPTION_USE_SC_FEEDBACK                 (1 << 1)
>  #define EXYNOS3_OPTION_SKIP_DEACTIVATE_ACEACP_IN_PWDN  (1 << 7)
>
> +/* EXYNOS4 */
> +#define EXYNOS_USE_SC_FEEDBACK                                 BIT(1)
> +#define EXYNOS_USE_SC_COUNTER                                  BIT(0)

Instead of adding third set of these defines, I would prefer to
cleanup existing and squash all into one (exynos3 and exynos5).

> +
> +#define EXYNOS4_ARM_CORE0_OPTION                               0x2008
> +#define EXYNOS4_ARM_CORE1_OPTION                               0x2088
> +#define EXYNOS4_ARM_CORE2_OPTION                               0x2108
> +#define EXYNOS4_ARM_CORE3_OPTION                               0x2188

The same.

> +#define EXYNOS4_ARM_COMMON_OPTION                              0x2408
> +#define EXYNOS4_CAM_OPTION                                     0x3C08
> +#define EXYNOS4_TV_OPTION                                      0x3C28
> +#define EXYNOS4_MFC_OPTION                                     0x3C48
> +#define EXYNOS4_G3D_OPTION                                     0x3C68
> +#define EXYNOS4_LCD0_OPTION                                    0x3C88
> +#define EXYNOS4_ISP_OPTION                                     0x3CA8
> +#define EXYNOS4_MAUDIO_OPTION                                  0x3CC8
> +#define EXYNOS4_GPS_OPTION                                     0x3CE8
> +#define EXYNOS4_GPS_ALIVE_OPTION                               0x3D08

Do you need them? I think the are already defined and used by Exynos3.

Best regards,
Krzysztof

> +
>  /* For EXYNOS5 */
>
>  #define EXYNOS5_AUTO_WDTRESET_DISABLE                          0x0408
> --
> 2.20.1
>

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
