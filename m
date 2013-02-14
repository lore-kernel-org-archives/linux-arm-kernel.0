From: balbi@ti.com (Felipe Balbi)
Date: Thu, 14 Feb 2013 19:57:19 +0200
Subject: [RFC/NOT FOR MERGING 1/3] arm: omap: use generic implementation
 if !od
In-Reply-To: <20130214112043.GQ17852@n2100.arm.linux.org.uk>
References: <1360840554-26901-1-git-send-email-balbi@ti.com>
 <20130214112043.GQ17852@n2100.arm.linux.org.uk>
Message-ID: <20130214175719.GB25891@arwen.pp.htv.fi>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Feb 14, 2013 at 11:20:43AM +0000, Russell King - ARM Linux wrote:
> On Thu, Feb 14, 2013 at 01:15:52PM +0200, Felipe Balbi wrote:
> >  	struct platform_device *pdev = to_platform_device(dev);
> > +	struct omap_device *od = to_omap_device(pdev);
> >  	int ret;
> >  
> >  	ret = pm_generic_runtime_suspend(dev);
> >  
> > +	if (!od)
> > +		goto out;
> > +
> >  	if (!ret)
> 
> What's wrong with the single line change per function of:
> 
> -	if (!ret)
> +	if (!ret && to_omap_device(pdev))
> 
> ?

nothing, will change. Let me just check if the other folks are ok with
the patchset.

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130214/7bc41cb4/attachment.sig>
