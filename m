From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 25 Apr 2012 19:57:47 +0100
Subject: [PATCH 6.2/7] MMC: mmci: Enable Device Tree support for ux500
In-Reply-To: <4F8BE5B0.4000900@linaro.org>
References: <1334325909-5779-1-git-send-email-lee.jones@linaro.org>
 <1334325909-5779-7-git-send-email-lee.jones@linaro.org>
 <CACRpkdYyP=V=aXtDuo_W4oDxH0UkQKq1x1HKG_z=zWHoWng6JQ@mail.gmail.com>
 <4F8BE5B0.4000900@linaro.org>
Message-ID: <20120425185747.GC24211@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Apr 16, 2012 at 10:26:08AM +0100, Lee Jones wrote:
> +	/* Must have platform data or Device Tree. */
> +	if (!plat && !np) {
> +		dev_err(&dev->dev, "No plat data or DT found\n");
> +		return -EINVAL;
>  	}
>  
> +	if (np)
> +		mmci_dt_populate_generic_pdata(np, plat);

Please tell me what happens if plat is NULL, but we're running on a DT
enabled platform.  Something tells me that you might just want to fix
that case _before_ I apply your patch.
