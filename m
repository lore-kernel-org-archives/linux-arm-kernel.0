Return-Path: <SRS0=AWyS=OJ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33A2CC04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 18:26:35 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 06B0D20673
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 18:26:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="eOkJzBpI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 06B0D20673
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=gGwvl6mPQPZLr1pqh9+NsxTqM+c+1oPHIT39mm1Xk08=; b=eOkJzBpIUaumqQ
	7ladErAkrlF31TpDF+Xm5dBCibh6XSPkmSBAWBpNjQ+PI4uzx9xkt+pMPveuDEuEQyLfxtqoaihB1
	rB9MdaXwFCEExy86GmIUo+Xtiq5MnCLubbSzWPVxKX+/DjCqXwzMiSpt36QGnE3mBxlpv+Ydr8J/h
	h9/hR2zbuoLDc4PPPbqHrIew+lMXyU/c2DFxIanS4SEH9Ic882PG0Jrn7IqSI402rfkJH6jQYc8EX
	0H+wHAOYmj3qAZHdO03obrdq8YGQr4Ku/8mTgdhiuWJLPCa6W1+kRJCwh+7omzqA3dmDru/s0v2Ws
	WkPAaGBOophyArxVlrDQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gSnUh-0001SS-7Q; Fri, 30 Nov 2018 18:26:27 +0000
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]
 helo=foss.arm.com)
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gSnUd-0001RU-QS
 for linux-arm-kernel@lists.infradead.org; Fri, 30 Nov 2018 18:26:25 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 129F9165C;
 Fri, 30 Nov 2018 10:26:11 -0800 (PST)
Received: from edgewater-inn.cambridge.arm.com
 (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id D5DA83F575;
 Fri, 30 Nov 2018 10:26:10 -0800 (PST)
Received: by edgewater-inn.cambridge.arm.com (Postfix, from userid 1000)
 id B8FAC1AE0FA2; Fri, 30 Nov 2018 18:26:29 +0000 (GMT)
Date: Fri, 30 Nov 2018 18:26:29 +0000
From: Will Deacon <will.deacon@arm.com>
To: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Subject: Re: [PATCH v4 2/2] arm64/bpf: don't allocate BPF JIT programs in
 module memory
Message-ID: <20181130182629.GA16085@arm.com>
References: <20181123221804.440-1-ard.biesheuvel@linaro.org>
 <20181123221804.440-3-ard.biesheuvel@linaro.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20181123221804.440-3-ard.biesheuvel@linaro.org>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181130_102623_875768_4F5F1F1D 
X-CRM114-Status: GOOD (  23.72  )
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
Cc: Mark Rutland <mark.rutland@arm.com>, Daniel Borkmann <daniel@iogearbox.net>,
 Eric Dumazet <eric.dumazet@gmail.com>, Jann Horn <jannh@google.com>,
 Catalin Marinas <catalin.marinas@arm.com>, linux-kernel@vger.kernel.org,
 Alexei Starovoitov <ast@kernel.org>, netdev@vger.kernel.org,
 Arnd Bergmann <arnd@arndb.de>, Jessica Yu <jeyu@kernel.org>,
 Rick Edgecombe <rick.p.edgecombe@intel.com>,
 "David S. Miller" <davem@davemloft.net>, linux-arm-kernel@lists.infradead.org,
 Kees Cook <keescook@chromium.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Fri, Nov 23, 2018 at 11:18:04PM +0100, Ard Biesheuvel wrote:
> The arm64 module region is a 128 MB region that is kept close to
> the core kernel, in order to ensure that relative branches are
> always in range. So using the same region for programs that do
> not have this restriction is wasteful, and preferably avoided.
> 
> Now that the core BPF JIT code permits the alloc/free routines to
> be overridden, implement them by vmalloc()/vfree() calls from a
> dedicated 128 MB region set aside for BPF programs. This ensures
> that BPF programs are still in branching range of each other, which
> is something the JIT currently depends upon (and is not guaranteed
> when using module_alloc() on KASLR kernels like we do currently).
> It also ensures that placement of BPF programs does not correlate
> with the placement of the core kernel or modules, making it less
> likely that leaking the former will reveal the latter.
> 
> This also solves an issue under KASAN, where shadow memory is
> needlessly allocated for all BPF programs (which don't require KASAN
> shadow pages since they are not KASAN instrumented)
> 
> Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> ---
>  arch/arm64/include/asm/memory.h |  5 ++++-
>  arch/arm64/net/bpf_jit_comp.c   | 13 +++++++++++++
>  2 files changed, 17 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/include/asm/memory.h b/arch/arm64/include/asm/memory.h
> index b96442960aea..ee20fc63899c 100644
> --- a/arch/arm64/include/asm/memory.h
> +++ b/arch/arm64/include/asm/memory.h
> @@ -62,8 +62,11 @@
>  #define PAGE_OFFSET		(UL(0xffffffffffffffff) - \
>  	(UL(1) << (VA_BITS - 1)) + 1)
>  #define KIMAGE_VADDR		(MODULES_END)
> +#define BPF_JIT_REGION_START	(VA_START + KASAN_SHADOW_SIZE)
> +#define BPF_JIT_REGION_SIZE	(SZ_128M)
> +#define BPF_JIT_REGION_END	(BPF_JIT_REGION_START + BPF_JIT_REGION_SIZE)
>  #define MODULES_END		(MODULES_VADDR + MODULES_VSIZE)
> -#define MODULES_VADDR		(VA_START + KASAN_SHADOW_SIZE)
> +#define MODULES_VADDR		(BPF_JIT_REGION_END)
>  #define MODULES_VSIZE		(SZ_128M)
>  #define VMEMMAP_START		(PAGE_OFFSET - VMEMMAP_SIZE)
>  #define PCI_IO_END		(VMEMMAP_START - SZ_2M)
> diff --git a/arch/arm64/net/bpf_jit_comp.c b/arch/arm64/net/bpf_jit_comp.c
> index a6fdaea07c63..76c2ab40c02d 100644
> --- a/arch/arm64/net/bpf_jit_comp.c
> +++ b/arch/arm64/net/bpf_jit_comp.c
> @@ -940,3 +940,16 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *prog)
>  					   tmp : orig_prog);
>  	return prog;
>  }
> +
> +void *bpf_jit_alloc_exec(unsigned long size)
> +{
> +	return __vmalloc_node_range(size, PAGE_SIZE, BPF_JIT_REGION_START,
> +				    BPF_JIT_REGION_END, GFP_KERNEL,
> +				    PAGE_KERNEL_EXEC, 0, NUMA_NO_NODE,
> +				    __builtin_return_address(0));

I guess we'll want VM_IMMEDIATE_UNMAP here if Rich gets that merged. In the
meantime, I wonder if it's worth zeroing the region in bpf_jit_free_exec()?
(although we'd need the size information...).

Will

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
