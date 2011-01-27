From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 27 Jan 2011 16:31:49 +0000
Subject: [PATCH] ARM: map ATAGs when not in first 1MB of RAM
In-Reply-To: <1296143443-9442-1-git-send-email-robherring2@gmail.com>
References: <1296143443-9442-1-git-send-email-robherring2@gmail.com>
Message-ID: <20110127163149.GF25968@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 27, 2011 at 09:50:43AM -0600, Rob Herring wrote:
> +	/*
> +	 * Otherwise map the 1MB region r2 points to (atags or dtb)
> +	 */
> +1:	mov	r0, r2, lsr #20
> +	mov	r0, r0, lsl #20
> +	sub	r3, r0, #(PHYS_OFFSET & 0xff000000)
> +	.if	(PHYS_OFFSET & 0x00f00000)
> +	sub	r3, r3, #(PHYS_OFFSET & 0x00f00000)

This introduces new PHYS_OFFSET uses which we're trying hard to get
rid of.  This will need to be reworked.
