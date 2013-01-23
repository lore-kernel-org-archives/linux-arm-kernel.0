From: dev@lynxeye.de (Lucas Stach)
Date: Wed, 23 Jan 2013 10:45:26 +0100
Subject: [PATCH 1/2] usb: host: tegra: don't touch EMC clock
In-Reply-To: <D958900912E20642BCBC71664EFECE3E6E1B13B855@BGMAIL02.nvidia.com>
References: <1358900903-27654-1-git-send-email-swarren@wwwdotorg.org>
 <D958900912E20642BCBC71664EFECE3E6E1B13B855@BGMAIL02.nvidia.com>
Message-ID: <1358934326.1540.32.camel@tellur>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Mittwoch, den 23.01.2013, 12:25 +0530 schrieb Venu Byravarasu:
> > -----Original Message-----
> > From: linux-tegra-owner at vger.kernel.org [mailto:linux-tegra-
> > owner at vger.kernel.org] On Behalf Of Stephen Warren
> > Sent: Wednesday, January 23, 2013 5:58 AM
> > To: Alan Stern; Greg Kroah-Hartman; Stephen Warren
> > Cc: Venu Byravarasu; linux-tegra at vger.kernel.org; linux-arm-
> > kernel at lists.infradead.org; linux-usb at vger.kernel.org; Stephen Warren
> > Subject: [PATCH 1/2] usb: host: tegra: don't touch EMC clock
> > 
> > From: Stephen Warren <swarren@nvidia.com>
> > 
> > Clock "emc" is for the External Memory Controller. The USB driver has no
> > business touching this clock directly. Remove the code that does so.
> 
> Stephen,
> This was primarily done to make sure that EMC is set to a minimum
> frequency, below which data errors may occur during USB transfers.
> If we plan to remove this, how should we make sure that the EMC
> is programmed for the required frequency during USB transfers?
>  
You could use something like the API I added in "ARM: tegra: add EMC
clock scaling API". This needs some rework and I looked into integrating
this with the DEVFREQ framework, but I don't think it fits too well.

Bandwidth requirements should always be communicated to the EMC driver
and not described by clock rates.

Regards,
Lucas
