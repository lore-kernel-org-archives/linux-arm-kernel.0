From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 28 Apr 2011 17:51:00 +0100
Subject: [PATCH 2/9] ARM i.MX5: Add IPU device support
In-Reply-To: <1303738709-27562-1-git-send-email-weitway@gmail.com>
References: <1303738709-27562-1-git-send-email-weitway@gmail.com>
Message-ID: <20110428165059.GY17290@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Apr 25, 2011 at 09:38:29PM +0800, weitway at gmail.com wrote:
> +#include <mach/ipu-v3.h>
> +struct imx_ipuv3_data {
> +	resource_size_t iobase;
> +	resource_size_t iosize;
> +	resource_size_t irq_err;
> +	resource_size_t irq;

IRQs don't need to be resource_size_t.  They're treated as 'int's by
the request_irq() API, so high bits get truncated anyway.  Keep them
as int or unsigned int in this structure and just allow the compiler
to promote them as required to resource_size_t on assignment.
