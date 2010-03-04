From: catalin.marinas@arm.com (Catalin Marinas)
Date: Thu, 04 Mar 2010 15:29:38 +0000
Subject: USB mass storage and ARM cache coherency
In-Reply-To: <1267712512.31654.176.camel@mulgrave.site>
References: <20100226210030.GC23933@n2100.arm.linux.org.uk>
	<1267316072.23523.1842.camel@pasglop>
	<1267333263.2762.11.camel@mulgrave.site>
	<20100302211049V.fujita.tomonori@lab.ntt.co.jp>
	<1267549527.15401.78.camel@e102109-lin.cambridge.arm.com>
	<20100303215437.GF2579@ucw.cz>
	<1267709756.6526.380.camel@e102109-lin.cambridge.arm.com>
	<20100304135128.GA12191@atrey.karlin.mff.cuni.cz>
	<1267712512.31654.176.camel@mulgrave.site>
Message-ID: <1267716578.6526.483.camel@e102109-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 2010-03-04 at 14:21 +0000, James Bottomley wrote:
> The thing which was discovered in this thread is basically that ARM is
> handling deferred flushing (for D/I coherency) in a slightly different
> way from everyone else ... 

Doing a grep for PG_dcache_dirty defined in terms of PG_arch_1 reveals
that MIPS, Parisc, Score, SH and SPARC do similar things to ARM. PowerPC
and IA-64 use PG_arch_1 as a clean rather than dirty bit.

-- 
Catalin
