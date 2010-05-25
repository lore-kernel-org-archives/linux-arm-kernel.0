From: rumjantsev@papillon.ru (237 Rumjantsev Egor (PROG))
Date: Tue, 25 May 2010 21:35:18 +0600
Subject: vpack270 and sleep mode
In-Reply-To: <201005251702.21204.marek.vasut@gmail.com>
References: <1272311167-576-1-git-send-email-marek.vasut@gmail.com>
	<201005251439.50508.marek.vasut@gmail.com>
	<4BFBD01E.8010101@papillon.ru>
	<201005251702.21204.marek.vasut@gmail.com>
Message-ID: <4BFBEE36.6000004@papillon.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

25.05.2010 21:02, Marek Vasut ?????:
> Dne ?t 25. kv?tna 2010 15:26:54 237 Rumjantsev Egor (PROG) napsal(a):
>> 25.05.2010 18:39, Marek Vasut ?????:
>>> Dne ?t 25. kv?tna 2010 14:38:09 Marek Vasut napsal(a):
>>>> Dne ?t 25. kv?tna 2010 14:13:01 237 Rumjantsev Egor (PROG) napsal(a):
>>>>> Hello, Marek
>>>>
>>>> Hi,
>>>>
>>>>> Could you help to solve the following problem:
>>>>> I try to move my board based on Voipac PXA270 module to sleep state.
>>>>> I'm running kernel 2.6.28.10 on it.
>>>>
>>>> CCed Voipac and linux-arm-kernel. Btw. that's not Voipac official
>>>> kernel, is it?
>>
>> Yes it isn't. I patched vanilla kernel to get basic Voipac module
>> support and add some my code for our board.
>
> Please, use what's in mainline then. (git.kernel.org, search for ycmiao, use -
> devel branch).

i did so. I downloaded 2.6.28.10 sources, patched it to get basic 
support for Voipac module and add some my platform devices.


>>
>>> My bad, CCed wrong linux-arm-kernel, fixed now :)
>>>
>>>>> When i try echo mem>   /sys/power/state i see messages that system goes
>>>>> to sleep state but after pushing wake-up button (GPIO0) i don't see
>>>>> that a bootloader is running (i set up some GPIOs as flags in
>>>>> bootloader and see on them whith oscilloscope).
>>>>
>>>> The bootloader checks RCSR once you wake it up and it sets-up SDRAM. If
>>>> there's a sleep-wakeup bit, it branches to location in PSPR and there's
>>>> linux kernel already.
>>
>> i know that as i have to use U-boot 1.3.0 for my board. It's also not
>> Voipac's u-boot version.
>
> Can't you use u-boot-pxa from git.denx.de ?

u-boot-2009.11.1 haven't Voipac or Toradex Colibri support.

>>>>>
>>>>> but if i type command echo standby>   /sys/power/state
>>>>> the system reacts on wake-up button but hangs after some messages about
>>>>> null dereferencing pointers.
>>>>>
>>>>> is there any possibility to trace such problem?
>>>>
>>>> Try CONFIG_PM_ADVANCED_DEBUG.
>>
>> i've looked through kernel sources and didn't such identifer
>>
> Maybe you need newer kernel, see above.

May be....but then i need to rewrite some of hardware drivers as drivers 
api for some kind of devices has changed since 2.6.28.
When i run 2.6.24 kernel on Toradex Colibri module i haven't such 
troubles so i hope that 2.6.28 can work with sleep mode.

>
> What's pxa_reg module? Does it have proper suspend/resume functions?

No, it doesn't. I unloaded it but all the same - kernel hangs

>>
>>>> There was also a way to keep the console enabled until the kernel didn't
>>>> totally suspend, but I can't find that option now, maybe someone will be
>>>> more successful. And maybe I'm mistaking this with an option to don't
>>>> blank consoles until then, it's been some time since I needed that.
>>>>
>>>>> P.S.: sorry if i disturb you, but you the only man in ARM linux mailing
>>>>> list who posted messages about Voipac modules.
>>>>
>>>> You're welcome.
>>>>
>>>>> Best regards !!!
>


-- 
Rumjantsev Egor
