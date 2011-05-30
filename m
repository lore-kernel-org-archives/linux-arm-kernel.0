From: kgene.kim@samsung.com (Kukjin Kim)
Date: Sun, 29 May 2011 18:24:32 -0700
Subject: [PATCH] ARM: SAMSUNG: serial: Fix on handling of one clock source
	for UART
In-Reply-To: <20110528093904.GC21388@kroah.com>
References: <1306548243-2526-1-git-send-email-kgene.kim@samsung.com>
	<20110528093904.GC21388@kroah.com>
Message-ID: <4DE2F1D0.6030604@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/28/11 02:39, Greg KH wrote:
> On Fri, May 27, 2011 at 07:04:03PM -0700, Kukjin Kim wrote:
>> From: Boojin Kim<boojin.kim@samsung.com>
>>
>> This patch fixes the way of comparison for handling of two or more
>> clock sources for UART.
>>
>> For example, if just only one clock source is defined even though
>> there are two clock sources for UART, the serial driver does not
>> set proper clock up. Of course, it is problem.
>>
>> So this patch changes the condition of comparison to avoid useless
>> setup clock and adds a flag 'NO_NEED_CHECK_CLKSRC' which means
>> selection of source clock is not required.
>>
>> In addition, since the Exynos4210 has only one clock source for UART
>> this patch adds the flag into its common_init_uarts().
>>
>> Signed-off-by: Boojin Kim<boojin.kim@samsung.com>
>> Cc: Greg Kroah-Hartman<greg@kroah.com>
>> Signed-off-by: Kukjin Kim<kgene.kim@samsung.com>
>> ---
>>   arch/arm/mach-exynos4/init.c                     |    1 +
>>   arch/arm/plat-samsung/include/plat/regs-serial.h |    2 ++
>>   drivers/tty/serial/s5pv210.c                     |    4 ++--
>>   3 files changed, 5 insertions(+), 2 deletions(-)
>
> Is this needed in older kernels as well (like .39)?
>
Hi, Greg :)

Yes, we need this on 2.6.39 but don't need on .38 because the comparison 
codes has been merged during 39 merge window.

Could you please apply this on next .39 stable?

Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.
