From: tony@atomide.com (Tony Lindgren)
Date: Wed, 11 Jul 2018 06:24:31 -0700
Subject: [PATCH V2] ARM: DRA7/OMAP5: Enable ACTLR[0] (Enable invalidates
 of BTB) for secondary cores
In-Reply-To: <20180710194725.20339-1-nm@ti.com>
References: <20180710194725.20339-1-nm@ti.com>
Message-ID: <20180711132431.GK99251@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Nishanth Menon <nm@ti.com> [180710 12:50]:
> Call secure services to enable ACTLR[0] (Enable invalidates of BTB with
> ICIALLU) when branch hardening is enabled for kernel.
> 
> On GP devices OMAP5/DRA7, there is no possibility to update secure
> side since "secure world" is ROM and there are no override mechanisms
> possible. On HS devices, appropriate PPA should do the workarounds as
> well.
> 
> However, the configuration is only done for secondary core, since it is
> expected that firmware/bootloader will have enabled the required
> configuration for the primary boot core (note: bootloaders typically
> will NOT enable secondary processors, since it has no need to do so).

Thanks for updating this. Seems like we should merge this into v4.18-rc
cycle as without this the already merged fixes are incomplete.
So if no objections, I'm planning to apply this tomorrow.

Regards,

Tony
