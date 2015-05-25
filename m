From: shawn.guo@linaro.org (Shawn Guo)
Date: Mon, 25 May 2015 13:19:41 +0800
Subject: [PATCH v2 12/12] ARM: imx: move timer driver into
 drivers/clocksource
In-Reply-To: <BL2PR03MB3702177604C473A9473AAC183C00@BL2PR03MB370.namprd03.prod.outlook.com>
References: <1432308599-28643-1-git-send-email-shawn.guo@linaro.org>
 <1432308599-28643-13-git-send-email-shawn.guo@linaro.org>
 <BL2PR03MB3702177604C473A9473AAC183C00@BL2PR03MB370.namprd03.prod.outlook.com>
Message-ID: <20150525051940.GB3264@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 22, 2015 at 06:28:59PM +0000, Shenwei Wang wrote:
> > @@ -52,3 +52,4 @@ obj-$(CONFIG_ARCH_INTEGRATOR_AP)	+=
> > timer-integrator-ap.o
> >  obj-$(CONFIG_CLKSRC_VERSATILE)		+= versatile.o
> >  obj-$(CONFIG_CLKSRC_MIPS_GIC)		+= mips-gic-timer.o
> >  obj-$(CONFIG_ASM9260_TIMER)		+= asm9260_timer.o
> > +obj-$(CONFIG_ARCH_MXC)			+= timer-imx.o
> 
> Because there are several types of timers on imx family socs, and this is the driver for the GPT block only, so it would be better to change the file name to timer-gpt.c
> 

Okay, I decided to name it timer-imx-gpt.c, so that when people try to
find the timer driver for i.MX in drivers/clocksource folder, it will be
easier.

Shawn
