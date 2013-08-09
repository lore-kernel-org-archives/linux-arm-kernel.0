From: kuninori.morimoto.gx@renesas.com (Kuninori Morimoto)
Date: Thu, 08 Aug 2013 18:33:47 -0700 (PDT)
Subject: [PATCH 1/2] ARM: shmobile: r8a7779: add HPB-DMAC support
In-Reply-To: <201308090142.08148.sergei.shtylyov@cogentembedded.com>
References: <201308090140.14515.sergei.shtylyov@cogentembedded.com>
 <201308090142.08148.sergei.shtylyov@cogentembedded.com>
Message-ID: <874nazodfr.wl%kuninori.morimoto.gx@renesas.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Hi

> From: Max Filippov <max.filippov@cogentembedded.com>
> 
> Add HPB-DMAC platform device on R8A7779 SoC along with its slave and channel
> configurations.
> 
> Signed-off-by: Max Filippov <max.filippov@cogentembedded.com>
> [Sergei: moved *enum* declaring HPB-DMAC slave IDs from now removed <mach/dma.h>
> to <mach/r8a7779.h>, removed #include <mach/dma.h> from setup-r8a7779.c, removed
> SSI-related *enum* values and SSI-related data from hpb_dmae_slaves[] and
> hpb_dmae_channels[], added ASYNCMDR.ASBTMD20 and ASYNCMDR.ASMD20 fields/values,
> fixed comments to ASYNCMDR.ASBTMD2[123]  and ASYNCMDR.ASMD2[123] fields/values,
> moved comments after the element initializers of hpb_dmae_channels[].]
> Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
(snip)
> +/* HPB-DMA */
> +
> +/* Asynchronous mode register bits */
> +#define	ASYNCMDR_ASMD41_MASK		BIT(19)	/* SDHI3 */
> +#define	ASYNCMDR_ASMD41_SINGLE		BIT(19)	/* SDHI3 */
> +#define	ASYNCMDR_ASMD41_MULTI		0	/* SDHI3 */
> +#define	ASYNCMDR_ASBTMD41_MASK		BIT(18)	/* SDHI3 */
> +#define	ASYNCMDR_ASBTMD41_BURST		BIT(18)	/* SDHI3 */
> +#define	ASYNCMDR_ASBTMD41_NBURST	0	/* SDHI3 */
> +#define	ASYNCMDR_ASMD40_MASK		BIT(17)	/* SDHI3 */
> +#define	ASYNCMDR_ASMD40_SINGLE		BIT(17)	/* SDHI3 */
> +#define	ASYNCMDR_ASMD40_MULTI		0	/* SDHI3 */
> +#define	ASYNCMDR_ASBTMD40_MASK		BIT(16)	/* SDHI3 */
> +#define	ASYNCMDR_ASBTMD40_BURST		BIT(16)	/* SDHI3 */
> +#define	ASYNCMDR_ASBTMD40_NBURST	0	/* SDHI3 */
> +#define	ASYNCMDR_ASMD39_MASK		BIT(15)	/* SDHI3 */
> +#define	ASYNCMDR_ASMD39_SINGLE		BIT(15)	/* SDHI3 */
> +#define	ASYNCMDR_ASMD39_MULTI		0	/* SDHI3 */
> +#define	ASYNCMDR_ASBTMD39_MASK		BIT(14)	/* SDHI3 */
> +#define	ASYNCMDR_ASBTMD39_BURST		BIT(14)	/* SDHI3 */
> +#define	ASYNCMDR_ASBTMD39_NBURST	0	/* SDHI3 */
> +#define	ASYNCMDR_ASMD27_MASK		BIT(13)	/* SDHI2 */
> +#define	ASYNCMDR_ASMD27_SINGLE		BIT(13)	/* SDHI2 */
> +#define	ASYNCMDR_ASMD27_MULTI		0	/* SDHI2 */
> +#define	ASYNCMDR_ASBTMD27_MASK		BIT(12)	/* SDHI2 */
> +#define	ASYNCMDR_ASBTMD27_BURST		BIT(12)	/* SDHI2 */
> +#define	ASYNCMDR_ASBTMD27_NBURST	0	/* SDHI2 */
> +#define	ASYNCMDR_ASMD26_MASK		BIT(11)	/* SDHI2 */
> +#define	ASYNCMDR_ASMD26_SINGLE		BIT(11)	/* SDHI2 */
> +#define	ASYNCMDR_ASMD26_MULTI		0	/* SDHI2 */
> +#define	ASYNCMDR_ASBTMD26_MASK		BIT(10)	/* SDHI2 */
> +#define	ASYNCMDR_ASBTMD26_BURST		BIT(10)	/* SDHI2 */
> +#define	ASYNCMDR_ASBTMD26_NBURST	0	/* SDHI2 */
> +#define	ASYNCMDR_ASMD25_MASK		BIT(9)	/* SDHI2 */
> +#define	ASYNCMDR_ASMD25_SINGLE		BIT(9)	/* SDHI2 */
> +#define	ASYNCMDR_ASMD25_MULTI		0	/* SDHI2 */
> +#define	ASYNCMDR_ASBTMD25_MASK		BIT(8)	/* SDHI2 */
> +#define	ASYNCMDR_ASBTMD25_BURST		BIT(8)	/* SDHI2 */
> +#define	ASYNCMDR_ASBTMD25_NBURST	0	/* SDHI2 */
> +#define	ASYNCMDR_ASMD23_MASK		BIT(7)	/* SDHI0 */
> +#define	ASYNCMDR_ASMD23_SINGLE		BIT(7)	/* SDHI0 */
> +#define	ASYNCMDR_ASMD23_MULTI		0	/* SDHI0 */
> +#define	ASYNCMDR_ASBTMD23_MASK		BIT(6)	/* SDHI0 */
> +#define	ASYNCMDR_ASBTMD23_BURST		BIT(6)	/* SDHI0 */
> +#define	ASYNCMDR_ASBTMD23_NBURST	0	/* SDHI0 */
> +#define	ASYNCMDR_ASMD22_MASK		BIT(5)	/* SDHI0 */
> +#define	ASYNCMDR_ASMD22_SINGLE		BIT(5)	/* SDHI0 */
> +#define	ASYNCMDR_ASMD22_MULTI		0	/* SDHI0 */
> +#define	ASYNCMDR_ASBTMD22_MASK		BIT(4)	/* SDHI0 */
> +#define	ASYNCMDR_ASBTMD22_BURST		BIT(4)	/* SDHI0 */
> +#define	ASYNCMDR_ASBTMD22_NBURST	0	/* SDHI0 */
> +#define	ASYNCMDR_ASMD21_MASK		BIT(3)	/* SDHI0 */
> +#define	ASYNCMDR_ASMD21_SINGLE		BIT(3)	/* SDHI0 */
> +#define	ASYNCMDR_ASMD21_MULTI		0	/* SDHI0 */
> +#define	ASYNCMDR_ASBTMD21_MASK		BIT(2)	/* SDHI0 */
> +#define	ASYNCMDR_ASBTMD21_BURST		BIT(2)	/* SDHI0 */
> +#define	ASYNCMDR_ASBTMD21_NBURST	0	/* SDHI0 */
> +#define	ASYNCMDR_ASMD20_MASK		BIT(1)	/* SDHI1 */
> +#define	ASYNCMDR_ASMD20_SINGLE		BIT(1)	/* SDHI1 */
> +#define	ASYNCMDR_ASMD20_MULTI		0	/* SDHI1 */
> +#define	ASYNCMDR_ASBTMD20_MASK		BIT(0)	/* SDHI1 */
> +#define	ASYNCMDR_ASBTMD20_BURST		BIT(0)	/* SDHI1 */
> +#define	ASYNCMDR_ASBTMD20_NBURST	0	/* SDHI1 */

Your "r8a7778"'s HPB-DMAC patch had "used" ASYNCMDR_xxx only,
and here, r8a7779 seems have "all" ASYNCMDR_xxx.
I don't care about it,
but, above "all" settings seems doesn't have 
channel 43 (= 23/22 bit) and channel 24 (= 21/20 bit).

Best regards
---
Kuninori Morimoto
