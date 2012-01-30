From: marek.vasut@gmail.com (Marek Vasut)
Date: Mon, 30 Jan 2012 13:24:13 +0100
Subject: [PATCH] mtd/gpmi : add BBT support
In-Reply-To: <4F267F21.1030204@freescale.com>
References: <1327898174-13656-1-git-send-email-b32955@freescale.com>
 <20120130104428.GB15596@pengutronix.de> <4F267F21.1030204@freescale.com>
Message-ID: <201201301324.13962.marek.vasut@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> >> The bootloader usually is burned on /dev/mtd0, while the BBT is placed
> >> at the end
> >> of the NAND chip.
> >> 
> >> I tested the NAND boot mode too.
> >> 
> >> What's your concern?
> > 
> > Bootloaders may also need to write to NAND. So, they need to share the
> 
> Do you mean the uboot may write something to the NAND?

Yes it can, mainline for certain and ... surprisingly even the one provided by 
freescale ;-)

> Could you show me some more detail cases?

Type "help" in the command prompt and look for "nand" ;-)
> 
> > same bad block information with the kernel. Currently, I am not aware of
> > a bootloader for mxs which support BBT without OOB. Unless this has
> > changed meanwhile, we shouldn't make this default, because they can't
> 
> The NAND_BBT_NO_OOB makes the BBT written to the NAND with the ECC enabled.
> 
> > share the same information then. To be on the safe side regardings

The mainline incarnation of this should be able to work with the BBT just fine. 
You can give it a go, mx28evk (the freescale kit) is supported.
> 
> The kobs-ng which burns the bootloader to the NAND will also burn the
> whole BBT
> to the NAND too.
> 
> So I think the bootloader and the kernel share the same BBT information.
> 
> But if the bootloader can make some block bad, the BBT information
> becomes different.
> Does the bootloader have the feature to make some block bad?

Sure

M
> 
> 
> Br
> Huang Shijie
> 
> > regressions, we shouldn't make this default as well, come to think of
> > it.
> > 
> > Regards,
> > 
> >    Wolfram
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
