From: tomi.valkeinen@ti.com (Tomi Valkeinen)
Date: Thu, 24 May 2018 09:25:50 +0300
Subject: v4.17-rc1: regressions on N900, N950
In-Reply-To: <20180523220254.GD2299@darkstar.musicnaut.iki.fi>
References: <20180422074213.GA12428@amd>
 <20180423202940.ig6iud5lrbgnu35a@darkstar.musicnaut.iki.fi>
 <20180521213952.GA11596@amd> <20180522080250.4fzyvqrgw5oigexn@pali>
 <20180522194139.GB2299@darkstar.musicnaut.iki.fi>
 <20180522205824.GA24927@amd>
 <20180522215638.GC2299@darkstar.musicnaut.iki.fi>
 <20180523220254.GD2299@darkstar.musicnaut.iki.fi>
Message-ID: <39a1e3a3-b9ca-3aa9-eed1-7ac5ee580c8f@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 24/05/18 01:02, Aaro Koskinen wrote:

> But turns out that omapdrm tree is unbisectable, as I get build failures such
> as (commit 28d79f3e56b2c1d5ff0fd363da3229be0962cc85):
> 
> /home/aaro/git/devel/linux/drivers/gpu/drm/omapdrm/dss/dss.c:1473:52: error: undefined identifier 'dss_debug_dump_clocks'
> /home/aaro/git/devel/linux/drivers/gpu/drm/omapdrm/dss/dss.c:1472:51: warning: callwith no type!

This goes away if you enable CONFIG_OMAP2_DSS_DEBUGFS.

> In file included from /home/aaro/git/devel/linux/drivers/gpu/drm/omapdrm/dss/core.c:28:0:
> /home/aaro/git/devel/linux/drivers/gpu/drm/omapdrm/dss/dss.h:395:25: error: conflicting types for 'port'
>       struct device_node *port,
>                           ^~~~

And this goes away if you enable CONFIG_OMAP2_DSS_DPI.

Sorry about those.

  Tomi

-- 
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki. 
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
