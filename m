From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 23 Sep 2011 17:45:06 +0200
Subject: DT vs ARM static mappings
In-Reply-To: <1316708611.4611.873.camel@hornet.cambridge.arm.com>
References: <1316519479.4611.150.camel@hornet.cambridge.arm.com>
	<201109202128.55517.arnd@arndb.de>
	<1316708611.4611.873.camel@hornet.cambridge.arm.com>
Message-ID: <201109231745.06264.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 22 September 2011, Pawel Moll wrote:
> Executive summary:
> 
> * I have second map_desc with pfn for RS1 memory map, but using the same
> virtual address as the legacy one. The legacy one is used if root of the
> tree is compatible with "arm,vexpress-legacy".
> 
> * The devices I need to use in v2m.c have aliases in DTS so I can find
> their offsets in the flat tree (the *_find_node_by_alias() function is
> rather generic and could be moved to drivers/of/fdt.c if you think it
> would be useful for others).
> 
> * There are no more users of MMIO_P2V in v2m.c, next thing I will do is
> the same in core tile; then the macro can be killed. Once this happens
> the virtual address currently taken from __MMIO_P2V(V2M_PA_CS7) will be
> replaced by some kind of "#define V2M_PERIPH_BASE 0xf8000000".
> 
> * Once Nico's changes regarding static maps are in, the manual pointer
> operations in v2m_dt_map_io can be replaced with neat ioremap()-s.
> 
> All feedback appreciated, cheers!

Look ok to me. Just a comment on the submission:

Even when you post something for review instead of inclusion, please add
a Signed-off-by: line and a diffstat.

	Arnd
