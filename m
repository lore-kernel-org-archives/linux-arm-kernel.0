From: broonie@kernel.org (Mark Brown)
Date: Fri, 20 Nov 2015 18:08:54 +0000
Subject: [PATCH] ASoC: Atmel: ClassD: Set GCK's parent clock
In-Reply-To: <1447903590-3285-1-git-send-email-songjun.wu@atmel.com>
References: <1447903590-3285-1-git-send-email-songjun.wu@atmel.com>
Message-ID: <20151120180854.GD1929@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 19, 2015 at 11:26:30AM +0800, Songjun Wu wrote:
> Set GCK's parent clock as audio clock, make
> sure the GCK's parent clock is audio clock.

> +	ret = clk_set_parent(dd->gclk, dd->aclk);
> +	if (ret) {
> +		dev_err(dev, "failed to set GCK parent clock: %d\n", ret);
> +		return ret;
> +	}

Why are we doing this in the driver?  This should be done by whatever
creates the clock tree, not by the driver that uses the clocks - that
way if some future SoC has a different clock tree the driver will
continue to work.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20151120/e13829e1/attachment.sig>
