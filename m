From: mark.rutland@arm.com (Mark Rutland)
Date: Fri, 9 Jun 2017 10:29:48 +0100
Subject: [PATCH v5] mm: huge-vmap: fail gracefully on unexpected huge
 vmap mappings
In-Reply-To: <CAKv+Gu_te54d9VU9AKYevkOvSpCBBeDQy5PE+PhX-t=ka3L8JA@mail.gmail.com>
References: <20170609082226.26152-1-ard.biesheuvel@linaro.org>
 <20170609092209.GA10665@leverpostej>
 <CAKv+Gu_te54d9VU9AKYevkOvSpCBBeDQy5PE+PhX-t=ka3L8JA@mail.gmail.com>
Message-ID: <20170609092947.GB10665@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 09, 2017 at 09:27:15AM +0000, Ard Biesheuvel wrote:
> On 9 June 2017 at 09:22, Mark Rutland <mark.rutland@arm.com> wrote:
> > On Fri, Jun 09, 2017 at 08:22:26AM +0000, Ard Biesheuvel wrote:
> >> v4: - use pud_bad/pmd_bad instead of pud_huge/pmd_huge, which don't require
> >>       changes to hugetlb.h, and give us what we need on all architectures
> >>     - move WARN_ON_ONCE() calls out of conditionals
> 
> ^^^

Ah, sorry. Clearly I scanned this too quickly.

> >> +     WARN_ON_ONCE(pud_bad(*pud));
> >> +     if (pud_none(*pud) || pud_bad(*pud))
> >>               return NULL;
> >
> > Nit: the WARN_ON_ONCE() can be folded into the conditional:
> >
> >         if (pud_none(*pud) || WARN_ON_ONCE(pud_bad(*pud)))
> >                 reutrn NULL;

> Actually, it was Dave who requested them to be taken out of the conditional.

Fair enough. My ack stands, either way!

Thanks,
Mark.
