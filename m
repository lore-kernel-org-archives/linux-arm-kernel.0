From: sakoman@gmail.com (Steve Sakoman)
Date: Fri, 16 Dec 2011 08:52:16 -0800
Subject: [PATCH v2] ARM: OMAP3: hwmod data: disable multiblock reads on
 MMC1/2 on OMAP34xx/35xx <= ES2.1
In-Reply-To: <alpine.DEB.2.00.1112152346080.12660@utopia.booyaka.com>
References: <alpine.DEB.2.00.1110061453540.4611@utopia.booyaka.com>
 <alpine.DEB.2.00.1112152346080.12660@utopia.booyaka.com>
Message-ID: <CAGDS+nnWz5hW_13hHf51s-MhK8B-C_cMVLLmEpUA1pTCBJ3hbg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Dec 16, 2011 at 12:04 AM, Paul Walmsley <paul@pwsan.com> wrote:
>
> The HSMMC1/HSMMC2 host controllers on OMAP34xx and
> OMAP3503/3515/3525/3530 chips at ES levels prior to 3.0 can't do multiple
> block reads[1]. ?Mark the hwmod data appropriately.
>
> Reported by Dave Hylands <dhylands@gmail.com> and Steve Sakoman
> <sakoman@gmail.com>. ?Thanks to Steve Sakoman for further help
> testing this patch.
>
> 1. See for example Advisory 2.1.1.128 "MMC: Multiple Block Read
> ? Operation Issue" in _OMAP3530/3525/3515/3503 Silicon Errata_
> ? Revision F (October 2010) (SPRZ278F), available from
> ? http://focus.ti.com/lit/er/sprz278f/sprz278f.pdf
>
> Signed-off-by: Paul Walmsley <paul@pwsan.com>
> Cc: Dave Hylands <dhylands@gmail.com>
> Cc: Steve Sakoman <sakoman@gmail.com>
> ---
>
> The first version of this patch caused MMC hwmods to not be registered on
> 36xx/37xx chips. ?Thanks to Steve Sakoman for noting this. ?This version
> fixes it - tested on 37xx BeagleBoard.

I tested this on multiple different processor versions:

OMAP3503-GP ES2.1
OMAP3503-GP ES3.1
OMAP3530-GP ES3.1
OMAP3730-GP ES1.0
OMAP3730-GP ES1.2

All worked as expected, multi-block reads were enabled for all except
OMAP3503-GP ES2.1, which displayed:

omap_hsmmc omap_hsmmc.0: multiblock reads disabled due to 35xx erratum
2.1.1.128; MMC read performance may suffer

Thanks, Paul!

Tested-by: Steve Sakoman <steve@sakoman.com>
