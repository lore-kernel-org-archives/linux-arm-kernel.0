From: mark.rutland@arm.com (Mark Rutland)
Date: Mon, 13 Jun 2016 18:26:16 +0100
Subject: [PATCH v4] arm64: cpuinfo: Expose MIDR_EL1 and REVIDR_EL1 to sysfs
In-Reply-To: <1465837689-28215-1-git-send-email-suzuki.poulose@arm.com>
References: <1465837689-28215-1-git-send-email-suzuki.poulose@arm.com>
Message-ID: <20160613172616.GC17128@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 13, 2016 at 06:08:09PM +0100, Suzuki K Poulose wrote:
> +/*
> + * Both MIDR_EL1 and REVIDR_EL1 are 32bit registers. However, per C5.1.1,
> + * "Principles of the System instruction class encoding" in ARM DDI 0487A.i,
> + * when a system register is escribed as 32-bit, this only means that the
> + * upper 32 bits are RES0, not that they will never be made use of. To avoid
> + * changing the ABI for the future, the values are exported as 64bit values.
> + */

I see this is a direct copy+paste of my earlier message, typo and all.

I'd prefer something like the below:

/*
 * The ARM ARM uses the phrase "32-bit register" to describe a register
 * whose upper 32 bits are RES0 (per C5.1.1, ARM DDI 0487A.i), however
 * no statement is made as to whether the upper 32 bits will or will not
 * be made use of in future, and between ARM DDI 0487A.c and ARM DDI
 * 0487A.d CLIDR_EL1 was expanded from 32-bit to 64-bit.
 *
 * Thus, while both MIDR_EL1 and REVIDR_EL1 are described as 32-bit
 * registers, we expose them both as 64 bit values to cater for possible
 * future expansion without an ABI break.
 */

Thanks,
Mark.
