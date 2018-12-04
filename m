Return-Path: <SRS0=gVCq=ON=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D314C04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 15:45:53 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 503B7206B7
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 15:45:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="cqWKLZf2";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="VqAv5J1o"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 503B7206B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=bcM3yVy9MIh6BjDZSiLPyBMS08/ChSvjGrFiFxF2n2k=; b=cqWKLZf2UEFx7Z
	/ruWMyvsCbIpmWG1OkaycBgdUp7ntCTEktkVIBo8+707pn7eEHtnDj2ai2nNZOYYU0g4AvmaDXKu0
	h0/2rMup67/2zxF/VBOpPIRiMTAGPkcZLtaFdhiCcTgkVDMeWp/G6b2wJZpQn1GY5uOEinc7aMnry
	FBMDhuf8lT7wMWtxO9YXycUpsHq3Q5viyW2UR8yT5q2Dw9+4q3C335fBsfv+k9EeqJcTFfh3ssIVd
	xfxzEKwcEG6WtvPG81UMOLTr0OLwe4dnNw8UpMOMM5kxyzBMQnl4A04Hgd/+XyL+daaJw+W9iqX9T
	LUEY+j9oI2pYN9Ut1G0w==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gUCtP-0003js-BL; Tue, 04 Dec 2018 15:45:47 +0000
Received: from mail-io1-xd42.google.com ([2607:f8b0:4864:20::d42])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gUCtE-0003Or-Q7
 for linux-arm-kernel@lists.infradead.org; Tue, 04 Dec 2018 15:45:39 +0000
Received: by mail-io1-xd42.google.com with SMTP id r9so6518758ioa.1
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 04 Dec 2018 07:45:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=cOUYmVqM7lapaZ9KA66jWsVgjD9fs0gfbIMTvRz2Wtc=;
 b=VqAv5J1oNCU7hCx5278Rvv/rjhF7ijV8zXoB/+x9AFzlxvXqJBQzO5ICnPdtXAQbAT
 Ee3tx8ksKeKTR679KkStO8htgP+3aSwTqUmO7Y+XTllRvjFRBFAIngJEUXSwQEUtAcKH
 8IfLsSsfScnyu13QZvguqr/d/q3X9OXBcMmic=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=cOUYmVqM7lapaZ9KA66jWsVgjD9fs0gfbIMTvRz2Wtc=;
 b=GYGJb50BKnTdjm0jrvAqjfzYzeU8Nhq63B3UvTmarplH7CRITeCfZmTCo0qzj3Z3vM
 gHGS7j6RPww/7ArwEfVUkyc6X04OnPyVFsTi1FdJ27uIxju5oepBK6iWJZSdqSNzb0IU
 1SzS5VQuBESTu3cPH7SX7zzvJuT5TVuUlGKyrLNFUBRCczLHYsEaA9Qz6pZcHljK9ylP
 +C0QQAWwI22m9t9Ayp01UtS0NALDy87YXd/s9Q+Vb+qpC7Vf7GXputCzgWi3yruSazoE
 F9aZFkCnn2Vp8riyfLOCy1RQxyBXU3jSA7ObTu3Xq/xgJpNNIdaPw8bOg8z+WRYTY6Ld
 5y8Q==
X-Gm-Message-State: AA+aEWb1W+OkoZ98ZiQh6ZMHZw16sEm19Z84cW0xePtbjul5HNOX9GGq
 0CI/B9cnACsyC4ttZgptkBOY2c/Kbma26mn+ieH8Xi2ZObc=
X-Google-Smtp-Source: AFSGD/X413EQanwgeVJ4brZdBjy1F6YIHN6DWkMLxbz+kURI00M88Nur9yMRbmGWo4706uj8Uw2huWi9JSyLvGhjrn4=
X-Received: by 2002:a6b:5d01:: with SMTP id r1mr16939660iob.170.1543938325552; 
 Tue, 04 Dec 2018 07:45:25 -0800 (PST)
MIME-Version: 1.0
References: <20181123221804.440-1-ard.biesheuvel@linaro.org>
 <20181123221804.440-3-ard.biesheuvel@linaro.org>
 <20181130182629.GA16085@arm.com>
 <CAKv+Gu9QVHLWu5H3Ok1Kbm=vtzd1KaHUn2VEij6oToW5aPR9uA@mail.gmail.com>
 <20181203124930.GB25097@arm.com>
In-Reply-To: <20181203124930.GB25097@arm.com>
From: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date: Tue, 4 Dec 2018 16:45:12 +0100
Message-ID: <CAKv+Gu8svuTSOzg7wmmK70tRPgFqGvBh5BZR-V+43dMLvT1bJg@mail.gmail.com>
Subject: Re: [PATCH v4 2/2] arm64/bpf: don't allocate BPF JIT programs in
 module memory
To: Will Deacon <will.deacon@arm.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181204_074537_013453_97F70DB1 
X-CRM114-Status: GOOD (  29.26  )
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

