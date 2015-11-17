From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 17 Nov 2015 10:50:44 +0100
Subject: [PATCH v3 04/62] arm/acpi: Emulate io ports for arm
In-Reply-To: <1447753261-7552-5-git-send-email-shannon.zhao@linaro.org>
References: <1447753261-7552-1-git-send-email-shannon.zhao@linaro.org>
 <1447753261-7552-5-git-send-email-shannon.zhao@linaro.org>
Message-ID: <4167037.Po02bj0iif@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 17 November 2015 17:40:03 shannon.zhao at linaro.org wrote:
> +/*
> + * Emulate x86 io ports for arm.
> + */
> +#define __armio(addr) ( (void __iomem *)addr )
> +
> +#define inb(c) ( readb( __armio(c) ) )
> +#define inw(c) ( readw( __armio(c) ) )
> +#define inl(c) ( readl( __armio(c) ) )
> +
> +#define outb(v, c) ( writeb(v, __armio(c) ) )
> +#define outw(v, c) ( writew(v, __armio(c) ) )
> +#define outl(v, c) ( writel(v, __armio(c) ) )
> +

This is almost certainly wrong. There might be I/O port accesses, but they
won't be in the same place as normal pointers.

	Arnd
