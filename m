From: catalin.marinas@arm.com (Catalin Marinas)
Date: Wed, 4 Mar 2015 18:09:55 +0000
Subject: [PATCH v2 3/3] arm64: remove __lookup_processor_type_data object
 from head.S
In-Reply-To: <1425468197-22377-4-git-send-email-ard.biesheuvel@linaro.org>
References: <1425468197-22377-1-git-send-email-ard.biesheuvel@linaro.org>
 <1425468197-22377-4-git-send-email-ard.biesheuvel@linaro.org>
Message-ID: <20150304180955.GE28951@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 04, 2015 at 12:23:17PM +0100, Ard Biesheuvel wrote:
> This removes __lookup_processor_type_data, replacing the original
> use with a simple PC-relative address load.
> 
> Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>

Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>

>  ENTRY(lookup_processor_type)
> -	adr	x1, __lookup_processor_type_data
> -	ldp	x2, x3, [x1]
> -	sub	x1, x1, x2			// get offset between VA and PA
> -	add	x3, x3, x1			// convert VA to PA
> +	adrp	x3, cpu_table
> +	add	x3, x3, :lo12:cpu_table

I wonder whether we should add a macro for these two instructions, it's
becoming a common pattern.

-- 
Catalin
