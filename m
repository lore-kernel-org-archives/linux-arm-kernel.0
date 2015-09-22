From: bhupesh.sharma@freescale.com (Sharma Bhupesh)
Date: Tue, 22 Sep 2015 19:04:56 +0000
Subject: [PATCH 4/6] arm64/ls1043a: add DTS for Freescale LS1043A SoC
In-Reply-To: <DM2PR0301MB07342356008C1A50AB26FEFFBA450@DM2PR0301MB0734.namprd03.prod.outlook.com>
References: <1442838158-2964-1-git-send-email-B48286@freescale.com>
 <1442838158-2964-5-git-send-email-B48286@freescale.com>
 <20150922012403.GA1535@svinekod>
 <CY1PR0301MB078008B10188504C951076498B450@CY1PR0301MB0780.namprd03.prod.outlook.com>
 <DM2PR0301MB07342356008C1A50AB26FEFFBA450@DM2PR0301MB0734.namprd03.prod.outlook.com>
Message-ID: <BY1PR0301MB1303F9A6F3B00F91C7B18C0682450@BY1PR0301MB1303.namprd03.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



> -----Original Message-----
> From: Li Yang-Leo-R58472
> Sent: Tuesday, September 22, 2015 10:53 PM
> To: Hou Zhiqiang-B48286; Mark Rutland; marc.zyngier at arm.com
> Cc: linux-arm-kernel at lists.infradead.org; Catalin Marinas; Will Deacon;
> linux-i2c at vger.kernel.org; linux-watchdog at vger.kernel.org; linux-
> doc at vger.kernel.org; linux-clk at vger.kernel.org; Xie Shaohui-B21989;
> corbet at lwn.net; Sharma Bhupesh-B45370; mturquette at baylibre.com; wsa at the-
> dreams.de; sboyd at codeaurora.org; wim at iguana.be; Song Wenbin-B53747; Wood
> Scott-B07421; Hu Mingkai-B21284
> Subject: RE: [PATCH 4/6] arm64/ls1043a: add DTS for Freescale LS1043A SoC
> 
> > >
> > > Hi,
> > >
> > > > +/memreserve/ 0x80000000 0x00010000;
> > >
> > > Why is this necessary?
> >
> > This memory region is pre-reserved for the spin-table/psci, although
> > didn't add Enable method of secondary cores.
> 
> Can this be reserved by bootloader?

No need to reserve this for PSCI based secondary bootup.

> >
> > > If this is necessary, please add a comment stating what this is for.
> > >
> > > > +               cpu at 3 {
> > > > +                       device_type = "cpu";
> > > > +                       compatible = "arm,cortex-a53";
> > > > +                       reg = <0x0 0x3>;
> > > > +                       clocks = <&clockgen 1 0>;
> > > > +               };
> > >
> > > Missing enable-method properties on all the secondary CPUs.
> > >
> >
> > There are two methods (spin-table and psci) to bring up secondary
> > cores, which one do you think is better?
> 
> Do we have the PSCI support ready in both UEFI and u-boot?  If not, we
> should use spin-table for now.

UEFI has been using PSCI with Arm Trusted Firmware (ATF) since some time. U-boot can also work with ATF seamlessly.

Spin-table method is deprecated and newer patches should support PSCI. If not, all intelligence should be left to the
Bootloader and the Linux DTS should not mention the 'enable-method' and the 'memreserve' regions. 

For details please see the LS2085A Freescale DTS already present in mainline kernel.

Regards,
Bhupesh
