From: jg1.han@samsung.com (Jingoo Han)
Date: Tue, 11 Jun 2013 15:00:25 +0900
Subject: [PATCH 6/6] ARM: dts: Add pcie controller node for Samsung
 EXYNOS5440 SoC
In-Reply-To: <201306101722.10146.arnd@arndb.de>
References: <00c001ce277b$92b26ab0$b8174010$%han@samsung.com>
 <201306071943.18407.arnd@arndb.de>
 <000001ce65b5$e45477f0$acfd67d0$@samsung.com>
 <201306101722.10146.arnd@arndb.de>
Message-ID: <002e01ce6668$f785dc20$e6919460$@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday, June 11, 2013 12:22 AM, Arnd Bergmann wrote:
> On Monday 10 June 2013, Jingoo Han wrote:
> > On Saturday, June 08, 2013 2:43 AM, Arnd Bergmann wrote:
> > For multiple domains, how can I fix the DT properties?
> 
> Domains are a Linux concept, you have to pick a new domain number for each
> struct hw_pci you register.

Hi Arnd,

Thank you for your reply.
It is very helpful. :)

I will set domain numbers for each struct hw_pci.

> 
> > Current DT properties are as below:
> >
> > +	pcie0 at 40000000 {
> > +		compatible = "samsung,exynos5440-pcie";
> > +		reg = <0x40000000 0x4000
> > +			0x290000 0x1000
> > +			0x270000 0x1000
> > +			0x271000 0x40>;
> > +		interrupts = <0 20 0>, <0 21 0>, <0 22 0>;
> > +		#address-cells = <3>;
> > +		#size-cells = <2>;
> > +		device_type = "pci";
> > +		ranges = <0x00000800 0 0x40000000 0x40000000 0 0x00200000   /* configuration space */
> > +			  0x81000000 0 0	  0x40200000 0 0x00004000   /* downstream I/O */
> > +			  0x82000000 0 0	  0x40204000 0 0x10000000>; /* non-prefetchable memory */
> > +	};
> 
> An unrelated comment: your first "reg" field seems to overlap with part
> of your configuration space. Is that intentional?

Yes, intentional.
But, I will try to remove it.

> 
> Also, shouldn't your memory space end on a 256MB boundary, rather than
> extend up to 0x50203fff?

According to the manual of Exynos PCIe, each memory space for Exynos PCIe
can support 512MB, including I/O, CFG regions.

Is there any problem when over 256MB boundary is used?
Please let me know. :)


Best regards,
Jingoo Han

> 
> 	Arnd
