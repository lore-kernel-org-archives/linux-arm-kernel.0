From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 5 Nov 2013 15:17:07 +0000
Subject: [PATCH 2/3] ARM: mm: fix __phys_to_virt to work with 64 bit
 phys_addr_t in BE case
In-Reply-To: <1383617765-28052-3-git-send-email-victor.kamensky@linaro.org>
References: <1383617765-28052-1-git-send-email-victor.kamensky@linaro.org>
 <1383617765-28052-3-git-send-email-victor.kamensky@linaro.org>
Message-ID: <20131105151707.GS16735@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 04, 2013 at 06:16:04PM -0800, Victor Kamensky wrote:
>  static inline unsigned long __phys_to_virt(phys_addr_t x)
>  {
>  	unsigned long t;
> -	__pv_stub(x, t, "sub", __PV_BITS_31_24);
> +        /*
> +         * 'unsigned long' cast discard upper word when
> +         * phys_addr_t is 64 bit, and makes sure that inline
> +         * assembler expression receives 32 bit argument
> +         * in place where 'r' 32 bit operand is expected.
> +         */

We use tabs for indentation in the kernel source, not 8 spaces.  Please
fix before final submission, thanks. :)
