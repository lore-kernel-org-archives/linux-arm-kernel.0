From: takahiro.akashi@linaro.org (AKASHI Takahiro)
Date: Fri, 27 Jul 2018 14:22:37 +0900
Subject: [PATCH v12 01/16] asm-generic: add kexec_file_load system call
 to unistd.h
In-Reply-To: <f77fe157-f9f6-8dfc-eca0-1ecd687f671f@arm.com>
References: <20180724065759.19186-1-takahiro.akashi@linaro.org>
 <20180724065759.19186-2-takahiro.akashi@linaro.org>
 <f77fe157-f9f6-8dfc-eca0-1ecd687f671f@arm.com>
Message-ID: <20180727052235.GD11258@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 26, 2018 at 02:35:50PM +0100, James Morse wrote:
> Hi Akashi,
> 
> On 24/07/18 07:57, AKASHI Takahiro wrote:
> > The initial user of this system call number is arm64.
> 
> This patch conflicts with commit db7a2d1809a5 ("asm-generic: unistd.h: Wire up
> sys_rseq") in the arm64 tree.

OK. I will try to rebase my code to arm64/for-next/core at v13.

Thanks,
-Takahiro AKASHI

> Thanks,
> 
> James
> 
> > diff --git a/include/uapi/asm-generic/unistd.h b/include/uapi/asm-generic/unistd.h
> > index 42990676a55e..c81f4a0df51f 100644
> > --- a/include/uapi/asm-generic/unistd.h
> > +++ b/include/uapi/asm-generic/unistd.h
> > @@ -734,9 +734,11 @@ __SYSCALL(__NR_pkey_free,     sys_pkey_free)
> >  __SYSCALL(__NR_statx,     sys_statx)
> >  #define __NR_io_pgetevents 292
> >  __SC_COMP(__NR_io_pgetevents, sys_io_pgetevents, compat_sys_io_pgetevents)
> > +#define __NR_kexec_file_load 293
> > +__SYSCALL(__NR_kexec_file_load,     sys_kexec_file_load)
> >  
> >  #undef __NR_syscalls
> > -#define __NR_syscalls 293
> > +#define __NR_syscalls 294
> >  
> >  /*
> >   * 32 bit systems traditionally used different
> > 
