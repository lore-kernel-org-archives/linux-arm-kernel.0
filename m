From: pali.rohar@gmail.com (Pali =?utf-8?q?Roh=C3=A1r?=)
Date: Tue, 17 Sep 2013 17:53:23 +0200
Subject: [PATCH v4 1/2] ARM: OMAP: Add secure function omap_smc3() which
 calling instruction smc #1
In-Reply-To: <20130917154331.GA9994@atomide.com>
References: <20130916171023.GA17477@localhost.localdomain>
 <20130917154331.GA9994@atomide.com>
Message-ID: <201309171753.24433@pali>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 17 September 2013 17:43:31 Tony Lindgren wrote:
> * Dave Martin <Dave.Martin@arm.com> [130916 10:18]:
> > On Sat, Sep 14, 2013 at 10:37:12AM +0100, Pali Roh?r wrote:
> > > On Sunday 08 September 2013 09:43:29 Pali Roh?r wrote:
> > > > + */
> > > > +ENTRY(omap_smc3)
> > > > +	stmfd	sp!, {r4-r11, lr}
> > > > +	mov	r12, r0		@ Copy the secure service ID
> > > > +	mov	r6, #0xff	@ Indicate new Task call
> > > > +	dsb			@ Memory Barrier (not sure if needed, copied
> > > > from omap_smc2) +	smc	#1		@ Call PPA service
> > > > +	ldmfd	sp!, {r4-r11, pc}
> > > > +ENDPROC(omap_smc3)
> > > > +
> > > > 
> > > >  ENTRY(omap_modify_auxcoreboot0)
> > > >  
> > > >  	stmfd   sp!, {r1-r12, lr}
> > > >  	ldr	r12, =0x104
> > > 
> > > Dave, it is ok now?
> > 
> > Yes, that's sufficient to warn people to stop and think (at
> > least, if someone copy-pastes it, they will likely
> > highlight the possible error by copy-pasting the comment
> > too).  Thanks.
> > 
> > Acked-by: Dave Martin <Dave.Martin@arm.com>
> 
> Have you guys checked how this works with the recently posted
> "[PATCH v6 0/5] ARM: support for Trusted Foundations secure
> monitor" series?
> 
> Regards,
> 
> Tony

Hello,

this code looks like some Tegra and "Trusted Foundations" 
specific. There is Note: The API followed by Trusted Foundations 
does *not* follow the SMC calling conventions.  Also code calling 
smc #0 instruction, so in my opinion for rx51 it is useless.

Tony, can you include this two rx51 secure patches (patch v4 1/2 
and patch v2 2/2)? Or is there some any other problem?

-- 
Pali Roh?r
pali.rohar at gmail.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 198 bytes
Desc: This is a digitally signed message part.
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130917/9e7d55e4/attachment.sig>
