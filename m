From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 24 Jun 2014 15:08:22 +0100
Subject: VFP handling in multiplatform feroceon kernels
In-Reply-To: <7416978.W29blLsymn@wuerfel>
References: <7416978.W29blLsymn@wuerfel>
Message-ID: <20140624140822.GO32514@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 24, 2014 at 03:17:06PM +0200, Arnd Bergmann wrote:
> Since 3.16, we have the ability to build a multiplatform kernel
> that includes both kirkwood (feroceon) and some other ARMv5 CPU.
> 
> I accidentally stumbled over a bug in the VFP code that looks
> like it will break at least ARM9 VFP support if CPU_FEROCEON
> is also enabled, introduced by this (old) commit:

This is down confusion in the ID registers, and is something we've
known about for a very long time.

There is nothing that can be done about this: Marvell specifically
designed this variant of the Feroceon to look 100% identical to an
ARM926 in every respect, so it could in theory run anything that
checked for an ARM926 CPU.  However, the implementation is soo buggy
that the result is that software written for ARM926 can't run on it.

The net result is that the Feroceon is indistinguishable from an
ARM926 in every respect, except you need the work-arounds for
Feroceon to work.  This makes Feroceon fundamentally incompatible
with a single zImage.

-- 
FTTC broadband for 0.8mile line: now at 9.7Mbps down 460kbps up... slowly
improving, and getting towards what was expected from it.
