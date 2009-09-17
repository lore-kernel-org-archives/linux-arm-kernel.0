From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 17 Sep 2009 21:00:54 +0100
Subject: [PATCH] Samsung SoCs: OneNAND support
In-Reply-To: <20090917081659.GA28591@july>
References: <20090917081659.GA28591@july>
Message-ID: <20090917200054.GB12766@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 17, 2009 at 05:16:59PM +0900, Kyungmin Park wrote:
> +#include <asm/io.h>

Please make sure that you use linux/io.h

> +static int s3c_onenand_probe(struct platform_device *pdev)
> +{
> +	struct onenand_platform_data *pdata;
> +	struct onenand_chip *this;
> +	struct mtd_info *mtd;
> +	struct resource *r;
> +	int size, err;
> +	unsigned long ahb_addr = 0, ahb_addr_size;
> +
> +	if (!(cpu_is_s3c64xx() || cpu_is_s5pc1xx()))
> +		return -ENODEV;

Isn't it normal to leave these kind of decisions to the declaration of
the devices, rather than encoding it into the driver?
