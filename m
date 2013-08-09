From: Dave.Martin@arm.com (Dave Martin)
Date: Fri, 9 Aug 2013 15:30:39 +0100
Subject: [RFC PATCH] ARM: add workaround for ambiguous C99 stdint.h types
In-Reply-To: <CAKv+Gu9TMDdyvZ=1fqRQQq_7Sz7hxWBbHqnF_mbVhh5uqJgTJg@mail.gmail.com>
References: <1376033802-12826-1-git-send-email-ard.biesheuvel@linaro.org>
 <20130809141424.GC3977@localhost.localdomain>
 <CAKv+Gu9TMDdyvZ=1fqRQQq_7Sz7hxWBbHqnF_mbVhh5uqJgTJg@mail.gmail.com>
Message-ID: <20130809143039.GD3977@localhost.localdomain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Aug 09, 2013 at 04:18:30PM +0200, Ard Biesheuvel wrote:
> On 9 August 2013 16:14, Dave Martin <Dave.Martin@arm.com> wrote:
> > On Fri, Aug 09, 2013 at 09:36:42AM +0200, Ard Biesheuvel wrote:
> 
> [...]
> 
> > Somebody else might have the opposite problem to ARM, so I'm doubtful
> > about whether it's safe to do this for all arches.  The arch maintainers
> > would have to comment on that.  This looks ugly in an otherwise generic
> > header.
> >
> 
> This is actually under arch/arm so that should not be a problem. In
> fact, it's a copy of asm-generic/types.h with just the #defines added.

Duh.  Misread your patch, sorry about that.

> > (As a cosmetic thing, you can lose the #ifdefs.  #undef doesn't trigger
> > an error of the specified macro doesn't already exist.)
> >
> 
> I am aware of that, but I think it is cleaner not to pollute the
> namespace if the defines weren't there to begin with.

Ah, I see what you mean.  Yes, that makes sense.  I'd read the #ifdefs
as just being there to avoid redefinition errors.

I'll leave the thread for other people to comment, but this looks like
a reasonable thing to do for now.

Because the kernel is not a hosted C environment, we shouldn't be including
any foreign headers which care about the distinction, except for GCC's own
headers like arm_neon.h.

Cheers
---Dave
