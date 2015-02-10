From: joe@perches.com (Joe Perches)
Date: Mon, 09 Feb 2015 16:27:13 -0800
Subject: [PATCH 1/2] hwrng: iproc-rng200 - Add Broadcom IPROC RNG driver
In-Reply-To: <1423526830-29516-2-git-send-email-sbranden@broadcom.com>
References: <Scott Branden <sbranden@broadcom.com>
 <1423526830-29516-1-git-send-email-sbranden@broadcom.com>
 <1423526830-29516-2-git-send-email-sbranden@broadcom.com>
Message-ID: <1423528033.2933.29.camel@perches.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 2015-02-09 at 16:07 -0800, Scott Branden wrote:
> This adds a driver for random number generator present on Broadcom
> IPROC devices.

trivia:

> diff --git a/drivers/char/hw_random/iproc-rng200.c b/drivers/char/hw_random/iproc-rng200.c
[]
> +static int iproc_rng200_probe(struct platform_device *pdev)
> +{
[]
> +	if (!res) {
> +		dev_err(dev, "failed to get rng resources");

Missing terminating newline:

		dev_err(dev, "failed to get rng resources\n");

> +	rng_base = devm_ioremap_resource(dev, res);
> +	if (!rng_base) {
> +		dev_err(dev, "failed to remap rng regs");

here too.
