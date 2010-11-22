From: baruch@tkos.co.il (Baruch Siach)
Date: Mon, 22 Nov 2010 10:30:10 +0200
Subject: Query about cplusplus in linkage.h
In-Reply-To: <13701df.df91.12c677fe0fd.Coremail.bill_carson@126.com>
References: <13701df.df91.12c677fe0fd.Coremail.bill_carson@126.com>
Message-ID: <20101122083009.GB29610@jasper.tkos.co.il>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi rocky,

On Sat, Nov 20, 2010 at 12:17:02PM +0800, rocky wrote:
> I am a little confused about the following definition :
> 
> --------------include/linux/linkage.h-----------
> #ifdef __cplusplus
> #define CPP_ASMLINKAGE extern "C"
> #else
> #define CPP_ASMLINKAGE
> #endif
> 
> #ifndef asmlinkage
> #define asmlinkage CPP_ASMLINKAGE
> #endif
> 
> all system call functions are marked with asmlinkage, as well as other kernel function like printk/schedule/do_softirq
> 
> 
> so every asmlinkage function has extern "C"  attribute if cplusplus is defined, which definitely happens  when compiling C++ code.
> 
> I dont get it when cplusplus is needed when compiling kernel?

It isn't.

> Can anyone help me out of this little misunderstanding?

Userspace C++ code may include kernel header files. Making the exported 
function calls extern "C" makes it easier to build such applications.

baruch

-- 
                                                     ~. .~   Tk Open Systems
=}------------------------------------------------ooO--U--Ooo------------{=
   - baruch at tkos.co.il - tel: +972.2.679.5364, http://www.tkos.co.il -
