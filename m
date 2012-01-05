From: swarren@nvidia.com (Stephen Warren)
Date: Thu, 5 Jan 2012 08:47:15 -0800
Subject: [PATCH 5/6] gpio: tegra: Dynamically allocate IRQ base, and
 support DT
In-Reply-To: <20120105131736.GC4641@page>
References: <1325702378-20863-1-git-send-email-swarren@nvidia.com>
 <1325702378-20863-5-git-send-email-swarren@nvidia.com>
 <20120105131736.GC4641@page>
Message-ID: <74CDBE0F657A3D45AFBB94109FB122FF17761F1683@HQMAIL01.nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Jamie Iles wrote at Thursday, January 05, 2012 6:18 AM:
> On Wed, Jan 04, 2012 at 11:39:37AM -0700, Stephen Warren wrote:
> > Enhance the driver to dynamically allocate the base IRQ number, and
> > create an IRQ domain for itself. The use of an IRQ domain ensures that
> > any device tree node interrupts properties are correctly parsed.
...
> > diff --git a/Documentation/devicetree/bindings/gpio/gpio_nvidia.txt
...
> > +- #interrupt-cells : Should be 2.
> > +  The first cell is the GPIO number.
> > +  The second cell is used to specify flags:
> > +    bits[3:0] trigger type and level flags:
> > +      1 = low-to-high edge triggered.
> > +      2 = high-to-low edge triggered.
> > +      4 = active high level-sensitive.
> > +      8 = active low level-sensitive.
> > +      Valid combinations are 1, 2, 3, 4, 8.
> 
> It looks to me like the tegra gpio driver can do IRQ_TYPE_EDGE_BOTH so I
> would expect 12 to be a valid combination too no?

I believe EDGE_BOTH is 3 (OR of edge low and edge high)

-- 
nvpbulic
