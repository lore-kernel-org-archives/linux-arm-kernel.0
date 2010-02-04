From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 4 Feb 2010 17:02:30 +0000
Subject: CONFIG_SMP: Status of pending patches?
In-Reply-To: <4B6AFA10.9060004@googlemail.com>
References: <4B6AFA10.9060004@googlemail.com>
Message-ID: <20100204170230.GD27344@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Feb 04, 2010 at 05:47:12PM +0100, Dirk Behme wrote:
>
> Regarding two of Catalin's CONFIG_SMP patches in linux-arm git, I wonder 
> what's the recent status regarding mainline inclusion? The two patches
>
> 1. Global ASID allocation on SMP
> http://www.linux-arm.org/git?p=linux-2.6.git;a=commit;h=33618544e3151700950707c920ea2f7ec3e0b7ba
>
> 2. ARM: Implement read/write for ownership in the ARMv6 DMA cache ops
> http://www.linux-arm.org/git?p=linux-2.6.git;a=commit;h=1bb211d4b81d65760d6befb17a01348db79459b1
>
> seem to be essential for SMP stability.
>
> Patch (1) is marked as applied [1]. Will it be part of final 2.6.33?

Patch 1 is queued for the next merge window.

> For 
> patch (2) I couldn't find anything. Is planned for mainline inclusion, 
> too?

I don't think patch 2 is up to being ready yet, and it's outdated with
the respect to the rest of the DMA fixes.

Like it or not, 2.6.33 is not going to see a material improvement; the
fixes for this are just too large and invasive for -rc kernels (as I
pointed out before the previous merge window, when they ended up being
dropped from that merge).

Unfortunately, they're still undergoing testing; TI are reporting weird
failures on the patch set, but it's inconclusive at the moment - and it's
looking like this testing might overrun this coming merge window.  That
means they could end up missing their second second merge window.

It annoys me that I can't test them myself in any reasonable and
meaningful way - essentially my patch set is based on theory.

So, I'm going to continue sitting on them, not pushing them into mainline
until we know what's going on, and whether any of this stuff is actually
working properly.

They might get in for 2.6.35... I've just got no idea how long this is
going to take to sort out.
