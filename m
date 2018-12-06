Return-Path: <SRS0=DN+v=OP=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 517E3C04EB9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 09:33:18 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 13DA220672
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 09:33:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="bH/cNWJB";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="rYGOyoon"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 13DA220672
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:References:In-Reply-To:MIME-Version:
	Date:Message-ID:From:To:Subject:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Hgd7HkAetPDyUttAyyQ7to5PGxvitDZOL1OYo/11mGg=; b=bH/cNWJBiOWi6r
	V1/HXCJRI+Gl2h0mLjajA7EyJtn48FpMJGo3pwBc7S0ThYoPs2pcQidU8m4BmJtftODNP/hJvMK3Q
	PU4aT6VOxUo0QF2nCfkHtN4IcpMRuC8YcCdDG0TnWFN+iPYFAUSIFXNNRtWTMVnxkCR/OhLVdY0wN
	V0ri0Z57MyL07X8dhPAYY9WPX/HNBSaLKAWPFx04CeszfeYIorNjQzSvCvEUK1yW++1RMaK8BVkbg
	/5Trh1gnPJ1n8eDN33nofiJUQmxxf5zqXnoUReKZ0PngvEKy2oajFIFnZnO7Mx2yNxRhtrZFsui82
	ZdmjM8UmaOX/c1BDGPaQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gUq21-0002fh-7u; Thu, 06 Dec 2018 09:33:17 +0000
Received: from mailout1.w1.samsung.com ([210.118.77.11])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gUq1w-0002dY-1k
 for linux-arm-kernel@lists.infradead.org; Thu, 06 Dec 2018 09:33:15 +0000
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
 by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id
 20181206093259euoutp01f55cf8f51e7d85ff42e1e7f45dc7224f~ttJB1EBRh3097330973euoutp01b
 for <linux-arm-kernel@lists.infradead.org>;
 Thu,  6 Dec 2018 09:32:59 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com
 20181206093259euoutp01f55cf8f51e7d85ff42e1e7f45dc7224f~ttJB1EBRh3097330973euoutp01b
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1544088779;
 bh=9Pk6ITTdL8hgo2uoAo0T8k23nKcCw0cEGgNDmRQLhWo=;
 h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
 b=rYGOyoonZACoeqFI4n/8EJ/XsM9ZoJeVcvMZ9gdhjOXZngtrbLzyKiVucjAaVHZfE
 fF2sQLGEunC6FUf9yUpycDJvw0ZPmw7ythIx2mveAS4egvybvoO9Th5qQpVVuitfRt
 EH/7aELTxOvMia5z0z9hFunfFhnA9Aojw4f3Xikc=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
 eucas1p2.samsung.com (KnoxPortal) with ESMTP id
 20181206093258eucas1p22c10688b9271a9345024655fc1ff0426~ttJBCRm0O1302413024eucas1p2v;
 Thu,  6 Dec 2018 09:32:58 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
 eusmges1new.samsung.com (EUCPMTA) with SMTP id 0D.C9.04441.ACCE80C5; Thu,  6
 Dec 2018 09:32:58 +0000 (GMT)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
 eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
 20181206093257eucas1p18572e87ee55c12a2b42dfb945e5f1077~ttJABYNUL3174031740eucas1p1W;
 Thu,  6 Dec 2018 09:32:57 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
 eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
 20181206093257eusmtrp1f94fd71aafee6085a697e739da6544be~ttI-y0oYz1406614066eusmtrp1k;
 Thu,  6 Dec 2018 09:32:57 +0000 (GMT)
X-AuditID: cbfec7f2-5c9ff70000001159-2d-5c08ecca134f
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
 eusmgms1.samsung.com (EUCPMTA) with SMTP id 28.CD.04284.9CCE80C5; Thu,  6
 Dec 2018 09:32:57 +0000 (GMT)
Received: from [106.116.147.30] (unknown [106.116.147.30]) by
 eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
 20181206093256eusmtip201120f9d7097fda94febcbec44e8f8c4~ttI-KPnB_3158631586eusmtip2o;
 Thu,  6 Dec 2018 09:32:56 +0000 (GMT)
