From: awarkentin@vmware.com (Andrei Warkentin)
Date: Mon, 10 Oct 2011 10:37:22 -0700 (PDT)
Subject: [PATCH 2/5] drivercore: Add driver probe deferral mechanism
In-Reply-To: <20111008155502.GB616@kroah.com>
Message-ID: <361419345.198335.1318268242916.JavaMail.root@zimbra-prod-mbox-2.vmware.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

----- Original Message -----
> From: "Greg KH" <greg@kroah.com>
> To: "Josh Triplett" <josh@joshtriplett.org>
> Cc: "G, Manjunath Kondaiah" <manjugk@ti.com>, linux-arm-kernel at lists.infradead.org, "Grant Likely"
> <grant.likely@secretlab.ca>, linux-omap at vger.kernel.org, linux-mmc at vger.kernel.org, linux-kernel at vger.kernel.org,
> "Dilan Lee" <dilee@nvidia.com>, "Mark Brown" <broonie@opensource.wolfsonmicro.com>, Manjunath at jasper.es
> Sent: Saturday, October 8, 2011 11:55:02 AM
> Subject: Re: [PATCH 2/5] drivercore: Add driver probe deferral mechanism
> 

I'm a bit of a fly on the wall here, but I'm curious how this impacts suspend/resume.
device_initialize->device_pm_init are called from device_register, so certainly this
patch doesn't also ensure that the PM ordering matches probe ordering, which is bound
to break suspend, right? Was this ever tested with the OMAP target? Shouldn't the
PM change be also part of this patch set? I don't see why you would want to have this in
without the PM changes.

Maybe I have it all wrong though :-).

A
