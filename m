From: robin.murphy@arm.com (Robin Murphy)
Date: Thu, 22 Feb 2018 13:01:13 +0000
Subject: [PATCH 2/3] arm64: dts: rockchip: add rk3328 display nodes
In-Reply-To: <2909171.GCRVT3W7gj@phil>
References: <20180216223817.2821-1-heiko@sntech.de> <2712253.IuLOJ454Fc@phil>
 <ca7e8c5d-55e3-0dc9-1132-f542cb577693@arm.com>
 <2909171.GCRVT3W7gj@phil>
Message-ID: <51423eea-c127-4922-bd90-5b05bb5aef48@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 21/02/18 21:57, Heiko Stuebner wrote:
[...]
>> I guess it might just be a case of the VOP and/or HDMI clocks struggling
>> to attain an appropriate pixel clock, but the failure mode is really
>> non-obvious - if the monitor is plugged in at boot I get 4 or 5 of the
>> DRM_WARNs at various points, about 160 VOP interrupts somewhere along
>> the line, and HDMI interrupts at a constant rate of around two per
>> second; plugging it in after boot, however, just seems to silently do
>> nothing (IIRC hotplugging the TV similarly did work as expected). If I
>> find the time I might go back and try forcing a 60Hz mode to narrow
>> things down a bit more.
> 
> As I only have a standard 1080p display it's hard to check those edge cases,
> but the struggle for display frequencies follows us for quite some time
> already.
> 
> The current default is to source the display clock from the hdmi-phy
> which contains its own pll, so I guess first order of business should
> probably be to determine which rate gets requested for your display
> and which rate gets set - as I'm guessing that we're missing rates.
> 
> DRM_WARNS would be interesting I guess, can you post them?
> As for your hdmi-interrupts, from the dw-hdmi or the hdmi-phy?

Oops, my mistake, it's just a regular WARN() at 
drivers/gpu/drm/drm_atomic_helper.c:1348 - the IRQs I'm 99% sure were 
from dw-hdmi (I really should stop doing this way past bedtime then 
trying to remember the details days later...)

I'll turn on all the debug options and do some more digging over the 
weekend (and actually save some logs this time!)

Robin.
