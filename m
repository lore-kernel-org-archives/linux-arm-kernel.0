From: linux@roeck-us.net (Guenter Roeck)
Date: Mon, 20 Jul 2015 07:25:54 -0700
Subject: [PATCH] arm64: switch_to: calculate cpu context pointer using
 separate register
In-Reply-To: <1437401693-3273-1-git-send-email-will.deacon@arm.com>
References: <1437401693-3273-1-git-send-email-will.deacon@arm.com>
Message-ID: <55AD04F2.7000605@roeck-us.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/20/2015 07:14 AM, Will Deacon wrote:
> Commit 0c8c0f03e3a2 ("x86/fpu, sched: Dynamically allocate 'struct fpu'")
> moved the thread_struct to the bottom of task_struct. As a result, the
> offset is now too large to be used in an immediate add on arm64 with
> some kernel configs:
>
> arch/arm64/kernel/entry.S: Assembler messages:
> arch/arm64/kernel/entry.S:588: Error: immediate out of range
> arch/arm64/kernel/entry.S:597: Error: immediate out of range
>
> This patch calculates the offset using an additional register instead of
> an immediate offset.
>
> Fixes: 0c8c0f03e3a2 ("x86/fpu, sched: Dynamically allocate 'struct fpu'")
> Cc: Dave Hansen <dave.hansen@linux.intel.com>
> Cc: Olof Johansson <olof@lixom.net>
> Cc: Ingo Molnar <mingo@kernel.org>
> Signed-off-by: Will Deacon <will.deacon@arm.com>

With qemu:

Tested-by: Guenter Roeck <linux@roeck-us.net>

Guenter
