From: thierry.reding@gmail.com (Thierry Reding)
Date: Wed, 4 Dec 2013 10:48:10 +0100
Subject: [PATCH v4 2/3] regulator: tps6586x: add and use correct voltage
 table
In-Reply-To: <127fe07e18665f93aa8d7c03e03164f1a049ddb6.1386108712.git.stefan@agner.ch>
References: <cover.1386108712.git.stefan@agner.ch>
 <127fe07e18665f93aa8d7c03e03164f1a049ddb6.1386108712.git.stefan@agner.ch>
Message-ID: <20131204094809.GR19943@ulmo.nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Dec 03, 2013 at 11:18:47PM +0100, Stefan Agner wrote:
[...]
> diff --git a/drivers/regulator/tps6586x-regulator.c b/drivers/regulator/tps6586x-regulator.c
[...]
> +	/* Search version specific table first */
> +	if (table) {
> +		for (i = 0; i < num; i++) {
> +			ri = &table[i];
> +			if (ri->desc.id == id)
> +				return ri;
> +		}
> +	}

Ah... there you go. Looks good:

Reviewed-by: Thierry Reding <treding@nvidia.com>
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 836 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20131204/417edcbe/attachment-0001.sig>
