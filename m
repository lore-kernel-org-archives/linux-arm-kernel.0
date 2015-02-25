From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 25 Feb 2015 16:44:15 +0100
Subject: [PATCH] ASoC: omap: fix up SND_OMAP_SOC_OMAP_ABE_TWL6040
 dependency
In-Reply-To: <54EDEAE3.6080605@ti.com>
References: <22890811.0MuvZ4MxOU@wuerfel> <54EDEAE3.6080605@ti.com>
Message-ID: <2482424.WOd0SW5Oav@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 25 February 2015 17:31:47 Peter Ujfalusi wrote:
> Would it be better to have this changed to:
>         select COMMON_CLK_PALMAS if MFD_PALMAS
> instead of removing.
> 
> All OMAP5 boards uses Palmas as PMIC and the boards where twl6040 audio is in
> use the 32K clock for the codec is coming from Palmas.
> Without this clock the twl6040 will not boot up causing errors during probe time.

It's possible to build a kernel with omap5 support and this driver but
no palmas support, which makes the dependency it a bit strange, but I'll
let Mark decide.

Unfortunately, I've sent the changed v2 patch without fixing up the commit
message. Instead of sending another v3 right away, I'll wait for Mark
to comment.

	Arnd
