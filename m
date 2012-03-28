From: jon-hunter@ti.com (Jon Hunter)
Date: Wed, 28 Mar 2012 11:36:27 -0500
Subject: [PATCH] ARM: OMAP: hwmod: Fix error handling in functions used
 OMAP4 onwards
In-Reply-To: <alpine.DEB.2.00.1203272039010.22961@utopia.booyaka.com>
References: <1332842311-12308-1-git-send-email-rnayak@ti.com>
 <4F721A91.7000102@ti.com>
 <alpine.DEB.2.00.1203272039010.22961@utopia.booyaka.com>
Message-ID: <4F733E0B.2020901@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Paul,

On 3/27/2012 21:39, Paul Walmsley wrote:
> Hi Jon,
>
> On Tue, 27 Mar 2012, Jon Hunter wrote:
>
>> On 3/27/2012 4:58, Rajendra Nayak wrote:
>>
>>> diff --git a/arch/arm/mach-omap2/omap_hwmod.c
>>> b/arch/arm/mach-omap2/omap_hwmod.c
>>> index 8ac26f2..f2a9afa 100644
>>> --- a/arch/arm/mach-omap2/omap_hwmod.c
>>> +++ b/arch/arm/mach-omap2/omap_hwmod.c
>>> @@ -808,7 +808,7 @@ static void _enable_module(struct omap_hwmod *oh)
>>>     */
>>>    static int _omap4_wait_target_disable(struct omap_hwmod *oh)
>>>    {
>>> -	if (!cpu_is_omap44xx())
>>> +	if (cpu_is_omap24xx() || cpu_is_omap34xx())
>>>    		return 0;
>>
>> What about omap36xx?
>
> Unfortunately, cpu_is_omap34xx() also covers OMAP36xx :-(

Thanks. Is that still the case when MULTI_OMAP2 is defined? I can see if 
it is not define then it will always return 1 for all OMAP3, but for 
MULTI_OMAP2 it did not seem to me that it would. May be I should test ...

Cheers
Jon
