From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Tue, 16 Aug 2011 12:14:01 -0400 (EDT)
Subject: [PATCH 3/3] ARM: entry: Fix Thumb-2 undef handling for multi-CPU
	kernels
In-Reply-To: <CA+wbFdcP+xPOv+3uyFvV_71MAC940gDChubW9guCLXiqe=BpPg@mail.gmail.com>
References: <1313504053-27873-1-git-send-email-dave.martin@linaro.org>
	<1313504053-27873-4-git-send-email-dave.martin@linaro.org>
	<1313506300.2235.13.camel@computer2>
	<alpine.LFD.2.00.1108161139450.20358@xanadu.home>
	<CA+wbFdcP+xPOv+3uyFvV_71MAC940gDChubW9guCLXiqe=BpPg@mail.gmail.com>
Message-ID: <alpine.LFD.2.00.1108161213200.20358@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 16 Aug 2011, Dave Martin wrote:

> On Tue, Aug 16, 2011 at 4:47 PM, Nicolas Pitre <nicolas.pitre@linaro.org> wrote:
> > On Tue, 16 Aug 2011, Tixy wrote:
> >
> >> On Tue, 2011-08-16 at 15:14 +0100, Dave Martin wrote:
> >> [...]
> >> > +#ifdef NEED_CPU_ARCHITECTURE
> >> > + ? .align ?2
> >> > +.LCcpu_architecture:
> >> > + ? .word ? __cpu_architecture
> >> > +#endif
> >>
> >> What's the convention about the prefix '.LC' as opposed to just '.L'?
> >
> > The .Lfoo format is more widely used than .LCfoo in the tree.
> 
> ...but .LCfoo is more widely used in entry-armv.S, for exactly the
> same kind of thing.

Just use the same style then.


Nicolas