Subject: Re: [PATCH v2 5/5] ARM: spectre-v2: per-CPU vtables to work around
 big.Little systems
To: Russell King <rmk+kernel@armlinux.org.uk>,
 linux-arm-kernel@lists.infradead.org
From: Marek Szyprowski <m.szyprowski@samsung.com>
Message-ID: <dda0be26-5ac8-a158-3210-4bc6861bede2@samsung.com>
Date: Thu, 6 Dec 2018 10:32:56 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.2
MIME-Version: 1.0
In-Reply-To: <E1gK0dU-0007Mp-4h@rmk-PC.armlinux.org.uk>
Content-Language: en-US
X-Brightmail-Tracker: H4sIAAAAAAAAA02Sa0hTYRjHfXfOdo6jyeu0fLREGFEU5AWFDhbSDZz1IfvQl1zk0sO03JTN
 S2qRKGmKmrPItbyBiSmi5T1BySVta3gvDa2mZGnaEkstySTnmeW333P//19emhA3873oWFUi
 q1bJ4yQCIdn2crX/0KuvtMy/r3s/86molWAy35xlBgaeUEzTx1E+8+fduoCpHhviMQvffguY
 rro1ATN8R8tjviyayGNCaX15PZKOjA4R0qa6XIG0+dHNcPKC8Gg0GxebzKr9QiKFMb0rJiLh
 WfC1qZo2KgM1+uUhZxpwEOS/X+PnISEtxo8RzKxUCLhgCUF7j5bigh8ItL2tgq2RsqefN1mM
 axCsWr25pgUEtuIqvr3ghiNhalLLs7M7Pg+msvHNtQTu5YHOVrPZJMABkGfL29wkwiGQu1hJ
 2JnEe6HKcm9jmKZ3Yhl0zlznWlzB/GCatLMzPgwlc68pOxPYB9ptpQTHHjA+XcHjhBoo+DXh
 xfEpWFrPduTdYM7YQnG8Byx380m7NsBZCHJ0eooL8hG0lnY4LB+BF8Yhvl0QgQ9AY6fj8Y5D
 38MVwp4G7AJvba6cBhcobitxpEVwO1vMde8DvbHh39mewWGiCEn025zpt7nRb3Oj/3+3EpF1
 yINN0igVrCZAxab4auRKTZJK4RsVr2xCG1/Jsm783oGWhy8bEKaRZIdodpKSifnyZE2q0oCA
 JiTuIidfWiYWRctT01h1/CV1UhyrMaDdNCnxEKU7TUaIsUKeyF5l2QRWvVXl0c5eGeiitnqw
 OqXcNDBaGNZJzHbYrLG4ZyLIx+Ldv5aemSIJ7y67FXbD86e/7sPs6QhzdHm+2R+NLYf2R80+
 J+tzwqzn5uXVweby0LX7jSFXWryzUO2gyUIbFVXF/TitIVBmxgUnnHLma60NI4W7ilzOnAzM
 oDxtTuKyronmgjSdhNTEyAMOEmqN/C9Z7vo+RgMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrBIsWRmVeSWpSXmKPExsVy+t/xe7on33DEGLxeI2fxdMJWZoumq/4W
 589vYLfY9Pgaq8XfO//YLJZev8hk8f7dbzaLvav+sFlc6p/IZPHy4wkWBy6PNfPWMHpcvnaR
 2WPTqk42j81L6gNYovRsivJLS1IVMvKLS2yVog0tjPQMLS30jEws9QyNzWOtjEyV9O1sUlJz
 MstSi/TtEvQyjnw7wVyw06ri4fJt7A2M6/W7GDk5JARMJOZufMbWxcjFISSwlFFiYWMjK0RC
 RuLktAYoW1jiz7UuqKK3jBKrl9xkBkkICyRIPHwwkQnEFhEIlZjX+o8VpIhZ4ASTxL//sxkh
 OnYzStzcvw6sik3AUKLrLcgoTg5eATuJzo8LwCaxCKhILD49BaxGVCBGYsrl16wQNYISJ2c+
 YQGxOQXMJaa/usIOYjMLqEv8mXeJGcKWl9j+dg6ULS5x68l8pgmMQrOQtM9C0jILScssJC0L
 GFlWMYqklhbnpucWG+oVJ+YWl+al6yXn525iBMbitmM/N+9gvLQx+BCjAAejEg/viwfsMUKs
 iWXFlbmHGCU4mJVEeBn0OGKEeFMSK6tSi/Lji0pzUosPMZoCPTeRWUo0OR+YJvJK4g1NDc0t
 LA3Njc2NzSyUxHnPG1RGCQmkJ5akZqemFqQWwfQxcXBKNTDGvUvbyML5O4mVU0b3x99X+S63
 mu/bqb5k1j9tYiLtvVDubfiOw4qb63OXMH4vWX3goHTNtZXBSYziLaeDriXqG3q5m0TnrvQr
 FL+hmu96ZRG7vqGCn+PfzxM/7Z6vWOc1XWx9zFFncYadc+9dl98xdX/Icu4LhzZ9miKb1Tsr
 yXGtCWf43ltKLMUZiYZazEXFiQAoZ4Vg2wIAAA==
