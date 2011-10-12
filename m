From: manjugk@ti.com (G, Manjunath Kondaiah)
Date: Wed, 12 Oct 2011 12:34:29 +0530
Subject: [PATCH 2/5] drivercore: Add driver probe deferral mechanism
In-Reply-To: <361419345.198335.1318268242916.JavaMail.root@zimbra-prod-mbox-2.vmware.com>
References: <20111008155502.GB616@kroah.com>
	<361419345.198335.1318268242916.JavaMail.root@zimbra-prod-mbox-2.vmware.com>
Message-ID: <20111012070429.GC2080@manju-desktop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 10, 2011 at 10:37:22AM -0700, Andrei Warkentin wrote:
> Hi,
> 
> ----- Original Message -----
> > From: "Greg KH" <greg@kroah.com>
> > To: "Josh Triplett" <josh@joshtriplett.org>
> > Cc: "G, Manjunath Kondaiah" <manjugk@ti.com>, linux-arm-kernel at lists.infradead.org, "Grant Likely"
> > <grant.likely@secretlab.ca>, linux-omap at vger.kernel.org, linux-mmc at vger.kernel.org, linux-kernel at vger.kernel.org,
> > "Dilan Lee" <dilee@nvidia.com>, "Mark Brown" <broonie@opensource.wolfsonmicro.com>, Manjunath at jasper.es
> > Sent: Saturday, October 8, 2011 11:55:02 AM
> > Subject: Re: [PATCH 2/5] drivercore: Add driver probe deferral mechanism
> > 
> 
> I'm a bit of a fly on the wall here, but I'm curious how this impacts suspend/resume.
> device_initialize->device_pm_init are called from device_register, so certainly this
> patch doesn't also ensure that the PM ordering matches probe ordering, which is bound
> to break suspend, right? Was this ever tested with the OMAP target? Shouldn't the
> PM change be also part of this patch set? I don't see why you would want to have this in
> without the PM changes.

suspend/resume handling is already in TODO list:
http://permalink.gmane.org/gmane.linux.ports.arm.kernel/135461

-M

> 
> Maybe I have it all wrong though :-).
> 
> A
