From: shawn.guo@linaro.org (Shawn Guo)
Date: Tue, 10 Apr 2012 07:27:25 +0800
Subject: [PATCH 4/7] dt/clock: Add handling for fixed clocks and a clock
 node setup iterator
In-Reply-To: <4F82EFB3.80402@gmail.com>
References: <1331680947-29861-1-git-send-email-robherring2@gmail.com>
 <1331680947-29861-5-git-send-email-robherring2@gmail.com>
 <20120314075930.GF21337@S2101-09.ap.freescale.net>
 <4F81A53B.7020804@gmail.com>
 <20120409084930.GA18692@S2101-09.ap.freescale.net>
 <4F82EFB3.80402@gmail.com>
Message-ID: <20120409232723.GD18692@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Apr 09, 2012 at 09:18:27AM -0500, Rob Herring wrote:
...
> You still haven't given any benefits of supporting multiple clocks. It's
> slightly fewer dts lines, but not really anything else.
> 
What's more important than fewer dts lines is fewer nodes.  Isn't it
the whole point of #clock-cells?  In the real imx example I gave, with
#clock-cells support, I can have only one node to represent 3 fixed
clocks.

...
> I don't think people are going to define clocks generically in DT at the
> mux, clk gate and divider level anyway. If you only have a few clocks
> then you may, and 1 clock output per node is probably okay. If you have
> hundreds of clocks then you probably won't, and will have a SOC specific
> binding anyway.
> 
Why?

Take a look at clk-imx6q.c[1], you will find except pll and pfd, all
the imx6q clocks are represented as gate, divider and mux, and we
should not need a SoC specific binding for them.

-- 
Regards,
Shawn

[1] http://git.pengutronix.de/?p=imx/linux-2.6.git;a=blob;f=arch/arm/mach-imx/clk-imx6q.c;h=d5aaced3496439653238f18a399c466fc7264f4e;hb=1a9cf33bf1df7336b75235ae22fde83c6341c38e
