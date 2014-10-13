From: stefan@agner.ch (Stefan Agner)
Date: Mon, 13 Oct 2014 11:46:06 +0200
Subject: [RFC 2/7] clocksource: add dependencies for Vybrid pit clocksource
In-Reply-To: <20141012181821.GQ31554@pengutronix.de>
References: <cover.1413136383.git.stefan@agner.ch>
 <603e0f51e88b5643cb42e966cbb1b80b21a55ecf.1413136383.git.stefan@agner.ch>
 <20141012181821.GQ31554@pengutronix.de>
Message-ID: <98ca2b7a76dc786a36cf6c4113ca751f@agner.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am 2014-10-12 20:18, schrieb Uwe Kleine-K?nig:
> Hello,
> 
> On Sun, Oct 12, 2014 at 08:13:56PM +0200, Stefan Agner wrote:
>> Add the minimal dependencies required to use the Vybrid PIT
>> clocksource driver. Those are not part of the SoC dependencies.
>>
>> Signed-off-by: Stefan Agner <stefan@agner.ch>
>> ---
>>  drivers/clocksource/Kconfig | 2 ++
>>  1 file changed, 2 insertions(+)
>>
>> diff --git a/drivers/clocksource/Kconfig b/drivers/clocksource/Kconfig
>> index cfd6519..26464dd 100644
>> --- a/drivers/clocksource/Kconfig
>> +++ b/drivers/clocksource/Kconfig
>> @@ -146,6 +146,8 @@ config FSL_FTM_TIMER
>>
>>  config VF_PIT_TIMER
>>  	bool
>> +	select CLKSRC_MMIO
>> +	select CLKSRC_OF
>>  	help
>>  	  Support for Period Interrupt Timer on Freescale Vybrid Family SoCs.
> This one seems to qualify as a fix for the MMU stuff, right?

Well, this appeared when working on the !MMU stuff. Because on the MMU
SoC, CLKSRC_OF is selected by ARCH_MULTIPLATFORM and CLKSRC_MMIO is
selected by ARCH_MXC, it would not be a problem for MMU SOC_VF610. But I
guess we should try to define dependencies on the lowest level, so it is
probably a general fix?

--
Stefan