X-CMS-MailID: 20181206093257eucas1p18572e87ee55c12a2b42dfb945e5f1077
X-Msg-Generator: CA
X-RootMTR: 20181106124037epcas4p35f0ed44d430e44310e764190f15c2883
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20181106124037epcas4p35f0ed44d430e44310e764190f15c2883
References: <20181106123700.GA30658@n2100.armlinux.org.uk>
 <CGME20181106124037epcas4p35f0ed44d430e44310e764190f15c2883@epcas4p3.samsung.com>
 <E1gK0dU-0007Mp-4h@rmk-PC.armlinux.org.uk>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181206_013312_395628_D109CA4C 
X-CRM114-Status: GOOD (  25.33  )
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
Cc: Mark Rutland <mark.rutland@arm.com>,
 Julien Thierry <julien.thierry@arm.com>, Marc Zyngier <marc.zyngier@arm.com>,
 Will Deacon <will.deacon@arm.com>, Krzysztof Kozlowski <krzk@kernel.org>,
 Morten Rasmussen <Morten.Rasmussen@arm.com>,
 Dietmar Eggemann <dietmar.eggemann@arm.com>, Qais Yousef <Qais.Yousef@arm.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi All,

On 2018-11-06 13:39, Russell King wrote:
> In big.Little systems, some CPUs require the Spectre workarounds in
> paths such as the context switch, but other CPUs do not.  In order
> to handle these differences, we need per-CPU vtables.
>
> We are unable to use the kernel's per-CPU variables to support this
> as per-CPU is not initialised at times when we need access to the
> vtables, so we have to use an array indexed by logical CPU number.
>
> We use an array-of-pointers to avoid having function pointers in
> the kernel's read/write .data section.
>
> Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>

Today I've noticed that this patch (which has landed in v4.20-rc3 as
commit 383fb3ee8024) causes regression in CPU hotplug and suspend/resume
handling on Samsung Exynos4412 SoC (4*CortexA9 SMP). After putting any
non-zero CPU offline, it is no longer possible to get it online again.
Same in system suspend/resume - after s2r cycle, only CPU0 is online.
The regression can be observed on Hardkernel's Odroid U3 and Samsung
Trats2 boards.

Any idea how to fix this issue?

