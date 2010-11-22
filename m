From: bill_carson@126.com (rocky)
Date: Mon, 22 Nov 2010 15:07:55 -0000
Subject: Query about cplusplus in linkage.h
In-Reply-To: <20101122083009.GB29610@jasper.tkos.co.il>
References: <20101122083009.GB29610@jasper.tkos.co.il>
	<13701df.df91.12c677fe0fd.Coremail.bill_carson@126.com>
Message-ID: <1c8df545.121ab.12c74028c01.Coremail.bill_carson@126.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

hi,Baruch

thanks for you kindly replay;
I am still lost in this maze, so does extern "C" help user space C++ program to call schedule/printk?
sys_xxx functions are called through SWI ,not directly called from user space C++ program;

BR

rocky

At 2010-11-22 16:30:10?"Baruch Siach" <baruch@tkos.co.il> wrote:

>Hi rocky,
>
>On Sat, Nov 20, 2010 at 12:17:02PM +0800, rocky wrote:
>> I am a little confused about the following definition :
>> 
>> --------------include/linux/linkage.h-----------
>> #ifdef __cplusplus
>> #define CPP_ASMLINKAGE extern "C"
>> #else
>> #define CPP_ASMLINKAGE
>> #endif
>> 
>> #ifndef asmlinkage
>> #define asmlinkage CPP_ASMLINKAGE
>> #endif
>> 
>> all system call functions are marked with asmlinkage, as well as other kernel function like printk/schedule/do_softirq
>> 
>> 
>> so every asmlinkage function has extern "C"  attribute if cplusplus is defined, which definitely happens  when compiling C++ code.
>> 
>> I dont get it when cplusplus is needed when compiling kernel?
>
>It isn't.
>
>> Can anyone help me out of this little misunderstanding?
>
>Userspace C++ code may include kernel header files. Making the exported 
>function calls extern "C" makes it easier to build such applications.
>
>baruch
>
>-- 
>                                                     ~. .~   Tk Open Systems
>=}------------------------------------------------ooO--U--Ooo------------{=
>   - baruch at tkos.co.il - tel: +972.2.679.5364, http://www.tkos.co.il -
>
>_______________________________________________
>linux-arm-kernel mailing list
>linux-arm-kernel at lists.infradead.org
>http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20101122/a99e6519/attachment-0001.html>
