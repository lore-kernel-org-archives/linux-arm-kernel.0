From: dave.martin@linaro.org (Dave Martin)
Date: Tue, 31 Jan 2012 11:11:28 +0000
Subject: [PATCHv2 0/6] ARM: jump label support
In-Reply-To: <1327998194.13821.12.camel@computer2.home>
References: <1327757725-10114-1-git-send-email-rabin@rab.in>
 <1327998194.13821.12.camel@computer2.home>
Message-ID: <20120131111125.GB2085@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 31, 2012 at 08:23:14AM +0000, Jon Medhurst (Tixy) wrote:
> On Sat, 2012-01-28 at 19:05 +0530, Rabin Vincent wrote:
> > v2:
> >  - Use helper macros from Dave Martin's "ARM: Add generic instruction opcode
> >    manipulation helpers"
> >    http://www.arm.linux.org.uk/developer/patches/viewpatch.php?id=7278/1
> 
> This patch is broken, it contains two diff listings for
> arch/arm/include/asm/opcodes.h
> 
> The second one looks more correct as the diff accounts for commit
> 0c9030deaf59d444 (ARM: 7206/1: Add generic ARM instruction set condition
> code checks). However, when opcodes.h is included in assembler files it
> produces error as it #includes C headers.

Erm, I'm really not sure what happened there...  it looks like I somehow
pasted together an old and a new submission in one file whem I submittedo
it.  The mind boggles.

> 
> Moving the #ifndef __ASSEMBLY__ to above the #includes makes things
> compile cleanly...
> 
> +#ifndef __ASSEMBLY__
>  #include <linux/types.h>
>  #include <linux/swab.h>
> 
> -#ifndef __ASSEMBLY__

This is straightforwardly fixed -- I'll fix these issues and post back to
the list.


Now reposted here:

http://lists.infradead.org/pipermail/linux-arm-kernel/2012-January/082603.html

When people have had a chance to review, I'll update the patch in the
patch system.

Cheers
---Dave
