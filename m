From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 22 Jun 2012 13:48:39 +0000
Subject: [PATCH v2 07/10] ARM: tegra: pcie: Add device tree support
In-Reply-To: <20120622132253.GA30704@avionic-0098.mockup.avionic-design.de>
References: <20120613081910.GB6528@avionic-0098.mockup.avionic-design.de>
 <20120622110403.GA15710@avionic-0098.mockup.avionic-design.de>
 <20120622132253.GA30704@avionic-0098.mockup.avionic-design.de>
Message-ID: <201206221348.39346.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 22 June 2012, Thierry Reding wrote:
> > It seems like this isn't working properly. For some reason both the reg
> > property of pci at 0 and pci at 1 are translated to the same parent address
> > 0x80000000. I'll have to investigate where exactly this goes wrong.
> 
> So it turns out that while of_read_number() can actually read any number
> of cells, only the two least significant are kept because it returns a
> u64. Since of_bus_default_map() uses of_read_number() the addresses
> <0 0 0> and <1 0 0> are in fact the same. I'm not sure how best to solve
> this. I'm not aware of a 128 bit integer type in the kernel, so I guess
> the better alternative would be to fix of_bus_default_map() to cope with
> #address-cells > 2 properly.

of_translate_address should get it right. Which codes uses of_read_number()?
Can it be converted to use of_translate_address()?

	Arnd
