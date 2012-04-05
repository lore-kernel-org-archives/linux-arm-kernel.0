From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 5 Apr 2012 13:36:42 +0100
Subject: [PATCH 6/7] MMC: mmci: Enable Device Tree support for ux500
 variants
In-Reply-To: <1333619748-16126-7-git-send-email-lee.jones@linaro.org>
References: <1333619748-16126-1-git-send-email-lee.jones@linaro.org>
 <1333619748-16126-7-git-send-email-lee.jones@linaro.org>
Message-ID: <20120405123642.GG24211@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 05, 2012 at 10:55:47AM +0100, Lee Jones wrote:
> +	of_property_read_u32(np, "clock-frequency", &pdata->f_max);
> +	if (!pdata->f_max)
> +		pr_warn("%s has no 'clock-frequency' property\n", np->full_name);

To be anal about this (which is what we should be about DT bindings)
this is not a 'clock frequency' but a maximum clock frequency for the
bus.  Or to put it another way, a clock frequency limit.

A 'clock-frequency' property suggests (at least to me) that it's
specifying the rate of the MCLK signal, which is not what it's doing.
