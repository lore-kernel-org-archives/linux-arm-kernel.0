From: fabrizio.castro@bp.renesas.com (Fabrizio Castro)
Date: Fri, 15 Sep 2017 08:57:53 +0000
Subject: [PATCH 1/8] ARM: dts: r8a7745: Add APMU node and second CPU core
In-Reply-To: <CAMuHMdWrMiHQz_Tadh3R00n+zeSnGOW-o=skbK-R-yD6Z-x2+A@mail.gmail.com>
References: <1505322341-9480-1-git-send-email-chris.paterson2@renesas.com>
 <1505322341-9480-2-git-send-email-chris.paterson2@renesas.com>
 <20170915074551.GF3924@verge.net.au>
 <CAMuHMdWrMiHQz_Tadh3R00n+zeSnGOW-o=skbK-R-yD6Z-x2+A@mail.gmail.com>
Message-ID: <TY1PR06MB0895763DA6DE79A64B9981ECC06C0@TY1PR06MB0895.apcprd06.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Simon, Geert,

> -----Original Message-----
> From: linux-renesas-soc-owner at vger.kernel.org [mailto:linux-renesas-soc-owner at vger.kernel.org] On Behalf Of Geert
> Uytterhoeven
> Sent: 15 September 2017 09:05
> To: Simon Horman <horms@verge.net.au>; Fabrizio Castro <fabrizio.castro@bp.renesas.com>
> Cc: Chris Paterson <Chris.Paterson2@renesas.com>; Rob Herring <robh+dt@kernel.org>; Mark Rutland <mark.rutland@arm.com>;
> Magnus Damm <magnus.damm@gmail.com>; Russell King <linux@armlinux.org.uk>; devicetree at vger.kernel.org; Linux-Renesas
> <linux-renesas-soc@vger.kernel.org>; linux-arm-kernel at lists.infradead.org; Geert Uytterhoeven <geert+renesas@glider.be>
> Subject: Re: [PATCH 1/8] ARM: dts: r8a7745: Add APMU node and second CPU core
>
> Hi Simon, Fabrizio,
>
> On Fri, Sep 15, 2017 at 9:45 AM, Simon Horman <horms@verge.net.au> wrote:
> > On Wed, Sep 13, 2017 at 06:05:34PM +0100, Chris Paterson wrote:
> >> From: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
> >>
> >> Add DT node for the Advanced Power Management Unit (APMU), add the
> >> second CPU core, and use "renesas,apmu" as "enable-method".
> >>
> >> Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
> >> Signed-off-by: Chris Paterson <chris.paterson2@renesas.com>
> >> ---
> >> This patch is based on renesas-devel-20170913-v4.13.
> >
> > Hi,
> >
> > with reference to "[PATCH v3 0/3] ARM: renesas: Enable SMP on R-Car E2"
> > is the CNTVOFF initialised in the boot loader of boards (in upstream)
> > for this SoC? If not I expect you will have trouble with the arch timer
> > on secondary CPU cores.

I can confirm that this patch relies on:
* "ARM: Add definition for monitor mode", and
* "ARM: shmobile: rcar-gen2: Make sure CNTVOFF is initialized on CA7/15 "
as the bootloader doesn't initialize CNTVOFF.

>
> Exactly my question.
>
> Fabrizio: Given your feedback on "[PATCH v3 0/3] ARM: renesas: Enable SMP on
> R-Car E2", I think SMP enablement on RZ/G1E has to be postponed until "ARM:
> shmobile: rcar-gen2: Make sure CNTVOFF is initialized on CA7/15" has been
> accepted upstream.

You are right, somehow we missed the comment made by Simon on Monday:

" I would like to deffer the third and last patch until v4.16 to avoid
an awkward branch dependency on the above - the branches are different
even though the tree is the same. Please resubmit this patch once the
above dependencies are present in an rc release, which at this stage
I expect to be v4.15-rc1."

Apologies for this, we will send this patch later on, once both patches have been
accepted upstream.

Simon, is this going to make the application of the remaining patches problematic?
Please, let me (or Chris) know if you want us to rebase and resend without this
patch.

Best regards,
Fabrizio

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



Renesas Electronics Europe Ltd, Dukes Meadow, Millboard Road, Bourne End, Buckinghamshire, SL8 5FH, UK. Registered in England & Wales under Registered No. 04586709.
