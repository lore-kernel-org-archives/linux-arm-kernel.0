From: HartleyS@visionengravers.com (Hartley Sweeten)
Date: Mon, 11 Dec 2017 17:17:37 +0000
Subject: [PATCH v4 5/5] ARM: ep93xx: ts72xx: Add support for BK3 board -
 ts72xx derivative
In-Reply-To: <20171130235140.12243-6-lukma@denx.de>
References: <20171116232239.16823-1-lukma@denx.de>
 <20171130235140.12243-1-lukma@denx.de> <20171130235140.12243-6-lukma@denx.de>
Message-ID: <SN1PR0101MB156532C13ABBAE280B3754CED0370@SN1PR0101MB1565.prod.exchangelabs.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday, November 30, 2017 4:52 PM, Lukasz Majewski wrote:
>
> The BK3 board is a derivative of the ts72xx reference design.

Lukasz,

I was just reviewing the other TS-72xx boards and noticed this:

<snip>

> +/* BK3 specific defines */
> +#define BK3_CPLDVER_PHYS_BASE		0x23400000
> +#define BK3_CPLDVER_VIRT_BASE		0xfebfd000
> +#define BK3_CPLDVER_SIZE		0x00001000
> +

<snip>

> +static struct map_desc bk3_io_desc[] __initdata = {
> +	{
> +		.virtual	= BK3_CPLDVER_VIRT_BASE,
> +		.pfn		= __phys_to_pfn(BK3_CPLDVER_PHYS_BASE),
> +		.length	= BK3_CPLDVER_SIZE,
> +		.type		= MT_DEVICE,
> +	}
> +};
> +

This register appears to be common to all the TS-72xx boards.

I don't think Arnd has pulled the series yet. Would you mind renaming the
defines and rebasing this patch? The BK3 board and other TS-72xx boards
can then have a common .map_io.

Thanks,
Hartley
