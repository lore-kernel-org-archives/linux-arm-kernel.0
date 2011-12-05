From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Mon, 5 Dec 2011 09:03:51 +0100
Subject: [PATCH 0/6] arm/imx: kill macro MXC_GPIO_IRQ_START
In-Reply-To: <1323058550-13368-1-git-send-email-shawn.guo@linaro.org>
References: <1323058550-13368-1-git-send-email-shawn.guo@linaro.org>
Message-ID: <20111205080351.GV27267@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Dec 05, 2011 at 12:15:42PM +0800, Shawn Guo wrote:
> Hi Arnd, Sascha,
> 
> The imx gpio interrupt controller is currently broken for DT users.
> I have sent the following two patches to fix them.
> 
>  - arm/imx: fix return type of callback passed to of_irq_init()
>    http://www.spinics.net/lists/arm-kernel/msg149891.html
> 
>  - arm/imx: fix irq_base for gpio
>    http://www.spinics.net/lists/arm-kernel/msg149892.html
> 
> Inspired by the patches/discussion from Stephen Warren and Rob Herring,
> I decided to send this series to fix the problem in a cleaner way,
> which will kill the macro MXC_GPIO_IRQ_START and let the gpio and irq
> numbers be dynamically allocated for both DT and non-DT users, rather
> than the statically defining currently used in non-DT case.
> 
> Please let me know if you would send the series through -rc.  If you
> do, that's great.  If you do not, that's fine, since it touches many
> files and looks more like a cleanup work, and I will send your the
> above quick/temporary fixing for -rc, and then rebase this series on
> top of it and send for v3.3.

As you touch many boards which you can't test I don't think this stuff
is suitable for -rc. Otherwise I'm fine with this series.

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
