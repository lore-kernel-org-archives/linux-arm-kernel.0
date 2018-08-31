From: Suzuki.Poulose@arm.com (Suzuki K Poulose)
Date: Fri, 31 Aug 2018 13:39:34 +0100
Subject: [PATCH 2/7] arm64: cpufeature: Detect SSBS and advertise to
 userspace
In-Reply-To: <1535645767-9901-3-git-send-email-will.deacon@arm.com>
References: <1535645767-9901-1-git-send-email-will.deacon@arm.com>
 <1535645767-9901-3-git-send-email-will.deacon@arm.com>
Message-ID: <dff5885f-de95-5aab-0d47-daf20d9a63c2@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 30/08/18 17:16, Will Deacon wrote:
> Armv8.5 introduces a new PSTATE bit known as Speculative Store Bypass
> Safe (SSBS) which can be used as a mitigation against Spectre variant 4.
> 
> Additionally, a CPU may provide instructions to manipulate PSTATE.SSBS
> directly, so that userspace can toggle the SSBS control without trapping
> to the kernel.
> 
> This patch probes for the existence of SSBS and advertise the new instructions
> to userspace if they exist.
> 
> Signed-off-by: Will Deacon <will.deacon@arm.com>
> ---
>   arch/arm64/include/asm/cpucaps.h    |  3 ++-
>   arch/arm64/include/asm/sysreg.h     | 16 ++++++++++++----
>   arch/arm64/include/uapi/asm/hwcap.h |  1 +
>   arch/arm64/kernel/cpufeature.c      | 19 +++++++++++++++++--
>   arch/arm64/kernel/cpuinfo.c         |  1 +
>   5 files changed, 33 insertions(+), 7 deletions(-)
> 

Reviewed-by: Suzuki K Poulose <suzuki.poulose@arm.com>
