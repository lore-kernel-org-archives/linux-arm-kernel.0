From: pieterg@gmx.com (pieterg)
Date: Thu, 8 Jul 2010 14:55:16 +0200
Subject: machine definition for colibri-pxa3xx
In-Reply-To: <201007081406.20038.marek.vasut@gmail.com>
References: <201007081236.39550.pieterg@gmx.com>
	<201007081406.20038.marek.vasut@gmail.com>
Message-ID: <201007081455.16353.pieterg@gmx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 08 July 2010 14:06:19 Marek Vasut wrote:
> Dne ?t 8. ?ervence 2010 12:36:39 pieterg napsal(a):
> > At the moment, colibri-pxa300.c as well as colibri-pxa320.c have their
> > own machine definition.
> >
> > However, running a kernel built with CONFIG_MACH_COLIBRI300 and
> > CONFIG_MACH_COLIBRI320 on a colibri 300 or 310, it will match the 320
> > machine definition, and therefore use colibri-pxa320.c.
>
> Huh? Your bootloader is messed up? What bootloader do you use ?

Perhaps? I'm using u-boot.

Actually, I now see what you mean.

gd->bd->bi_arch_number = MACH_TYPE_COLIBRI320;

that causes it.
My bootloader (modified 1.3.3) is from before MACH_TYPE_COLIBRI300 was 
added.
