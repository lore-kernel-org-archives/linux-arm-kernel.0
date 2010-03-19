From: catalin.marinas@arm.com (Catalin Marinas)
Date: Fri, 19 Mar 2010 14:41:17 +0000
Subject: Highmem issues with MMC filesystem
In-Reply-To: <alpine.LFD.2.00.1003180904440.31128@xanadu.home>
References: <037201cac5d7$6c5b8c60$LocalHost@wipblrx0099946>
	<alpine.LFD.2.00.1003170946250.31128@xanadu.home>
	<043e01cac5df$c3ec1b90$LocalHost@wipblrx0099946>
	<alpine.LFD.2.00.1003171050160.31128@xanadu.home>
	<20100318092352.GD8267@n2100.arm.linux.org.uk>
	<c70ff3ad1003180415x58e29baaj9b8b77e6378cb0cb@mail.gmail.com>
	<20100318112453.GA19544@n2100.arm.linux.org.uk>
	<alpine.LFD.2.00.1003180904440.31128@xanadu.home>
Message-ID: <1269009677.31227.10.camel@e102109-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 2010-03-18 at 13:20 +0000, Nicolas Pitre wrote:
> The only way a highmem page can be unmapped is through kunmap_atomic()
> where an explicit __cpuc_flush_dcache_area() is performed, or through
> flush_all_zero_pkmaps() where flush_cache_kmaps() translates into
> flush_cache_all().

The thing that I couldn't fully understand with the kunmap_atomic()
function is that there is a path (when kvaddr < FIXADDR_START) where no
cache flushing occurs. Can this not happen?

-- 
Catalin
