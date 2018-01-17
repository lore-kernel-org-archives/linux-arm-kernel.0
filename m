From: Dave.Martin@arm.com (Dave Martin)
Date: Wed, 17 Jan 2018 17:39:44 +0000
Subject: [PATCH 07/11] signal/arm64: Document conflicts with SI_USER and
 SIGFPE, SIGTRAP, SIGBUS
In-Reply-To: <87h8rkflft.fsf@xmission.com>
References: <87373b6ghs.fsf@xmission.com>
 <20180112005940.23279-7-ebiederm@xmission.com>
 <20180115163028.GU22781@e103592.cambridge.arm.com>
 <87h8rnox3c.fsf@xmission.com>
 <20180117171729.GJ22781@e103592.cambridge.arm.com>
 <87h8rkflft.fsf@xmission.com>
Message-ID: <20180117173944.GK22781@e103592.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 17, 2018 at 11:24:06AM -0600, Eric W. Biederman wrote:
> Dave Martin <Dave.Martin@arm.com> writes:

[...]

> > Should si_code simply be ignored for the SIGKILL case?
> 
> I know what x86 does in a similar case is it uses force_sig instead of
> force_sig_info.  Then the generic code gets to worry about 
> 
> If the appropriate paths generic paths get to worry about what siginfo
> to fill in in that case.  Which for SI_KERNEL is zero for everything
> except the si_code and the si_signo.
> 
> That seems perfectly reasonable.

OK, I'll go with SI_KERNEL then.

Cheers
---Dave
