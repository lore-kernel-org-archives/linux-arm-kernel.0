From: catalin.marinas@arm.com (Catalin Marinas)
Date: Fri, 16 May 2014 15:06:07 +0100
Subject: [PATCH 4/4] arm64: Enable TEXT_OFFSET fuzzing
In-Reply-To: <1400233839-15140-5-git-send-email-mark.rutland@arm.com>
References: <1400233839-15140-1-git-send-email-mark.rutland@arm.com>
 <1400233839-15140-5-git-send-email-mark.rutland@arm.com>
Message-ID: <20140516140606.GH5624@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 16, 2014 at 10:50:39AM +0100, Mark Rutland wrote:
> --- a/arch/arm64/Kconfig.debug
> +++ b/arch/arm64/Kconfig.debug
> @@ -37,4 +37,35 @@ config PID_IN_CONTEXTIDR
>  	  instructions during context switch. Say Y here only if you are
>  	  planning to use hardware trace tools with this kernel.
>  
> +config ARM64_RANDOMIZE_TEXT_OFFSET
> +	bool "Randomize TEXT_OFFSET at build time (EXPERIMENTAL)"
> +	default N

(nitpick: no need for default n)

I think that's good for testing. It would have been nice to be able to
set some limits for the random offset but I can't figure out an easy way
to do this via Kconfig (maybe with additional options).

> +config ARM64_TEXT_OFFSET
> +	hex "Required image load offset"
> +	depends on !ARM64_RANDOMIZE_TEXT_OFFSET
> +	default "0x0000000000080000"

I don't think we should include this. It encourages people to set
specific offsets for their SoCs.

-- 
Catalin
