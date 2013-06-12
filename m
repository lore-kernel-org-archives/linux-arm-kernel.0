From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 12 Jun 2013 17:10:58 +0200
Subject: [PATCH 6/6] ARM: dts: Add pcie controller node for Samsung
 EXYNOS5440 SoC
In-Reply-To: <002e01ce6668$f785dc20$e6919460$@samsung.com>
References: <00c001ce277b$92b26ab0$b8174010$%han@samsung.com>
 <201306101722.10146.arnd@arndb.de>
 <002e01ce6668$f785dc20$e6919460$@samsung.com>
Message-ID: <201306121710.58601.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 11 June 2013, Jingoo Han wrote:
> > > +           ranges = <0x00000800 0 0x40000000 0x40000000 0 0x00200000   /* configuration space */
> > > +                     0x81000000 0 0          0x40200000 0 0x00004000   /* downstream I/O */
> > > +                     0x82000000 0 0          0x40204000 0 0x10000000>; /* non-prefetchable memory */
> > > +   };
> > 
> ...
> > Also, shouldn't your memory space end on a 256MB boundary, rather than
> > extend up to 0x50203fff?
> 
> According to the manual of Exynos PCIe, each memory space for Exynos PCIe
> can support 512MB, including I/O, CFG regions.
> 
> Is there any problem when over 256MB boundary is used?
> Please let me know. :)

No, that's not a problem, but I think you should have the window span
the entire space that is provided in hardware. If there are 512 MB total, why
not use them?

You could use 

	ranges = <0x82000000 0 0          0x40204000 0 0x1fdfc000>;

to pass a range for the memory space that extends all the way until
0x5fffffff.

	Arnd
