From: niklas.soderlund@ragnatech.se (Niklas =?iso-8859-1?Q?S=F6derlund?=)
Date: Thu, 10 Mar 2016 14:43:25 +0100
Subject: [PATCH 00/30] ARM: dts: r8a779[0-4]: Reference both DMA
 controllers
In-Reply-To: <CAMuHMdXF4FMLg=Y_cZ2chjzGWAV90N=vLsCkPKGmmYx5mFY64Q@mail.gmail.com>
References: <1457609782-24108-1-git-send-email-niklas.soderlund+renesas@ragnatech.se>
 <CAMuHMdXF4FMLg=Y_cZ2chjzGWAV90N=vLsCkPKGmmYx5mFY64Q@mail.gmail.com>
Message-ID: <20160310134325.GA1111@bigcity.dyn.berto.se>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Geert,

On 2016-03-10 13:20:56 +0100, Geert Uytterhoeven wrote:
> Hi Niklas,
> 
> On Thu, Mar 10, 2016 at 12:35 PM, Niklas S?derlund
> <niklas.soderlund+renesas@ragnatech.se> wrote:
> > R-Car Gen2 have two DMA controllers, which are equivalent. However DMA
> > slaves were tied only to a single DMA controller in .dtsi. This series
> > add references to to both DMA controllers for all nodes that previously
> > only referenced one of them. It also adds dma references to the SDHI
> > nodes for r8a7794 which according to the datasheet should work but I
> > have not access to HW to verify.
> >
> > Tested on Koelsch (r8a7791) by altering the compatible value of either
> > dmac0 or dmac1 and verifying that the DMA slaves pick the DMA controller
> > that is instantiated.
> 
> Thanks for your series!
> 
> If you fix the subject of patch 30:
> Acked-by: Geert Uytterhoeven <geert+renesas@glider.be>

Thanks for your review and that you found my error in the subject.

> 
> I guess this is against v4.5-rc7? It doesn't apply against
> renesas-devel-20160308-v4.5-rc7.
> Unfortunately you'll have to rebase against Simon's tree, and add scif2
> on r8a7790, and i2c[6-8] on r8a7793.

I will rebase and update the relevant patches to include the additions 
to r8a7790 and r8a7793.

> 
> Hint for the other reviewers: use the --color-words option of git diff/show.
> 
> Gr{oetje,eeting}s,
> 
>                         Geert
> 
> --
> Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org
> 
> In personal conversations with technical people, I call myself a hacker. But
> when I'm talking to journalists I just say "programmer" or something like that.
>                                 -- Linus Torvalds

-- 
Regards,
Niklas S?derlund
