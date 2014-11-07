From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Fri, 7 Nov 2014 15:51:50 +0100
Subject: [PATCH 2/2] arm64: kvm: eliminate literal pool entries
In-Reply-To: <545CDACC.5070406@arm.com>
References: <1415369554-7444-1-git-send-email-ard.biesheuvel@linaro.org>
 <1415369554-7444-2-git-send-email-ard.biesheuvel@linaro.org>
 <545CDACC.5070406@arm.com>
Message-ID: <20141107145150.GA18586@cbox>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 07, 2014 at 02:44:28PM +0000, Marc Zyngier wrote:
> On 07/11/14 14:12, Ard Biesheuvel wrote:
> > Replace two instances of 'ldr xN, =(constant)' in the world switch
> > hot path with 'mov' instructions.
> > 
> > Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> > ---
> >  arch/arm64/kvm/hyp.S | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> > 
> > diff --git a/arch/arm64/kvm/hyp.S b/arch/arm64/kvm/hyp.S
> > index b72aa9f9215c..fbe909fb0a1a 100644
> > --- a/arch/arm64/kvm/hyp.S
> > +++ b/arch/arm64/kvm/hyp.S
> > @@ -761,10 +761,10 @@
> >  .macro activate_traps
> >  	ldr     x2, [x0, #VCPU_HCR_EL2]
> >  	msr     hcr_el2, x2
> > -	ldr	x2, =(CPTR_EL2_TTA)
> > +	mov	x2, #CPTR_EL2_TTA
> >  	msr	cptr_el2, x2
> >  
> > -	ldr	x2, =(1 << 15)	// Trap CP15 Cr=15
> > +	mov	x2, #(1 << 15)	// Trap CP15 Cr=15
> >  	msr	hstr_el2, x2
> >  
> >  	mrs	x2, mdcr_el2
> > 
> 
> Looks good to me.
> 
> Acked-by: Marc Zyngier <marc.zyngier@arm.com>
> 
Yup, me too:

Acked-by: Christoffer Dall <christoffer.dall@linaro.org>
