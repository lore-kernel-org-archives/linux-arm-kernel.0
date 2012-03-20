From: jonsmirl@gmail.com (jonsmirl at gmail.com)
Date: Tue, 20 Mar 2012 12:52:58 -0400
Subject: Device tree and IO map_desc.
Message-ID: <CAKON4OyHRVvdtZGt+HiCnsRT_5zTuDVBVgOx22kFC2xxFLnD+Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Is there a helper for building the IO map_desc from the device tree?

For example on Versatile. All of this map_io data is already in the
device tree, it is just repeated here.


DT_MACHINE_START(VERSATILE_PB, "ARM-Versatile (Device Tree Support)")
	.map_io		= versatile_map_io,
	.init_early	= versatile_init_early,
....
MACHINE_END

void __init versatile_map_io(void)
{
	iotable_init(versatile_io_desc, ARRAY_SIZE(versatile_io_desc));
}

static struct map_desc versatile_io_desc[] __initdata = {
	{
		.virtual	=  IO_ADDRESS(VERSATILE_SYS_BASE),
		.pfn		= __phys_to_pfn(VERSATILE_SYS_BASE),
		.length		= SZ_4K,
		.type		= MT_DEVICE
	}, {
		.virtual	=  IO_ADDRESS(VERSATILE_SIC_BASE),
		.pfn		= __phys_to_pfn(VERSATILE_SIC_BASE),
		.length		= SZ_4K,
		.type		= MT_DEVICE
	}, {
		.virtual	=  IO_ADDRESS(VERSATILE_VIC_BASE),
		.pfn		= __phys_to_pfn(VERSATILE_VIC_BASE),
		.length		= SZ_4K,
		.type		= MT_DEVICE
	}, {
...

-- 
Jon Smirl
jonsmirl at gmail.com
