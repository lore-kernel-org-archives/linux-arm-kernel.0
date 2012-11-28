From: pawel.moll@arm.com (Pawel Moll)
Date: Wed, 28 Nov 2012 12:36:04 +0000
Subject: vexpress compilation error in next-20121127
In-Reply-To: <50B56601.5010305@broadcom.com>
References: <50B56601.5010305@broadcom.com>
Message-ID: <1354106164.2987.21.camel@hornet>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2012-11-28 at 01:16 +0000, Markus Mayer wrote:
> Hi Pawel,
> 
> There seems to be an issue compiling vexpress at this point. The problem 
> being that vexpress' makefile references reset.o, but there's no reset.c 
> in arch/arm/mach-vexpress.
> 
> [...]
>    CC      arch/arm/mach-bcm/board_bcm.o
>    LD      arch/arm/mach-bcm/built-in.o
>    CC      arch/arm/mach-vexpress/v2m.o
> make[1]: *** No rule to make target `arch/arm/mach-vexpress/reset.o', 
> needed by `arch/arm/mach-vexpress/built-in.o'.  Stop.
> make: *** [arch/arm/mach-vexpress] Error 2
> 
> The commit in question seems to be this:
> 
> http://git.kernel.org/?p=linux/kernel/git/arm/arm-soc.git;a=commitdiff;h=38669e045dbf8f62a008898a7fb1e93975b3817c
> 
> It adds the reference to reset.o to the makefile, but doesn't add 
> reset.c itself. That doesn't seem right -- or did I overlook anything 
> obvious?

That's strange... The reset.c comes from the vexpress/drivers branch,
which seems to be merged correctly in the arm-soc:

http://git.kernel.org/?p=linux/kernel/git/arm/arm-soc.git;a=tree;f=arch/arm/mach-vexpress;hb=refs/heads/for-next

And it's there in the linux-next head:

https://git.kernel.org/?p=linux/kernel/git/next/linux-next.git;a=tree;f=arch/arm/mach-vexpress

Also the next-20121127 looks good for me:

https://git.kernel.org/?p=linux/kernel/git/next/linux-next.git;a=tree;f=arch/arm/mach-vexpress;h=47f9de5972efaa719c35bb9dce177fbd2954647c;hb=ce2931ab5e448a93fee55d9d82de9f5e754ff6f7

Are you sure you've checked out the correct tag?

Pawe?
