Return-Path: <SRS0=AWyS=OJ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72DADC04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 19:20:48 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 46AFF20868
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 19:20:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="SG4YgMgP";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="hHS8LBd2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 46AFF20868
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=ao5n7rZhMeBFbX/KK9a/0CjwP2YEWOi/1Iobazp9Q7g=; b=SG4YgMgPdONr6m
	BHq0h6I/SzeDIz2b3gLvBLR3Kzyp/mg99EbDoUAVhRDuF0Y7M7C0FN34gwfP6nBtX96GywqT71jZJ
	psSAxq5z763skVuizxvsBbDYVl0VqVGSKVRR0YVm0QpC/GTT9pJ14n5aXbHObWgXDKmO5AFLVm9H6
	bzG68k1mExnkajo096Vl7pUa8b6E8GfnvvtauFIPnmpB7HeI2liBijTU8+aRKJDZ466sUSAgpMrqa
	oUezBk8+nTKVdEFxOKkEeZKWb0RAMQD3qgASbKQ3RPXTNxZnn7bIUvn8uULr0IM7WsmrjORYo2WHa
	Tw+Z91izaohsJEiUqmMQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gSoL6-0000vw-54; Fri, 30 Nov 2018 19:20:36 +0000
Received: from mail-io1-xd42.google.com ([2607:f8b0:4864:20::d42])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gSoL2-0000uZ-F3
 for linux-arm-kernel@lists.infradead.org; Fri, 30 Nov 2018 19:20:34 +0000
Received: by mail-io1-xd42.google.com with SMTP id w7so5406887iom.12
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 30 Nov 2018 11:20:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=8oyLivuR6iu3HBUduImb583ldtAsf/AHlenv6DXRn7I=;
 b=hHS8LBd2YHsWqDkPHzu+JfBTi4G6Rb0rtS5CdBZeGFmxdcDqzUianqzCpVdRfk+R0V
 ffGKyShmJWinTSqvOT79TUqn3R3ndPV0wbcw9nk8CDb+0PlD8Sv11XxEKJ3+y/OTkxVw
 6foQDWk1Jk2WJAdJw7Clwgur97sGZv5WUdbXk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=8oyLivuR6iu3HBUduImb583ldtAsf/AHlenv6DXRn7I=;
 b=HMgY9NS5Vd2MwXgC+Q9mBlxR1qPK0PMxDEFe0RwfUdGMohJ57rtiLlNTs+QPvyEB3w
 /Mxf8kFLY8r0Pw8f8u/MBLWErazsIFSRg087/gsmjt8aGjMmW2i6KX+Jsdj76rJl/nkD
 SH3/andC/fEJpwCqxZB7wWZHx+rwCvxU65A8UO4P+h56fFgLI4RKwt068DQpEbTs++rf
 kwVwbafqPPsOqO27THyu1tzwruFp/HIZNDRYQt/1+Sbs8rmJTxvCj6Lpt4SNwHfIlrGW
 KUNY7HjrR9MTSkx0jXGOAPX6cCB6BbwM3TPp3Si+lqfVEctuAXdZVEOBfzzWU1bf+G9P
 Pdyw==
X-Gm-Message-State: AA+aEWbEeRguFNbmwd9UDPhwkJ8XFYCRTQ+p2cFtqTCzIwL6OqYBYS3F
 nYdnTNb/TmY/IqLjXYv0/sD2UXZ4DtYkQDhKnKpb2Q==
X-Google-Smtp-Source: AFSGD/VhXBciaLlTOF6kvbc1O2gs0a4+AjyfEH4L6uD4+ox5SdkbFDXw/HS5RJAr4ZvDqaVsVy4+/j2Pm1+JX8ejzo8=
X-Received: by 2002:a5d:8402:: with SMTP id i2mr5799226ion.173.1543605620911; 
 Fri, 30 Nov 2018 11:20:20 -0800 (PST)
MIME-Version: 1.0
References: <20181123221804.440-1-ard.biesheuvel@linaro.org>
 <20181123221804.440-3-ard.biesheuvel@linaro.org>
 <20181130182629.GA16085@arm.com>
In-Reply-To: <20181130182629.GA16085@arm.com>
From: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date: Fri, 30 Nov 2018 20:20:06 +0100
Message-ID: <CAKv+Gu9QVHLWu5H3Ok1Kbm=vtzd1KaHUn2VEij6oToW5aPR9uA@mail.gmail.com>
Subject: Re: [PATCH v4 2/2] arm64/bpf: don't allocate BPF JIT programs in
 module memory
