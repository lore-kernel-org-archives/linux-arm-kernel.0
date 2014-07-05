From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Sat, 5 Jul 2014 09:08:16 +0200
Subject: [PATCH] ARM: mvebu: Fix the operand list in the inline asm of
 armada_370_xp_pmsu_idle_enter
In-Reply-To: <1404483736-16938-1-git-send-email-gregory.clement@free-electrons.com>
References: <1404483736-16938-1-git-send-email-gregory.clement@free-electrons.com>
Message-ID: <20140705090816.7724961d@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Gregory CLEMENT,

On Fri,  4 Jul 2014 16:22:16 +0200, Gregory CLEMENT wrote:
> In the inline asm part of the function armada_370_xp_pmsu_idle_enter()
> the input operand was used. The intent here was to let the compiler
> choose this register so it could do the optimization it
> needed.
> 
> However an input operand is not supposed to be modified by the inline
> asm code. This can lead to improper generated instructions.
> 
> In some case generated instruction the compiler made the choice to
> reuse the same register to store the return value. But in the assembly
> part this register was modified, so it can lead to return an wrong
> value.
> 
> The fix is to use a clobber. Thanks to this the compiler will know
> that the value of this register will be modified.
> 
> Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>

Reviewed-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>

Thanks!

Thomas
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
