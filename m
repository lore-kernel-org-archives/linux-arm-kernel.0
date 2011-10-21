From: will.deacon@arm.com (Will Deacon)
Date: Fri, 21 Oct 2011 11:59:41 +0100
Subject: [GIT PULL] DEBUG_LL platform updates for 3.2
In-Reply-To: <201110201657.51810.arnd@arndb.de>
References: <20110928103815.GA8344@e102144-lin.cambridge.arm.com>
	<20111017082506.GC21648@n2100.arm.linux.org.uk>
	<20111017092342.GB2459@mudshark.cambridge.arm.com>
	<201110201657.51810.arnd@arndb.de>
Message-ID: <20111021105941.GE30168@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd,

On Thu, Oct 20, 2011 at 03:57:49PM +0100, Arnd Bergmann wrote:
> Ok, thanks a lot. I've updated my branches now and recreated
> the for-next branch with these. Can you have a look to make sure
> that everything looks good there now?

The cpu mapping and debug-ll stuff all looks good to me, thanks. On the
downside, I'm seeing a couple of problems with your for-next branch:

1. I can't compile if !CONFIG_OF, because l2x0_init isn't declared in
   cache-l2x0.h. There seems to be some broken ifdeffery because of
   what looks like duplicate commits d94527dd and 5260f15b, although
   they are slightly different (and actually, both look broken to me
   anyway!).

2. The GIC is hosed on versatile express. Reverting e3f14d3 ("ARM: gic: add
   OF based initialization") and 2071a2a4 ("ARM: gic: add irq_domain support")
   allows me to boot again.

Cheers,

Will
