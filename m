From: j-keerthy@ti.com (Keerthy)
Date: Fri, 23 Feb 2018 09:38:40 +0530
Subject: [PATCH v11 04/10] clocksource: timer-ti-dm: Replace architecture
In-Reply-To: <20180222184541.GB5184@atomide.com>
References: <1518674511-26421-1-git-send-email-j-keerthy@ti.com>
 <1518674511-26421-5-git-send-email-j-keerthy@ti.com>
 <20180222105713.GA30885@lenoch> <20180222184541.GB5184@atomide.com>
Message-ID: <44e7cb7c-aafa-ad10-fc11-6417066fb6e9@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On Friday 23 February 2018 12:15 AM, Tony Lindgren wrote:
> * Ladislav Michl <ladis@linux-mips.org> [180222 10:58]:
>> On Thu, Feb 15, 2018 at 11:31:45AM +0530, Keerthy wrote:
>>> Replace architecture specific guard with clocksource guard.
>>>
>>> Signed-off-by: Keerthy <j-keerthy@ti.com>
>>> Replace architecture specific defines with clocksource
>>
>> This looks like a bit unussual commit log. Also, what about merging
>> it with previous patch?
> 
> I'll just remove that line locally to avoid yet another set
> of patches being posted :)

Thanks!

> 
>> Btw, I tested whole serie again on the top of today's -next and it is
>> still working fine. What is preventing these patches from being merged?

Ladis,

Thanks once again.


> 
> Well I noticed we need a fix for omap1 that I just posted.
> And patch 4/10 needs the following select for omap16xx that
> I'll fold in.
> 
> I'll push it all to omap-for-v4.17/timer and will merge into
> my for-next after some more testing. It seems any further
> patching can be done after move to drivers.

Yes that would be great.

> 
> Regards,
> 
> Tony
> 
> 8< -----------------
> --- a/arch/arm/mach-omap1/Kconfig
> +++ b/arch/arm/mach-omap1/Kconfig
> @@ -30,6 +30,7 @@ config ARCH_OMAP16XX
>  	bool "OMAP16xx Based System"
>  	select ARCH_OMAP_OTG
>  	select CPU_ARM926T
> +	select OMAP_DM_TIMER
>  
>  config OMAP_MUX
>  	bool "OMAP multiplexing support"
> 
