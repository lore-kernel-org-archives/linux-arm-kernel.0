From: marex@denx.de (Marek Vasut)
Date: Tue, 12 Jun 2012 13:09:46 +0200
Subject: [PATCH] MXS: Add DENX M28 dts file
In-Reply-To: <4FD6DF01.4000809@freescale.com>
References: <1338084735-12083-1-git-send-email-marex@denx.de>
 <201206111259.36917.marex@denx.de> <4FD6DF01.4000809@freescale.com>
Message-ID: <201206121309.46921.marex@denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Huang Shijie,

> ? 2012?06?11? 18:59, Marek Vasut ??:
> > Dear Huang Shijie,
> > 
> >> ? 2012?06?11? 13:45, Shawn Guo ??:
> >>> On Fri, Jun 08, 2012 at 09:03:09PM +0200, Marek Vasut wrote:
> >>>>> I just applied Huang's gpmi changes below.  Can you please rebase the
> >>>>> the patch on top of it?  If you have the same pin setup as imx28-evk,
> >>>>> we can save above data completely.
> >>>>> 
> >>>>> http://thread.gmane.org/gmane.linux.ports.arm.kernel/169351
> >>>> 
> >>>> Well, GPMI NAND doens't work for me (AGAIN). Screw this, I'm not
> >>>> debuging it for the third damn time only to be told to rebase it again
> >>>> and that all I did was for naught. Sorry
> >>> 
> >>> Hmm, I was told by Huang that GPMI NAND works for him.  As I do not
> >> 
> >> sorry. It can not works now. :(
> >> 
> >> There is a bug in the GPMI-NAND driver( i guess).
> >> 
> >> The pinmux, clocks, IO resources are all correct.
> >> And the ECC read page/ ECC write page are ok too.
> >> 
> >> But the UBIFS can not works.
> > 
> > I sent you that link ... it might be the problem you're facing. And if it
> > isn't, then you should fix that too, since you're depending on undefined
> > behavior there.
> 
> thanks for your link. But it's not the root cause.

But that doesn't quite change the fact that it is also a bug which should be 
fixed, right? Will you please investigate and fix it?

> The ECC read-page/write-page are _NOT_ stable. They can fail in some
> unknown cases.

Rant: I think I've said it multiple times already, but Linux is a community 
effort. That's why the quality is so high and bug count so low. It was complete 
flub to have GPMI NAND driver in mainline linux for almost 6 months without 
merging the actual code that'd let anyone else test it and wait for the DT 
bindings. Maybe if you did merge it, this and many other bugs would already be 
fixed.

> Best Regards
> Huang Shijie
> 
> >> I am debugging it now.
> >> 
> >> Huang Shijie
> >> 
> >>> have NAND device to play, can you guys aligned here?
> > 
> > Best regards,
> > Marek Vasut

Best regards,
Marek Vasut
