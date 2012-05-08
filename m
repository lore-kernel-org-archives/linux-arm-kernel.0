From: afzal@ti.com (Mohammed, Afzal)
Date: Tue, 8 May 2012 06:24:16 +0000
Subject: [PATCH v4 02/39] ARM: OMAP2+: gpmc: Adapt to HWMOD
In-Reply-To: <4FA7F473.7060607@ti.com>
References: <cover.1335874494.git.afzal@ti.com>
 <e0cf9678cb9a44d2a16401383ab8496eb825c291.1335874494.git.afzal@ti.com>
 <4FA04A8C.4050703@ti.com>
 <C8443D0743D26F4388EA172BF4E2A7A93E98299B@DBDE01.ent.ti.com>
 <4FA4041D.9010000@ti.com>
 <C8443D0743D26F4388EA172BF4E2A7A93E987159@DBDE01.ent.ti.com>
 <4FA7F473.7060607@ti.com>
Message-ID: <C8443D0743D26F4388EA172BF4E2A7A93E987902@DBDE01.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Jon,

On Mon, May 07, 2012 at 21:42:35, Hunter, Jon wrote:

> > Clk_prd is a platform data passed to the driver, so platform code
> > updates it, where else can it be done ?
> 
> The point is that you can pass what ever you like. You do not need to
> pass the frequency you can pass the clock handle instead.

As clk rate is required in platform code for timing calculation, and
already available, period was passed

> 
> What happens it the clk_get() of the gpmc_l3_clk fails during the init?

Thanks for bringing this point, invalid clk_prd has to be handled by driver.

> 
> In fact if you migrate to runtime pm then we should not have the clk_get
> in the gpmc_init any more.

Even if converted to RPM, to get clk rate, clk_get has to be done
somewhere, right ?

Regards
Afzal
