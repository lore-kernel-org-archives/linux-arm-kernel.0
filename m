From: paul@pwsan.com (Paul Walmsley)
Date: Thu, 17 Jan 2013 18:51:08 +0000 (UTC)
Subject: [PATCH] ARM: OMAP2: Fix missing omap2xxx_clkt_vps_xxx function
 calls
In-Reply-To: <1357851209-5332-1-git-send-email-jon-hunter@ti.com>
References: <1357851209-5332-1-git-send-email-jon-hunter@ti.com>
Message-ID: <alpine.DEB.2.00.1301171848490.14118@utopia.booyaka.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Jon

On Thu, 10 Jan 2013, Jon Hunter wrote:

> During the migration to the common clock framework, calls to the
> functions omap2xxx_clkt_vps_late_init() and
> omap2xxx_clkt_vps_check_bootloader_rates() were not preserved for
> OMAP2420 and OMAP2430. This causes the variables "sys_ck_rate" and
> "curr_prcm_set" to be uninitialised on boot. On reboot, this causes the
> following error message to be displayed because the appropriate MPU
> clock frequency (derived from sys_ck_rate) cannot be found.
> 
> "Could not set MPU rate to 4294MHz"

I don't see this message on 2430sdp or n800 with v3.8-rc3, but maybe 
that's due to sys_clk differences.  Do you still see this on v3.8-rc3 
with H4?

Also, there's already a call to omap2xxx_clkt_vps_check_bootloader_rates() 
-- is it necessary to add another one?

	
- Paul
