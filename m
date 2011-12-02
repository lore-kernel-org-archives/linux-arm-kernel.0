From: paul.gortmaker@windriver.com (Paul Gortmaker)
Date: Fri, 2 Dec 2011 11:31:50 -0500
Subject: [PATCH] arm: add default value for PHYS_OFFSET Kconfig setting
In-Reply-To: <20111202092124.GR26618@pengutronix.de>
References: <1322711557-8279-1-git-send-email-paul.gortmaker@windriver.com>
 <201112011419.46751.arnd@arndb.de>
 <CAP=VYLrp1zqyOzU-xzatF3jE3wL6wBjEDMR=sEXimP2ZvkQ0Lg@mail.gmail.com>
 <alpine.LFD.2.02.1112020005270.2357@xanadu.home>
 <alpine.LFD.2.02.1112020024370.2357@xanadu.home>
 <20111202092124.GR26618@pengutronix.de>
Message-ID: <4ED8FD76.3000802@windriver.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11-12-02 04:21 AM, Uwe Kleine-K?nig wrote:
> Hello Nicolas,
> 
> On Fri, Dec 02, 2011 at 12:33:26AM -0500, Nicolas Pitre wrote:

[...]

>> And it seems that at91x40 is the only defconfig with MMU=n, so the only 
>> option is really to provide a default CONFIG_PHYS_OFFSET.  So what about 
>> this:
>>
>> diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
>> index e084b7e981..a24672924f 100644
>> --- a/arch/arm/Kconfig
>> +++ b/arch/arm/Kconfig
>> @@ -222,6 +222,7 @@ config NEED_MACH_MEMORY_H
>>  config PHYS_OFFSET
>>  	hex "Physical address of main memory"
>>  	depends on !ARM_PATCH_PHYS_VIRT && !NEED_MACH_MEMORY_H
>> +	default DRAM_BASE if !MMU
>>  	help
>>  	  Please provide the physical address corresponding to the
>>  	  location of main memory in your system.
>>
>> Eventually the DRAM_BASE config option could simply be replaced by 
>> PHYS_OFFSET directly, but that's a larger change.
> I'm working on a MMU-less machine, too and had that change already in my
> working copy. I was about to commit and it send out later today.
> 
> So: Acked-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>

Looks fine to me as well; I had no particular attachment to the
original patch, and you guys have a much better understanding of
the specifics of the system.

Thanks,
Paul.

> 
> Best regards
> Uwe
> 
