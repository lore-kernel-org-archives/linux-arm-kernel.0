From: eric.y.miao@gmail.com (Eric Miao)
Date: Wed, 18 Jul 2012 02:01:51 +0800
Subject: [PATCH] [RFC] arm: add documentation describing Marvell families
 of SoC
In-Reply-To: <1342535201-12907-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1342535201-12907-1-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <CAMPhdO8jiTwfdk0DkhjdwMbH3Mt6=XXZKhwNH412UfNbodu7Ww@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> +PXA 2xx/3xx/93x/95 family (application processor)
> +-------------------------------------------------
> +  Flavors:
> +        PXA270, PXA271, PXA272
> +             Product Brief         : http://www.marvell.com/application-processors/pxa-family/assets/pxa_27x_pb.pdf
> +             Design guide          : http://www.marvell.com/application-processors/pxa-family/assets/pxa_27x_design_guide.pdf
> +             Developers manual     : http://www.marvell.com/application-processors/pxa-family/assets/pxa_27x_dev_man.pdf
> +             Specification         : http://www.marvell.com/application-processors/pxa-family/assets/pxa_27x_emts.pdf
> +             Specification update  : http://www.marvell.com/application-processors/pxa-family/assets/pxa_27x_spec_update.pdf
> +             Core: ARMv5 XScale core
> +        PXA300, PXA310, PXA320
> +             PXA 300 Product Brief : http://www.marvell.com/application-processors/pxa-family/assets/PXA300_PB_R4.pdf
> +             PXA 310 Product Brief : http://www.marvell.com/application-processors/pxa-family/assets/PXA310_PB_R4.pdf
> +             PXA 320 Product Brief : http://www.marvell.com/application-processors/pxa-family/assets/PXA320_PB_R4.pdf
> +             Design guide          : http://www.marvell.com/application-processors/pxa-family/assets/PXA3xx_Design_Guide.pdf
> +             Developers manual     : http://www.marvell.com/application-processors/pxa-family/assets/PXA3xx_Developers_Manual.zip
> +             Specifications        : http://www.marvell.com/application-processors/pxa-family/assets/PXA3xx_EMTS.pdf
> +             Specification Update  : http://www.marvell.com/application-processors/pxa-family/assets/PXA3xx_Spec_Update.zip
> +             Reference Manual      : http://www.marvell.com/application-processors/pxa-family/assets/PXA3xx_TavorP_BootROM_Ref_Manual.pdf
> +             Core: ARMv5 XScale core
> +        PXA930, PXA935, PXA955
> +             Core: ARMv5 compatible Sheeva core
> +   Comment: bought by Marvell from Intel in ~2006. Completely
> +   different IPs than the previously listed Marvell SoCs.
> +   Linux kernel directory: arch/arm/mach-pxa
> +
> +MMP/MMP2 family (communication processor)
> +-----------------------------------------
> +
> +   Flavors:
> +        PXA168, a.k.a Armada 168
> +             Homepage             : http://www.marvell.com/application-processors/armada-100/armada-168.jsp
> +             Product brief        : http://www.marvell.com/application-processors/armada-100/assets/pxa_168_pb.pdf
> +             Hardware manual      : http://www.marvell.com/application-processors/armada-100/assets/armada_16x_datasheet.pdf
> +             Software manual      : http://www.marvell.com/application-processors/armada-100/assets/armada_16x_software_manual.pdf
> +             Specification update : http://www.marvell.com/application-processors/armada-100/assets/ARMADA16x_Spec_update.pdf
> +             Boot ROM manual      : http://www.marvell.com/application-processors/armada-100/assets/armada_16x_ref_manual.pdf
> +             App node package     : http://www.marvell.com/application-processors/armada-100/assets/armada_16x_app_note_package.pdf
> +             Core: ARMv5 compatible Marvell PJ1 (Mohawk)
> +        PXA910
> +             Homepage             : http://www.marvell.com/communication-processors/pxa910/
> +             Product Brief        : http://www.marvell.com/communication-processors/pxa910/assets/Marvell_PXA910_Platform-001_PB_final.pdf
> +             Core: ARMv5 compatible Marvell PJ1 (Mohawk)
> +        MMP2, a.k.a Armada 610
> +             Product Brief        : http://www.marvell.com/application-processors/armada-600/assets/armada610_pb.pdf
> +             Core: ARMv7 compatible Sheeva PJ4 core
> +   Linux kernel directory: arch/arm/mach-mmp

This is so useful to Marvell processor new comers, thanks everyone to
compile this.

The PXA side might need a bit modification though, so for historical reason
there is PXA series as originated back from Intel. So there are really those
legacy ones:

  PXA21x/PXA25x/PXA27x/PXA3xx/PXA93x

The new ones developed after Marvell acquired Intel's XScale biz are:

  PXA95x/PXA168/PXA910/MMP2

And among these, they are actually categorized into two flavors:

  AP with CP: PXA93x/PXA95X/PXA910
  AP only without CP: the rest of them

And the ARM cores used are also a bit different:

  XScale (Intel's ARMv5te compatible): PXA21x/PXA25x/PXA27x/PXA3xx/PXA93x
  Marvell's PJ1 (Marvell's ARMv5te compatible): PXA168/PXA910
  Marvell's PJ4 (Marvell's ARMv7 compatible): PXA95x/MMP2

So these are really a bit complicated, by the end of the day, we would still
go the way as Arnd suggested, that to collapse PXA and MMP series into one,
so that will be simpler and easier to understand.

Considering the complications here, I would suggest to simply have a single
processor line as: PXA/MMP processor line, and list all the processor flavors
under, whether it's an AP or a AP+CP could be individually indicated.

> +
> +Credits
> +-------
> +
> + Maen Suleiman <maen@marvell.com>
> + Lior Amsalem <alior@marvell.com>
> + Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
> --
> 1.7.9.5
>
