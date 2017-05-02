From: LW@KARO-electronics.de (Lothar =?UTF-8?B?V2HDn21hbm4=?=)
Date: Tue, 2 May 2017 16:15:53 +0200
Subject: fsl, imx-parallel-display Question
In-Reply-To: <CAHCN7xLNgy77ocUM04--11vUBsL198+3_g_ur+Yj8jTtj3SNNQ@mail.gmail.com>
References: <CAHCN7xLNgy77ocUM04--11vUBsL198+3_g_ur+Yj8jTtj3SNNQ@mail.gmail.com>
Message-ID: <20170502161553.2af9a1be@ipc1.ka-ro>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Tue, 2 May 2017 08:55:20 -0500 Adam Ford wrote:
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
>  Is imx6q-tx6q-1010-comtft.dts doing something wrong?
> 
You can specify the display timings in the 'display-timings' subnode of
the display at di0 node. The active timing can be selected by setting the
'native-mode' property appropriately.


Lothar Wa?mann
