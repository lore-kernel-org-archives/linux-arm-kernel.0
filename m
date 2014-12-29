From: tomi.valkeinen@ti.com (Tomi Valkeinen)
Date: Mon, 29 Dec 2014 10:04:46 +0200
Subject: v3.19-rc1 regression(?) on N900
In-Reply-To: <20141225222122.GB582@fuloong-minipc.musicnaut.iki.fi>
References: <549B44E2.6080202@ti.com> <201412250932.40403@pali>
 <20141225091121.GA20355@amd>
 <20141225222122.GB582@fuloong-minipc.musicnaut.iki.fi>
Message-ID: <54A10B1E.7030800@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 26/12/14 00:21, Aaro Koskinen wrote:

> ...however, I can confirm that framebuffer is broken:
> 
> [    8.230743] omapfb omapfb: no displays
> [    8.255584] omapfb omapfb: failed to setup omapfb
> [    8.260620] platform omapfb: Driver omapfb requests probe deferral
> [    8.284118] of_get_named_gpiod_flags: parsed 'reset-gpios' property of node
> '/ocp/spi at 48098000/acx565akm at 2[0]' - status (0)
> [    8.284271] acx565akm spi1.2: failed to find video source
> [    8.290069] spi spi1.2: Driver acx565akm requests probe deferral
> 
> I bisected it to ef691ff48bc8 (OMAPDSS: DT: Get source endpoint
> by matching reg-id). When I revert that, also FB works with 3.19-rc1.

I've attached a patch for this. Only hack-tested on OMAP3 beagle, so
please report if it works.

 Tomi

-------------- next part --------------
A non-text attachment was scrubbed...
Name: 0001-OMAPDSS-SDI-fix-output-port_num.patch
Type: text/x-patch
Size: 1355 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20141229/5bc95826/attachment.bin>
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20141229/5bc95826/attachment.sig>
