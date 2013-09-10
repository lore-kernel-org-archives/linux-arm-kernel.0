From: nsekhar@ti.com (Sekhar Nori)
Date: Tue, 10 Sep 2013 18:50:39 +0530
Subject: [GIT PULL 1/2] DaVinci SoC updates for v3.12
In-Reply-To: <5229DA4A.30205@ahsoftware.de>
References: <52151BA6.2060109@ti.com> <87ppt5r1t4.fsf@linaro.org>
 <52291BCD.7030106@ahsoftware.de> <5229A405.3090409@ti.com>
 <5229DA4A.30205@ahsoftware.de>
Message-ID: <522F1CA7.7090701@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 06 September 2013 07:06 PM, Alexander Holler wrote:
> Am 06.09.2013 11:44, schrieb Sekhar Nori:
>> Hi Alexander,
>>> Just a warning, I've tried the patch series for the serial on top of
>>> 3.11 and the patch
>>>
>>> ARM: davinci: serial: get rid of davinci_uart_config
>>>
>>> doesn't even compile here.
>>>
>>> The culprit is a misplaced
>>>
>>> #include <linux/platform_device.h>
>>>
>>> in arch/arm/mach-davinci/include/mach/serial.h
>>
>> I need more information on how to reproduce the issue. This pull request
>> was based on v3.11-rc2 and I had verified the build before posting. I
>> just verified build on linux-next master too. All builds were verified
>> using davinci_all_defconfig and da8xx_omapl_defconfig.
>>
>> Can you please send the error log? Your .config against latest
>> linux-next/master will also help.
>>
> 
> Just enable earlyprintk (DEBUG_LL) so that an assembler file (in this
> case debug.S) will include that broken serial.h.

Thanks for reporting this. I just sent a fix. Will try to get it in
before -rc1 comes out.

Thanks,
Sekhar
