From: olof@lixom.net (Olof Johansson)
Date: Fri, 18 Dec 2009 09:35:12 -0600
Subject: "Flush the D-cache during copy_user_highpage" breaks compile
	for v7 on -rc1
In-Reply-To: <20091218081851.GB28704@n2100.arm.linux.org.uk>
References: <20091218031923.GA4575@atomide.com>
	<20091218081851.GB28704@n2100.arm.linux.org.uk>
Message-ID: <20091218153512.GA30512@lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Fri, Dec 18, 2009 at 08:18:52AM +0000, Russell King - ARM Linux wrote:
> On Thu, Dec 17, 2009 at 07:19:24PM -0800, Tony Lindgren wrote:
> > Hi Catalin,
> > 
> > You may have already run into this, but if not, looks like commit
> > 115b22474eb1905da2f606a057da3455833333d3 breaks compile for v7:
> > 
> > arch/arm/mm/copypage-v6.c: In function 'v6_copy_user_highpage_nonaliasing':
> > arch/arm/mm/copypage-v6.c:51: error: implicit declaration of function '__cpuc_flush_dcache_page'
> > 
> > Undoing that makes it work again.
> 
> It's a combination of changes - my initial changes for fixing the ARMv7
> DMA support went in last night, but were based on a tree older than
> Catalin's changes, which had already been committed.
> 
> My test build didn't catch any of these - it's the usual problem that
> there is no way to adequately build-test the ARM kernel in a reasonable
> time anymore.

FWIW: I've added an omap3_defconfig, that should be a superset of the
configs used on the OMAP3 boards, to catch as much as possible affecting
those boards with one single build. Takes about 90 seconds for me to
build on a $600 PC, and Stephen builds it for every linux-next too.


-Olof
