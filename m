From: ext-mika.1.westerberg@nokia.com (Mika Westerberg)
Date: Fri, 16 Jul 2010 11:14:05 +0300
Subject: [PATCH v2 6/8] arm: allow passing an ELF64 header to
	elf_check_arch()
In-Reply-To: <20100510122156.GA7796@n2100.arm.linux.org.uk>
References: <cover.1273041357.git.ext-mika.1.westerberg@nokia.com>
	<3c8da055f0a84cfd1c6659d9fda24e4eb97ab9fb.1273041358.git.ext-mika.1.westerberg@nokia.com>
	<20100510112036.GC14337@n2100.arm.linux.org.uk>
	<20100510120920.GD11783@esdhcp04058.research.nokia.com>
	<20100510122156.GA7796@n2100.arm.linux.org.uk>
Message-ID: <20100716081405.GR4247@esdhcp04058.research.nokia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, May 10, 2010 at 02:21:56PM +0200, ext Russell King - ARM Linux wrote:
> On Mon, May 10, 2010 at 03:09:20PM +0300, Mika Westerberg wrote:
[...]
> > I really don't know but fs/proc/vmcore.c is coded in such way that it supports
> > both types of ELF headers. It however, passes the header to elf_check_arch()
> > which in our case should fail if it is something else than ELF32 header.
> 
> There's other arches which want elf_check_arch to be a function call, so
> I think my question needs to be looked at more closely - and possibly
> the code changed such that we don't end up with this situation.
> 
> Maybe a cleaner solution would be for vmcore.c to split its calls to
> elf_check_arch() - to be elf32_check_arch() and elf64_check_arch() ?
> Platforms where it's just a macro can define both to be elf_check_arch()
> but those where only one flavour is supported should define the unsupported
> flavour to zero - which incidentally would allow the compiler to optimize
> away the unnecessary parts of parse_crash_elf*_headers().

Russell,

I noticed that you applied all the kdump patches except this and the
CONFIG_CRASH_DUMP patch. Thanks.

Should I update this patch as you describe above? So that we don't need to
perform any casting but just have elf_check_arch() separated into 32- and 64-bit
versions. Or is there something else preventing these 2 patches to be merged?

Thanks,
MW
