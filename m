From: nsekhar@ti.com (Sekhar Nori)
Date: Fri, 6 Sep 2013 15:14:37 +0530
Subject: [GIT PULL 1/2] DaVinci SoC updates for v3.12
In-Reply-To: <52291BCD.7030106@ahsoftware.de>
References: <52151BA6.2060109@ti.com> <87ppt5r1t4.fsf@linaro.org>
 <52291BCD.7030106@ahsoftware.de>
Message-ID: <5229A405.3090409@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Alexander,

On Friday 06 September 2013 05:33 AM, Alexander Holler wrote:
> Am 22.08.2013 20:57, schrieb Kevin Hilman:
>> Sekhar Nori <nsekhar@ti.com> writes:
>>
>>> Hi Arnd, Olof, Kevin,
>>>
>>> Please pull the following DaVinci SoC changes for v3.12
>>>
>>> Thanks,
>>> Sekhar
>>>
>>> The following changes since commit 3b2f64d00c46e1e4e9bd0bb9bb12619adac27a4b:
>>>
>>>   Linux 3.11-rc2 (2013-07-21 12:05:29 -0700)
>>>
>>> are available in the git repository at:
>>>
>>>   git://git.kernel.org/pub/scm/linux/kernel/git/nsekhar/linux-davinci.git tags/davinci-for-v3.12/soc
>>>
>>> for you to fetch changes up to 46c1833467c5e555f31cd6f14b342a7383f26885:
>>>
>>>   ARM: davinci: fix clock lookup for mdio device (2013-08-22 00:39:01 +0530)
>>>
>>> ----------------------------------------------------------------
>>> DaVinci SoC updates for v3.12
>>> -----------------------------
>>>
>>> This set of SoC updates contains changes to the
>>> way UART clock is handled to enabled DT-boot to
>>> obtain UART clock frequency instead of relying
>>> on DT-binding being supplied. Similarly handling
>>> of MDIO clock is fixed to make it easier to support
>>> MDIO in DT-boot. Finally there is patch to remove
>>> now unnecessary setting of wake-up capable flag for
>>> RTC.
>>
>> Thanks for the detailed description.
>>
>> Pulled into next/soc
> 
> Just a warning, I've tried the patch series for the serial on top of
> 3.11 and the patch
> 
> ARM: davinci: serial: get rid of davinci_uart_config
> 
> doesn't even compile here.
> 
> The culprit is a misplaced
> 
> #include <linux/platform_device.h>
> 
> in arch/arm/mach-davinci/include/mach/serial.h

I need more information on how to reproduce the issue. This pull request
was based on v3.11-rc2 and I had verified the build before posting. I
just verified build on linux-next master too. All builds were verified
using davinci_all_defconfig and da8xx_omapl_defconfig.

Can you please send the error log? Your .config against latest
linux-next/master will also help.

Thanks,
Sekhar
