From: bharat.bhushan@nxp.com (Bharat Bhushan)
Date: Fri, 24 Nov 2017 16:00:42 +0000
Subject: [PATCH v3] staging: fsl-mc: use 32bits to support 64K size
 mc-portals
In-Reply-To: <20171124155848.GA8630@kroah.com>
References: <1511336923-610-1-git-send-email-Bharat.Bhushan@nxp.com>
 <5A155642.70809@nxp.com> <20171124155848.GA8630@kroah.com>
Message-ID: <AM5PR0401MB2545B2636B0CDE3AFB838E7C9A260@AM5PR0401MB2545.eurprd04.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Greg,

> -----Original Message-----
> From: gregkh at linuxfoundation.org [mailto:gregkh at linuxfoundation.org]
> Sent: Friday, November 24, 2017 9:29 PM
> To: Laurentiu Tudor <laurentiu.tudor@nxp.com>
> Cc: Bharat Bhushan <bharat.bhushan@nxp.com>; Ruxandra Ioana Radulescu
> <ruxandra.radulescu@nxp.com>; devel at driverdev.osuosl.org;
> stuyoder at gmail.com; Roy Pledge <roy.pledge@nxp.com>; linux-
> kernel at vger.kernel.org; Leo Li <leoyang.li@nxp.com>; Bogdan Purcareata
> <bogdan.purcareata@nxp.com>; linux-arm-kernel at lists.infradead.org
> Subject: Re: [PATCH v3] staging: fsl-mc: use 32bits to support 64K size mc-
> portals
> 
> On Wed, Nov 22, 2017 at 10:49:50AM +0000, Laurentiu Tudor wrote:
> >
> >
> > On 11/22/2017 09:48 AM, Bharat Bhushan wrote:
> > > As per APIs each mc-portal is of 64K size while currently 16bits
> > > (type u16) is used to store size of mc-portal.
> > > In these cases upper bit of portal size gets truncated.
> > >
> > > Signed-off-by: Bharat Bhushan <Bharat.Bhushan@nxp.com>
> > > ---
> >
> > Ok, so just to clarify this fixes the case where size is equal (or
> > maybe larger in the future) to 0x10000.
> 
> Is this something that can happen today?  Is this needed in 4.14 to fix a
> problem people are having and need to be backported to stable, or can it
> wait until 4.15?

We can wait for 4.15 and no need to backport.

Thanks
-Bharat

> 
> thanks,
> 
> greg k-h