To: Will Deacon <will.deacon@arm.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181130_112032_507193_38CC6411 
X-CRM114-Status: GOOD (  22.98  )
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

On Fri, 30 Nov 2018 at 19:26, Will Deacon <will.deacon@arm.com> wrote:
>
> On Fri, Nov 23, 2018 at 11:18:04PM +0100, Ard Biesheuvel wrote:
> > The arm64 module region is a 128 MB region that is kept close to
> > the core kernel, in order to ensure that relative branches are
> > always in range. So using the same region for programs that do
> > not have this restriction is wasteful, and preferably avoided.
> >
> > Now that the core BPF JIT code permits the alloc/free routines to
> > be overridden, implement them by vmalloc()/vfree() calls from a
> > dedicated 128 MB region set aside for BPF programs. This ensures
> > that BPF programs are still in branching range of each other, which
> > is something the JIT currently depends upon (and is not guaranteed
> > when using module_alloc() on KASLR kernels like we do currently).
> > It also ensures that placement of BPF programs does not correlate
> > with the placement of the core kernel or modules, making it less
> > likely that leaking the former will reveal the latter.
> >
> > This also solves an issue under KASAN, where shadow memory is
> > needlessly allocated for all BPF programs (which don't require KASAN
> > shadow pages since they are not KASAN instrumented)
> >
> > Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> > ---
> >  arch/arm64/include/asm/memory.h |  5 ++++-
> >  arch/arm64/net/bpf_jit_comp.c   | 13 +++++++++++++
> >  2 files changed, 17 insertions(+), 1 deletion(-)
> >
> > diff --git a/arch/arm64/include/asm/memory.h b/arch/arm64/include/asm/memory.h
> > index b96442960aea..ee20fc63899c 100644
> > --- a/arch/arm64/include/asm/memory.h
> > +++ b/arch/arm64/include/asm/memory.h
> > @@ -62,8 +62,11 @@
> >  #define PAGE_OFFSET          (UL(0xffffffffffffffff) - \
> >       (UL(1) << (VA_BITS - 1)) + 1)
> >  #define KIMAGE_VADDR         (MODULES_END)
> > +#define BPF_JIT_REGION_START (VA_START + KASAN_SHADOW_SIZE)
> > +#define BPF_JIT_REGION_SIZE  (SZ_128M)
> > +#define BPF_JIT_REGION_END   (BPF_JIT_REGION_START + BPF_JIT_REGION_SIZE)
> >  #define MODULES_END          (MODULES_VADDR + MODULES_VSIZE)
> > -#define MODULES_VADDR                (VA_START + KASAN_SHADOW_SIZE)
> > +#define MODULES_VADDR                (BPF_JIT_REGION_END)
> >  #define MODULES_VSIZE                (SZ_128M)
> >  #define VMEMMAP_START                (PAGE_OFFSET - VMEMMAP_SIZE)
> >  #define PCI_IO_END           (VMEMMAP_START - SZ_2M)
> > diff --git a/arch/arm64/net/bpf_jit_comp.c b/arch/arm64/net/bpf_jit_comp.c
> > index a6fdaea07c63..76c2ab40c02d 100644
> > --- a/arch/arm64/net/bpf_jit_comp.c
> > +++ b/arch/arm64/net/bpf_jit_comp.c
> > @@ -940,3 +940,16 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *prog)
> >                                          tmp : orig_prog);
> >       return prog;
> >  }
> > +
> > +void *bpf_jit_alloc_exec(unsigned long size)
> > +{
> > +     return __vmalloc_node_range(size, PAGE_SIZE, BPF_JIT_REGION_START,
> > +                                 BPF_JIT_REGION_END, GFP_KERNEL,
> > +                                 PAGE_KERNEL_EXEC, 0, NUMA_NO_NODE,
> > +                                 __builtin_return_address(0));
>
> I guess we'll want VM_IMMEDIATE_UNMAP here if Rich gets that merged.

I think akpm already queued up that patch.

> In the
> meantime, I wonder if it's worth zeroing the region in bpf_jit_free_exec()?
> (although we'd need the size information...).
>

Not sure. What exactly would that achieve?

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
