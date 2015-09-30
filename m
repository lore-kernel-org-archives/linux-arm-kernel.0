From: hns@goldelico.com (H. Nikolaus Schaller)
Date: Wed, 30 Sep 2015 19:47:39 +0200
Subject: [PATCH] ARM: fix vdsomunge depends on glibc specific byteswap.h
In-Reply-To: <560C1DD0.1000907@mentor.com>
References: <cover.1443628457.git.hns@goldelico.com>
 <2039A9BE-ADA4-4D28-84F4-C8B9D76834AD@goldelico.com>
 <CAKv+Gu_098GVMeJPjDWaQ-uXek_cGUe4UMVy+fMdKw=_C+P7Tg@mail.gmail.com>
 <B6E60776-A054-4749-BCAF-1433BFFC6AF7@goldelico.com>
 <CAKv+Gu_6DibhUUPGrACCZE3S_k50rcO8A5ZcHh5c4UiDQUNApA@mail.gmail.com>
 <560C1DD0.1000907@mentor.com>
Message-ID: <8B76E3E8-52BF-4803-B1F9-E5704A858870@goldelico.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Am 30.09.2015 um 19:37 schrieb Nathan Lynch <Nathan_Lynch@mentor.com>:

> On 09/30/2015 11:17 AM, Ard Biesheuvel wrote:
>> On 30 September 2015 at 18:13, H. Nikolaus Schaller <hns@goldelico.com> wrote:
>>> 
>>> Am 30.09.2015 um 18:02 schrieb Ard Biesheuvel <ard.biesheuvel@linaro.org>:
>>>> 
>>>> Have you tried this?
>>>> 
>>>> #define bswap_16 __builtin_bswap16
>>>> #define bswap_32 __builtin_bswap32
>>>> #define bswap_64 __builtin_bswap64
>>>> 
>>>> https://gcc.gnu.org/onlinedocs/gcc/Other-Builtins.html
>>> 
>>> OS X host uses llvm and I am not sure if these builtins are
>>> always available.
>>> 
>> 
>> I am pretty sure recent clang supports these as well. Could you please try it?
> 
> Well, I think GCC did not provide __builtin_bswap16 consistently until
> the 4.8 release:
> 
> https://gcc.gnu.org/bugzilla/show_bug.cgi?id=52624
> 
> That seems too recent to me.

Same for me.

> 
> vdsomunge makes only three or four potentially byteswapped accesses to
> the ELF header.  It's not worth a lot of effort to try to use the most
> optimal implementation available.

Especially as it does not run on the target device but the build host.

>  Why not just use a generic
> implementation like is found in mips' elf2ecoff?

Do you have a reference?
I can't find byte swapping in

https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/tree/arch/mips/boot/elf2ecoff.c?id=refs/tags/v4.3-rc3

BR and thanks,
Nikolaus Schaller
