From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 24 Oct 2011 10:26:19 +0100
Subject: [RFC PATCH 09/15] ARM: uncompress: Introduce ucuart as
	low-level serial port driver
In-Reply-To: <1319404245-12740-9-git-send-email-zoss@devai.org>
References: <1319404245-12740-1-git-send-email-zoss@devai.org>
	<1319404245-12740-9-git-send-email-zoss@devai.org>
Message-ID: <20111024092619.GE9893@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Oct 23, 2011 at 11:10:39PM +0200, Zoltan Devai wrote:
> +struct uncompress_uart {
> +	void __iomem		*base;
> +	int			reg_shift;
> +	enum ucuart_iotypes	iotype;
> +	int			tx_regoff;
> +	int			txfree_regoff;
> +	int			txfree_mask;
> +	int			txfree_val;
> +	int			flush_regoff;
> +	int			flush_mask;
> +	int			flush_val;

The values and masks should be unsigned.

> +};
> +
> +void ucuart_init(int base, int regshift, enum ucuart_iotypes iotype,
> +		 int tx_regoff, int txfree_regoff, int txfree_mask,
> +		 int txfree_val, int flush_regoff, int flush_mask,
> +		 int flush_val);

Ditto.

> +#include <linux/io.h>

I don't like this - this is *not* part of the kernel, it's part of a
separate execution environment which may not contain everything required
for a functional macros in this header file.
