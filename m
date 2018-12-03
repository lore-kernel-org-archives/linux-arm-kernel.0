Return-Path: <SRS0=0OAT=OM=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C8C6C04EBF
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 12:49:38 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F2DF220850
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 12:49:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="bjG0ICw/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F2DF220850
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=t6/QnInrwCGSsSbUb3mtK19kVvfTtZFye5iDI6Ty3Ic=; b=bjG0ICw/sk9gc+
	olJQ8PGS2SzGvM51gN3qPKeIAIMl1/g8xabpl180LyCj9IR26hk29uXHEqKFVWuzC/dA7VccK1Zur
	D9VznTPH7qkHwzLgmRbR0ezRjI2346CU29ndx7hrhuOH3HAwqkG/ho6dQ++4LSWWCGHh2TRlYDRUw
	pjVpqapPi/fSMPMvVys3gZhqIb5pYZiAgx1Hbk7mFghEBgIy7ccynojpwycGNF8QHV8dR0D4HrX9S
	6ccDzjRGk+0PrB0ncYo2bFkqYNmCJLs6aoMpOT98CUxnrL6oPOvNf0jBNWtNrQGnpWWv/qT+qLM1g
	WMRgzVQtOZsPxrp7haUQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gTnfJ-0004nr-Sw; Mon, 03 Dec 2018 12:49:33 +0000
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]
 helo=foss.arm.com)
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gTnfA-0004SU-8z
 for linux-arm-kernel@lists.infradead.org; Mon, 03 Dec 2018 12:49:28 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E0CDE1688;
 Mon,  3 Dec 2018 04:49:10 -0800 (PST)
