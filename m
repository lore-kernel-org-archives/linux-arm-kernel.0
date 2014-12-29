From: aaro.koskinen@iki.fi (Aaro Koskinen)
Date: Mon, 29 Dec 2014 20:02:52 +0200
Subject: v3.19-rc1 regression(?) on N900
In-Reply-To: <54A10B1E.7030800@ti.com>
References: <549B44E2.6080202@ti.com> <201412250932.40403@pali>
 <20141225091121.GA20355@amd>
 <20141225222122.GB582@fuloong-minipc.musicnaut.iki.fi>
 <54A10B1E.7030800@ti.com>
Message-ID: <20141229180252.GE582@fuloong-minipc.musicnaut.iki.fi>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Mon, Dec 29, 2014 at 10:04:46AM +0200, Tomi Valkeinen wrote:
> On 26/12/14 00:21, Aaro Koskinen wrote:
> 
> > ...however, I can confirm that framebuffer is broken:
> > 
> > [    8.230743] omapfb omapfb: no displays
> > [    8.255584] omapfb omapfb: failed to setup omapfb
> > [    8.260620] platform omapfb: Driver omapfb requests probe deferral
> > [    8.284118] of_get_named_gpiod_flags: parsed 'reset-gpios' property of node
> > '/ocp/spi at 48098000/acx565akm at 2[0]' - status (0)
> > [    8.284271] acx565akm spi1.2: failed to find video source
> > [    8.290069] spi spi1.2: Driver acx565akm requests probe deferral
> > 
> > I bisected it to ef691ff48bc8 (OMAPDSS: DT: Get source endpoint
> > by matching reg-id). When I revert that, also FB works with 3.19-rc1.
> 
> I've attached a patch for this. Only hack-tested on OMAP3 beagle, so
> please report if it works.

That works, thanks.

A.
