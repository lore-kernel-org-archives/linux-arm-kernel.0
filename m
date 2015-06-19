From: horms@verge.net.au (Simon Horman)
Date: Fri, 19 Jun 2015 12:43:24 +0900
Subject: [PATCH 0/5] ARM: shmobile: R-Mobile APE6 / R-Car Gen2: Use
 "arm,gic-400"
In-Reply-To: <1434546216-10773-1-git-send-email-geert+renesas@glider.be>
References: <1434546216-10773-1-git-send-email-geert+renesas@glider.be>
Message-ID: <20150619034323.GD22912@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 17, 2015 at 03:03:31PM +0200, Geert Uytterhoeven wrote:
> 	Hi Simon, Magnus,
> 
> This patch series replaces the "arm,cortex-a15-gic" compatible value for
> the GIC device node by "arm,gic-400" in the R-Mobile APE6 and R-Car Gen2
> device trees:
>   - The R-Mobile APE6 documentation states it has a GIC-400,
>   - The R-Car Gen2 is assumed to have a GIC-400, too.
> 
> The presence of a GIC-400 has been confirmed on APE6 and R-Car M2 by
> reading the GICD_IIDR register[1], which reports 0x0200043b (GIC-400 =
> 0x02, ARM = 0x43b).
> 
> This change has no effect on runtime behavior, as currently[2] the GIC
> driver treats both compatible values the same.
> 
> This has been tested on r8a73a4/ape6evm and r8a7791/koelsch.
> 
> Thanks for applying!
> 
> [1] Using Mark Rutland's patch in https://lkml.org/lkml/2015/4/29/259,
>     or from U-Boot using "md 0xf1001008 1",
> [2] Backporter's note: since commit 144cb08864ed44be ("irqchip: gic: Add
>     binding probe for ARM GIC400").

Thanks, I have queued these up after testing that the following still boot.

r8a73a4/ape6evm, r8a7790/lager r8a7791/koelsch, r8a7794/alt

I am unable to test the r8a7794/gose at this time.
