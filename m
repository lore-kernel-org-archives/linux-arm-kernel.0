From: joerg.krause@embedded.rocks (=?ISO-8859-1?Q?J=F6rg?= Krause)
Date: Sun, 20 Nov 2016 15:42:09 +0100
Subject: mmc: core: complete/wait_for_completion performance
In-Reply-To: <585759233.283839.1cb53b4d-2805-48ea-aef1-dd282306d108.open-xchange@email.1und1.de>
References: <1479644869.2653.3.camel@embedded.rocks>
 <585759233.283839.1cb53b4d-2805-48ea-aef1-dd282306d108.open-xchange@email.1und1.de>
Message-ID: <1479652929.2841.1.camel@embedded.rocks>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Stefan,

On Sun, 2016-11-20 at 14:28 +0100, Stefan Wahren wrote:
> Hi J?rg,
> 
> > J?rg Krause <joerg.krause@embedded.rocks> hat am 20. November 2016
> > um 13:27
> > geschrieben:
> > 
> > 
> > Hi,
> > 
> > I started the discussion on this mailing list in another thread
> > [1],
> > but I'd like to move it to a new thread, because it might be mmc
> > specific.
> > 
> > The issue is that I am noticed low wifi network throughput on an
> > i.MX28
> > board with the mainline kernel (v4.7.10, about 6 Mbps) compared to
> > the
> > vendor kernel (Freescale v2.6.35.3, about 20 Mbps). The wifi chip
> > is
> > attached using the SDIO interface.
> > 
> > I started investigation where the bottleneck in the mainline
> > kernel?might come from. Therefore I checked that the configs and
> > settings for the interfaces and drivers are the same. They are.
> 
> so you're not using the mxs_defconfig settings anymore?

No, I changed the settings.

> Better provide your settings because there are differences between
> the vendor defconfig and mainline defconfig.

The configs I have for the vendor and mainline kernel are pretty much
the same for the parts you showed as an example:

Vendor kernel config:

CONFIG_TICK_ONESHOT=y
CONFIG_NO_HZ=y
CONFIG_HIGH_RES_TIMERS=y
CONFIG_PREEMPT=y
CONFIG_HZ=100
CONFIG_DEFAULT_IOSCHED="cfq"

Mainline kernel config:

CONFIG_TICK_ONESHOT=y
CONFIG_NO_HZ_COMMON=y
CONFIG_NO_HZ_IDLE=y
CONFIG_HIGH_RES_TIMERS=y
CONFIG_PREEMPT=y
CONFIG_HZ=100
CONFIG_DEFAULT_IOSCHED="cfq"

J?rg
