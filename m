From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Wed, 6 Mar 2013 20:07:38 +0100
Subject: [PATCH 1/3] arm: kirkwood: affect pins to their devices on
 OpenBlocks A6
In-Reply-To: <20130306182131.GF3904@lunn.ch>
References: <1362587021-32762-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1362587021-32762-2-git-send-email-thomas.petazzoni@free-electrons.com>
 <20130306182131.GF3904@lunn.ch>
Message-ID: <20130306200738.6d41b16e@skate>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Andrew Lunn,

On Wed, 6 Mar 2013 19:21:31 +0100, Andrew Lunn wrote:

> Being able to add pinctrl nodes to the device is new. I think it was
> added in 3.8. Before then each device driver had to explicitly request
> its pins and most didn't, so hogs was the way to do it.

A number of drivers were already capable of doing this, like gpio-leds
for example. But as you say, in 3.9 a patch making this globally
available to all drivers without having to modify them has been merged,
and that's what I rely on.

> Now the core
> driver code gets the pins. So i would not say it is odd, just
> outdated. It would be nice to change the comment to reflect this.

Ok, I'll fix that up.

> > Therefore, this patch moves the selection of pin muxing of the
> > relevant pins to the UART nodes, the I2C node, the NAND node and the
> > gpio-leds node.
> 
> For gpio-leds, see the comment i just made for the next patch.
> 
> Otherwise this look O.K.

Thanks.

Thomas
-- 
Thomas Petazzoni, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
