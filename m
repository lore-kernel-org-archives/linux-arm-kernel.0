From: shawn.guo@linaro.org (Shawn Guo)
Date: Wed, 15 Feb 2012 20:51:12 -0800
Subject: [PATCH] mtd/gpmi : add gpmi support for mx6q
In-Reply-To: <4F3C6C22.2010003@freescale.com>
References: <1328505606-27981-1-git-send-email-b32955@freescale.com>
 <20120215183720.GA2399@r65073-Latitude-D630>
 <4F3C623A.3000301@freescale.com>
 <20120216021841.GG30946@r65073-Latitude-D630>
 <4F3C6C22.2010003@freescale.com>
Message-ID: <20120216045111.GH30946@r65073-Latitude-D630>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Feb 16, 2012 at 10:38:26AM +0800, Huang Shijie wrote:
> Hi,
> >On Thu, Feb 16, 2012 at 09:56:10AM +0800, Huang Shijie wrote:
> >>Hi,
> >>>The imx6q only supports DT boot, but I do not see you are adding DT
> >>>probe for the driver, so I'm wondering how you tested the driver on
> >>>imx6q.
> >>>
> >>This patch is just the first patch  for mx6q. My following patches will
> >>add DT to the gpmi nand driver for mx6q. Due to the dependency
> >>issue, I will send the patches
> >>in the following order:
> >>[1] mtd/gpmi: add gpmi support for mx6q.
> >>[2] [PATCH v5] patch set about the MXS-DMA
> >>[3] add DT support to gpmi for mx6q.
> >>
> >It should be:
> >
> >  1. MXS-DMA series
> >  2. Add imx6q support with DT probe
> >
> I ever did so in this order. But the mxs-dma series delayed for long
> time( I missed the CCs).
> But Artem's tree is faster to merge patch.

You can not change the order because of that.  The fact is imx6q gpmi
support depends on the mxs-dma change.

> >>I tested this patch based on our bsp code.
> >>
> >This is wrong approach.  You are submitting patches to mainline, so
> >you should test your patches on mainline tree.
> >
> Beside the DT, the gpmi nand driver is the same.
> 
> Is the mainline tree ready now? How can i to set the pinmux for gpmi?
> 
People have eventually archived the agreement on pinctrl DT design,
and the patch will come out pretty soon.  Before we have the pinctrl
driver for imx6q, you can rely on boot loader to set pins up properly
for your testing. 

-- 
Regards,
Shawn
