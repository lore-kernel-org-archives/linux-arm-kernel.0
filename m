From: Dave.Martin@arm.com (Dave Martin)
Date: Wed, 25 Jul 2018 15:41:16 +0100
Subject: [RFC PATCH 10/16] KVM: arm64: Add a vcpu flag to control SVE
 visibility for the guest
In-Reply-To: <20180725134359.rebcjfsigkvbs2n5@kamzik.brq.redhat.com>
References: <1529593060-542-1-git-send-email-Dave.Martin@arm.com>
 <1529593060-542-11-git-send-email-Dave.Martin@arm.com>
 <20180719110810.2edkoz53b6vrafum@kamzik.brq.redhat.com>
 <20180725114103.GG4240@e103592.cambridge.arm.com>
 <20180725134359.rebcjfsigkvbs2n5@kamzik.brq.redhat.com>
Message-ID: <20180725144115.GO4240@e103592.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 25, 2018 at 03:43:59PM +0200, Andrew Jones wrote:
> On Wed, Jul 25, 2018 at 12:41:06PM +0100, Dave Martin wrote:

[...]

> > The main purpose of system_supports_sve() here is to shadow the check on
> > vcpu_arch->flags with a static branch.  If the system doesn't support
> > SVE, we don't pay the runtime cost of the dynamic check on
> > vcpu_arch->flags.
> > 
> > If the kernel is built with CONFIG_ARM64_SVE=n, the dynamic check should
> > be entirely optimised away by the compiler.
> 
> Ah, that makes sense. Thanks for clarifying it.
> 
> > 
> > I'd rather not add an explicit comment for this because the same
> > convention is followed elsewhere -- thus for consistency the comment
> > would need to be added in a lot of places.
> 
> Agreed that we don't need a comment. A note in the commit message might
> have been nice though.

Sure, I'll add something in the respin.

Cheers
---Dave
