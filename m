From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 12 Jul 2010 11:13:12 +0100
Subject: About SECTION_SIZE_BITS for Sparsemem
In-Reply-To: <AANLkTimsEDWv9X3PeX2EBjvxl53j9R6tnAkxQuOS3CQD@mail.gmail.com>
References: <000601cb219c$c7830b60$56892220$%kim@samsung.com>
	<AANLkTin1M4CnLb1sj9mZiePjF4SvgRXySyJmT4eWpJlj@mail.gmail.com>
	<001601cb21a8$d1cdd120$75697360$%kim@samsung.com>
	<AANLkTimsEDWv9X3PeX2EBjvxl53j9R6tnAkxQuOS3CQD@mail.gmail.com>
Message-ID: <20100712101312.GE22138@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 12, 2010 at 07:08:11PM +0900, Kyungmin Park wrote:
> 27 for our board. 28 for generic.
> 
> Note that I enabled HIGHMEM and modify the VMALLOC_END to 0xd000'0000
> to test HIGHMEM.

If you want to test HIGHMEM, the way to do it is to specify a vmalloc=
parameter to the kernel, not to modify VMALLOC_END.

> Universal # bdinfo
> arch_number = 0x00000B2E
> env_t       = 0x00000000
> boot_params = 0x30000100
> DRAM bank   = 0x00000000
> -> start    = 0x30000000
> -> size     = 0x05000000
> DRAM bank   = 0x00000001
> -> start    = 0x40000000
> -> size     = 0x18000000

28 will work for this too.
