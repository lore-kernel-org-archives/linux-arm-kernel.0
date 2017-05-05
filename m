From: punit.agrawal@arm.com (Punit Agrawal)
Date: Fri, 05 May 2017 15:51:05 +0100
Subject: [PATCH 4/6] arm64: armv8_deprecated: ensure extension of addr
In-Reply-To: <1493824178-7399-5-git-send-email-mark.rutland@arm.com> (Mark
 Rutland's message of "Wed, 3 May 2017 16:09:36 +0100")
References: <1493824178-7399-1-git-send-email-mark.rutland@arm.com>
 <1493824178-7399-5-git-send-email-mark.rutland@arm.com>
Message-ID: <87bmr7xspy.fsf@e105922-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Mark Rutland <mark.rutland@arm.com> writes:

> Our compat swp emulation holds the compat user address in an unsigned
> int, which it passes to __user_swpX_asm(). When a 32-bit value is passed
> in a register, the upper 32 bits of the register are unknown, and we
> must extend the value to 64 bits before we can use it as a base address.
>
> This patch casts the address to unsigned long to ensure it has been
> suitably extended, avoiding the potential issue, and silencing a related
> warning from clang.
>
> Fixes: bd35a4adc4131c53 ("arm64: Port SWP/SWPB emulation support from arm")
> Signed-off-by: Mark Rutland <mark.rutland@arm.com>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Matthias Kaehlcke <mka@chromium.org>
> Cc: Punit Agrawal <punit.agrawal@arm.com>
> Cc: Will Deacon <will.deacon@arm.com>

>From the description, the problem looks quite serious. I'm surprised
this hasn't exploded before.

FWIW,

        Acked-by: Punit Agrawal <punit.agrawal@arm.com>

Thanks!


[...]
