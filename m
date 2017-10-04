From: Dave.Martin@arm.com (Dave Martin)
Date: Wed, 4 Oct 2017 13:48:19 +0100
Subject: [PATCH] arm64: Enable MRS emulation early
In-Reply-To: <20171004113628.t4gv7srwpvbwwbsl@armageddon.cambridge.arm.com>
References: <20171004094805.24009-1-suzuki.poulose@arm.com>
 <20171004101425.GB23092@leverpostej>
 <20171004111040.vumbc3bk7sj2enc6@armageddon.cambridge.arm.com>
 <20171004113207.GT3611@e103592.cambridge.arm.com>
 <20171004113628.t4gv7srwpvbwwbsl@armageddon.cambridge.arm.com>
Message-ID: <20171004124819.GU3611@e103592.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Oct 04, 2017 at 12:36:29PM +0100, Catalin Marinas wrote:
> On Wed, Oct 04, 2017 at 12:32:07PM +0100, Dave P Martin wrote:

[...]

> > I don't think the hwcaps shouldn't change after entry to userspace,
> > so it really doesn't matter whether HWCAP_CPUID is set before or
> > after registration: for userspace it should all already have happened.
> 
> Good point, I forgot about this.
> 
> > It looks to me like all initcalls are called in the same kernel thread
> > that execs the initramfs init process, before the exec.
> > 
> > So I still don't see how a built-in late initcall can not have been
> > called before entry to userspace.
> > 
> > The patch seems to demonstrate that I'm wrong though.
> > What am I missing?
> 
> I also wondered about this. I think is the kernel invoking modprobe
> before the actual init/linuxrc in an initrd.

Ah, right.  Could that be a bug, do you think?

I wonder whether it's even well-defined how early that can happen.
i.e., which initcall level is guaranteed early enough to prevent this?

Cheers
---Dave
