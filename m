From: benh@kernel.crashing.org (Benjamin Herrenschmidt)
Date: Wed, 09 Nov 2016 10:12:59 +1100
Subject: [PATCH V5 2/3] ARM64 LPC: Add missing range exception for
 special ISA
In-Reply-To: <20161108114953.GB15297@leverpostej>
References: <1478576829-112707-1-git-send-email-yuanzhichang@hisilicon.com>
 <1478576829-112707-3-git-send-email-yuanzhichang@hisilicon.com>
 <20161108114953.GB15297@leverpostej>
Message-ID: <1478646779.7430.66.camel@kernel.crashing.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 2016-11-08 at 11:49 +0000, Mark Rutland wrote:
> 
> My understanding of ISA (which may be flawed) is that it's not part of
> the PCI host bridge, but rather on x86 it happens to share the IO space
> with PCI.

Sort-of. On some systems it actually goes through PCI and there's a
PCI->ISA bridge that uses substractive decoding to the legacy devices.

> So, how about this becomes:
> 
> ? Hisilicon Hip06 SoCs implement a Low Pin Count (LPC) controller, which
> ? provides access to some legacy ISA devices.
> 
> I believe that we could theoretically have multiple independent LPC/ISA
> busses, as is possible with PCI on !x86 systems. If the current ISA code
> assumes a singleton bus, I think that's something that needs to be fixed
> up more generically.
> 
> I don't see why we should need any architecture-specific code here. Why
> can we not fix up the ISA bus code in drivers/of/address.c such that it
> handles multiple ISA bus instances, and translates all sub-device
> addresses relative to the specific bus instance?

What in that code prevents that today ?

Cheers,
Ben.
