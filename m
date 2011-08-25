From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 25 Aug 2011 13:58:12 +0200
Subject: [PATCH 1/4 v4] drivers: create a pin control subsystem
In-Reply-To: <20110825110451.GU31404@pengutronix.de>
References: <1313747630-32258-1-git-send-email-linus.walleij@stericsson.com>
	<74CDBE0F657A3D45AFBB94109FB122FF04B24A3BC0@HQMAIL01.nvidia.com>
	<CACRpkdaZfG4hiGf8vug3EGMRMc0c92xbj=L_HAQcS27DAXYc4Q@mail.gmail.com>
	<20110825110451.GU31404@pengutronix.de>
Message-ID: <CACRpkdbV_Hgj=x5J3wYCtPcnZ++xMCqY91J2_i75c0G8OtYk5A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 25, 2011 at 1:04 PM, Sascha Hauer <s.hauer@pengutronix.de> wrote:

> Not really. UART2_CTS can't be routed to arbitrary pads, but it can be
> routed to more than one pad:
>
> #define _MX51_PAD_EIM_D16__UART2_CTS ? ? ? ? ? ?IOMUX_PAD(0x3f0, 0x5c, 3, 0x0000, 0, 0)
> #define _MX51_PAD_EIM_D25__UART2_CTS ? ? ? ? ? ?IOMUX_PAD(0x414, 0x80, 4, 0x0000, 0, 0)
> #define _MX51_PAD_USBH1_DATA0__UART2_CTS ? ? ? ?IOMUX_PAD(0x688, 0x288, 1, 0x0000, 0, 0)

Aha!

Is it typically a few pads like this, say 2,3,4 alternatives,
sometimes just one?

So the actual relation is not 1..1 nor 1...* but 1..<a few>?

> This is why there can't be a setup_iomux(uart2) function without
> being able to specify *which* pads in a board specific way.

In the current design it is the pinmux driver that
keeps track of that. Not the subsystem.

I think the question then is how the pinctrl subsystem
can help out in keeping that information together.

I'll try to think of something ...

Thanks,
Linus Walleij
