From: nsekhar@ti.com (Sekhar Nori)
Date: Fri, 8 Jul 2016 16:35:14 +0530
Subject: [PATCH] ARM: davinci: remove unused davinci-i2s pdata
In-Reply-To: <5213058.cGsNedsgWG@wuerfel>
References: <1462802388-25088-1-git-send-email-petr@barix.com>
 <575AB71B.9070007@ti.com> <5213058.cGsNedsgWG@wuerfel>
Message-ID: <577F88EA.5000602@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 08 July 2016 03:36 PM, Arnd Bergmann wrote:
> On Friday, June 10, 2016 6:18:27 PM CEST Sekhar Nori wrote:
>> On Monday 09 May 2016 07:29 PM, Petr Kulhavy wrote:
>>> The davinci-i2s driver ("davinci-mcbsp") does not use platform
>>> data any longer. Remove the dummy pdata provided by the board
>>> drivers dm355, dm365, dm644x and neuros-osd2.
>>>
>>> Signed-off-by: Petr Kulhavy <petr@barix.com>
>>> Reviewed-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
>>
>> Applied to v4.8/cleanup
> 
> This caused a randconfig failure:
> 
> arch/arm/mach-davinci/board-dm365-evm.c: In function 'dm365_evm_init':
> arch/arm/mach-davinci/board-dm365-evm.c:764:17: error: 'dm365_evm_snd_data' undeclared (first use in this function)
>   dm365_init_vc(&dm365_evm_snd_data);
>                  ^~~~~~~~~~~~~~~~~~
> arch/arm/mach-davinci/board-dm365-evm.c:764:17: note: each undeclared identifier is reported only once for each function it appears in
> 
> clearly, the dm365_evm_snd_data is still passed as platform_data
> into the voicecodec. However, I cannot see where it gets used,
> my interpretation of the git log is that it never was, so we should
> remove that too.

Arnd, you are right, this was missed. I will send a patch fixing it soonish.

Regards,
Sekhar
