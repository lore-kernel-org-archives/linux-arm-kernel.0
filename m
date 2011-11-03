From: s.nawrocki@samsung.com (Sylwester Nawrocki)
Date: Thu, 03 Nov 2011 11:24:34 +0100
Subject: [PATCH 1/3 v3] ARM: EXYNOS4: Support for generic I/O power domains
	on EXYNOS4210/4212
In-Reply-To: <013301cc99cd$8d5a6a00$a80f3e00$%kim@samsung.com>
References: <4EA690EF.4000703@samsung.com>
	<013301cc99cd$8d5a6a00$a80f3e00$%kim@samsung.com>
Message-ID: <4EB26BE2.2060508@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Kgene,

On 11/03/2011 03:09 AM, Kukjin Kim wrote:
> As I said, I don't think we should control/gate the clocks with regarding power domain. 

As far as I know there is a plan to let the drivers override start/stop_device callbacks,
moreover the clock control can be disabled globally by not implementing start/stop_device
callbacks or per device by not adding clkdev entities to the device clock list at runtime 
PM core. So IMHO, there is/going to be enough flexibility.

> It should be controlled by each regarding device driver and in addition, as I know,
> to handle block of clock is not recommended on EXYNOS4 now.

What do you mean by this ? I couldn't find such information in any documentation.
Shouldn't "clock gate block" registers be touched by boot loader and the kernel?
Our boot loaders disable all clocks, and if the global clock gate is not enabled
by the kernel there is no chance any multimedia device will work.

Should the global clock block gate be always enabled then ? I'm afraid it is not
optimal form power management POV.

-- 
Thanks,
Sylwester
