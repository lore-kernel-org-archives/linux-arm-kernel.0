From: catalin.marinas@arm.com (Catalin Marinas)
Date: Fri, 6 Jan 2017 12:16:12 +0000
Subject: [PATCH v3 9/9] arm64: Documentation - Expose CPU feature registers
In-Reply-To: <1483552147-9605-10-git-send-email-suzuki.poulose@arm.com>
References: <1483552147-9605-1-git-send-email-suzuki.poulose@arm.com>
 <1483552147-9605-10-git-send-email-suzuki.poulose@arm.com>
Message-ID: <20170106121612.GA12863@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 04, 2017 at 05:49:07PM +0000, Suzuki K. Poulose wrote:
> +The following rules are applied to the value returned by the
> +infrastructure:
> +
> + a) The value of an 'IMPLEMENTATION DEFINED' field is set to 0.
> + b) The value of a reserved field is populated with the reserved
> +    value as defined by the architecture.
> + c) The value of a field marked as not 'visible', is set to indicate
> +    the feature is missing (as defined by the architecture).
> + d) The value of a 'visible' field holds the system wide safe value
> +    for the particular feature(except for MIDR_EL1, see section 4).
> +    See Appendix I for more information on safe value.
> +
> +There are only a few registers visible to the userspace. See Section 4,
> +for the list of 'visible' registers.
> +
> +All others are emulated as having 'invisible' features.

BTW, we don't have any statement about whether a visible field may
become invisible but I guess this wouldn't be a problem as long as the
feature is reported as missing. I'm thinking about currently RES0 fields
that are listed as visible but they may report something in the future
that we don't want exposed to user. At that point, we'll change the
field to "invisible" while reporting RES0 to user. I don't see an issue
with this, just I thought worth flagging.

Anyway:

Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
