From: arve@android.com (=?ISO-8859-1?Q?Arve_Hj=F8nnev=E5g?=)
Date: Sat, 12 Dec 2009 04:11:51 -0800
Subject: tree with htc dream support
In-Reply-To: <d6200be20912120351w2cdc328ar9d2fb490593b2a48@mail.gmail.com>
References: <20091205221100.GA32522@elf.ucw.cz>
	<1260054737.23633.35.camel@desktop>
	<a55d774e0912051638u7858878cg7cf62905c3c005c1@mail.gmail.com>
	<d6200be20912112142r7bdf8f18o31edd4457aa64998@mail.gmail.com>
	<20091212112536.GA2302@elf.ucw.cz>
	<d6200be20912120351w2cdc328ar9d2fb490593b2a48@mail.gmail.com>
Message-ID: <d6200be20912120411s140931e1q3097a7ba7d6667c1@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2009/12/12 Arve Hj?nnev?g <arve@android.com>:
> On Sat, Dec 12, 2009 at 3:25 AM, Pavel Machek <pavel@ucw.cz> wrote:
>> On Fri 2009-12-11 21:42:07, Arve Hj?nnev?g wrote:
>>> On Sat, Dec 5, 2009 at 4:38 PM, Brian Swetland <swetland@google.com> wrote:
>>> > Arve's about to take our common and msm trees and rebase them over the .32,
>>> > which may be useful for reference -- at least as a snapshot of a fully
>>> > functional set of patches that android donut and eclair run on, on
>>> > production hardware.? We'll make that available as soon as we have something
>>> > that's bootable.
>>> >
>>> > Brian
>>> >
>>> >
>>>
>>> A first pass of this is available in the android-msm-2.6.32-test1
>>> branch at git://android.git.kernel.org/kernel/experimental.git.
>>
>> According to some docs, i2c_detach can be just removed, so...?
>>
>> Then I got this:
>>
>> ?CC ? ? ?drivers/input/misc/gpio_axis.o
>> ?CC ? ? ?drivers/input/misc/keychord.o
>> drivers/input/misc/keychord.c: In function 'keychord_event':
>> drivers/input/misc/keychord.c:129: error: 'TASK_INTERRUPTIBLE'
>> undeclared (first use in this
>> function)drivers/input/misc/keychord.c:129: error: (Each undeclared
>> identifier is reported only once
>> drivers/input/misc/keychord.c:129: error: for each function it appears
>> in.)
>> drivers/input/misc/keychord.c: In function 'keychord_read':
>> drivers/input/misc/keychord.c:205: error: 'TASK_INTERRUPTIBLE'
>> undeclared (first use in this
>> function)drivers/input/misc/keychord.c:205: error: implicit
>> declaration of function 'signal_pending'
>> drivers/input/misc/keychord.c:205: error: implicit declaration of
>> function 'schedule'
>> make[3]: *** [drivers/input/misc/keychord.o] Error 1
>> make[2]: *** [drivers/input/misc] Error 2
>> make[1]: *** [drivers/input] Error 2
>> make: *** [drivers] Error 2
>> 12.60user 2.53system 16.93 (0m16.939s) elapsed 89.36%CPU
>> pavel at amd:/data/l/linux-msm-32$
>>
>
> I don't know what is different, but this compiles for me without
> adding sched.h. I did have to add sched.h to some other drivers
> though.

It fails to build if I turn off CONFIG_PREEMPT.

For now run "make msm_defconfig" if you want a working configuration.

-- 
Arve Hj?nnev?g
