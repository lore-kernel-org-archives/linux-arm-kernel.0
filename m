From: andriy.shevchenko@linux.intel.com (Andy Shevchenko)
Date: Wed, 02 Aug 2017 21:02:15 +0300
Subject: [PATCH 0/2] serial: 8250: add support for MediaTek BTIF controller
In-Reply-To: <1501695470.25246.7.camel@mtkswgap22>
References: <cover.1501692369.git.sean.wang@mediatek.com>
 <1501694063.29303.361.camel@linux.intel.com>
 <1501695470.25246.7.camel@mtkswgap22>
Message-ID: <1501696935.29303.367.camel@linux.intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 2017-08-03 at 01:37 +0800, Sean Wang wrote:
> On Wed, 2017-08-02 at 20:14 +0300, Andy Shevchenko wrote:
> > On Thu, 2017-08-03 at 01:05 +0800, sean.wang at mediatek.com wrote:
> > > From: Sean Wang <sean.wang@mediatek.com>
> > > 
> > > This patchset introduces the support for MediaTek BTIF controller.
> > > 
> > > MediaTek BTIF controller is the serial interface similar to UART
> > > but
> > > it
> > > works only as the digital device which is mainly used to
> > > communicate
> > > with
> > > the connectivity module also called CONNSYS inside the SoC which
> > > could
> > > be
> > > mostly found on those MediaTek SoCs with Bluetooth feature.
> > > 
> > > And the controller is made as being compatible with the 8250
> > > register
> > > layout so it tends to be integrated with existing 8250 core driver
> > > and
> > > have no requirement for the modem configuration additionally such
> > > as
> > > the
> > > baud rate calculation and assignment.

+Cc: Arnd.

> > Why it requires a separate driver?
> > 
> > 8250_of is for DT enabled drivers.
> > 
> 
> Hi, Andy
> 
> thanks for your information
> 
> the hardware is not completely identical to 8250 device,?
> it has extra registers belonged to platform control such as internal
> loopback, dma disable/enable, sleep/wakeup setup and so on, so I
> create
> it as a separate driver.

Over all 200+ LOCs I didn't see any of the above except loopback, which
is one property that can be easily added to 8250_of.c.

Moreover, if you have more code coming I would suggest you to split
8250_of to library and driver parts and re-use stuff from there.

Arnd, what is your opinion about new 8250 OF based drivers?

-- 
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
