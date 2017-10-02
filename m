From: will.deacon@arm.com (Will Deacon)
Date: Mon, 2 Oct 2017 11:26:43 +0100
Subject: [PATCH] arm64: Expose ASIMD dot product instruction support
In-Reply-To: <20170927143316.14761-1-suzuki.poulose@arm.com>
References: <20170927143316.14761-1-suzuki.poulose@arm.com>
Message-ID: <20171002102643.GA3823@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Sep 27, 2017 at 03:33:16PM +0100, Suzuki K Poulose wrote:
> ARM v8-A adds two new optional instructions in architecture version v8.2
> and v8.3, for performing dot product of 8bit elements in each 32bit element
> of two vectors and accumulating the result into a third vector. Expose the
> functionality via ELF HWCAPs and MRS emulation.
> 
> Cc: Will Deacon <will.deacon@arm.com>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
> ---
>  Documentation/arm64/cpu-feature-registers.txt | 6 +++++-
>  arch/arm64/include/asm/sysreg.h               | 1 +
>  arch/arm64/include/uapi/asm/hwcap.h           | 1 +
>  arch/arm64/kernel/cpufeature.c                | 2 ++
>  arch/arm64/kernel/cpuinfo.c                   | 1 +
>  5 files changed, 10 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/arm64/cpu-feature-registers.txt b/Documentation/arm64/cpu-feature-registers.txt
> index dad411d635d8..f25cfbfa91a7 100644
> --- a/Documentation/arm64/cpu-feature-registers.txt
> +++ b/Documentation/arm64/cpu-feature-registers.txt
> @@ -110,7 +110,11 @@ infrastructure:
>       x--------------------------------------------------x
>       | Name                         |  bits   | visible |
>       |--------------------------------------------------|
> -     | RES0                         | [63-32] |    n    |
> +     | RES0                         | [63-48] |    n    |
> +     |--------------------------------------------------|
> +     | DP                           | [47-44] |    y    |
> +     |--------------------------------------------------|
> +     | RES0                         | [43-32] |    n    |

Can you also add the other new features that occupy this RES0 space, please?
They're listed in the public XML descriptions of the system registers.

Will
