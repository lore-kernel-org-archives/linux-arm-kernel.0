From: catalin.marinas@arm.com (Catalin Marinas)
Date: Tue, 16 Oct 2018 12:00:26 +0100
Subject: [PATCH v2 0/3] arm64: cpufeature: Fix handling of CTR_EL0
In-Reply-To: <20181009134707.3479-1-suzuki.poulose@arm.com>
References: <20181009134707.3479-1-suzuki.poulose@arm.com>
Message-ID: <20181016110005.GF108539@arrakis.emea.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 09, 2018 at 02:47:03PM +0100, Suzuki K. Poulose wrote:
> This series makes sure that we handle the CTR_EL0 field mismatches
> properly, especially for the IDC field. Also, skip trapping CTR
> accesses on a CPU if it matches the safe value.
> 
> Applies on arm64 for-next/core.
> 
> Changes since v1
>  - Fix wrong hunk in has_cache_idc()
>  - Allow a late secondary CPU with raw CTR_EL0.IDC = 0 and effective
>    CTR_EL0.IDC = 1, to boot on a system without IDC available.
> 
> Suzuki K Poulose (3):
>   arm64: cpufeature: ctr: Fix cpu capability check for late CPUs
>   arm64: cpufeature: Fix handling of CTR_EL0.IDC field
>   arm64: cpufeature: Trap CTR_EL0 access only where it is necessary

Queued for 4.20. Thanks.

-- 
Catalin
