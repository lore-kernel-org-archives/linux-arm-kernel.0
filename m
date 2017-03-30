From: mark.rutland@arm.com (Mark Rutland)
Date: Thu, 30 Mar 2017 16:29:56 +0100
Subject: KVM/ARM: sleeping function called from invalid context
In-Reply-To: <20170330143112.GI16211@leverpostej>
References: <20170330143112.GI16211@leverpostej>
Message-ID: <20170330152955.GJ16211@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 30, 2017 at 03:31:12PM +0100, Mark Rutland wrote:
> Hi,
> 
> I'm seeing the splat below when running KVM on an arm64 host with
> CONFIG_DEBUG_ATOMIC_SLEEP and CONFIG_LOCKDEP enabled.
> 
> I saw this on v4.11-rc1, and I can reproduce the problem on the current
> kvmarm master branch (563e2f5daa66fbc1).
>
> I've hacked noinlines into arch/arm/kvm/mmu.c in an attempt to get a
> better backtrace; without this, the report says the call is at
> arch/arm/kvm/mmu.c:299, which is somewhat confusing.

Looking again, that initial kernel was not a vanilla v4.11-rc1, and I am
*not* able to reproduce this issue with a vanilla v4.11-rc1.

I believe I had applied an earlier fix for the locking issue Suzuki
recently addressed, which was why my line numbers were off.

I *can* trigger this issue with the current kvmarm master, and the log I
posted is valid.

Sorry for the bogus info; I will be more careful next time.

Thanks,
Mark.
