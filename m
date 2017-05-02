From: l.stach@pengutronix.de (Lucas Stach)
Date: Tue, 02 May 2017 16:15:56 +0200
Subject: fsl, imx-parallel-display Question
In-Reply-To: <CAHCN7xLNgy77ocUM04--11vUBsL198+3_g_ur+Yj8jTtj3SNNQ@mail.gmail.com>
References: <CAHCN7xLNgy77ocUM04--11vUBsL198+3_g_ur+Yj8jTtj3SNNQ@mail.gmail.com>
Message-ID: <1493734556.13947.26.camel@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Dienstag, den 02.05.2017, 08:55 -0500 schrieb Adam Ford:
> I am trying to use a parallel LCD with an i.MX6Q board using the
> device tree, but I was hoping to do it in the device tree itself
> instead of modifying the "panel-simple" driver that most imx6q devices
> appear to use.  I have an omap product with the LCD, and I was hoping
> to just re-use the panel timings, etc.
> 
> I found imx6q-tx6q-1010-comtft.dts didn't use "panel-simple", but
> using that as an example doesn't work, for me yet I can get it working
> with "panel-simple"
> 
> Looking at the driver for parallel-display.c, I states that "port at 1"
> is the output port which is consistent with most of the boards that
> use "panel-simple" but imx6q-tx6q-1010-comtft.dts does not have this.
> The other thing I noticed is that "panel-simple" devices have an gpio
> enable which I need, but but imx6q-tx6q-1010-comtft.dts does not have
> this either.
> 
> Is "panel-simple" the only solution, or is there a way to integrate
> the display info into the device tree and keep the enable-gpios stuff?

Please use the panel-simple option. It's the agreed solution to describe
the panels in DT and is the only option that is acceptable if you ever
try to upstream your DT.

>  Is imx6q-tx6q-1010-comtft.dts doing something wrong?

It's using the deprecated way of describing the attached panel, by
putting the timings in the DT. This is not acceptable for new DTs, so
please don't try to replicate this.

Regards,
Lucas
