From: balbi@ti.com (Felipe Balbi)
Date: Wed, 20 Jul 2011 14:23:06 +0300
Subject: [PATCH 5/7] ehci mxc: make it more flexible to be used for mx28
In-Reply-To: <97D3A72708D04647A5AC84A04996E5B51616AD@039-SN1MPN1-006.039d.mgd.msft.net>
References: <1311160106-4898-1-git-send-email-tony.lin@freescale.com>
	<1311160106-4898-6-git-send-email-tony.lin@freescale.com>
	<20110720111442.GN764@legolas.emea.dhcp.ti.com>
	<97D3A72708D04647A5AC84A04996E5B51616AD@039-SN1MPN1-006.039d.mgd.msft.net>
Message-ID: <20110720112305.GP764@legolas.emea.dhcp.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Wed, Jul 20, 2011 at 11:21:10AM +0000, Lin Tony-B19295 wrote:
> > -----Original Message-----
> > From: Felipe Balbi [mailto:balbi at ti.com]
> > Sent: Wednesday, July 20, 2011 7:15 PM
> > To: Lin Tony-B19295
> > Cc: linux-usb at vger.kernel.org; linux-arm-kernel at lists.infradead.org;
> > balbi at ti.com; koen.beel.barco at gmail.com
> > Subject: Re: [PATCH 5/7] ehci mxc: make it more flexible to be used for
> > mx28
> > 
> > Hi,
> > 
> > On Wed, Jul 20, 2011 at 07:08:24PM +0800, Tony Lin wrote:
> > > @@ -165,14 +187,15 @@ static int ehci_mxc_drv_probe(struct
> > platform_device *pdev)
> > >  	}
> > >
> > >  	/* enable clocks */
> > > -	priv->usbclk = clk_get(dev, "usb");
> > > -	if (IS_ERR(priv->usbclk)) {
> > > -		ret = PTR_ERR(priv->usbclk);
> > > -		goto err_clk;
> > > +	if (!cpu_is_mx28()) {
> > 
> > this should not be used in drivers, IMHO.
> > 
> > > +		priv->usbclk = clk_get(dev, "usb");
> > 
> > drivers should not have to care about clock names, are you sure your
> > clkdev support is correct ?
> 
> Yes, I agree with you about above two points. I feel the same as you.
> But I had to following the existing framework. I didn't add any new special to the driver.
> Just try some ways to workaround these ugly points.

but in that case, since you're already there... why not cleaning those
things up before making your changes ?

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 490 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20110720/ce9098e9/attachment.sig>
