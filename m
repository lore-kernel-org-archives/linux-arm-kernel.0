From: broonie@kernel.org (Mark Brown)
Date: Fri, 1 Aug 2014 11:38:24 +0100
Subject: [PATCH 2/2] clk: initial clock driver for TWL6030
In-Reply-To: <53DB6633.3020005@kpanic.de>
References: <1406728949-7560-1-git-send-email-sassmann@kpanic.de>
 <1406728949-7560-3-git-send-email-sassmann@kpanic.de>
 <53DA3613.9010305@ti.com> <53DA3C68.3020406@kpanic.de>
 <53DA3D66.1030407@ti.com> <53DA4D37.4030408@kpanic.de>
 <20140731192053.4463.27499@quantum> <53DB6633.3020005@kpanic.de>
Message-ID: <20140801103824.GC17528@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Aug 01, 2014 at 12:04:35PM +0200, Stefan Assmann wrote:

> probe function doesn't even get called without the clock being
> powered/enabled. I've instrumented do_one_initcall() to verify this.
> With the clock being enabled I see:
> [   19.693511] init/main.c do_one_initcall:792 initcall wl1271_init+0x0/0x38 [wlcore_sdio]
> [   20.993347] init/main.c do_one_initcall:792 initcall wl12xx_driver_init+0x0/0x14 [wl12xx]
> If the clock is kept disabled none of the calls is made and we never get
> to wl12xx_probe().
> The device might not be discoverable without the clock.

> Maybe we should rethink the idea of doing that single register write to
> enable the device in twl-core code, if the TWL6030 is present.

> Alternatively this could be done by u-boot. Seems like something that
> should have been done by firmware upfront.

If this is a SDIO device please search the lists for discussion on how
to handle enabling required resources for them - Ulf was working on
something generic for that.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140801/82690b08/attachment.sig>
