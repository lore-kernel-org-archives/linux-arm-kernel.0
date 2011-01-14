From: linuxzsc@gmail.com (Richard Zhao)
Date: Fri, 14 Jan 2011 22:50:05 +0800
Subject: [PATCH 2/2] arm: mx50_rdp: add i2c bus support
In-Reply-To: <AANLkTik2fL=viMrd=va0VwwNEJzk=hwkPVgFwcqhf5m0@mail.gmail.com>
References: <1294988137-24654-1-git-send-email-richard.zhao@freescale.com>
	<1294988137-24654-2-git-send-email-richard.zhao@freescale.com>
	<AANLkTik2fL=viMrd=va0VwwNEJzk=hwkPVgFwcqhf5m0@mail.gmail.com>
Message-ID: <AANLkTinahps3SxrSy+SRD_H+ifHnQTpuFpC4+2mTFLaC@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 14, 2011 at 10:27 PM, Jason Liu <liu.h.jason@gmail.com> wrote:
> Hi, Richard,
>
> 2011/1/14 Richard Zhao <richard.zhao@freescale.com>:
>> Signed-off-by: Richard Zhao <richard.zhao@freescale.com>
>> ---
>> ?arch/arm/mach-mx5/board-mx50_rdp.c ? ? ? ? ? | ? ?7 +++++++
>> ?arch/arm/mach-mx5/devices-mx50.h ? ? ? ? ? ? | ? ?3 +++
>
> We need align the naming convention with i.mx53/i.mx50 fordevices-mx50.h ,
> I have send out one patch for it.It seems not good when using devices-mx50.h
> while using devices-imx53 and devices-imx51.h in the same directory.
>
> I think we need use imx as much as possible since i.mx is FSL chip brand name.
>
> Sascha, please help merge the following patch if you don't have some
> comments about it.
> http://lists.arm.linux.org.uk/lurker/message/20110110.223149.e2d1fe51.en.html
I have comments on that thread too. I past here:
I noticed that too. Sometimes we use imx as part of file name or macro
name, but other times we use mx . We'd better make some rule that when
and where we suppose to use what.
I suggest we move all to mx for short. Reasons:
- For freescale internal, starting from mx5, we all use mx.
- macros in soc header files all use mx.
- soc header file name all use mx too.
- mach-types all use mx. (count in freescale board only)

Thanks
Richard
>
> BR,
> Jason
>
>> _______________________________________________
>> linux-arm-kernel mailing list
>> linux-arm-kernel at lists.infradead.org
>> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
>>
>
