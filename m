From: shawn.guo@freescale.com (Shawn Guo)
Date: Fri, 1 Apr 2011 11:47:31 +0800
Subject: [PATCH V3 2/6] dmaengine: add interrupt check for GPMI controller
In-Reply-To: <4D9444A6.2060109@freescale.com>
References: <19858.62649.218523.984252@ipc1.ka-ro>
	<1301554968-29066-1-git-send-email-b32955@freescale.com>
	<19860.13566.651111.241538@ipc1.ka-ro>
	<4D94403F.6000000@freescale.com>
	<19860.16442.199644.984424@ipc1.ka-ro>
	<4D9444A6.2060109@freescale.com>
Message-ID: <20110401034730.GE25866@S2100-06.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 31, 2011 at 05:08:54PM +0800, Huang Shijie wrote:
[...]
> >>>You should make the distinction based on the platform_id, which would
> >>>save you the ugly ifdef's and cpu_is_... macros.
> >>>
> >>>
> >>This in the DMA driver.
> >>Do you want me to change the DMA driver to add the platform_id?
> >>The DMA driver has already used the cpu_is_xx() macros.
> >>
> >The mxs-dma driver is already using platform ids!
> >
> >
> Do you mean the mxd_dma_type[] ?
> 
> How can i distinction the imx23 and imx28 with it ?
> It seems can not be used to do the work.
> 
You can drop the dmaengine patch from your gpmi series.  I will find
some time to fix this together with removing cpu_is_xx() and inclusion
of mxs.h, to get it prepared for i.mx50 aphb-dma support.

-- 
Regards,
Shawn
