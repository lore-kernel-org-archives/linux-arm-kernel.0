From: ruxandra.radulescu@nxp.com (Ruxandra Ioana Radulescu)
Date: Wed, 14 Jun 2017 13:09:47 +0000
Subject: [PATCH 15/18] staging: fsl-dpaa2/eth: Reorder priv fields
In-Reply-To: <20170613100358.GA11444@kroah.com>
References: <20170606150041.10955-1-ruxandra.radulescu@nxp.com>
 <20170606150041.10955-16-ruxandra.radulescu@nxp.com>
 <20170613100358.GA11444@kroah.com>
Message-ID: <VI1PR0402MB2847D1AD9FED44E9882C73D594C30@VI1PR0402MB2847.eurprd04.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> -----Original Message-----
> From: Greg KH [mailto:gregkh at linuxfoundation.org]
> Sent: Tuesday, June 13, 2017 1:04 PM
> To: Ruxandra Ioana Radulescu <ruxandra.radulescu@nxp.com>
> Cc: devel at driverdev.osuosl.org; stuyoder at gmail.com; arnd at arndb.de;
> linux-kernel at vger.kernel.org; agraf at suse.de; Bharat Bhushan
> <bharat.bhushan@nxp.com>; Bogdan Purcareata
> <bogdan.purcareata@nxp.com>; linux-arm-kernel at lists.infradead.org;
> Laurentiu Tudor <laurentiu.tudor@nxp.com>
> Subject: Re: [PATCH 15/18] staging: fsl-dpaa2/eth: Reorder priv fields
> 
> On Tue, Jun 06, 2017 at 10:00:38AM -0500, Ioana Radulescu wrote:
> > Reorder fields in the device's private structure such that
> > the ones most used on the hotpath are at the beginning of
> > the structure.
> >
> > This brings a small performance improvement due to better
> > cache usage.
> 
> Really?  What kind of performance improvement?  Always be specific.

Fair point, thanks.

The test scenario was ipfwd with small frames and the improvement ~1%,
but I took this patch from an internal repo, so I need to redo the
measurements on the current tree before resending.

> 
> Please fix up and resend.

We're preparing a larger patchset with several optimizations, I'll
probably include the v2 there.

Thanks,
Ioana
