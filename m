From: mingo@kernel.org (Ingo Molnar)
Date: Wed, 17 Feb 2016 10:45:10 +0100
Subject: [PATCH v3 0/2] Consolidate redundant register/stack access code
In-Reply-To: <56BA5226.3090105@linaro.org>
References: <1454996337-7935-1-git-send-email-dave.long@linaro.org>
 <1455010600.13384.3.camel@ellerman.id.au>
 <20160209094526.GB25268@gmail.com> <56BA5226.3090105@linaro.org>
Message-ID: <20160217094510.GA27144@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


* David Long <dave.long@linaro.org> wrote:

> On 02/09/2016 04:45 AM, Ingo Molnar wrote:
> >
> >* Michael Ellerman <mpe@ellerman.id.au> wrote:
> >
> >>On Tue, 2016-02-09 at 00:38 -0500, David Long wrote:
> >>
> >>>From: "David A. Long" <dave.long@linaro.org>
> >>>
> >>>Move duplicate and functionally equivalent code for accessing registers
> >>>and stack (CONFIG_HAVE_REGS_AND_STACK_ACCESS_API) from arch subdirs into
> >>>common kernel files.
> >>>
> >>>I'm sending this out again (with updated distribution list) because v2
> >>>just never got pulled in, even though I don't think there were any
> >>>outstanding issues.
> >>
> >>A big cross arch patch like this would often get taken by Andrew Morton, but
> >>AFAICS you didn't CC him - so I just added him, perhaps he'll pick it up for
> >>us :D
> >
> >The other problem is that the second patch is commingling changes to 6 separate
> >architectures:
> >
> >  16 files changed, 106 insertions(+), 343 deletions(-)
> >
> >that should probably be 6 separate patches. Easier to review, easier to bisect to,
> >easier to revert, etc.
> >
> >Thanks,
> >
> >	Ingo
> >
> 
> I see your point but I'm not sure it could have been broken into separate 
> successive patches that would each build for all architectures.

Why? AFAICS all the functionality appears to be conditional on 
CONFIG_HAVE_REGS_AND_STACK_ACCESS_API, so it ought to build standalone as well, on 
a per arch basis, as long as the core kernel patch is applied first.

Thanks,

	Ingo
