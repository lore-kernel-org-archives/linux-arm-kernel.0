From: broonie@kernel.org (Mark Brown)
Date: Fri, 7 Aug 2015 13:09:06 +0100
Subject: [PATCH v3 06/18] regulator: core: Probe regulators on demand
In-Reply-To: <1438870315-18689-7-git-send-email-tomeu.vizoso@collabora.com>
References: <1438870315-18689-1-git-send-email-tomeu.vizoso@collabora.com>
 <1438870315-18689-7-git-send-email-tomeu.vizoso@collabora.com>
Message-ID: <20150807120906.GR20873@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 06, 2015 at 04:11:43PM +0200, Tomeu Vizoso wrote:

> When looking up a regulator through its OF node, probe it if it hasn't
> already.
> 
> The goal is to reduce deferred probes to a minimum, as it makes it very
> cumbersome to find out why a device failed to probe, and can introduce
> very big delays in when a critical device is probed.

Still the same problem as we had before with this stuff, why is this DT
only?

>  #include <linux/regulator/consumer.h>
> @@ -1336,6 +1337,7 @@ static struct regulator_dev *regulator_dev_lookup(struct device *dev,
>  	if (dev && dev->of_node) {
>  		node = of_get_regulator(dev, supply);
>  		if (node) {
> +			of_platform_probe(node);

And why the assumption that this is a platform device?
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150807/6862a5d3/attachment.sig>
