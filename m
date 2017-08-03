From: catalin.marinas@arm.com (Catalin Marinas)
Date: Thu, 3 Aug 2017 15:49:27 +0100
Subject: [PATCH 01/11] arm64: docs: describe ELF hwcaps
In-Reply-To: <1500480092-28480-2-git-send-email-mark.rutland@arm.com>
References: <1500480092-28480-1-git-send-email-mark.rutland@arm.com>
 <1500480092-28480-2-git-send-email-mark.rutland@arm.com>
Message-ID: <20170803144926.7eankdjmnyxw3zru@armageddon.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 19, 2017 at 05:01:22PM +0100, Mark Rutland wrote:
> +3. The hwcaps exposed in AT_HWCAP
> +---------------------------------
> +
> +HWCAP_FP
> +
> +    Functionality implied by ID_AA64PFR0_EL1.FP == 0b0000.

Aren't these too restrictive? Linux would still present HWCAP_FP even
when ID_AA64PFR0_EL1.FP == 1. I think we should replace the strict
equal with greater than or equal, also mentioning that the field is
signed (or refer to the cpuid where the sign of the fields is
described).

-- 
Catalin
