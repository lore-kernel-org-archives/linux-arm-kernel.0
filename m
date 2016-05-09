From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 09 May 2016 16:41:46 +0200
Subject: [GIT PULL] omap legacy boot vs dt boot fixes for v4.7 merge window
In-Reply-To: <20160504173153.GT5995@atomide.com>
References: <20160504173153.GT5995@atomide.com>
Message-ID: <4944500.vQ12ELNkJC@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 04 May 2016 10:31:53 Tony Lindgren wrote:
> Legacy booting vs device tree booting fixes for omaps for
> v4.7 merge window. These are not considered urgent fixes enough
> for the v4.6-rc cycle, but we need them in v4.7 in order to drop
> the last remaining board-*.c files for omap3 for v4.8 merge window.
> 
> On Nokia N900, we need to pass the MMC slot names for the legacy
> user space to work. Let's do that using auxdata as the driver is
> setting up things already with the pdata for legacy booting. Then
> we can later on discuss if we may want to have some generic binding
> describing where the MMC slots are on the device.
> 
> N900 also has had the ir-rx51 device driver unusable with multiarch
> for a long time. Let's pass the dmtimer data in pdata for the driver
> to get it going again. Then once things are working, we can eventually
> change the driver to use just hrtimer and PWM framework. The driver
> changes will be queued separately.
> 

Good plan, merged it into next/fixes-non-critical, thanks!

	Arnd
