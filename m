From: parkch98@gmail.com (Chanho Park)
Date: Fri, 5 Dec 2014 11:45:19 +0900
Subject: arm64: dose arm64 support the sysfs system call?
In-Reply-To: <5481136D.4030303@huawei.com>
References: <546EE946.1020905@huawei.com> <118663792.1vhfOdg7Rq@wuerfel>
 <5481136D.4030303@huawei.com>
Message-ID: <CAPTzV14_vBMMXWczuewYp8UORU1ZLUOucfmcQuAgDBVPrHBMyA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

2014-12-05 11:07 GMT+09:00 wangyufen <wangyufen@huawei.com>:
>
> On 2014/11/21 19:10, Arnd Bergmann wrote:
> > On Friday 21 November 2014 15:27:02 wangyufen wrote:
> >> Hi,
> >>
> >> I did ltp test on arm64, the sysfs testcases failed:
> >>
> >>     sysfs01     0  TWARN  :  This test can only run on kernels that support the sysfs system call
> >>
> >> because the __NR_sysfs didn't define in aarch64
> >>
> >> Dose anyone know what number the sysfs system call is in aarch64?
> >
> > It's disabled of course, because we don't support ancient libc
> > implementations. No modern Linux port has this.
> >
> >       Arnd
> >
> >
>
> __NR__lchown32?__NR_lstat?__NR__sysctl?__NR_vserver have similar problems.
>
> Dose aarch64 support those system call?
>
>  How I distinguish the ancient libc implementations.

You can find the syscalls from include/uapi/asm-generic/unistd.h.
Please note below definitions are not defined on aarch64.
__ARCH_WANT_SYSCALL_NO_AT
__ARCH_WANT_SYSCALL_NO_FLAGS
__ARCH_WANT_SYSCALL_DEPRECATED

Best Regards,
Chanho Park
