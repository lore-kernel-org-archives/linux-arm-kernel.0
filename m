From: broonie@kernel.org (Mark Brown)
Date: Mon, 22 Aug 2016 17:52:59 +0100
Subject: [PATCH 4/9] regulator: axp20x: support AXP806 variant
In-Reply-To: <20160821021125.1521-5-wens@csie.org>
References: <20160821021125.1521-1-wens@csie.org>
 <20160821021125.1521-5-wens@csie.org>
Message-ID: <20160822165259.GS22076@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Aug 21, 2016 at 10:11:20AM +0800, Chen-Yu Tsai wrote:

> +	if (id == AXP806_DCDCB) {
> +		return (((reg & GENMASK(7, 6)) == BIT(6)) ||
> +			((reg & GENMASK(7, 6)) == BIT(7)));
> +	} else if (id == AXP806_DCDCC) {
> +		return ((reg & GENMASK(7, 6)) == BIT(7));
> +	} else if (id == AXP806_DCDCE) {
> +		return !!(reg & BIT(5));
> +	}

This looks like you're trying to write a switch statement, please do
that.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160822/045c85a3/attachment.sig>
