From: slash.tmp@free.fr (Mason)
Date: Fri, 16 Oct 2015 11:51:13 +0200
Subject: l2c: Kernel panic in l2c310_enable() in non-secure mode
In-Reply-To: <561F88F4.40401@sigmadesigns.com>
References: <561E6407.6000002@sigmadesigns.com>
 <561E6B1F.1070701@sigmadesigns.com>
 <20151014174721.GR32532@n2100.arm.linux.org.uk>
 <561F7948.8080201@sigmadesigns.com> <561F88F4.40401@sigmadesigns.com>
Message-ID: <5620C891.9040707@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 15/10/2015 13:07, Marc Gonzalez wrote:

> One more question on this topic:
> 
> When Linux sees L310_AUX_CTRL_FULL_LINE_ZERO set, it then enables:
> 
>   bit3 = Write full line of zeros mode
>   bit2 = L1 Prefetch enable
>   bit1 = L2 Prefetch hint enable
> 
> Why are the "prefetch enable" features bundled in the operation?

Russell,

The prefetch enable bits were introduced in commit 8ef418c7178fa
("ARM: l2c: trial at enabling some Cortex-A9 optimisations")

I didn't find a ML thread discussing that patch. Whenever possible,
could you provide some insight into the rationale leading you to
set bits 1 and 2 along with bit 3? (The ARM integrator here tends
to think the two concepts are somewhat orthogonal.)

Regards.
