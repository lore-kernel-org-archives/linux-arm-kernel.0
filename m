From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Mon, 15 Jan 2018 12:26:13 +0100
Subject: [PATCH v4 06/19] arm64: insn: Add N immediate encoding
In-Reply-To: <20180104184334.16571-7-marc.zyngier@arm.com>
References: <20180104184334.16571-1-marc.zyngier@arm.com>
 <20180104184334.16571-7-marc.zyngier@arm.com>
Message-ID: <20180115112613.GG21403@cbox>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 04, 2018 at 06:43:21PM +0000, Marc Zyngier wrote:
> We're missing the a way to generate the encoding of the N immediate,
> which is only a single bit used in a number of instruction that take
> an immediate.
> 
> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>

Acked-by: Christoffer Dall <christoffer.dall@linaro.org>

> ---
>  arch/arm64/include/asm/insn.h | 1 +
>  arch/arm64/kernel/insn.c      | 4 ++++
>  2 files changed, 5 insertions(+)
> 
> diff --git a/arch/arm64/include/asm/insn.h b/arch/arm64/include/asm/insn.h
> index 4214c38d016b..21fffdd290a3 100644
> --- a/arch/arm64/include/asm/insn.h
> +++ b/arch/arm64/include/asm/insn.h
> @@ -70,6 +70,7 @@ enum aarch64_insn_imm_type {
>  	AARCH64_INSN_IMM_6,
>  	AARCH64_INSN_IMM_S,
>  	AARCH64_INSN_IMM_R,
> +	AARCH64_INSN_IMM_N,
>  	AARCH64_INSN_IMM_MAX
>  };
>  
> diff --git a/arch/arm64/kernel/insn.c b/arch/arm64/kernel/insn.c
> index 2718a77da165..7e432662d454 100644
> --- a/arch/arm64/kernel/insn.c
> +++ b/arch/arm64/kernel/insn.c
> @@ -343,6 +343,10 @@ static int __kprobes aarch64_get_imm_shift_mask(enum aarch64_insn_imm_type type,
>  		mask = BIT(6) - 1;
>  		shift = 16;
>  		break;
> +	case AARCH64_INSN_IMM_N:
> +		mask = 1;
> +		shift = 22;
> +		break;
>  	default:
>  		return -EINVAL;
>  	}
> -- 
> 2.14.2
> 
