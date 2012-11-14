From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 14 Nov 2012 00:14:38 +0000
Subject: [PATCH V2 4/5] arm: mm: Added support for PJ4B cpu and init
 routines
In-Reply-To: <1351545108-18954-5-git-send-email-gregory.clement@free-electrons.com>
References: <1351545108-18954-1-git-send-email-gregory.clement@free-electrons.com>
 <1351545108-18954-5-git-send-email-gregory.clement@free-electrons.com>
Message-ID: <20121114001438.GF3290@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 29, 2012 at 10:11:47PM +0100, Gregory CLEMENT wrote:
> +	/* Auxiliary Debug Modes Control 2 Register */
> +	mrc	p15, 1,	r0, c15, c1, 2
> +	bic	r0, r0, #(1 << 23)   @ Enable fast LDR.
> +	orr	r0, r0, #(1 << 25)   @ Dont interleave write and snoop data.
> +	orr	r0, r0, #(1 << 27)   @ Disable Critical Word First feature.
> +	orr	r0, r0, #(1 << 29)   @ Disable outstanding non cacheable request
> +	orr	r0, r0, #(1 << 30)   @ L1 replacement - Strict round robin

This just looks silly to me - setting five bits with five instructions
when they can all be done in one instruction.  Yes, I know you want
to comment it, but there's other ways to achieve that.

> +__v7_pj4b_proc_info:
> +	.long	0x562f5842
> +	.long	0xffffffff

Same comment here as Will :)
