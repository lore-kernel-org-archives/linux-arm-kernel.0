From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Tue, 7 Feb 2012 13:16:57 +0000
Subject: [PATCH v2 7/7] MFD: TWL6040: Add regulator support for VIO, V2V1
 supplies
In-Reply-To: <1328619678-26080-8-git-send-email-peter.ujfalusi@ti.com>
References: <1328619678-26080-1-git-send-email-peter.ujfalusi@ti.com>
 <1328619678-26080-8-git-send-email-peter.ujfalusi@ti.com>
Message-ID: <20120207131657.GL3332@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 07, 2012 at 03:01:18PM +0200, Peter Ujfalusi wrote:
> twl6040 has three power supply source:
> VBAT needs to be connected to VBAT, VIO, and V2V1.
> Add regulator support for the VIO, V2V1 supplies.
> Initially handle the two supply together with bulk commands.

> Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>

Reviewed-by: Mark Brown <broonie@opensource.wolfsonmicro.com>

> +	twl6040->supplies = devm_kzalloc(&client->dev,
> +					 sizeof(struct regulator_bulk_data) *
> +					 TWL6040_NUM_SUPPLIES, GFP_KERNEL);
> +	if (!twl6040->supplies) {
> +		ret = -ENOMEM;
> +		goto err;
> +	}
> +

though I'd be inclined to just embed this structure into the twl6040
struct directly, you're always going to need to allocate it and it saves
a tiny bit of error handling and whatnot.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120207/1e62da28/attachment.sig>
