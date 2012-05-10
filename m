From: afzal@ti.com (Mohammed, Afzal)
Date: Thu, 10 May 2012 05:17:39 +0000
Subject: [PATCH v4 02/39] ARM: OMAP2+: gpmc: Adapt to HWMOD
In-Reply-To: <4FA9380F.90700@ti.com>
References: <cover.1335874494.git.afzal@ti.com>
 <e0cf9678cb9a44d2a16401383ab8496eb825c291.1335874494.git.afzal@ti.com>
 <4FA04A8C.4050703@ti.com>
 <C8443D0743D26F4388EA172BF4E2A7A93E98299B@DBDE01.ent.ti.com>
 <4FA4041D.9010000@ti.com>
 <C8443D0743D26F4388EA172BF4E2A7A93E987159@DBDE01.ent.ti.com>
 <4FA7F473.7060607@ti.com>
 <C8443D0743D26F4388EA172BF4E2A7A93E987902@DBDE01.ent.ti.com>
 <4FA9380F.90700@ti.com>
Message-ID: <C8443D0743D26F4388EA172BF4E2A7A93E98A2AA@DBDE01.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Jon,

On Tue, May 08, 2012 at 20:43:19, Hunter, Jon wrote:

> >> In fact if you migrate to runtime pm then we should not have the clk_get
> >> in the gpmc_init any more.
> > 
> > Even if converted to RPM, to get clk rate, clk_get has to be done
> > somewhere, right ?
> 
> Yes exactly. However, you could now do this in the driver itself like
> the probe function. Or may be just pass the frequency of the gpmc fclk
> to the driver and let the driver convert to the period. No reason we
> need to convert to the period outside of the driver. Hence, we can keep
> the function to do the conversion static in the driver and don't need to
> expose externally.

But platform need period before driver is probed (for calculating
peripheral timings to be passed for driver)

Regards
Afzal
