From: will.deacon@arm.com (Will Deacon)
Date: Tue, 20 Nov 2012 17:01:27 +0000
Subject: [PATCH V4 5/5] arm: mvebu: Added SMP support for Armada XP
In-Reply-To: <50ABB499.6090508@free-electrons.com>
References: <1353357360-7242-1-git-send-email-gregory.clement@free-electrons.com>
 <1353357360-7242-6-git-send-email-gregory.clement@free-electrons.com>
 <20121120164058.GB27765@mudshark.cambridge.arm.com>
 <50ABB499.6090508@free-electrons.com>
Message-ID: <20121120170127.GE27765@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 20, 2012 at 04:49:29PM +0000, Gregory CLEMENT wrote:
> On 11/20/2012 05:40 PM, Will Deacon wrote:
> > 
> > ENTRY(armada_xp_secondary_startup)
> > 	ldr     r0, =ARMADA_XP_CFB_BASE
> > 	mrc     p15, 0, r1, c0, c0, 5
> > 	and     r1, r1, #0xF
> > 	adr	lr, BSYM(secondary_startup)
> > 
> > 	/* Fallthrough */
> > 
> > ENTRY(ll_set_cpu_coherent)
> > ...
> > ENDPROC(ll_set_cpu_coherent)
> > ENDPROC(armada_xp_secondary_startup)
> > 
> > what do you think?
> > 
> 
> I prefer to keep them separate, as we can use coherency without SMP.
> That's why I create the coherency_ll.S file instead of putting everything
> in this file.

Hmm, can you elaborate a bit more on coherency without SMP please? Do these
controls also affect IO coherency?

Will
