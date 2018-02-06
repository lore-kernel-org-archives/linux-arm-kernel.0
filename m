From: bogdan.purcareata@nxp.com (Bogdan Purcareata)
Date: Tue, 6 Feb 2018 08:57:10 +0000
Subject: [PATCH v6 1/2] staging: fsl-mc: Move core bus out of staging
In-Reply-To: <VI1PR0402MB33427D7D04239420F3FE7D5A98FD0@VI1PR0402MB3342.eurprd04.prod.outlook.com>
References: <20180205140743.29974-1-bogdan.purcareata@nxp.com>
 <20180205140743.29974-2-bogdan.purcareata@nxp.com>
 <VI1PR0402MB33427D7D04239420F3FE7D5A98FD0@VI1PR0402MB3342.eurprd04.prod.outlook.com>
Message-ID: <AM0PR0402MB3649BC95F62CDAA921CF361DEAFD0@AM0PR0402MB3649.eurprd04.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> -----Original Message-----
> From: Horia Geant?
> Sent: Tuesday, February 06, 2018 9:18 AM
> To: Bogdan Purcareata <bogdan.purcareata@nxp.com>; gregkh at linuxfoundation.org;
> Laurentiu Tudor <laurentiu.tudor@nxp.com>; Ruxandra Ioana Ciocoi Radulescu
> <ruxandra.radulescu@nxp.com>
> Cc: stuyoder at gmail.com; arnd at arndb.de; robh at kernel.org; Razvan Stefanescu
> <razvan.stefanescu@nxp.com>; Ioana Ciornei <ioana.ciornei@nxp.com>; Nipun Gupta
> <nipun.gupta@nxp.com>; Roy Pledge <roy.pledge@nxp.com>; marc.zyngier at arm.com;
> tglx at linutronix.de; jason at lakedaemon.net; devel at driverdev.osuosl.org; linux-
> kernel at vger.kernel.org; linux-arm-kernel at lists.infradead.org
> Subject: Re: [PATCH v6 1/2] staging: fsl-mc: Move core bus out of staging
> 
> On 2/5/2018 4:08 PM, Bogdan Purcareata wrote:
> > Move the source files out of staging into their final locations:
> >   -mc.h include file in drivers/staging/fsl-mc/include go to
> include/linux/fsl
> >   -source files in drivers/staging/fsl-mc/bus go to drivers/bus/fsl-mc
> >   -overview.rst, providing an overview of DPAA2, goes to
> >    Documentation/networking/dpaa2/overview.rst
> [...]
> >  rename {drivers/staging/fsl-mc =>
> Documentation/networking/dpaa2}/overview.rst (100%)
> 
> Is this the proper location for documentation?
> The doc focuses on networking, however there's also information about fsl mc
> bus, dpio.

Yes, after internal discussions we concluded it would be the best fit, since
the end usage scenario is a networking one. So far the main user of the fsl-mc
bus and dpio is dpaa2-eth, which is an Ethernet driver. It's also next to the
previous DPAA generation driver documentation at Documentation/networking/dpaa.txt.

> In the future, we might want to add doc for other dpaa2 objects sitting on the
> fsl mc bus:
> -dpseci ("Data Path SEC Interface" - abstraction for the crypto engine)
> -dpdcei ("Data Path Decompression and Compression Engine Interface")
> 
> Would these fit under networking doc folder too?

IMO it would make sense to place them in the same Documentation/networking/dpaa2/
folder, since they're part of the same architecture. Of course, the end location
can be changed based on later feedback.

Cheers,
Bogdan P.
