From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Sun, 30 Nov 2014 12:08:42 +0100
Subject: [PATCH] kvm: arm: vgic: Let one looping code instead of two
 looping code
In-Reply-To: <547C7570.1020006@gmail.com>
References: <547A9A7C.1080508@gmail.com> <20141130100718.GA484@cbox>
 <547C7570.1020006@gmail.com>
Message-ID: <20141130110842.GA83910@macair>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Dec 01, 2014 at 10:04:32PM +0800, Chen Gang wrote:
> On 11/30/2014 06:07 PM, Christoffer Dall wrote:
> > On Sun, Nov 30, 2014 at 12:18:04PM +0800, Chen Gang wrote:
> >> Use one looping instead of two, so can let code more simpler and get a
> >> little better performance.
> >>
> >> Signed-off-by: Chen Gang <gang.chen.5i5j@gmail.com>
> > 
> > Performance?  Please, this is vgic_create....
> > 
> 
> I guess your meaning is "this code is not performance sensitive", do not
> mean "1 looping can not get a little better performance than 2 looping".
> If what I guess is incorrect, please let me know.
> 

I doubt if this is even measureable.  Have you even looked at how this
compiles?

> > This does nothing else than introduce churn.
> > 
> 
> I don't think it does nothing, it can let code simpler than before:
> remove the redundant looping -- the 2 looping do the same thing which
> is commented just above the firstly looping.

I don't think there's any big benefit here.

> 
> And I don't know which churn this patch will introduce. At least, no one
> want to waste him/her time resources to intend churn, please provide
> more details about it.
> 
> If kvm does not like me, or does not like members to find issues based
> on reading source code, please let me know (no reply means kvm does not
> like me or this way), I will quit, so can save time resources both.
> 
I appreciate your efforts and welcome anybody to contribute to the code
base.  But you seem to be insisting on changing some insignificant
details, and we just have bigger fish to fry right now.  Sorry.

This is not about anyone not liking someone, it is about the code and
whether there's a need to take this patch right now or not.

-Christoffer
