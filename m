From: broonie@kernel.org (Mark Brown)
Date: Mon, 24 Oct 2016 18:53:20 +0100
Subject: [PATCH/RFT v2 09/17] regulator: fixed: Add over current event
In-Reply-To: <20161024164634.4330-10-ahaslam@baylibre.com>
References: <20161024164634.4330-1-ahaslam@baylibre.com>
 <20161024164634.4330-10-ahaslam@baylibre.com>
Message-ID: <20161024175320.GO17252@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 24, 2016 at 06:46:26PM +0200, ahaslam at baylibre.com wrote:

> +		if (ret) {
> +			pr_err("Failed to request irq: %d\n", ret);

dev_err()

> +++ b/include/linux/regulator/consumer.h
> @@ -74,6 +74,10 @@
>   *             the most noisy and may not be able to handle fast load
>   *             switching.
>   *
> + * OVERCURRENT Regulator has detected an overcurrent condition, and
> + *             may be limiting the supply output.
> + *
> + *
>   * NOTE: Most regulators will only support a subset of these modes. Some
>   * will only just support NORMAL.
>   *
> @@ -84,6 +88,7 @@
>  #define REGULATOR_MODE_NORMAL			0x2
>  #define REGULATOR_MODE_IDLE			0x4
>  #define REGULATOR_MODE_STANDBY			0x8
> +#define REGULATOR_MODE_OVERCURRENT		0x10

This is adding a new core feature with a new mode and should have been
split out of the driver specific change with a spearate changelog.  Why
does it make sense to report this as a mode, we don't report other error
conditions as modes but instead use REGULATOR_STATUS_ with the
get_status() operation?
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20161024/f2f48bdd/attachment.sig>
