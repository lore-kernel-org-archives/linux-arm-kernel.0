From: benh@kernel.crashing.org (Benjamin Herrenschmidt)
Date: Thu, 10 Nov 2016 18:08:27 +1100
Subject: [PATCH V5 2/3] ARM64 LPC: Add missing range exception for
 special ISA
In-Reply-To: <20161109111959.GB17020@leverpostej>
References: <1478576829-112707-1-git-send-email-yuanzhichang@hisilicon.com>
 <1478576829-112707-3-git-send-email-yuanzhichang@hisilicon.com>
 <20161108114953.GB15297@leverpostej>
 <1478646779.7430.66.camel@kernel.crashing.org>
 <20161109111959.GB17020@leverpostej>
Message-ID: <1478761707.7430.119.camel@kernel.crashing.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2016-11-09 at 11:20 +0000, Mark Rutland wrote:
> The big change would be to handle !MMIO translations, for which we'd
> need a runtime registry of ISA bus instance to find the relevant
> accessor ops and instance-specific data.

Yes. We do something a bit like that on ppc, we find the PCI bus
for which the IO ports match and I have a hook to register the
special indirect ISA.

It's a bit messy, we could do something nicer generically.

Cheers,
Ben.
