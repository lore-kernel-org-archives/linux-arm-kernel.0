From: balbi@ti.com (Felipe Balbi)
Date: Thu, 6 Sep 2012 15:29:50 +0300
Subject: [PATCH v3 03/23] serial: omap: don't access the platform_device
In-Reply-To: <20120905202721.GA2430@kroah.com>
References: <1345717983-18179-1-git-send-email-balbi@ti.com>
 <1345717983-18179-4-git-send-email-balbi@ti.com>
 <20120905202721.GA2430@kroah.com>
Message-ID: <20120906122948.GC29202@arwen.pp.htv.fi>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Sep 05, 2012 at 01:27:21PM -0700, Greg KH wrote:
> On Thu, Aug 23, 2012 at 01:32:43PM +0300, Felipe Balbi wrote:
> > The driver doesn't need to know about its platform_device.
> > 
> > Everything the driver needs can be done through the
> > struct device pointer. In case we need to use the
> > OMAP-specific PM function pointers, those can make
> > sure to find the device's platform_device pointer
> > so they can find the struct omap_device through
> > pdev->archdata field.
> > 
> > Tested-by: Shubhrajyoti D <shubhrajyoti@ti.com>
> > Acked-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
> > Signed-off-by: Felipe Balbi <balbi@ti.com>
> > Acked-by: Tony Lindgren <tony@atomide.com>
> 
> This series fails when applying to my tty-next branch at this patch :(
> 
> Care to refresh it, and resend it, with Tony's acks added, so I can
> apply it?  Note, I've already applied the first two.

Sure, will do and reply to this mail with the new series. Thanks

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120906/ffc25bf0/attachment.sig>
