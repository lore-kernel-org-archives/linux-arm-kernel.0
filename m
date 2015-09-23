From: LeoLi@freescale.com (Li Leo)
Date: Wed, 23 Sep 2015 04:16:10 +0000
Subject: [PATCH 4/6] arm64/ls1043a: add DTS for Freescale LS1043A SoC
In-Reply-To: <CY1PR0301MB07805FA01ACAF84648C806138B440@CY1PR0301MB0780.namprd03.prod.outlook.com>
References: <1442838158-2964-1-git-send-email-B48286@freescale.com>
 <1442838158-2964-5-git-send-email-B48286@freescale.com>
 <20150922012403.GA1535@svinekod>
 <CY1PR0301MB078008B10188504C951076498B450@CY1PR0301MB0780.namprd03.prod.outlook.com>
 <DM2PR0301MB07342356008C1A50AB26FEFFBA450@DM2PR0301MB0734.namprd03.prod.outlook.com>
 <CY1PR0301MB07805FA01ACAF84648C806138B440@CY1PR0301MB0780.namprd03.prod.outlook.com>
Message-ID: <DM2PR0301MB0734302E89290593BE7D9565BA440@DM2PR0301MB0734.namprd03.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> > > >
> > > > Hi,
> > > >
> > > > > +/memreserve/ 0x80000000 0x00010000;
> > > >
> > > > Why is this necessary?
> > >
> > > This memory region is pre-reserved for the spin-table/psci, although
> > > didn't add Enable method of secondary cores.
> >
> > Can this be reserved by bootloader?
> 
> Yes, the memory for psci was reserved by u-boot code. But due to spin-table
> need the release address, is it better adding the /memreserve/ in dts file?
> Or add it by bootloader and fix the release address accordingly?

Both the reserved memory region and cpu-release-addr should be updated by bootloader.

Regards,
Leo
