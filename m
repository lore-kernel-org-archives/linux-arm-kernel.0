Return-Path: <SRS0=ULCN=QZ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17ED9C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 04:14:43 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DA910218B0
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 04:14:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="pXxdAlUg";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Kk+QZ2Ld"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DA910218B0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=MoXRu6kymx+pP2PanVJ8L13Wy2CHqjP+pRCaFjlQyA4=; b=pXxdAlUge6V+TC
	C2ay3Lsfx/58SQSS1mjUYdnyLO/ri84twN5NgRqXe8d5F/j6A3UmeaMDsOP2kuuiWoTcsRgSS1tuW
	Sym6ot6tHNrhR2s8eROjZ56icAo6T7g6m0O1WrO9WCVLjqPWEHebrgiMzDqCRyCrFF/o227qf7QTJ
	1u0MdTJwDKCinCjJLihaaShMstZr/EKvhkXKs2XIG2c6gOyl+LpAyUwT+qfM6tnToVlgH6UbVLDJk
	1mh21C0gpPomdB7+cvndTslf9BPaxSQVFSYll+KOjn2oclHm7acWBgq6+S9nz0wY6qBIc5740SsW8
	FPZFfSNYYZwxu8Rjt24A==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gvaKB-00079R-VR; Mon, 18 Feb 2019 04:14:35 +0000
Received: from mail-ot1-x343.google.com ([2607:f8b0:4864:20::343])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gvaK8-000792-KO
 for linux-arm-kernel@lists.infradead.org; Mon, 18 Feb 2019 04:14:34 +0000
Received: by mail-ot1-x343.google.com with SMTP id i20so26181504otl.0
 for <linux-arm-kernel@lists.infradead.org>;
 Sun, 17 Feb 2019 20:14:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=j3zQ7MzetWIL4UARuFgAO2eqnT1z6SKxUJuSSbh4rHY=;
 b=Kk+QZ2LdlC6falH9icBuGeXSD0fGYCvW5G/Sm4q8ZY1gsb6jtBVNzIUG0DygDa3RCU
 qKTYwn/yWGjzJzMLy+V+ZXS1Kiu7tk9WovDjdbkku+nR1GFmAc8CBgYEWjYZZExfKfGU
 DD5H7h6MW23K79jyuOXq1VIkMyihmolsWgCjP69WREu3Rx+nNRO+jRCH4Ola5g+TEl9W
 +qzh8r4gtkKz3WfPrHzSesJDt8Y5QKDLmLJiMrkQqe+RZTRpbfhkeMv6X4d/prG7T4o6
 FjX1HOEsLDHDOtcEk5OeFcL+foH84Usvfw5SPZzzVy1i+fM8EmpsfXfQDhQVB9rny8SV
 mWLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=j3zQ7MzetWIL4UARuFgAO2eqnT1z6SKxUJuSSbh4rHY=;
 b=DcGIyXx0uQ4m5emve8j2jqZPS9BafmKayU4NV2G4yfeARUFLY+h5CT6S/o6uzB3CfI
 4biodbkrnxZjjWh+DSoE+7yi6pWwNB4BLOeZ0rLVNpPp9Opv4CVZjbZzfisrEMAXJYiv
 mHYEuE3iCXon5JkkzClG5WM2sWPVztRPfuY6ILdzxjbPGgWsrx3YDPg1+wpAADHD2wu6
 Em0E1sb4ewd7+P2Bl+UcD5Rm/Q8RBBxevYzvq+yieoHdDM1P9TFZ8M6V6rMXqBBg4w/E
 Y6Mf33a4dPho6zQnXdvwRwODt+P7AMZOcvBV7VIlzrngFfus7CpoWtDX4OYa03NSsVJ/
 I+BQ==
X-Gm-Message-State: AHQUAubpl+/Zs8lvRpNieHEZP86ANFmO+mDRfPLoi/h25a1a3A1OKU10
 vbg2KN/DNbGcXeIn61a9TBn4yVD13CX2slfu0L0=
X-Google-Smtp-Source: AHgI3IaRjtBzmI3kHY+NZWl3+2f8BqZNMgfoSDbBhXtKUYXk5sdyOy2PqNHTEroo2QAuvZ2iM3BGiBsGsk5T9uNBtmw=
X-Received: by 2002:a9d:7417:: with SMTP id n23mr12615458otk.63.1550463268605; 
 Sun, 17 Feb 2019 20:14:28 -0800 (PST)
MIME-Version: 1.0
References: <CGME20190215105644eucas1p19d0bdab386354cff0a9a354b5e33f0fe@eucas1p1.samsung.com>
 <20190215105638.17476-1-m.szyprowski@samsung.com>
