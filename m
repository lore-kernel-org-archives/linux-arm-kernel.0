From: stephen.boyd@linaro.org (Stephen Boyd)
Date: Tue, 28 Jun 2016 15:24:36 -0700
Subject: [PATCH] usb: misc: Add driver for usb4604
In-Reply-To: <20160628205637.GO3737@rob-hp-laptop>
References: <20160626052454.7743-1-stephen.boyd@linaro.org>
 <20160628205637.GO3737@rob-hp-laptop>
Message-ID: <146715267666.31418.16063659578272167797@sboyd-linaro>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Quoting Rob Herring (2016-06-28 13:56:37)
> On Sat, Jun 25, 2016 at 10:24:54PM -0700, Stephen Boyd wrote:
> > +
> > +Examples:
> > +     usb-hub at 2d {
> 
> I'm not sure what we'll do when/if we need this as a USB bus child node.
> 
 
I'll need to do something there soon. Right now, I have to probe this
device driver first before probing the HSIC controller, or this hub
never enumerates itself on the USB bus (when it does enumerate I see two
devices on the hub itself). I was thinking of holding some phandle in
the HSIC controller node to this i2c device and then probe deferring at
usb_add_hcd() until this device had probed. That solution still doesn't
feel great though because we really need to express that the hub needs
to be in "HUB" mode instead of just probed. Dual bus devices are a real
pain!
