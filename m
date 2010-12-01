From: ralf@linux-mips.org (Ralf Baechle)
Date: Wed, 1 Dec 2010 13:24:37 +0000
Subject: Change of Default kernel page size i.e 4KB
In-Reply-To: <AANLkTi=4gtEC9fZyvc9g6uHecvjPrr0dDc==KsDOvq2Q@mail.gmail.com>
References: <AANLkTi=4gtEC9fZyvc9g6uHecvjPrr0dDc==KsDOvq2Q@mail.gmail.com>
Message-ID: <20101201132437.GA32555@linux-mips.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Dec 01, 2010 at 01:50:13PM +0530, naveen yadav wrote:

> Cc: kernelnewbies at nl.linux.org,
> 	linux-arm-kernel-request at lists.arm.linux.org.uk,
                        ^^^^^^^^ WTF?
> 	linux-mips at linux-mips.org

> I have few drivers and very big application running on ARM and MIPS target.
> I want to check the performance by changing the page size ie.
> 
> 8K, 16K, 32K etc.
> 
> Is it possile, If yes then what all care i need to take .

For MIPS: Rebuild kernel with support for the new kernel size.  Few MIPS
cores.  Note that the `odd? page sizes, that those that aren't a power
of 4 are only supported by Cavium while all MIPS III and newer processors
support even `even? sizes 4KB, 16KB and 64KB.

Aside of rebuilding the kernel you also need a suitable userland; older
versions of binutils will produce binaries that only run
for 4kB page sizes.

For ARM the page size is fixed at 4kB which will simplify your benchmarking
efforts ;)

Performance gains very much depends on the workload but in general larger
sizes are beneficial except maybe for systems with very little memory.

  Ralf