In-Reply-To: <20190215105638.17476-1-m.szyprowski@samsung.com>
From: Anand Moon <linux.amoon@gmail.com>
Date: Mon, 18 Feb 2019 09:44:18 +0530
Message-ID: <CANAwSgRHhX8t7hDzfy2y6hggUiORRcLZ1VyM_UsDyiRTJ9L12w@mail.gmail.com>
Subject: Re: [PATCH v2] ARM: pm: fix HYP/SVC mode mismatch when MCPM is used
To: Marek Szyprowski <m.szyprowski@samsung.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190217_201432_694974_3FC56A30 
X-CRM114-Status: GOOD (  20.37  )
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
Cc: Nicolas Pitre <nicolas.pitre@linaro.org>, linux-samsung-soc@vger.kernel.org,
 Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
 Kevin Hilman <khilman@baylibre.com>, Seung-Woo Kim <sw0312.kim@samsung.com>,
 Linux Kernel <linux-kernel@vger.kernel.org>,
 Krzysztof Kozlowski <krzk@kernel.org>,
 Russell King <rmk+kernel@armlinux.org.uk>,
 Marian Mihailescu <mihailescu2m@gmail.com>,
 linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi Marek,

On Fri, 15 Feb 2019 at 21:40, Marek Szyprowski <m.szyprowski@samsung.com> wrote:
>
> MCPM does a soft reset of the CPUs and uses common cpu_resume() routine to
> perform low-level platform initialization. This results in a try to install
> HYP stubs for the second time for each CPU and results in false HYP/SVC
> mode mismatch detection. The HYP stubs are already installed at the
> beginning of the kernel initialization on the boot CPU (head.S) or in the
> secondary_startup() for other CPUs. To fix this issue MCPM code should use
> a cpu_resume() routine without HYP stubs installation.
>
> This change fixes HYP/SVC mode mismatch on Samsung Exynos5422-based Odroid
> XU3/XU4/HC1 boards.
>
> Fixes: 3721924c8154 ("ARM: 8081/1: MCPM: provide infrastructure to allow for MCPM loopback")
> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
> Acked-by: Nicolas Pitre <nico@linaro.org>
> ---

Please add my.

Tested-by: Anand Moon <linux.amoon@gmail.com>

[    0.701094] smp: Brought up 1 node, 8 CPUs
[    0.701212] SMP: Total of 8 processors activated (384.00 BogoMIPS).
[    0.701329] CPU: All CPU(s) started in HYP mode.
[    0.701421] CPU: Virtualization extensions available.


> v2:
> - fixed support for Thumb-mode kernel
> ---
>  arch/arm/common/mcpm_entry.c   |  2 +-
>  arch/arm/include/asm/suspend.h |  1 +
>  arch/arm/kernel/sleep.S        | 12 ++++++++++++
>  3 files changed, 14 insertions(+), 1 deletion(-)
>
> diff --git a/arch/arm/common/mcpm_entry.c b/arch/arm/common/mcpm_entry.c
> index ad574d20415c..1b1b82b37ce0 100644
> --- a/arch/arm/common/mcpm_entry.c
> +++ b/arch/arm/common/mcpm_entry.c
> @@ -381,7 +381,7 @@ static int __init nocache_trampoline(unsigned long _arg)
>         unsigned int cluster = MPIDR_AFFINITY_LEVEL(mpidr, 1);
>         phys_reset_t phys_reset;
>
> -       mcpm_set_entry_vector(cpu, cluster, cpu_resume);
> +       mcpm_set_entry_vector(cpu, cluster, cpu_resume_no_hyp);
>         setup_mm_for_reboot();
>
>         __mcpm_cpu_going_down(cpu, cluster);
> diff --git a/arch/arm/include/asm/suspend.h b/arch/arm/include/asm/suspend.h
> index 452bbdcbcc83..506314265c6f 100644
> --- a/arch/arm/include/asm/suspend.h
> +++ b/arch/arm/include/asm/suspend.h
> @@ -10,6 +10,7 @@ struct sleep_save_sp {
>  };
>
>  extern void cpu_resume(void);
> +extern void cpu_resume_no_hyp(void);
>  extern void cpu_resume_arm(void);
>  extern int cpu_suspend(unsigned long, int (*)(unsigned long));
>
> diff --git a/arch/arm/kernel/sleep.S b/arch/arm/kernel/sleep.S
> index a8257fc9cf2a..5dc8b80bb693 100644
> --- a/arch/arm/kernel/sleep.S
> +++ b/arch/arm/kernel/sleep.S
> @@ -120,6 +120,14 @@ ENDPROC(cpu_resume_after_mmu)
>         .text
>         .align
>
> +#ifdef CONFIG_MCPM
> +       .arm
> +THUMB( .thumb                  )
> +ENTRY(cpu_resume_no_hyp)
> +ARM_BE8(setend be)                     @ ensure we are in BE mode
> +       b       no_hyp
> +#endif
> +
>  #ifdef CONFIG_MMU
>         .arm
>  ENTRY(cpu_resume_arm)
> @@ -135,6 +143,7 @@ ARM_BE8(setend be)                  @ ensure we are in BE mode
>         bl      __hyp_stub_install_secondary
>  #endif
>         safe_svcmode_maskall r1
> +no_hyp:
>         mov     r1, #0
>         ALT_SMP(mrc p15, 0, r0, c0, c0, 5)
>         ALT_UP_B(1f)
> @@ -163,6 +172,9 @@ ENDPROC(cpu_resume)
>
>  #ifdef CONFIG_MMU
>  ENDPROC(cpu_resume_arm)
> +#endif
> +#ifdef CONFIG_MCPM
> +ENDPROC(cpu_resume_no_hyp)
>  #endif
>
>         .align 2
> --
> 2.17.1
>

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
