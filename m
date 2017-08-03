From: catalin.marinas@arm.com (Catalin Marinas)
Date: Thu, 3 Aug 2017 18:46:10 +0100
Subject: [PATCH v2] arm64: Decode information from ESR upon mem faults
In-Reply-To: <1500888078-50231-1-git-send-email-julien.thierry@arm.com>
References: <1500888078-50231-1-git-send-email-julien.thierry@arm.com>
Message-ID: <20170803174609.m43amupy4vxkjsen@armageddon.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Julien,

On Mon, Jul 24, 2017 at 10:21:18AM +0100, Julien Thierry wrote:
> When receiving unhandled faults from the CPU, description is very sparse.
> Adding information about faults decoded from ESR.
> 
> Added defines to esr.h corresponding ESR fields. Values are based on ARM
> Archtecture Reference Manual (DDI 0487B.a), section D7.2.28 ESR_ELx, Exception
> Syndrome Register (ELx) (pages D7-2275 to D7-2280).
> 
> New output is of the form:
> [   77.818059] Mem abort info:
> [   77.820826]   Exception class = DABT (current EL), IL = 32 bits
> [   77.826706]   SET = 0, FnV = 0
> [   77.829742]   EA = 0, S1PTW = 0
> [   77.832849] Data abort info:
> [   77.835713]   ISV = 0, ISS = 0x00000070
> [   77.839522]   CM = 0, WnR = 1
> 
> Signed-off-by: Julien Thierry <julien.thierry@arm.com>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will.deacon@arm.com>
> Cc: Mark Rutland <mark.rutland@arm.com>
> ---
>  arch/arm64/include/asm/esr.h | 38 ++++++++++++++++++++++++++---------
>  arch/arm64/mm/fault.c        | 47 ++++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 76 insertions(+), 9 deletions(-)

This patch doesn't apply against latest mainline. Would you mind
reposting against a newer tag like v4.13-rc3?

Thanks.

-- 
Catalin
