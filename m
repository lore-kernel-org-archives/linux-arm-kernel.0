From: Suzuki.Poulose@arm.com (Suzuki K Poulose)
Date: Fri, 22 Apr 2016 12:05:48 +0100
Subject: [PATCH v3 1/5] arm64: cpufeature: Add scope for capability check
In-Reply-To: <1461250597-16712-2-git-send-email-suzuki.poulose@arm.com>
References: <1461250597-16712-1-git-send-email-suzuki.poulose@arm.com>
 <1461250597-16712-2-git-send-email-suzuki.poulose@arm.com>
Message-ID: <571A058C.9000507@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 21/04/16 15:56, Suzuki K Poulose wrote:
> Add scope parameter to the arm64_cpu_capabilities::matches(), so that
> this can be reused for checking the capability on a given CPU vs the
> system wide. The system uses the default scope associated with the
> capability for initialising the CPU_HWCAPs and ELF_HWCAPs.
>
> Cc: James Morse <james.morse@arm.com>
> Cc: Marc Zyngier <marc.zyngier@arm.com>
> Cc: Andre Przywara <andre.przywara@arm.com>
> Cc: Will Deacon <will.deacon@arm.com>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>

  -71,7 +71,9 @@ DECLARE_BITMAP(cpu_hwcaps, ARM64_NCAPS);
>
>   /* meta feature for alternatives */
>   static bool __maybe_unused
> -cpufeature_pan_not_uao(const struct arm64_cpu_capabilities *entry);
> +cpufeature_pan_not_uao(const struct arm64_cpu_capabilities *entry, int __unused);
> +
> +static u64 __raw_read_system_reg(u32 sys_id);


I missed getting rid of the above forward declaration, will respin the series.

Thanks
Suzuki
