From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Fri, 9 Aug 2013 16:18:30 +0200
Subject: [RFC PATCH] ARM: add workaround for ambiguous C99 stdint.h types
In-Reply-To: <20130809141424.GC3977@localhost.localdomain>
References: <1376033802-12826-1-git-send-email-ard.biesheuvel@linaro.org>
 <20130809141424.GC3977@localhost.localdomain>
Message-ID: <CAKv+Gu9TMDdyvZ=1fqRQQq_7Sz7hxWBbHqnF_mbVhh5uqJgTJg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 9 August 2013 16:14, Dave Martin <Dave.Martin@arm.com> wrote:
> On Fri, Aug 09, 2013 at 09:36:42AM +0200, Ard Biesheuvel wrote:

[...]

> Somebody else might have the opposite problem to ARM, so I'm doubtful
> about whether it's safe to do this for all arches.  The arch maintainers
> would have to comment on that.  This looks ugly in an otherwise generic
> header.
>

This is actually under arch/arm so that should not be a problem. In
fact, it's a copy of asm-generic/types.h with just the #defines added.

> (As a cosmetic thing, you can lose the #ifdefs.  #undef doesn't trigger
> an error of the specified macro doesn't already exist.)
>

I am aware of that, but I think it is cleaner not to pollute the
namespace if the defines weren't there to begin with.

Cheers,
Ard.
