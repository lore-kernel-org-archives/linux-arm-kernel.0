From: benh@kernel.crashing.org (Benjamin Herrenschmidt)
Date: Fri, 19 Oct 2018 10:32:24 +1100
Subject: [[PATCH] 8/9] DMA-UART-Driver-for-AST2500
In-Reply-To: <20181018095507.GC2400@vkoul-mobl>
References: <1539749466-3912-1-git-send-email-open.sudheer@gmail.com>
 <1539749466-3912-9-git-send-email-open.sudheer@gmail.com>
 <20181017060531.GU2400@vkoul-mobl>
 <351eecd5b1b21893e94f76b34c058c6257b7f837.camel@kernel.crashing.org>
 <20181018095507.GC2400@vkoul-mobl>
Message-ID: <a3fecf7913d6a85a6294afbc5a1a18b7714d6756.camel@kernel.crashing.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 2018-10-18 at 15:25 +0530, Vinod wrote:
> 
> > It's not a dmaengine driver. It's a serial UART driver that happens to
> > use a dedicated DMA engine.
> 
> Then I see no reason for it to use dmaengine APIs. The framework allows
> people to share a controller for many clients, but if you have dedicated
> one then you may use it directly

Well... the engine is shared by a few UARTs, they have dedicated rings
but there's a common set of regs for interrupt handling etc.

That said, I still think it could be contained within a UART driver,
there's little benefit in adding the framework overhead, esp since
these are really weak cores, any overhead will be felt.

Ben.

> > It's unclear whether it should be split into two drivers, or just have
> > the serial driver directly use the dma engine since that engine is
> > dedicated in HW to only work on those UARTs and nothing else...
> > 
> > Cheers,
> > Ben.
> > 
> > 
> > > While doing resubmission please take some time to understand subsystem
> > > tags to use. (hint git log <subsystem> will tell you)
> > > 
> > > Also series has [[PATCH] 8/9] whereas it should be [PATCH 8/9] please
> > > let git generate that for you (hint git format-patch start..end does a
> > > good job)
> > > 
> > > > @@ -0,0 +1,1594 @@
> > > > +// SPDX-License-Identifier: GPL-2.0
> > > > +/*
> > > > + *   drivers/tty/serial/8250/8250_aspeed_uart_dma.c
> > > > + *    1. 2018/07/01 Shivah Shankar created
> > > > + *    2. 2018/08/25 sudheer.veliseti<open.sudheer@gmail.com> modified
> > > 
> > > we dont use this log in kernel. I do not see s-o-b by Shivah, that
> > > should be added. I think he should be author and you need to list
> > > changes you did..
> > > 
> 
> 
