From: santosh.shilimkar@ti.com (Santosh Shilimkar)
Date: Mon, 18 Nov 2013 19:04:40 -0500
Subject: [PATCH] ARM: OMAP2+: Fix undefined reference to set_cntfreq
In-Reply-To: <20131118232145.GX10317@atomide.com>
References: <20131118215855.GW10317@atomide.com> <528A9E8C.9040903@ti.com>
 <20131118232145.GX10317@atomide.com>
Message-ID: <528AAB18.7040105@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 18 November 2013 06:21 PM, Tony Lindgren wrote:
> * Santosh Shilimkar <santosh.shilimkar@ti.com> [131118 15:11]:
>> On Monday 18 November 2013 04:58 PM, Tony Lindgren wrote:
>>> If CONFIG_SOC_HAS_REALTIME_COUNTER is not selected for omap5
>>> or dra7xx, we can get the following error:
>>>
>>> arch/arm/mach-omap2/built-in.o: In function `omap4_secondary_init':
>>> :(.text+0x7ab0): undefined reference to `set_cntfreq'
>>>
>>> Fix the issue by not trying to initalize the realtime counter
>>> unles CONFIG_SOC_HAS_REALTIME_COUNTER is selected.
>>>
>>> Signed-off-by: Tony Lindgren <tony@atomide.com>
>>>
>> How about a dummy inline function of set_cntfreq() ?
>> Having #ifdef in middle of the code looks pretty ugly.
> 
> Sure, here's an updated version.
> 
Thanks for quick spin.

> 
> 
> From: Tony Lindgren <tony@atomide.com>
> Date: Mon, 18 Nov 2013 13:56:48 -0800
> Subject: [PATCH] ARM: OMAP2+: Fix undefined reference to set_cntfreq
> 
> If CONFIG_SOC_HAS_REALTIME_COUNTER is not selected for omap5
> or dra7xx, we can get the following error:
> 
> arch/arm/mach-omap2/built-in.o: In function `omap4_secondary_init':
> :(.text+0x7ab0): undefined reference to `set_cntfreq'
> 
> Fix the issue by not trying to initalize the realtime counter
> unles CONFIG_SOC_HAS_REALTIME_COUNTER is selected.
> 
> Signed-off-by: Tony Lindgren <tony@atomide.com>
> 
Acked-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
