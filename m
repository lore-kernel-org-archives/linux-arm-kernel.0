From: suzuki.poulose@arm.com (Suzuki K Poulose)
Date: Wed, 19 Sep 2018 11:22:24 +0100
Subject: [PATCH 3/3] arm64/cpufeatures: Emulate MRS instructions by
 parsing ESR_ELx.ISS
In-Reply-To: <1537328050-29176-4-git-send-email-anshuman.khandual@arm.com>
References: <1537328050-29176-1-git-send-email-anshuman.khandual@arm.com>
 <1537328050-29176-4-git-send-email-anshuman.khandual@arm.com>
Message-ID: <b0bbc994-7ddd-2375-b4e0-b529edf5bcd8@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/19/2018 04:34 AM, Anshuman Khandual wrote:
> Armv8.4-A extension enables MRS instruction encodings inside ESR_ELx.ISS
> during exception class ESR_ELx_EC_SYS64 (0x18). This encoding can be used
> to emulate MRS instructions which can avoid fetch/decode from user space
> thus improving performance. This adds a new sys64_hook structure element
> with applicable ESR mask/value pair for MRS instructions on various system
> registers but constrained by sysreg encodings which is currently allowed
> to be emulated.
> 
> Acked-by: Mark Rutland <mark.rutland@arm.com>
> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
> ---
>   arch/arm64/include/asm/esr.h | 12 ++++++++++++
>   arch/arm64/kernel/traps.c    | 17 +++++++++++++++++
>   2 files changed, 29 insertions(+)
> 

Reviewed-by : Suzuki K Poulose <suzuki.poulose@arm.com>
