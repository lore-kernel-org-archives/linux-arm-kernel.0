From: sboyd@codeaurora.org (Stephen Boyd)
Date: Tue, 16 Nov 2010 11:14:25 -0800
Subject: [PATCH v3 15/20] ARM: LPAE: use phys_addr_t instead of unsigned
	long	for physical addresses
In-Reply-To: <1289842829-3027-16-git-send-email-catalin.marinas@arm.com>
References: <1289842829-3027-1-git-send-email-catalin.marinas@arm.com>
	<1289842829-3027-16-git-send-email-catalin.marinas@arm.com>
Message-ID: <4CE2D811.50701@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/15/2010 09:40 AM, Catalin Marinas wrote:
> @@ -188,21 +189,21 @@
>   * translation for translating DMA addresses.  Use the driver
>   * DMA support - see dma-mapping.h.
>   */
> -static inline unsigned long virt_to_phys(void *x)
> +static inline phys_addr_t virt_to_phys(void *x)
>  {
>  	return __virt_to_phys((unsigned long)(x));
>  }

As you're already in the area can you mark the argument to
virt_to_phys() as const? I ran into a compiler warning due to that the
other day.

-- 
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
