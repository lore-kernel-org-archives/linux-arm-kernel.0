From: tony@atomide.com (Tony Lindgren)
Date: Wed, 27 Jan 2016 08:47:37 -0800
Subject: [PATCH] ARM: dts: am4372: fix irq type for arm twd and global
 timer
In-Reply-To: <1451310724-29454-1-git-send-email-grygorii.strashko@ti.com>
References: <1451310724-29454-1-git-send-email-grygorii.strashko@ti.com>
Message-ID: <20160127164737.GK19432@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Grygorii Strashko <grygorii.strashko@ti.com> [151228 05:52]:
> As per ARM documentation
> PPI(0) ID27 - global timer interrupt is rising-edge sensitive.
> PPI(2) ID29 - twd interrupt is rising-edge sensitive.
> 
> and the same is proved by GIC distributor register value
> GIC_DIST_CONFIG(0xC04) = 0x7DC00000.
> 
> Hence, set IRQ triggering type to IRQ_TYPE_EDGE_RISING
> for ARM TWD and Global timers.

Applying into omap-for-v4.5/fixes thanks.

Tony
