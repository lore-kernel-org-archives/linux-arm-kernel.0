From: will.deacon@arm.com (Will Deacon)
Date: Mon, 12 Jan 2015 13:49:55 +0000
Subject: [PATCH] arm64: dump: Fix implicit inclusion of definition for
 PCI_IOBASE
In-Reply-To: <20150112134611.GF16706@leverpostej>
References: <1421065784-31708-1-git-send-email-broonie@kernel.org>
 <20150112134611.GF16706@leverpostej>
Message-ID: <20150112134954.GD13360@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 12, 2015 at 01:46:11PM +0000, Mark Rutland wrote:
> On Mon, Jan 12, 2015 at 12:29:44PM +0000, Mark Brown wrote:
> > Since c9465b4ec37a68425 (arm64: add support to dump the kernel page tables)
> > allmodconfig has failed to build on arm64 as a result of:
> > 
> > ../arch/arm64/mm/dump.c:55:20: error: 'PCI_IOBASE' undeclared here (not in a function)
> 
> When I build a v3.19-rc4 allmodconfig, I don't see this failure, but I
> agree that we need the explicit include for PCI_IOBASE.

It's one of the failures in -next, but it didn't get resolved by Paul's
series unfortunately (I probably just did a defconfig build for that).

Will
