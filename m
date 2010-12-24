From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 24 Dec 2010 11:29:08 +0000
Subject: Bogus machine-type from bootloader
In-Reply-To: <BF43E57B-EE45-49B1-AE2A-96F8CBFD40FE@gmail.com>
References: <BF43E57B-EE45-49B1-AE2A-96F8CBFD40FE@gmail.com>
Message-ID: <20101224112908.GF20587@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Dec 24, 2010 at 12:19:25PM +0100, Damjan Marion wrote:
> Is there any "proper" way if fixing bogus machine type sent by
> bootloader (ofcourse except fixing bootloader itself)?
> 
> I'm looking into code where author did following:
> 
> 
> +++ a/arch/arm/boot/compressed/head-str9100.S	2009-01-20 04:26:26.000000000 +0100
> @@ -0,0 +1,7 @@
> +#include <asm/mach-types.h>
> +
> +		.section	".start", "ax"
> +
> +__str9100_start:
> +		mov	r7, #(MACH_TYPE_STR9100 & 0xFF00)
> +		orr	r7, r7, #(MACH_TYPE_STR9100 & 0x00FF)
> 
> I assume this is not something acceptable for having in official kernel source.
