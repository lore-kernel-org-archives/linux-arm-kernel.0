From: afzal@ti.com (Mohammed, Afzal)
Date: Wed, 13 Jun 2012 05:20:28 +0000
Subject: [PATCH v5 02/14] ARM: OMAP2+: gpmc: Adapt to HWMOD
In-Reply-To: <4FD77EF1.8000600@ti.com>
References: <cover.1339419492.git.afzal@ti.com>
 <fb739c3c5383806f78cee3666f7c74d61bed6427.1339419492.git.afzal@ti.com>
 <4FD64D6D.3020401@ti.com>
 <C8443D0743D26F4388EA172BF4E2A7A93E997DD6@DBDE01.ent.ti.com>
 <4FD77EF1.8000600@ti.com>
Message-ID: <C8443D0743D26F4388EA172BF4E2A7A93E9987B2@DBDE01.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Jon,

On Tue, Jun 12, 2012 at 23:10:01, Hunter, Jon wrote:
> On 06/12/2012 01:53 AM, Mohammed, Afzal wrote:
> > On Tue, Jun 12, 2012 at 01:26:29, Hunter, Jon wrote:

> >> My preference would be to store gpmc_l3_clk in the pdata and pass to
> >> probe via the pdata. The aim would be to remove the global gpmc_l3_clk
> >> altogether.
> > 
> > For timing calculation by platform outside of driver, we need clk rate
> 
> Right but potentially, this could be done by the driver.

I do not think it is practically possible. Please see timing calculations
in arch/arm/mach-omap2/gpmc-*, the way it is done for different
peripherals are different, and we cannot expect gpmc driver to do those as
that would require gpmc driver being aware of type of peripheral connected.

And all those gpmc-* timing calculation needs to be done before driver
is ready, they rely on functions like gpmc_get_fclk_rate(), which in turn
requires the clk rate to be available before driver is probed.

Regards
Afzal
