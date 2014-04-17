From: santosh.shilimkar@ti.com (Santosh Shilimkar)
Date: Thu, 17 Apr 2014 16:57:37 -0400
Subject: [PATCH V2 00/19] bus: omap_l3_noc: driver cleanups and support
 for DRA7/AM4372
In-Reply-To: <1397767775-10965-1-git-send-email-nm@ti.com>
References: <1397492726-17203-1-git-send-email-nm@ti.com>
 <1397767775-10965-1-git-send-email-nm@ti.com>
Message-ID: <53504041.7090906@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Nishant,

On Thursday 17 April 2014 04:49 PM, Nishanth Menon wrote:
> The following V2 of the series is based on v3.15-rc1 + peter's patch series:
> 	patch #1: https://patchwork.kernel.org/patch/3923141/
> 	(drivers: bus: omap_l3: Convert to use devm_kzalloc)
> 
> 	patch #2: https://patchwork.kernel.org/patch/3923061/
> 	(drivers: bus: omap_l3: Convert to use devm_ioremap_resource() )
> 
> 	patch #3: https://patchwork.kernel.org/patch/3923101/
> 	(drivers: bus: omap_l3: Convert to use devm_request_irq())
> 
> 	patch #4: https://patchwork.kernel.org/patch/3923081/
> 	(drivers: bus: omap_l3: Remove the platform driver's remove function)
> 
> 	patch #5: https://patchwork.kernel.org/patch/3923121/
> 	(drivers: bus: omap_l3: Change pr_crit() to dev_err() when IRQ request
> 	fails)
> 
> V1 was originally posted here: http://marc.info/?l=linux-omap&m=139749383932575&w=2
> 
> V2 introduces the following changes:
> 	- Additional bug fix detected during additional testing (all tests complete now). patch #12
> 	- reordering of patches to order logical changes and reduce code churn.
> 	- interrupt handler split up and additional information now provided in log to aid debug when error occur
> 	- patches are marked where new (12,14,15,16).
> 	- DRA7 updated from master document for all DRA7 variants.
> 
> This series cleansup omap_l3_noc driver and adds data to support DRA7
> and AM437x SoCs.
> 
I looked at the series and its looks pretty good. Thanks for fixups, updates.
For whole series,
Acked-by: Santosh Shilimkar <santosh.shilimkar@ti.com>

> Patches(including Peter's) is available here:
> https://github.com/nmenon/linux-2.6-playground/commits/l3noc/driver-fixes-v2
> 
Can Tony pull this branch for 3.16 then which includes Peter's series as well ?

Tony, Will you be able to line these up via arm-soc tree ?

Regards,
Santosh
