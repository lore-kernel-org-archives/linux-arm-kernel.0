From: benh@kernel.crashing.org (Benjamin Herrenschmidt)
Date: Fri, 05 Mar 2010 08:31:23 +1100
Subject: USB mass storage and ARM cache coherency
In-Reply-To: <1267716323.6526.479.camel@e102109-lin.cambridge.arm.com>
References: <20100226210030.GC23933@n2100.arm.linux.org.uk>
	<1267316072.23523.1842.camel@pasglop>
	<1267333263.2762.11.camel@mulgrave.site>
	<20100302211049V.fujita.tomonori@lab.ntt.co.jp>
	<1267549527.15401.78.camel@e102109-lin.cambridge.arm.com>
	<20100303215437.GF2579@ucw.cz>
	<1267709756.6526.380.camel@e102109-lin.cambridge.arm.com>
	<20100304135128.GA12191@atrey.karlin.mff.cuni.cz>
	<1267712512.31654.176.camel@mulgrave.site>
	<20100304142704.GB6622@n2100.arm.linux.org.uk>
	<1267716323.6526.479.camel@e102109-lin.cambridge.arm.com>
Message-ID: <1267738283.22204.72.camel@pasglop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 2010-03-04 at 15:25 +0000, Catalin Marinas wrote:
> My understanding from this long discussion is that we cannot get the
> kernel modifying a page cache page which is already mapped in user space
> (well, ptrace does this but we flush the cache there already).

Well, we -can- but it appears that we don't have to provide coherency
in that case since the modification is always done as the result of
userspace explicitely requesting that change (aka read() syscall) and
thus userspace is responsible for the flushing.

Cheers,
Ben.
