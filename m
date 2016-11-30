From: sid@reserved-bit.com (Siddhesh Poyarekar)
Date: Wed, 30 Nov 2016 16:44:52 +0530
Subject: [PATCH 9/9] arm64: Documentation - Expose CPU feature registers
In-Reply-To: <1479994809-9081-10-git-send-email-suzuki.poulose@arm.com>
References: <1479994809-9081-1-git-send-email-suzuki.poulose@arm.com>
 <1479994809-9081-10-git-send-email-suzuki.poulose@arm.com>
Message-ID: <e2f9a241-8453-0b2c-25db-e603b89acf46@reserved-bit.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 24 November 2016 07:10 PM, Suzuki K Poulose wrote:
> + d) CPU Identification :
> +    MIDR_EL1 is exposed to help identify the processor. On a
> +    heterogeneous system, this could be racy (just like getcpu()). The
> +    process could be migrated to another CPU by the time it uses the
> +    register value, unless the CPU affinity is set. Hence, there is no
> +    guarantee that the value reflects the processor that it is
> +    currently executing on. The REVIDR is not exposed due to this
> +    constraint, as REVIDR makes sense only in conjunction with the
> +    MIDR. Alternately, MIDR_EL1 and REVIDR_EL1 are exposed via sysfs
> +    at:
> +
> +	/sys/devices/system/cpu/cpu$ID/regs/identification/
> +	                                              \- midr
> +	                                              \- revidr
> +

This doesn't seem to be implemented in this patchset.

Siddhesh
