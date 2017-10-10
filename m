From: catalin.marinas@arm.com (Catalin Marinas)
Date: Tue, 10 Oct 2017 15:35:30 +0100
Subject: [PATCH v2] arm64: Expose support for optional ARMv8-A features
In-Reply-To: <20171010095310.30115-1-suzuki.poulose@arm.com>
References: <20171010095310.30115-1-suzuki.poulose@arm.com>
Message-ID: <20171010143530.fiomo7pqvtojflnn@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 10, 2017 at 10:53:10AM +0100, Suzuki K. Poulose wrote:
> diff --git a/arch/arm64/include/uapi/asm/hwcap.h b/arch/arm64/include/uapi/asm/hwcap.h
> index 4b9344cba83a..a4bad90a3fa3 100644
> --- a/arch/arm64/include/uapi/asm/hwcap.h
> +++ b/arch/arm64/include/uapi/asm/hwcap.h
> @@ -36,5 +36,10 @@
>  #define HWCAP_FCMA		(1 << 14)
>  #define HWCAP_LRCPC		(1 << 15)
>  #define HWCAP_DCPOP		(1 << 16)
> +#define HWCAP_SHA3		(1 << 17)
> +#define HWCAP_SM3		(1 << 18)
> +#define HWCAP_SM4		(1 << 19)
> +#define HWCAP_ASIMDDP		(1 << 20)
> +#define HWCAP_SHA512		(1 << 21)

We may be getting some conflicts around these with additional patches
coming in but not hard to solve. Anyway, whether we are getting pointer
authentication in or not (probably the latter), I would really like to
get the first patch in that series merged:

http://lkml.kernel.org/r/1500480092-28480-2-git-send-email-mark.rutland at arm.com

Otherwise, for this patch:

Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
