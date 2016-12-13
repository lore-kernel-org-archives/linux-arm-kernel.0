From: afzal.mohd.ma@gmail.com (Afzal Mohammed)
Date: Wed, 14 Dec 2016 00:14:23 +0530
Subject: [PATCH RFC 2/2] ARM: nommu: remap exception base address to RAM
In-Reply-To: <584FC18D.2050908@arm.com>
References: <20161211131028.3019-1-afzal.mohd.ma@gmail.com>
 <20161211131255.3221-1-afzal.mohd.ma@gmail.com>
 <584FC18D.2050908@arm.com>
Message-ID: <20161213184423.GC4629@afzalpc>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Tue, Dec 13, 2016 at 09:38:21AM +0000, Vladimir Murzin wrote:
> On 11/12/16 13:12, Afzal Mohammed wrote:

> > this probably would have to be made robust so as to not cause issue on
> > other v7-A's upon trying to do !MMU (this won't affect normal MMU boot),
> > or specifically where security extensions are not enabled. Also effect
> > of hypervisor extension also need to be considered. Please let know if
> > any better ways to handle this.

> You might need to check ID_PFR1 for that.

Had been searching ARM ARM for this kind of a thing, thanks.

> > +#ifdef CONFIG_REMAP_VECTORS_TO_RAM
> > +	mov	r3, #CONFIG_VECTORS_BASE	@ read VECTORS_BASE

> ldr r3,=CONFIG_VECTORS_BASE
> 
> would be more robust. I hit this in [1]
> 
> [1] https://www.spinics.net/lists/arm-kernel/msg546825.html

Russell suggested doing it in paging_init(), then probably assembly
circus can be avoided.

Regards
afzal
