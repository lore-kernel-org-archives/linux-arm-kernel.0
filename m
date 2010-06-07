From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 7 Jun 2010 15:01:31 +0100
Subject: [PATCH]ARM/footbridge: fix wrong parenthesis
In-Reply-To: <4C08C749.3050700@gmail.com>
References: <4C08C749.3050700@gmail.com>
Message-ID: <20100607140131.GA7220@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 04, 2010 at 05:28:41PM +0800, Wan ZongShun wrote:
> There is a wrong redundant right parenthesis in this code.

This patch is wrong.

>  unsigned long __pfn_to_bus(unsigned long pfn)
>  {
> -	return __pfn_to_phys(pfn) + (fb_bus_sdram_offset() - PHYS_OFFSET));
> +	return __pfn_to_phys(pfn + (fb_bus_sdram_offset() - PHYS_OFFSET));

It makes no sense to add byte address offsets to a PFN.  The correct
solution is to delete the right paren at the end of the line instead.
