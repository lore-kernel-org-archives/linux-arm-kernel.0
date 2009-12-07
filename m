From: hs@denx.de (Heiko Schocher)
Date: Mon, 07 Dec 2009 09:33:05 +0100
Subject: shared memory problem on ARM v5TE using threads
In-Reply-To: <20091206141601.GB28932@n2100.arm.linux.org.uk>
References: <4B18F141.7070101@denx.de>
	<20091204131307.GE15887@n2100.arm.linux.org.uk>
	<4B1911B4.7080907@denx.de>
	<20091204154231.GB20386@n2100.arm.linux.org.uk>
	<4B1931B3.90301@denx.de>
	<20091204163850.GC20386@n2100.arm.linux.org.uk>
	<4B194C8B.7070505@denx.de>
	<20091204191349.GG20386@n2100.arm.linux.org.uk>
	<4B196473.2040407@denx.de>
	<309002C0DA137042828828FC53D7A9347E212D1152@IL-MB01.marvell.com>
	<20091206141601.GB28932@n2100.arm.linux.org.uk>
Message-ID: <4B1CBDC1.1090904@denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Russell,

Russell King - ARM Linux wrote:
> On Sun, Dec 06, 2009 at 03:53:48PM +0200, Ronen Shitrit wrote:
>> There isn't any known issues related to working with C=0 B=1 on Kirkwood.
>> Can you pls run this test on some other ARMv5 platform and approve it is
>> working.
> 
> I ran it on an ARM926EJ-S, which is ARMv5 and worked fine.
> 
> If there's no problem with C=0 B=1 mappings on Kirkwood, I've no idea
> what's going on, and I don't have any suggestion on what to try next.

Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org> suggested
me, to try the following patch, he wrote:
> But to check whether C=0 B=1 is
> indeed the issue, you may try the following patch:
> 
> diff --git a/arch/arm/mm/fault-armv.c b/arch/arm/mm/fault-armv.c
> index d0d17b6..d65816e 100644
> --- a/arch/arm/mm/fault-armv.c
> +++ b/arch/arm/mm/fault-armv.c
> @@ -23,7 +23,7 @@
>  #include <asm/pgtable.h>
>  #include <asm/tlbflush.h>
> 
> -static unsigned long shared_pte_mask = L_PTE_MT_BUFFERABLE;
> +static unsigned long shared_pte_mask = L_PTE_MT_UNCACHED;
> 
>  /*
>   * We take the easy way out of this problem - we make the
> 
> 

I tried it with this patch, and the testprogram also don;t work ...

bye
Heiko
-- 
DENX Software Engineering GmbH,     MD: Wolfgang Denk & Detlev Zundel
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
