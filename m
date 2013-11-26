From: balbi@ti.com (Felipe Balbi)
Date: Tue, 26 Nov 2013 11:16:35 -0600
Subject: [PATCH 1/3] usb: dwc3: Add Keystone specific glue layer
In-Reply-To: <5293EFFD.9000508@ti.com>
References: <1385410581-12148-1-git-send-email-w-kwok2@ti.com>
 <1385410581-12148-2-git-send-email-w-kwok2@ti.com>
 <20131125203956.GI18046@saruman.home> <5293EFFD.9000508@ti.com>
Message-ID: <20131126171635.GP24310@saruman.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 25, 2013 at 07:49:01PM -0500, Santosh Shilimkar wrote:
> On Monday 25 November 2013 03:39 PM, Felipe Balbi wrote:
> > Hi,
> > 
> 
> [...]
> 
> > 
> >> +	kdwc3_dma_mask = dma_get_mask(dev);
> >> +	dev->dma_mask = &kdwc3_dma_mask;
> >> +
> >> +	error = kdwc3_enable(kdwc);
> > 
> > I would drop this function and just add your clk_prepare() here, then
> > move clk_enable()/clk_disable() to ->runtime_resume/->runtime_suspend()
> > respectively. Then you could just call pm_runtime_get_sync() when you
> > need to access your registers and pm_runtime_put() when you want to drop
> > the clock reference.
> > 
> > this will even make PM implementation a lot easier for you going
> > forward.
> > 
> Just to make the PM runtime part clear, there are few issues with PM
> core clock layer [1], hence drivers is using clock layer. Its trivial
> to update the driver though once the issue is sorted out.
> 
> Meanwhile driver development continue to be with clock calls. 

I don't mind having those clock calls, just suggested a different
placement for them.

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20131126/d5fef4bc/attachment.sig>
