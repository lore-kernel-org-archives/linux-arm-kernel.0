From: LeoLi@freescale.com (Li Leo)
Date: Tue, 22 Sep 2015 17:23:14 +0000
Subject: [PATCH 4/6] arm64/ls1043a: add DTS for Freescale LS1043A SoC
In-Reply-To: <CY1PR0301MB078008B10188504C951076498B450@CY1PR0301MB0780.namprd03.prod.outlook.com>
References: <1442838158-2964-1-git-send-email-B48286@freescale.com>
 <1442838158-2964-5-git-send-email-B48286@freescale.com>
 <20150922012403.GA1535@svinekod>
 <CY1PR0301MB078008B10188504C951076498B450@CY1PR0301MB0780.namprd03.prod.outlook.com>
Message-ID: <DM2PR0301MB07342356008C1A50AB26FEFFBA450@DM2PR0301MB0734.namprd03.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> >
> > Hi,
> >
> > > +/memreserve/ 0x80000000 0x00010000;
> >
> > Why is this necessary?
> 
> This memory region is pre-reserved for the spin-table/psci, although didn't add
> Enable method of secondary cores.

Can this be reserved by bootloader?

> 
> > If this is necessary, please add a comment stating what this is for.
> >
> > > +               cpu at 3 {
> > > +                       device_type = "cpu";
> > > +                       compatible = "arm,cortex-a53";
> > > +                       reg = <0x0 0x3>;
> > > +                       clocks = <&clockgen 1 0>;
> > > +               };
> >
> > Missing enable-method properties on all the secondary CPUs.
> >
> 
> There are two methods (spin-table and psci) to bring up secondary cores, which
> one do you think is better?

Do we have the PSCI support ready in both UEFI and u-boot?  If not, we should use spin-table for now.

Regards,
Leo
