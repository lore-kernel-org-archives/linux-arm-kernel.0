From: peter.chen@freescale.com (Peter Chen)
Date: Mon, 14 Jan 2013 21:16:20 +0800
Subject: [PATCH v3 2/3] usb: fsl_mxc_udc: replace MX35_IO_ADDRESS to
 ioremap
In-Reply-To: <20130114131056.GB23505@n2100.arm.linux.org.uk>
References: <1358158361-25550-1-git-send-email-peter.chen@freescale.com>
 <1358158361-25550-3-git-send-email-peter.chen@freescale.com>
 <20130114131056.GB23505@n2100.arm.linux.org.uk>
Message-ID: <20130114131619.GC30157@nchen-desktop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 14, 2013 at 01:10:56PM +0000, Russell King - ARM Linux wrote:
> On Mon, Jan 14, 2013 at 06:12:40PM +0800, Peter Chen wrote:
> > @@ -83,15 +84,16 @@ void fsl_udc_clk_finalize(enum fsl_udc_type devtype,
> >  	struct fsl_usb2_platform_data *pdata = pdev->dev.platform_data;
> >  	if (devtype == IMX35_UDC) {
> >  		unsigned int v;
> > +		void __iomem *phy_regs = ioremap((unsigned long)pdata->regs +
> > +						MX35_USBPHYCTRL_OFFSET, 512);
> 
> Consider that ioremap() can fail.
> 
Thanks, will check NULL pointer.

-- 

Best Regards,
Peter Chen
