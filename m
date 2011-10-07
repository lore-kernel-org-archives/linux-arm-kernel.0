From: santosh.shilimkar@ti.com (Santosh Shilimkar)
Date: Fri, 07 Oct 2011 12:26:36 +0530
Subject: [PATCH 5/4] ARM: OMAP: Move set_globals initialization to happen
	in init_early
In-Reply-To: <20111006013656.GG6324@atomide.com>
References: <20111005004339.26980.31149.stgit@kaulin.local>
	<20111005014044.GZ6324@atomide.com>
	<alpine.LFD.2.02.1110042150190.9106@xanadu.home>
	<20111006013656.GG6324@atomide.com>
Message-ID: <4E8EA2A4.5070301@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 06 October 2011 07:06 AM, Tony Lindgren wrote:
> * Nicolas Pitre <nico@fluxnic.net> [111004 18:17]:
>> On Tue, 4 Oct 2011, Tony Lindgren wrote:
>>
>>> Otherwise we can't do generic map_io as we currently rely on
>>> static mappings that work only because of arch_ioremap.
>>>
>>> Signed-off-by: Tony Lindgren <tony@atomide.com>
>>
>> That's great.
>>
>> Acked-by: Nicolas Pitre <nicolas.pitre@linaro.org>
> 
> Here's an updated version with all the early ioremap
> access converted to use L3/L4_IO_ADDRESS macros. Some
> of this may not be needed after generic map_io, but until
> then we can't use ioremap until in init_early after the
> SoC detection is done.
> 
> Regards,
> 
> Tony
> 
> 
> From: Tony Lindgren <tony@atomide.com>
> Date: Tue, 4 Oct 2011 18:17:41 -0700
> Subject: [PATCH] ARM: OMAP: Move set_globals initialization to happen in init_early
> 
> Otherwise we can't do generic map_io as we currently rely on
> static mappings that work only because of arch_ioremap.
> 
> Acked-by: Nicolas Pitre <nicolas.pitre@linaro.org>
> Signed-off-by: Tony Lindgren <tony@atomide.com>
> 
The changes looks fine to me. Though the ugly hard-coding
is back with it, it's a step towards generic_io, so hopefully
it won't have to stay for long time.

Reviewed-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
Tested-by: Santosh Shilimkar <santosh.shilimkar@ti.com>	


considering it's commin
