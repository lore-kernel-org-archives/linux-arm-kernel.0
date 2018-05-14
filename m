From: linux@dominikbrodowski.net (Dominik Brodowski)
Date: Mon, 14 May 2018 22:24:45 +0200
Subject: [PATCH 08/18] arm64: convert raw syscall invocation to C
In-Reply-To: <20180514125351.GK7753@e103592.cambridge.arm.com>
 <20180514114104.oubxdf526hf2m6t5@lakrids.cambridge.arm.com>
Message-ID: <20180514202445.GA26773@light.dominikbrodowski.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, May 14, 2018 at 12:41:10PM +0100, Mark Rutland wrote:
> I agree it would be nicer if it had a wrapper that took a pt_regs, even
> if it does nothing with it.
> 
> We can't use SYSCALL_DEFINE0() due to the fault injection muck, we'd
> need a ksys_ni_syscall() for our traps.c logic, and adding this
> uniformly would involve some arch-specific rework for x86, too, so I
> decided it was not worth the effort.

Couldn't you just open-code the "return -ENOSYS;" in traps.c? Error
injection has no reasonable stable ABI/API expectations, so that's not a
show-stopper either.

Thanks,
	Dominik
