From: laurentiu.tudor@nxp.com (Laurentiu Tudor)
Date: Mon, 22 May 2017 07:12:39 +0000
Subject: [PATCH 3/3][v4] staging: fsl-mc: move bus driver out of staging
In-Reply-To: <86tw4g6nb0.fsf@arm.com>
References: <20170519131305.5068-1-laurentiu.tudor@nxp.com>
 <20170519131305.5068-4-laurentiu.tudor@nxp.com>
 <b3980350-9663-d98b-6533-fd3c15f98671@gmail.com> <86tw4g6nb0.fsf@arm.com>
Message-ID: <VI1PR0401MB1856C0396AE7608FF2FC8CF1ECF80@VI1PR0401MB1856.eurprd04.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Marc,

> -----Original Message-----
> From: Marc Zyngier [mailto:marc.zyngier at arm.com]
> Sent: Saturday, May 20, 2017 9:43 AM
> To: Matthias Brugger <matthias.bgg@gmail.com>
> Cc: Laurentiu Tudor <laurentiu.tudor@nxp.com>; gregkh at linuxfoundation.org;
> stuyoder at gmail.com; devel at driverdev.osuosl.org; arnd at arndb.de; Ruxandra
> Ioana Radulescu <ruxandra.radulescu@nxp.com>; Stuart Yoder
> <stuart.yoder@nxp.com>; Roy Pledge <roy.pledge@nxp.com>; linux-
> kernel at vger.kernel.org; agraf at suse.de; Catalin Horghidan
> <catalin.horghidan@nxp.com>; Ioana Ciornei <ioana.ciornei@nxp.com>;
> Thomas Gleixner <tglx@linutronix.de>; Leo Li <leoyang.li@nxp.com>; Bharat
> Bhushan <bharat.bhushan@nxp.com>; Jason Cooper <jason@lakedaemon.net>;
> linux-arm-kernel at lists.infradead.org; Rob Herring <robh+dt@kernel.org>
> Subject: Re: [PATCH 3/3][v4] staging: fsl-mc: move bus driver out of staging
> Importance: High
> 
> On Fri, May 19 2017 at 02:41:43 PM, Matthias Brugger
> <matthias.bgg@gmail.com> wrote:
> > On 19/05/17 15:13, laurentiu.tudor at nxp.com wrote:
> >> From: Stuart Yoder <stuart.yoder@nxp.com>
> >>
> >> Move the source files out of staging into their final locations:
> >>    -include files in drivers/staging/fsl-mc/include go to include/linux/fsl
> >>    -irq-gic-v3-its-fsl-mc-msi.c goes to drivers/irqchip
> >
> > This driver has as compatible "arm,gic-v3-its". I wonder if this is
> > correct and if it should be moved like this out of staging.
> 
> This is no different from the way we handle *any* bus that uses the
> GICv3 ITS as an MSI controller. Each bus provides its glue code that latches onto
> the ITS node, and calls into the generic code.
> 
> Now, when it comes to moving this out of staging, here is my concern:
> There is mention of a userspace tool (restool) used to control the HW. Where is
> this tool? Where is the user ABI documented?

The tool is published here:

https://github.com/qoriq-open-source/restool

There are two ways of configuring the mc-bus:
 - a static one, through a FDT based configuration file (we call it DPL), documented in the refman linked below, chapter 22.
 - a dynamic one, using this restool utility.
Please note the usage of restool is optional.

The reference manual documenting the ABI can be found here (registration required):

https://freescale.sdlproducts.com/LiveContent/content/en-US/QorIQ_SDK/GUID-53BEBDD8-1A5E-4DD0-8354-A9647AD35755

Click on the DPAA2 user manual link.

We're also working on publishing the docs on github so that they're more accessible.

---
Thanks & Best Regards, Laurentiu
