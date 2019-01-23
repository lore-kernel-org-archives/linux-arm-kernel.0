Return-Path: <SRS0=uP4V=P7=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58A88C282C0
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 16:49:14 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F2D6621872
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 16:49:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="pwIsZHhD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F2D6621872
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:To:Subject:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=2ZqFTq4cQrLrh1kX/5tazAvF1eST6248IW1JlJMrHjs=; b=pwIsZHhDNWdyDX
	1UU6+FD2fxK8okUjYH5AbaJKa38SRVDwybYRItSCaQPogh+Eoe3QXwEjV3IwgT6pGpk6pfmLj9QG0
	yBLrLXwVyx2Cy3/KPp57FqBF/oxze8o/gN7uAkfTKJxPJSmKiw8hIbWE7xmX6VS62DAcr/4AWZY2f
	WJbVKp/YxFH3ZRcxFvaEtg6lxMQCusbeKsqXIisvHXRqXqoNMmAHSkLfIfBvbBTGEFUNkbdwgeapq
	Up40YR9JClReM0GThzfxWw5E7s57y7VpfUpPFppedg3Cd73iatxjvL73NW3H4CjrDVntpp8Vv/BEw
	dU1ODEXt8e4HEiL0gdjw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gmLiA-0004um-W9; Wed, 23 Jan 2019 16:49:11 +0000
Received: from foss.arm.com ([217.140.101.70])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gmLi6-0004tC-L0
 for linux-arm-kernel@lists.infradead.org; Wed, 23 Jan 2019 16:49:09 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1BA3AEBD;
 Wed, 23 Jan 2019 08:49:06 -0800 (PST)
Received: from [10.1.197.45] (e112298-lin.cambridge.arm.com [10.1.197.45])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id DBBDD3F237;
 Wed, 23 Jan 2019 08:49:04 -0800 (PST)
Subject: Re: [PATCH] ARM: prevent tracing IPI_CPU_BACKTRACE
To: Chunyan Zhang <zhang.chunyan@linaro.org>,
 Russell King <linux@armlinux.org.uk>, Marc Zyngier <Marc.Zyngier@arm.com>
References: <1538019697-14673-1-git-send-email-chunyan.zhang@unisoc.com>
 <1539851039-15778-1-git-send-email-zhang.chunyan@linaro.org>
From: Julien Thierry <julien.thierry@arm.com>
Message-ID: <b7a99b4e-c269-e2ac-81ab-226b80cdd099@arm.com>
Date: Wed, 23 Jan 2019 16:49:02 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <1539851039-15778-1-git-send-email-zhang.chunyan@linaro.org>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190123_084906_704945_FFB58DE7 
X-CRM114-Status: GOOD (  28.80  )
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
Cc: linux-arm-kernel@lists.infradead.org, Chunyan Zhang <zhang.lyra@gmail.com>,
 linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi,

On 18/10/2018 09:23, Chunyan Zhang wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> When function tracing for IPIs is enabled, we get a warning for an
> overflow of the ipi_types array with the IPI_CPU_BACKTRACE type
> as triggered by raise_nmi():
> 
> arch/arm/kernel/smp.c: In function 'raise_nmi':
> arch/arm/kernel/smp.c:489:2: error: array subscript is above array bounds [-Werror=array-bounds]
> 	trace_ipi_raise(target, ipi_types[ipinr]);
> 
> This is a correct warning as we actually overflow the array here.
> 
> This patch raise_nmi() to call __smp_cross_call() instead of
> smp_cross_call(), to avoid calling into ftrace. For clarification,
> I'm also adding a two new code comments describing how this one
> is special.
> 
> The warning appears to have shown up after patch e7273ff49acf
> ("ARM: 8488/1: Make IPI_CPU_BACKTRACE a "non-secure" SGI"), which
> changed the number assignment from '15' to '8', but as far as I can
> tell has existed since the IPI tracepoints were first introduced.
> If we decide to backport this patch to stable kernels, we probably
> need to backport e7273ff49acf as well.
> 
> Resubmitting this patch is because that I found coverity is complaining
> the issue this patch fixed, and also I got the traces like below:
> "ipi_raise: target_mask=00000001 (machine_suspend)" which actually was
> the TPS of suspend_resume[1] rather that ipi_raise.
> 

What's the status on this patch? it does not seem to be in v5.0-rc3 nor
linux-next and looks like an actual issue.

Also, I'm assuming the patch is avoiding the tracing of
IPI_CPU_BACKTRACE because the tracing is not NMI safe. It would be good
to have a comment about that either near NR_IPI or ipi_types stating why
this IPI is excluded.

Thanks,

> [1]
> https://elixir.bootlin.com/linux/latest/source/kernel/power/suspend.c#L80
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> Fixes: e7273ff49acf ("ARM: 8488/1: Make IPI_CPU_BACKTRACE a "non-secure" SGI")
> Fixes: 365ec7b17327 ("ARM: add IPI tracepoints") # v3.17
> Signed-off-by: Chunyan Zhang <zhang.chunyan@linaro.org>
> ---
>  arch/arm/include/asm/hardirq.h | 1 +
>  arch/arm/kernel/smp.c          | 6 +++++-
>  2 files changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm/include/asm/hardirq.h b/arch/arm/include/asm/hardirq.h
> index cba23ea..7a88f16 100644
> --- a/arch/arm/include/asm/hardirq.h
> +++ b/arch/arm/include/asm/hardirq.h
> @@ -6,6 +6,7 @@
>  #include <linux/threads.h>
>  #include <asm/irq.h>
>  
> +/* number of IPIS _not_ including IPI_CPU_BACKTRACE */
>  #define NR_IPI	7
>  
>  typedef struct {
> diff --git a/arch/arm/kernel/smp.c b/arch/arm/kernel/smp.c
> index 0978282..ddd48e2 100644
> --- a/arch/arm/kernel/smp.c
> +++ b/arch/arm/kernel/smp.c
> @@ -75,6 +75,10 @@ enum ipi_msg_type {
>  	IPI_CPU_STOP,
>  	IPI_IRQ_WORK,
>  	IPI_COMPLETION,
> +	/*
> +	 * CPU_BACKTRACE is special and not included in NR_IPI
> +	 * or tracable with trace_ipi_*
> +	 */
>  	IPI_CPU_BACKTRACE,
>  	/*
>  	 * SGI8-15 can be reserved by secure firmware, and thus may
> @@ -755,7 +759,7 @@ core_initcall(register_cpufreq_notifier);
>  
>  static void raise_nmi(cpumask_t *mask)
>  {
> -	smp_cross_call(mask, IPI_CPU_BACKTRACE);
> +	__smp_cross_call(mask, IPI_CPU_BACKTRACE);
>  }
>  
>  void arch_trigger_cpumask_backtrace(const cpumask_t *mask, bool exclude_self)
> 

-- 
Julien Thierry

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
