From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Tue, 15 Nov 2016 21:37:07 +0000
Subject: Default atomic_pool_size value & changing it
In-Reply-To: <CACna6ryHrkhxF-HKDB-+if=7XC9D=89oTEVyR9PJWpYAWnoVzw@mail.gmail.com>
References: <CACna6ryHrkhxF-HKDB-+if=7XC9D=89oTEVyR9PJWpYAWnoVzw@mail.gmail.com>
Message-ID: <20161115213706.GZ1041@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 15, 2016 at 10:15:51PM +0100, Rafa? Mi?ecki wrote:
> I've hit problem with allocating enough coherent DMA memory. Obviously
> there is a limit of this memory as pointed by:
> [ 0.283667] DMA: preallocated 256 KiB pool for atomic coherent allocations

This is for _atomic_ coherent allocations, not for normal coherent
allocations.  Normal coherent allocations come from the CMA memory.
Make sure you have CMA enabled, and you have enough of it.

Boot with cma=xxxMB with xxx set appropriately.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