> ---
>  arch/arm/include/asm/proc-fns.h | 20 ++++++++++++++++++++
>  arch/arm/kernel/setup.c         |  5 +++++
>  arch/arm/kernel/smp.c           | 31 +++++++++++++++++++++++++++++++
>  arch/arm/mm/proc-v7-bugs.c      | 17 ++---------------
>  4 files changed, 58 insertions(+), 15 deletions(-)
>
> diff --git a/arch/arm/include/asm/proc-fns.h b/arch/arm/include/asm/proc-fns.h
> index c259cc49c641..fe58fb3c4b4e 100644
> --- a/arch/arm/include/asm/proc-fns.h
> +++ b/arch/arm/include/asm/proc-fns.h
> @@ -104,12 +104,32 @@ extern void cpu_do_resume(void *);
>  #else
>  
>  extern struct processor processor;
> +#if defined(CONFIG_BIG_LITTLE) && defined(CONFIG_HARDEN_BRANCH_PREDICTOR)
> +#include <linux/smp.h>
> +/*
> + * This can't be a per-cpu variable because we need to access it before
> + * per-cpu has been initialised.
> + */
> +extern struct processor *cpu_vtable[];
> +#define PROC_VTABLE(f)			cpu_vtable[smp_processor_id()]->f
> +#define PROC_TABLE(f)			cpu_vtable[0]->f
> +static inline void init_proc_vtable(const struct processor *p)
> +{
> +	unsigned int cpu = smp_processor_id();
> +	*cpu_vtable[cpu] = *p;
> +	WARN_ON_ONCE(cpu_vtable[cpu]->dcache_clean_area !=
> +		     cpu_vtable[0]->dcache_clean_area);
> +	WARN_ON_ONCE(cpu_vtable[cpu]->set_pte_ext !=
> +		     cpu_vtable[0]->set_pte_ext);
> +}
> +#else
>  #define PROC_VTABLE(f)			processor.f
>  #define PROC_TABLE(f)			processor.f
>  static inline void init_proc_vtable(const struct processor *p)
>  {
>  	processor = *p;
>  }
> +#endif
>  
>  #define cpu_proc_init			PROC_VTABLE(_proc_init)
>  #define cpu_check_bugs			PROC_VTABLE(check_bugs)
> diff --git a/arch/arm/kernel/setup.c b/arch/arm/kernel/setup.c
> index c214bd14a1fe..cd46a595422c 100644
> --- a/arch/arm/kernel/setup.c
> +++ b/arch/arm/kernel/setup.c
> @@ -115,6 +115,11 @@ EXPORT_SYMBOL(elf_hwcap2);
>  
>  #ifdef MULTI_CPU
>  struct processor processor __ro_after_init;
> +#if defined(CONFIG_BIG_LITTLE) && defined(CONFIG_HARDEN_BRANCH_PREDICTOR)
> +struct processor *cpu_vtable[NR_CPUS] = {
> +	[0] = &processor,
> +};
> +#endif
>  #endif
>  #ifdef MULTI_TLB
>  struct cpu_tlb_fns cpu_tlb __ro_after_init;
> diff --git a/arch/arm/kernel/smp.c b/arch/arm/kernel/smp.c
> index 5ad0b67b9e33..82b879db32ee 100644
> --- a/arch/arm/kernel/smp.c
> +++ b/arch/arm/kernel/smp.c
> @@ -42,6 +42,7 @@
>  #include <asm/mmu_context.h>
>  #include <asm/pgtable.h>
>  #include <asm/pgalloc.h>
> +#include <asm/procinfo.h>
>  #include <asm/processor.h>
>  #include <asm/sections.h>
>  #include <asm/tlbflush.h>
> @@ -102,6 +103,30 @@ static unsigned long get_arch_pgd(pgd_t *pgd)
>  #endif
>  }
>  
> +#if defined(CONFIG_BIG_LITTLE) && defined(CONFIG_HARDEN_BRANCH_PREDICTOR)
> +static int secondary_biglittle_prepare(unsigned int cpu)
> +{
> +	if (!cpu_vtable[cpu])
> +		cpu_vtable[cpu] = kzalloc(sizeof(*cpu_vtable[cpu]), GFP_KERNEL);
> +
> +	return cpu_vtable[cpu] ? 0 : -ENOMEM;
> +}
> +
> +static void secondary_biglittle_init(void)
> +{
> +	init_proc_vtable(lookup_processor(read_cpuid_id())->proc);
> +}
> +#else
> +static int secondary_biglittle_prepare(unsigned int cpu)
> +{
> +	return 0;
> +}
> +
> +static void secondary_biglittle_init(void)
> +{
> +}
> +#endif
> +
>  int __cpu_up(unsigned int cpu, struct task_struct *idle)
>  {
>  	int ret;
> @@ -109,6 +134,10 @@ int __cpu_up(unsigned int cpu, struct task_struct *idle)
>  	if (!smp_ops.smp_boot_secondary)
>  		return -ENOSYS;
>  
> +	ret = secondary_biglittle_prepare(cpu);
> +	if (ret)
> +		return ret;
> +
>  	/*
>  	 * We need to tell the secondary core where to find
>  	 * its stack and the page tables.
> @@ -360,6 +389,8 @@ asmlinkage void secondary_start_kernel(void)
>  	struct mm_struct *mm = &init_mm;
>  	unsigned int cpu;
>  
> +	secondary_biglittle_init();
> +
>  	/*
>  	 * The identity mapping is uncached (strongly ordered), so
>  	 * switch away from it before attempting any exclusive accesses.
> diff --git a/arch/arm/mm/proc-v7-bugs.c b/arch/arm/mm/proc-v7-bugs.c
> index 5544b82a2e7a..9a07916af8dd 100644
> --- a/arch/arm/mm/proc-v7-bugs.c
> +++ b/arch/arm/mm/proc-v7-bugs.c
> @@ -52,8 +52,6 @@ static void cpu_v7_spectre_init(void)
>  	case ARM_CPU_PART_CORTEX_A17:
>  	case ARM_CPU_PART_CORTEX_A73:
>  	case ARM_CPU_PART_CORTEX_A75:
> -		if (processor.switch_mm != cpu_v7_bpiall_switch_mm)
> -			goto bl_error;
>  		per_cpu(harden_branch_predictor_fn, cpu) =
>  			harden_branch_predictor_bpiall;
>  		spectre_v2_method = "BPIALL";
> @@ -61,8 +59,6 @@ static void cpu_v7_spectre_init(void)
>  
>  	case ARM_CPU_PART_CORTEX_A15:
>  	case ARM_CPU_PART_BRAHMA_B15:
> -		if (processor.switch_mm != cpu_v7_iciallu_switch_mm)
> -			goto bl_error;
>  		per_cpu(harden_branch_predictor_fn, cpu) =
>  			harden_branch_predictor_iciallu;
>  		spectre_v2_method = "ICIALLU";
> @@ -88,11 +84,9 @@ static void cpu_v7_spectre_init(void)
>  					  ARM_SMCCC_ARCH_WORKAROUND_1, &res);
>  			if ((int)res.a0 != 0)
>  				break;
> -			if (processor.switch_mm != cpu_v7_hvc_switch_mm && cpu)
> -				goto bl_error;
>  			per_cpu(harden_branch_predictor_fn, cpu) =
>  				call_hvc_arch_workaround_1;
> -			processor.switch_mm = cpu_v7_hvc_switch_mm;
> +			cpu_do_switch_mm = cpu_v7_hvc_switch_mm;
>  			spectre_v2_method = "hypervisor";
>  			break;
>  
> @@ -101,11 +95,9 @@ static void cpu_v7_spectre_init(void)
>  					  ARM_SMCCC_ARCH_WORKAROUND_1, &res);
>  			if ((int)res.a0 != 0)
>  				break;
> -			if (processor.switch_mm != cpu_v7_smc_switch_mm && cpu)
> -				goto bl_error;
>  			per_cpu(harden_branch_predictor_fn, cpu) =
>  				call_smc_arch_workaround_1;
> -			processor.switch_mm = cpu_v7_smc_switch_mm;
> +			cpu_do_switch_mm = cpu_v7_smc_switch_mm;
>  			spectre_v2_method = "firmware";
>  			break;
>  
> @@ -119,11 +111,6 @@ static void cpu_v7_spectre_init(void)
>  	if (spectre_v2_method)
>  		pr_info("CPU%u: Spectre v2: using %s workaround\n",
>  			smp_processor_id(), spectre_v2_method);
> -	return;
> -
> -bl_error:
> -	pr_err("CPU%u: Spectre v2: incorrect context switching function, system vulnerable\n",
> -		cpu);
>  }
>  #else
>  static void cpu_v7_spectre_init(void)

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
