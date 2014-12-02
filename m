From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Tue, 2 Dec 2014 14:23:37 +0100
Subject: [PATCH 6/7] KVM: arm64: re-factor hyp.S debug register code
In-Reply-To: <87ppc31t9v.fsf@linaro.org>
References: <1416931805-23223-1-git-send-email-alex.bennee@linaro.org>
 <1416931805-23223-7-git-send-email-alex.bennee@linaro.org>
 <20141130102546.GI23653@cbox> <87ppc31t9v.fsf@linaro.org>
Message-ID: <20141202132337.GD545@cbox>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Dec 01, 2014 at 11:52:44AM +0000, Alex Benn?e wrote:
> 
> Christoffer Dall <christoffer.dall@linaro.org> writes:
> 
> > On Tue, Nov 25, 2014 at 04:10:04PM +0000, Alex Benn?e wrote:
> >> This is a pre-cursor to sharing the code with the guest debug support.
> >> This replaces the big macro that fishes data out of a fixed location
> >> with a more general helper macro to restore a set of debug registers. It
> >> uses macro substitution so it can be re-used for debug control and value
> >> registers. It does however rely on the debug registers being 64 bit
> >> aligned (as they happen to be in the hyp ABI).
> >
> > can you enforce that somewhere?
> 
> There is a comment in kvm_asm.h:
> 
> /*
>  * 0 is reserved as an invalid value.
>  * Order *must* be kept in sync with the hyp switch code.
>  */
> 
> But I'm not sure how to enforce it in assembly. Is there a #pragma or
> something I can use?
> 

You can add a BUG_ON somewhere at runtime, but I wouldn't bother, you
can stick a note in that existing comment just so people don't change
the declaration of the registers to be 32-bit aligned or something else.

-Christoffer
