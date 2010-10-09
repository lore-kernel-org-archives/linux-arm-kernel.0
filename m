From: tim.nordell@logicpd.com (Tim Nordell)
Date: Fri, 08 Oct 2010 19:28:55 -0500
Subject: [PATCH v4 0/4] LogicPD minimal board support for LV_SOM and
	Torpedo
In-Reply-To: <201010090155.25932.linz@li-pro.net>
References: <1285603550-6382-1-git-send-email-tim.nordell@logicpd.com>
	<20100928171908.GE3117@atomide.com>
	<201010090155.25932.linz@li-pro.net>
Message-ID: <4CAFB747.5020606@logicpd.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Stephan,

I do indeed work for LogicPD.  I was asked to take over the patch
submission process from Jacob Tanenbaum from early August (I don't know
if you saw those patches), and hence I was the last one to submit
patches off to the community.

I'll answer your other question off the newsgroups for now as I don't
want to post too many off-topic postings to the general newsgroup.

- Tim

On 10/08/10 18:55, Stephan Linz wrote:
> Hi Tony,
> Hi Tim,
> 
> nice to see my patches here on the Linux mailinglists. I have not been working 
> on it for a long time. Tim, how we can work together? Are you working for 
> LogicPD?
> 
> 
> Bye,
> Stephan
> 
> Am Dienstag, 28. September 2010, um 19:19:09 schrieb Tony Lindgren:
>> * Tim Nordell <tim.nordell@logicpd.com> [100927 08:57]:
>>> This was tested (and based) against 2.6.36-rc5
>>>
>>> Difference from patch v3 1/4:
>>>  - Merged DEBUG_LL support patch (patch v3 5/5) into first patch
>>>  - Added "select OMAP_PACKAGE_CBB" into Kconfig for both boards
>>>
>>> Tim Nordell (4):
>>>   Adding LogicPD OMAP3 board support
>>>   ARM: OMAP3LOGIC: Adding SDMMC support
>>>   ARM: OMAP3: Add generic smsc911x support when connected to GPMC
>>>   ARM: OMAP3LOGIC: Added SMSC Ethernet board support
>>>
>>>  arch/arm/mach-omap2/Kconfig                     |   20 ++
>>>  arch/arm/mach-omap2/Makefile                    |    7 +
>>>  arch/arm/mach-omap2/board-omap3logic.c          |  244
>>> +++++++++++++++++++++++ arch/arm/mach-omap2/gpmc-smsc911x.c             |
>>>  113 +++++++++++ arch/arm/plat-omap/include/plat/gpmc-smsc911x.h |   35
>>> ++++
>>>  arch/arm/plat-omap/include/plat/uncompress.h    |    2 +
>>>  6 files changed, 421 insertions(+), 0 deletions(-)
>>>  create mode 100644 arch/arm/mach-omap2/board-omap3logic.c
>>>  create mode 100644 arch/arm/mach-omap2/gpmc-smsc911x.c
>>>  create mode 100644 arch/arm/plat-omap/include/plat/gpmc-smsc911x.h
>>
>> Thanks, queuing all of them for the upcoming merge window.
>> I've updated the MMC related patch with the following to
>> keep it compiling with the MMC related platform init changes.
>>
>> Regards,
>>
>> Tony
>>
>> --- a/arch/arm/mach-omap2/board-omap3logic.c
>> +++ b/arch/arm/mach-omap2/board-omap3logic.c
>> @@ -26,6 +26,7 @@
>>  #include <linux/regulator/machine.h>
>>
>>  #include <linux/i2c/twl.h>
>> +#include <linux/mmc/host.h>
>>
>>  #include <mach/hardware.h>
>>  #include <asm/mach-types.h>
>> @@ -112,7 +113,7 @@ static struct omap2_hsmmc_info __initdata
>> board_mmc_info[] = { {
>>  		.name		= "external",
>>  		.mmc		= 1,
>> -		.wires		= 4,
>> +		.caps		= MMC_CAP_4_BIT_DATA,
>>  		.gpio_cd	= -EINVAL,
>>  		.gpio_wp	= -EINVAL,
>>  	},
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
>> the body of a message to majordomo at vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
