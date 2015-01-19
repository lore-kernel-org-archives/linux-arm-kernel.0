From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 19 Jan 2015 16:17:39 +0100
Subject: [PATCH v3 2/3] arm64: dts: Add APM X-Gene DMA device and DMA
 clock DTS nodes
In-Reply-To: <CAFd313wyVqsqGNdxrAzmGCCYd-RAEcrX6f4y2Gngi44OOkbx-Q@mail.gmail.com>
References: <1421671269-19441-1-git-send-email-rsahu@apm.com>
 <2407238.x2YxDm0cd4@wuerfel>
 <CAFd313wyVqsqGNdxrAzmGCCYd-RAEcrX6f4y2Gngi44OOkbx-Q@mail.gmail.com>
Message-ID: <4015362.jQuStL4p6a@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 19 January 2015 20:11:22 Rameshwar Sahu wrote:
> 
> >
> > The value should be
> >
> >         dma-ranges = <0x40 0x0 0x40 0x0 0x200 0>;
> >
> 
> then it should be :
> 
> dma-ranges = <0x40 0x0 0x40 0x0 0x400 0>;
> 
> 
> to say that any DMA to physical addresses from 0 to 0x3f.ffffffff

No, the property above is for a bus that extends from
0x40.00000000 to 0x43f.ffffffff

The first tuple is the address that is used for the local
bus, the second one is the address that it gets translated to
on the parent bus, and the third tuple is the length.

> > is disallowed and dma to physical addresses from 0x40.00000000
> > to 0x23f.ffffffff is allowed and gets translated using an
> > identity mapping.
> >
> > I also see that on Mustang, all memory is outside of this range,
> >
> 
> Do you mean all other device controller node in DT here??
> Basically these are all device controller memory, as what I understood is
> dma-ranges tells about DDR ranges like start address of DDR
> and length.

It has absolutely nothing to do with where the DDR memory resides,
only which addresses are valid on a particular bus, like the
ranges property for the opposite direction. This is usually set
up in some control register for the bus, and you should use the
same value here.

	Arnd
