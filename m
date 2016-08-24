From: slash.tmp@free.fr (Mason)
Date: Wed, 24 Aug 2016 17:12:22 +0200
Subject: [PATCH v3] thermal: tango: add resume support
In-Reply-To: <2198269.vtL6N6bMEV@wuerfel>
References: <57726196.5060909@free.fr> <3377280.mzxhCYOnLL@wuerfel>
 <1472027140.2682.49.camel@intel.com> <2198269.vtL6N6bMEV@wuerfel>
Message-ID: <57BDB956.8020709@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 24/08/2016 10:32, Arnd Bergmann wrote:

> I think the ideal is to have only one set of conditionals in each
> driver, so at least you don't get a mismatch between them.
> 
> SIMPLE_DEV_PM_OPS uses conditional evaluation (but does not
> show the reference to the compiler). Annotating the functions as
> __maybe_unused lets the compiler decide for itself if they should
> be dropped or not, which means we use only the conditional inside
> of SIMPLE_DEV_PM_OPS.
> 
> Ideally, SIMPLE_DEV_PM_OPS itself should have used an IS_ENABLED()
> check instead of the #ifdef, that would have made it possible to
> just leave the function always defined with no __maybe_unused, but
> still have it dropped from the object code without a warning
> when there is no runtime reference.

I'm not sure my trivial issue deserves this much discussion. I just
want the patch to be upstream in some form.

I'll submit one more patch, with SIMPLE_DEV_PM_OPS used unconditionally,
and annotate the resume function with __maybe_unused.

This will waste the space of the struct on systems where S3 is disabled,
but it seems to be the preferred solution, IIUC.

Regards.
