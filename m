From: balbi@ti.com (Felipe Balbi)
Date: Mon, 4 Oct 2010 10:00:40 +0300
Subject: [PATCH 08/10] OMAP: split plat-omap/common.c
In-Reply-To: <20101004065624.GD2559@legolas.emea.dhcp.ti.com>
References: <20101001213119.1408.65395.stgit@twilight.localdomain>
	<20101001213532.1408.55832.stgit@twilight.localdomain>
	<EAF47CD23C76F840A9E7FCE10091EFAB030CDFE3C6@dbde02.ent.ti.com>
	<20101004065624.GD2559@legolas.emea.dhcp.ti.com>
Message-ID: <20101004070040.GE2559@legolas.emea.dhcp.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 04, 2010 at 01:56:24AM -0500, Balbi, Felipe wrote:
>On Mon, Oct 04, 2010 at 12:34:48AM -0500, Shilimkar, Santosh wrote:
>>Felipe,
>>
>>> -----Original Message-----
>>> From: linux-omap-owner at vger.kernel.org [mailto:linux-omap-
>>> owner at vger.kernel.org] On Behalf Of Paul Walmsley
>>> Sent: Saturday, October 02, 2010 3:06 AM
>>> To: linux-omap at vger.kernel.org; linux-arm-kernel at lists.infradead.org
>>> Subject: [PATCH 08/10] OMAP: split plat-omap/common.c
>>>
>>> Split plat-omap/common.c into three pieces:
>>>
>>> 1. the 32KiHz sync timer and clocksource code, which now lives in
>>>    plat-omap/32ksynctimer.c;
>>>
>>I remember you have converted the 32k sync time code to a platform driver.
>>That was also addressing the multi-omap build and was removing all
>>the compile time switches.
>>Do you plan to rebase it and post it again ?
>
>I still have that sitting on my gitorious tree. The patch is attached
>to this mail. I compile tested (only) for omap3_defconfig, it probably
>needs to start using pm_runtime functions at some point and probably
>move to drivers/clocksource instead of arch/arm/plat-omap.
>
>patch is also available at [1]
>
>[1] git://gitorious.org/usb/usb.git clksource

I made a few changes to make checkpatch.pl --strict happy. Attached

-- 
balbi
