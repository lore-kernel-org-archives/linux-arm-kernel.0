From: vkoul@kernel.org (Vinod)
Date: Thu, 18 Oct 2018 15:25:07 +0530
Subject: [[PATCH] 8/9] DMA-UART-Driver-for-AST2500
In-Reply-To: <351eecd5b1b21893e94f76b34c058c6257b7f837.camel@kernel.crashing.org>
References: <1539749466-3912-1-git-send-email-open.sudheer@gmail.com>
 <1539749466-3912-9-git-send-email-open.sudheer@gmail.com>
 <20181017060531.GU2400@vkoul-mobl>
 <351eecd5b1b21893e94f76b34c058c6257b7f837.camel@kernel.crashing.org>
Message-ID: <20181018095507.GC2400@vkoul-mobl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 17-10-18, 19:56, Benjamin Herrenschmidt wrote:
> On Wed, 2018-10-17 at 11:35 +0530, Vinod wrote:
> > On 17-10-18, 09:41, sudheer.v wrote:
> > 
> > Please add the change log describing the driver and its features
> > 
> > > Signed-off-by: sudheer.v <open.sudheer@gmail.com>
> > > ---
> > >  drivers/tty/serial/8250/8250_aspeed_uart_dma.c | 1594 ++++++++++++++++++++++++
> > >  1 file changed, 1594 insertions(+)
> > >  create mode 100644 drivers/tty/serial/8250/8250_aspeed_uart_dma.c
> > > 
> > > diff --git a/drivers/tty/serial/8250/8250_aspeed_uart_dma.c b/drivers/tty/serial/8250/8250_aspeed_uart_dma.c
> > > new file mode 100644
> > > index 0000000..e1019a8
> > > --- /dev/null
> > > +++ b/drivers/tty/serial/8250/8250_aspeed_uart_dma.c
> > 
> > why is this in serial. It is dmaengine driver so belongs to drivers/dma/
> > like other controllers. Please move it out and resubmit.
>  
> It's not a dmaengine driver. It's a serial UART driver that happens to
> use a dedicated DMA engine.

Then I see no reason for it to use dmaengine APIs. The framework allows
people to share a controller for many clients, but if you have dedicated
one then you may use it directly

> It's unclear whether it should be split into two drivers, or just have
> the serial driver directly use the dma engine since that engine is
> dedicated in HW to only work on those UARTs and nothing else...
> 
> Cheers,
> Ben.
> 
> 
> > While doing resubmission please take some time to understand subsystem
> > tags to use. (hint git log <subsystem> will tell you)
> > 
> > Also series has [[PATCH] 8/9] whereas it should be [PATCH 8/9] please
> > let git generate that for you (hint git format-patch start..end does a
> > good job)
> > 
> > > @@ -0,0 +1,1594 @@
> > > +// SPDX-License-Identifier: GPL-2.0
> > > +/*
> > > + *   drivers/tty/serial/8250/8250_aspeed_uart_dma.c
> > > + *    1. 2018/07/01 Shivah Shankar created
> > > + *    2. 2018/08/25 sudheer.veliseti<open.sudheer@gmail.com> modified
> > 
> > we dont use this log in kernel. I do not see s-o-b by Shivah, that
> > should be added. I think he should be author and you need to list
> > changes you did..
> > 

-- 
~Vinod
