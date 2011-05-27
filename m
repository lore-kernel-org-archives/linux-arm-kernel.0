From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 27 May 2011 13:10:18 +0200
Subject: [PATCH 2/3] ARM: mxs: add gpio-mxs platform devices
In-Reply-To: <20110527091158.GD30146@S2100-06.ap.freescale.net>
References: <1305885446-27404-1-git-send-email-shawn.guo@linaro.org>
	<201105201623.40990.arnd@arndb.de>
	<20110527091158.GD30146@S2100-06.ap.freescale.net>
Message-ID: <201105271310.18450.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 27 May 2011, Shawn Guo wrote:
> On Fri, May 20, 2011 at 04:23:40PM +0200, Arnd Bergmann wrote:
> [...]
> > No, this would put all gpio devices below the top-level /sys/devices/platform
> > directory, where they certainly don't belong. Please find a proper
> > place and put them there.
> > 
> To make it clear, which one is the best to have all gpio devices below?
> 
>  * /sys/devices/platform/gpio-mxs
>  * /sys/devices/platform/mxs
>  * /sys/devices/platform/mxs/gpio

I would say the third one is closes to how it should be.

The (sysfs) device tree, like the of device tree, should ideally be
modeled after the high-level block diagram of the machine.

In case of i.MX23, that could look like

/sys/devices/system \
  /ahb
    /apbh
       /gpio0
       /gpio1
       /gpmi
    /usb0
    /apbx
       /i2c
       /uart0
       /pwm
       /spi
          /mmc
          /ethernet
       /usb
       /rtc
       /...


You can argue on whether it makes sense to include the top level, or if you
also want to model the various levels of ahb buses, so there is some freedom
here.

	Arnd
