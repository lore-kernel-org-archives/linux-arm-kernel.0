From: paul@pwsan.com (Paul Walmsley)
Date: Thu, 18 Oct 2012 14:41:56 +0000 (UTC)
Subject: [PATCH] ARM: OMAP2+: clockdomain: Fix OMAP4 ISS clk domain to
 support only SWSUP
In-Reply-To: <50800679.2030202@ti.com>
References: <50800679.2030202@ti.com>
Message-ID: <alpine.DEB.2.00.1210181441020.8746@utopia.booyaka.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 18 Oct 2012, Benoit Cousson wrote:

> From: Miguel Vadillo <vadillo@ti.com>
> 
> Since CAM domain (ISS) has no module wake-up dependency
> with any other clock domain of the device and the dynamic
> dependency from L3_main_2 is always disabled, the domain
> needs to be in force wakeup in order to be able to access
> it for configure (sysconfig) it or use it.
> 
> Also since there is no clock in the domain managed automatically
> by the hardware, there is no use to configure automatic
> clock domain transition. SW should keep the SW_WKUP domain
> transition as long as a module in the domain is required to
> be functional.
> 
> Signed-off-by: Miguel Vadillo <vadillo@ti.com>
> Signed-off-by: Benoit Cousson <b-cousson@ti.com>

Thanks queued for 3.7-rc.


- Paul
