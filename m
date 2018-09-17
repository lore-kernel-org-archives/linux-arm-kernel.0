From: boris.brezillon@bootlin.com (Boris Brezillon)
Date: Mon, 17 Sep 2018 13:37:51 +0200
Subject: [PATCH v2 1/5] spi: spi-mem: Add driver for NXP FlexSPI controller
In-Reply-To: <1537177710-9379-2-git-send-email-yogeshnarayan.gaur@nxp.com>
References: <1537177710-9379-1-git-send-email-yogeshnarayan.gaur@nxp.com>
 <1537177710-9379-2-git-send-email-yogeshnarayan.gaur@nxp.com>
Message-ID: <20180917133751.453ea6ed@bbrezillon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Yogesh,

On Mon, 17 Sep 2018 15:18:26 +0530
Yogesh Gaur <yogeshnarayan.gaur@nxp.com> wrote:

> +
> +	/*
> +	 * R/W functions for big- or little-endian registers:
> +	 * The FSPI controller's endianness is independent of
> +	 * the CPU core's endianness. So far, although the CPU
> +	 * core is little-endian the FSPI controller can use
> +	 * big-endian or little-endian.
> +	 */
> +	if (of_property_read_bool(np, "big-endian")) {
> +		f->write = fspi_writel_be;
> +		f->read = fspi_readl_be;
> +	} else {
> +		f->write = fspi_writel;
> +		f->read = fspi_readl;
> +	}

Hm, isn't it something you can extract from the compatible string? I'd
rather not allow users to set that in their DT if it's not something
you can change.

Regards,

Boris
