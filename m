From: jon-hunter@ti.com (Jon Hunter)
Date: Thu, 7 Jun 2012 18:36:06 -0500
Subject: [PATCH V2 00/10] ARM: OMAP4: Add PMU Support
In-Reply-To: <1339104132-26885-1-git-send-email-jon-hunter@ti.com>
References: <1339104132-26885-1-git-send-email-jon-hunter@ti.com>
Message-ID: <4FD13AE6.6070206@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


On 06/07/2012 04:22 PM, Jon Hunter wrote:
> This series adds PMU support for OMAP4 devices. This is based upon Will Deacons
> series [1]. This series fixes the management of the EMU power domain so that
> PMU can be enabled at runtime and low-power states are not prevented when PMU
> is not in-use. The fix is based upon inputs from Benoit, Paul and Kevin [2].
> 
> This series also converts OMAP2/3 devices to use HWMOD to create the PMU device
> and add a new file to mach-omap2 directory called pmu.c where the PMU devices
> are created.
> 
> This series is based upon the latest linux-omap master branch from Tony
> (3.5-rc1).
> 
> Testing:
> - Verified that PMU is working on OMAP3430 Beagle Board, OMAP4430 Blaze and
>   4460 Panda.
> - Tested on the above boards with CPU-idle enabled to ensure that PMU is working
>   with power management. For OMAP4 boards I have disabled CPU1 so that CPU0 and
>   hence the MPU power domain is reaching the low-power retention state.
> - I have booted the kernel on an OMAP2430 SDP but not verified PMU is working.
> - Unable to verify 4470 Blaze because kernel is not currently booting.

Update on the 4470 status. Now I have 4470 booting [1], I have now
verified that PMU on 4470 is also working with this series (and with
CPU-idle enabled).

Cheers
Jon

[1] http://marc.info/?l=linux-omap&m=133911023112941&w=2