Received: from edgewater-inn.cambridge.arm.com
 (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id AF9A53F614;
 Mon,  3 Dec 2018 04:49:10 -0800 (PST)
Received: by edgewater-inn.cambridge.arm.com (Postfix, from userid 1000)
 id A0DA11AE1062; Mon,  3 Dec 2018 12:49:30 +0000 (GMT)
Date: Mon, 3 Dec 2018 12:49:30 +0000
From: Will Deacon <will.deacon@arm.com>
To: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Subject: Re: [PATCH v4 2/2] arm64/bpf: don't allocate BPF JIT programs in
 module memory
Message-ID: <20181203124930.GB25097@arm.com>
References: <20181123221804.440-1-ard.biesheuvel@linaro.org>
 <20181123221804.440-3-ard.biesheuvel@linaro.org>
 <20181130182629.GA16085@arm.com>
 <CAKv+Gu9QVHLWu5H3Ok1Kbm=vtzd1KaHUn2VEij6oToW5aPR9uA@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAKv+Gu9QVHLWu5H3Ok1Kbm=vtzd1KaHUn2VEij6oToW5aPR9uA@mail.gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181203_044924_752095_433988C8 
X-CRM114-Status: GOOD (  30.05  )
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
 Catalin Marinas <catalin.marinas@arm.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Alexei Starovoitov <ast@kernel.org>,
 "<netdev@vger.kernel.org>" <netdev@vger.kernel.org>,
 Arnd Bergmann <arnd@arndb.de>, Jessica Yu <jeyu@kernel.org>,
 Rick Edgecombe <rick.p.edgecombe@intel.com>,
 "David S. Miller" <davem@davemloft.net>,
 linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
 Kees Cook <keescook@chromium.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Fri, Nov 30, 2018 at 08:20:06PM +0100, Ard Biesheuvel wrote:
> On Fri, 30 Nov 2018 at 19:26, Will Deacon <will.deacon@arm.com> wrote:
> >
> > On Fri, Nov 23, 2018 at 11:18:04PM +0100, Ard Biesheuvel wrote:
> > > The arm64 module region is a 128 MB region that is kept close to
> > > the core kernel, in order to ensure that relative branches are
> > > always in range. So using the same region for programs that do
> > > not have this restriction is wasteful, and preferably avoided.
> > >
> > > Now that the core BPF JIT code permits the alloc/free routines to
> > > be overridden, implement them by vmalloc()/vfree() calls from a
> > > dedicated 128 MB region set aside for BPF programs. This ensures
> > > that BPF programs are still in branching range of each other, which
> > > is something the JIT currently depends upon (and is not guaranteed
> > > when using module_alloc() on KASLR kernels like we do currently).
> > > It also ensures that placement of BPF programs does not correlate
> > > with the placement of the core kernel or modules, making it less
> > > likely that leaking the former will reveal the latter.
> > >
> > > This also solves an issue under KASAN, where shadow memory is
> > > needlessly allocated for all BPF programs (which don't require KASAN
> > > shadow pages since they are not KASAN instrumented)
> > >
> > > Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> > > ---
> > >  arch/arm64/include/asm/memory.h |  5 ++++-
> > >  arch/arm64/net/bpf_jit_comp.c   | 13 +++++++++++++
> > >  2 files changed, 17 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/arch/arm64/include/asm/memory.h b/arch/arm64/include/asm/memory.h
> > > index b96442960aea..ee20fc63899c 100644
> > > --- a/arch/arm64/include/asm/memory.h
> > > +++ b/arch/arm64/include/asm/memory.h
> > > @@ -62,8 +62,11 @@
> > >  #define PAGE_OFFSET          (UL(0xffffffffffffffff) - \
> > >       (UL(1) << (VA_BITS - 1)) + 1)
> > >  #define KIMAGE_VADDR         (MODULES_END)
> > > +#define BPF_JIT_REGION_START (VA_START + KASAN_SHADOW_SIZE)
> > > +#define BPF_JIT_REGION_SIZE  (SZ_128M)
> > > +#define BPF_JIT_REGION_END   (BPF_JIT_REGION_START + BPF_JIT_REGION_SIZE)
> > >  #define MODULES_END          (MODULES_VADDR + MODULES_VSIZE)
> > > -#define MODULES_VADDR                (VA_START + KASAN_SHADOW_SIZE)
> > > +#define MODULES_VADDR                (BPF_JIT_REGION_END)
> > >  #define MODULES_VSIZE                (SZ_128M)
> > >  #define VMEMMAP_START                (PAGE_OFFSET - VMEMMAP_SIZE)
> > >  #define PCI_IO_END           (VMEMMAP_START - SZ_2M)
> > > diff --git a/arch/arm64/net/bpf_jit_comp.c b/arch/arm64/net/bpf_jit_comp.c
> > > index a6fdaea07c63..76c2ab40c02d 100644
> > > --- a/arch/arm64/net/bpf_jit_comp.c
> > > +++ b/arch/arm64/net/bpf_jit_comp.c
> > > @@ -940,3 +940,16 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *prog)
> > >                                          tmp : orig_prog);
> > >       return prog;
> > >  }
> > > +
> > > +void *bpf_jit_alloc_exec(unsigned long size)
> > > +{
> > > +     return __vmalloc_node_range(size, PAGE_SIZE, BPF_JIT_REGION_START,
> > > +                                 BPF_JIT_REGION_END, GFP_KERNEL,
> > > +                                 PAGE_KERNEL_EXEC, 0, NUMA_NO_NODE,
> > > +                                 __builtin_return_address(0));
> >
> > I guess we'll want VM_IMMEDIATE_UNMAP here if Rich gets that merged.
> 
> I think akpm already queued up that patch.
> 
> > In the
> > meantime, I wonder if it's worth zeroing the region in bpf_jit_free_exec()?
> > (although we'd need the size information...).
> >
> 
> Not sure. What exactly would that achieve?

I think the zero encoding is guaranteed to be undefined, so it would limit
the usefulness of any stale, executable TLB entries. However, we'd also need
cache maintenance to make that stuff visible to the I side, so it's probably
not worth it, especially if akpm has queued the stuff from Rich.

Maybe just add an:

/* FIXME: Remove this when VM_IMMEDIATE_UNMAP is supported */
#ifndef VM_IMMEDIATE_UNMAP
#define VM_IMMEDIATE_UNMAP	0
#endif

so we remember to come back and sort this out? Up to you.

Will

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
