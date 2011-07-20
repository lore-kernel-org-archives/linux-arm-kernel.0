From: B19295@freescale.com (Lin Tony-B19295)
Date: Wed, 20 Jul 2011 11:21:10 +0000
Subject: [PATCH 5/7] ehci mxc: make it more flexible to be used for mx28
In-Reply-To: <20110720111442.GN764@legolas.emea.dhcp.ti.com>
References: <1311160106-4898-1-git-send-email-tony.lin@freescale.com>
	<1311160106-4898-6-git-send-email-tony.lin@freescale.com>
	<20110720111442.GN764@legolas.emea.dhcp.ti.com>
Message-ID: <97D3A72708D04647A5AC84A04996E5B51616AD@039-SN1MPN1-006.039d.mgd.msft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> -----Original Message-----
> From: Felipe Balbi [mailto:balbi at ti.com]
> Sent: Wednesday, July 20, 2011 7:15 PM
> To: Lin Tony-B19295
> Cc: linux-usb at vger.kernel.org; linux-arm-kernel at lists.infradead.org;
> balbi at ti.com; koen.beel.barco at gmail.com
> Subject: Re: [PATCH 5/7] ehci mxc: make it more flexible to be used for
> mx28
> 
> Hi,
> 
> On Wed, Jul 20, 2011 at 07:08:24PM +0800, Tony Lin wrote:
> > @@ -165,14 +187,15 @@ static int ehci_mxc_drv_probe(struct
> platform_device *pdev)
> >  	}
> >
> >  	/* enable clocks */
> > -	priv->usbclk = clk_get(dev, "usb");
> > -	if (IS_ERR(priv->usbclk)) {
> > -		ret = PTR_ERR(priv->usbclk);
> > -		goto err_clk;
> > +	if (!cpu_is_mx28()) {
> 
> this should not be used in drivers, IMHO.
> 
> > +		priv->usbclk = clk_get(dev, "usb");
> 
> drivers should not have to care about clock names, are you sure your
> clkdev support is correct ?

Yes, I agree with you about above two points. I feel the same as you.
But I had to following the existing framework. I didn't add any new special to the driver.
Just try some ways to workaround these ugly points.

> 
> --
> balbi
