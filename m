From: alex.bennee@linaro.org (Alex =?utf-8?Q?Benn=C3=A9e?=)
Date: Wed, 23 May 2018 14:44:09 +0100
Subject: [PATCH v10 01/18] arm64: fpsimd: Fix TIF_FOREIGN_FPSTATE after
 invalidating cpu regs
In-Reply-To: <1527005119-6842-2-git-send-email-Dave.Martin@arm.com>
References: <1527005119-6842-1-git-send-email-Dave.Martin@arm.com>
 <1527005119-6842-2-git-send-email-Dave.Martin@arm.com>
Message-ID: <87r2m2trkm.fsf@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Dave Martin <Dave.Martin@arm.com> writes:

> fpsimd_last_state.st is set to NULL as a way of indicating that
> current's FPSIMD registers are no longer loaded in the cpu.  In
> particular, this is done when the kernel temporarily uses or
> clobbers the FPSIMD registers for its own purposes, as in CPU PM or
> kernel-mode NEON, resulting in them being populated with garbage
> data not belonging to a task.
<snip>
>
> Signed-off-by: Dave Martin <Dave.Martin@arm.com>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will.deacon@arm.com>
> Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>

Reviewed-by: Alex Benn?e <alex.bennee@linaro.org>

--
Alex Benn?e
