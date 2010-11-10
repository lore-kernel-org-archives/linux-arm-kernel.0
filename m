From: R00091@freescale.com (Nguyen Dinh-R00091)
Date: Wed, 10 Nov 2010 08:51:19 -0700
Subject: [PATCHv3 1/2] ARM: imx: Add core definitions for MX53
In-Reply-To: <20101109214607.GG6017@pengutronix.de>
References: <1288972551-21877-1-git-send-email-Dinh.Nguyen@freescale.com>
	<20101109214607.GG6017@pengutronix.de>
Message-ID: <86A0E76937111F4C92FABEC0A20988510523D224@az33exm21>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Sascha,

>-----Original Message-----
>From: Sascha Hauer [mailto:s.hauer at pengutronix.de]
>Sent: Tuesday, November 09, 2010 3:46 PM
>To: Nguyen Dinh-R00091
>Cc: linux-kernel at vger.kernel.org; linux-arm-kernel at lists.infradead.org;
linux at arm.linux.org.uk;
>u.kleine-koenig at pengutronix.de; amit.kucheria at canonical.com;
eric at eukrea.com
>Subject: Re: [PATCHv3 1/2] ARM: imx: Add core definitions for MX53
>
>Hi Dinh,
>
>On Fri, Nov 05, 2010 at 10:55:50AM -0500, Dinh.Nguyen at freescale.com
wrote:
>> From: Dinh Nguyen <Dinh.Nguyen@freescale.com>
>>
>> Add iomux, clocks,  and memory map for Freescale's MX53 SoC.
>> Add cpu_is_mx53 function to common.h.
>> Add 3 more banks of gpio's to mxc_gpio_ports.
>> Add MX53 phys offset address.
>>
>> Signed-off-by: Dinh Nguyen <Dinh.Nguyen@freescale.com>
>> ---
>>  arch/arm/mach-mx5/clock-mx53.c              |  857
+++++++++++++++++++++++++++
>>  arch/arm/mach-mx5/devices.c                 |   27 +
>>  arch/arm/plat-mxc/include/mach/common.h     |    4 +
>>  arch/arm/plat-mxc/include/mach/iomux-mx53.h |  303 ++++++++++
>>  arch/arm/plat-mxc/include/mach/memory.h     |    1 +
>>  arch/arm/plat-mxc/include/mach/mx53.h       |  406 +++++++++++++
>>  6 files changed, 1598 insertions(+), 0 deletions(-)
>>  create mode 100644 arch/arm/mach-mx5/clock-mx53.c
>>  create mode 100644 arch/arm/plat-mxc/include/mach/iomux-mx53.h
>>  create mode 100644 arch/arm/plat-mxc/include/mach/mx53.h
>>
>> diff --git a/arch/arm/mach-mx5/clock-mx53.c
b/arch/arm/mach-mx5/clock-mx53.c
>> new file mode 100644
>> index 0000000..d547cb8
>> --- /dev/null
>> +++ b/arch/arm/mach-mx5/clock-mx53.c
>
>Most of this code looks like it could be shared with clock-mx51.c

Agreed, but I was unsure how to proceed with adding clock code for mx53.
Should I merge mx53 clock code into clock-mx51 and rename clock-mx51? 

>
>> +extern int mx53_revision(void);
>> +#endif
>> +
>> +#endif	/* ifndef __MACH_H__ */
>
>__MACH_MX53_H__
>
>> --
>> 1.6.0.4
>>
>>
>>
>
>--
>Pengutronix e.K.                           |
|
>Industrial Linux Solutions                 | http://www.pengutronix.de/
|
>Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0
|
>Amtsgericht Hildesheim, HRA 2686           | Fax:
+49-5121-206917-5555 |

Thanks for the review,

Dinh
