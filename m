From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 13 Jun 2011 12:24:54 +0100
Subject: [PATCH 1/3] ARM: zImage: ensure it is always a multiple of 64
	bits in size
In-Reply-To: <1307858800-16712-2-git-send-email-nicolas.pitre@linaro.org>
References: <1307858800-16712-1-git-send-email-nicolas.pitre@linaro.org>
	<1307858800-16712-2-git-send-email-nicolas.pitre@linaro.org>
Message-ID: <20110613112454.GA12325@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Jun 12, 2011 at 02:06:38AM -0400, Nicolas Pitre wrote:
> diff --git a/arch/arm/boot/compressed/vmlinux.lds.in b/arch/arm/boot/compressed/vmlinux.lds.in
> index ea80abe..6c02db1 100644
> --- a/arch/arm/boot/compressed/vmlinux.lds.in
> +++ b/arch/arm/boot/compressed/vmlinux.lds.in
> @@ -47,6 +47,9 @@ SECTIONS
>    .got			: { *(.got) }
>    _got_end = .;
>    .got.plt		: { *(.got.plt) }
> +
> +  /* ensure the zImage file size is always a multiple of 64 bits */
> +  .pad			: { BYTE(0); . = ALIGN(8); }

Why add a byte before aligning?  Isn't merely aligning to 64-bit sufficient?
