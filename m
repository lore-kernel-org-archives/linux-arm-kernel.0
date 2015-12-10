From: bhupesh.sharma@freescale.com (Sharma Bhupesh)
Date: Thu, 10 Dec 2015 11:05:49 +0000
Subject: [PATCH v2 5/5] can: flexcan: Add support for non RX-FIFO mode
In-Reply-To: <BY1PR0301MB130358076C3A5969406DE69182D80@BY1PR0301MB1303.namprd03.prod.outlook.com>
References: <1431603215-25546-1-git-send-email-bhupesh.sharma@freescale.com>
 <1431603215-25546-6-git-send-email-bhupesh.sharma@freescale.com>
 <5554C244.80809@pengutronix.de>
 <BY1PR0301MB130358076C3A5969406DE69182D80@BY1PR0301MB1303.namprd03.prod.outlook.com>
Message-ID: <BY1PR0301MB130384E91308C49A850DEC4782E90@BY1PR0301MB1303.namprd03.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mark,

> -----Original Message-----
> From: linux-arm-kernel [mailto:linux-arm-kernel-
> bounces at lists.infradead.org] On Behalf Of Sharma Bhupesh
> Sent: Thursday, May 14, 2015 9:14 PM
> To: Marc Kleine-Budde; arnd at arndb.de; linux-can at vger.kernel.org
> Cc: bhupesh.linux at gmail.com; linux-arm-kernel at lists.infradead.org; Arora
> Sakar-B45205
> Subject: RE: [PATCH v2 5/5] can: flexcan: Add support for non RX-FIFO
> mode
> 
> > -----Original Message-----
> > From: Marc Kleine-Budde [mailto:mkl at pengutronix.de]
> > Sent: Thursday, May 14, 2015 9:12 PM
> > To: Sharma Bhupesh-B45370; arnd at arndb.de; linux-can at vger.kernel.org
> > Cc: bhupesh.linux at gmail.com; Arora Sakar-B45205; linux-arm-
> > kernel at lists.infradead.org
> > Subject: Re: [PATCH v2 5/5] can: flexcan: Add support for non RX-FIFO
> > mode
> >
> > On 05/14/2015 01:33 PM, Bhupesh Sharma wrote:
> > > This patch adds support for non RX-FIFO (legacy) mode in the flexcan
> > > driver.
> > >
> > > On certain SoCs, the RX-FIFO support might be broken, as a result we
> > > need to fall-back on the legacy (non RX-FIFO) mode to receive CAN
> > > frames.
> > >
> > > Signed-off-by: Bhupesh Sharma <bhupesh.sharma@freescale.com>
> > > Signed-off-by: Sakar Arora <Sakar.Arora@freescale.com>
> >
> > The non FIFO mode doesn't guarantee the order of the incoming frames,
> > not does not even try to...this is not acceptable. I'm currently
> > working on a patch by David Jander that brings in non FIFO mode, but
> > tries to keep the order of the frames.
> 
> That is already WIP at our end. V3 will contain the same change.
> If you are already working on it, I don't know how to proceed further as
> we had already v1 of this patchset with the non FIFO mode out since a
> month or so.

I don't remember seeing a patch from you which supports non-FIFO mode for flexcan IP.
Since we now have Freescale LS1021A chip out in the field on which the FIFO mode broken,
we cannot use the upstream flexcan driver for enabling flexcan IP on these chips.

Do you still have plans to work on this? Or should I submit my v3 with in-order reception
supported for rx frames.

Regards,
Bhupesh
