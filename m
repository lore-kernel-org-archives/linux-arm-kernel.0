From: afzal@ti.com (Mohammed, Afzal)
Date: Tue, 27 Mar 2012 05:19:32 +0000
Subject: [TMP][PATCH 5/5] OMAP3EVM: Test gpmc-nand
In-Reply-To: <4F70ACB6.5070208@ti.com>
References: <1332484630-22181-1-git-send-email-afzal@ti.com>
 <4F70ACB6.5070208@ti.com>
Message-ID: <C8443D0743D26F4388EA172BF4E2A7A9317BD700@DBDE01.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Jon,

On Mon, Mar 26, 2012 at 23:21:50, Hunter, Jon wrote:
> I see this is marked as a temp patch, but this is actually needed to 
> register the device. Actually, we would need to do this for all boards, 
> right?

Yes, as NAND support on OMAP3EVM was not in mainline, made it TMP.
Once GPMC driver interfaces are acceptable, other boards too will
be modified accordingly.

> Rather than registering the device here, may be we should add a function 
> in arch/arm/mach-omap2/devices.c called "omap_gpmc_init()" that is 
> called from all of the boards files passing the pdata structure. Then 
> the omap_gmpc_init() function should use omap_device_build() API to 
> register the device. If you look at arch/arm/mach-omap2/devices.c you 
> can look at omap4_keyboard_init() as an example. Let me know if this is 
> clear.

Yes that is the final plan, i.e. once driver is ok, it has to be adapted
to HWMOD, and this will be taken care.

Regards
Afzal