On Mon, 3 Dec 2018 at 13:49, Will Deacon <will.deacon@arm.com> wrote:
>
> On Fri, Nov 30, 2018 at 08:20:06PM +0100, Ard Biesheuvel wrote:
> > On Fri, 30 Nov 2018 at 19:26, Will Deacon <will.deacon@arm.com> wrote:
> > >
> > > On Fri, Nov 23, 2018 at 11:18:04PM +0100, Ard Biesheuvel wrote:
> > > > The arm64 module region is a 128 MB region that is kept close to
> > > > the core kernel, in order to ensure that relative branches are
> > > > always in range. So using the same region for programs that do
> > > > not have this restriction is wasteful, and preferably avoided.
> > > >
> > > > Now that the core BPF JIT code permits the alloc/free routines to
> > > > be overridden, implement them by vmalloc()/vfree() calls from a
> > > > dedicated 128 MB region set aside for BPF programs. This ensures
> > > > that BPF programs are still in branching range of each other, which
> > > > is something the JIT currently depends upon (and is not guaranteed
> > > > when using module_alloc() on KASLR kernels like we do currently).
> > > > It also ensures that placement of BPF programs does not correlate
> > > > with the placement of the core kernel or modules, making it less
> > > > likely that leaking the former will reveal the latter.
> > > >
> > > > This also solves an issue under KASAN, where shadow memory is
> > > > needlessly allocated for all BPF programs (which don't require KASAN
> > > > shadow pages since they are not KASAN instrumented)
> > > >
> > > > Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> > > > ---
> > > >  arch/arm64/include/asm/memory.h |  5 ++++-
> > > >  arch/arm64/net/bpf_jit_comp.c   | 13 +++++++++++++
> > > >  2 files changed, 17 insertions(+), 1 deletion(-)
> > > >
> > > > diff --git a/arch/arm64/include/asm/memory.h b/arch/arm64/include/asm/memory.h
> > > > index b96442960aea..ee20fc63899c 100644
> > > > --- a/arch/arm64/include/asm/memory.h
> > > > +++ b/arch/arm64/include/asm/memory.h
> > > > @@ -62,8 +62,11 @@
> > > >  #define PAGE_OFFSET          (UL(0xffffffffffffffff) - \
> > > >       (UL(1) << (VA_BITS - 1)) + 1)
> > > >  #define KIMAGE_VADDR         (MODULES_END)
> > > > +#define BPF_JIT_REGION_START (VA_START + KASAN_SHADOW_SIZE)
> > > > +#define BPF_JIT_REGION_SIZE  (SZ_128M)
> > > > +#define BPF_JIT_REGION_END   (BPF_JIT_REGION_START + BPF_JIT_REGION_SIZE)
> > > >  #define MODULES_END          (MODULES_VADDR + MODULES_VSIZE)
> > > > -#define MODULES_VADDR                (VA_START + KASAN_SHADOW_SIZE)
> > > > +#define MODULES_VADDR                (BPF_JIT_REGION_END)
> > > >  #define MODULES_VSIZE                (SZ_128M)
> > > >  #define VMEMMAP_START                (PAGE_OFFSET - VMEMMAP_SIZE)
> > > >  #define PCI_IO_END           (VMEMMAP_START - SZ_2M)
> > > > diff --git a/arch/arm64/net/bpf_jit_comp.c b/arch/arm64/net/bpf_jit_comp.c
> > > > index a6fdaea07c63..76c2ab40c02d 100644
> > > > --- a/arch/arm64/net/bpf_jit_comp.c
> > > > +++ b/arch/arm64/net/bpf_jit_comp.c
> > > > @@ -940,3 +940,16 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *prog)
> > > >                                          tmp : orig_prog);
> > > >       return prog;
> > > >  }
> > > > +
> > > > +void *bpf_jit_alloc_exec(unsigned long size)
> > > > +{
> > > > +     return __vmalloc_node_range(size, PAGE_SIZE, BPF_JIT_REGION_START,
> > > > +                                 BPF_JIT_REGION_END, GFP_KERNEL,
> > > > +                                 PAGE_KERNEL_EXEC, 0, NUMA_NO_NODE,
> > > > +                                 __builtin_return_address(0));
> > >
> > > I guess we'll want VM_IMMEDIATE_UNMAP here if Rich gets that merged.
> >
> > I think akpm already queued up that patch.
> >
> > > In the
> > > meantime, I wonder if it's worth zeroing the region in bpf_jit_free_exec()?
> > > (although we'd need the size information...).
> > >
> >
> > Not sure. What exactly would that achieve?
>
> I think the zero encoding is guaranteed to be undefined, so it would limit
> the usefulness of any stale, executable TLB entries. However, we'd also need
> cache maintenance to make that stuff visible to the I side, so it's probably
> not worth it, especially if akpm has queued the stuff from Rich.
>
> Maybe just add an:
>
> /* FIXME: Remove this when VM_IMMEDIATE_UNMAP is supported */
> #ifndef VM_IMMEDIATE_UNMAP
> #define VM_IMMEDIATE_UNMAP      0
> #endif
>
> so we remember to come back and sort this out? Up to you.
>

I'll just make a note to send out that patch once the definition lands via -akpm

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
