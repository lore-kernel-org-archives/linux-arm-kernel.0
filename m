From: clabbe.montjoie@gmail.com (LABBE Corentin)
Date: Wed, 10 Aug 2016 10:58:23 +0200
Subject: [linux-sunxi] [RFC PATCH 1/5] mailbox: introduce ARM SMC based
 mailbox
In-Reply-To: <20160809115303.17032-2-andre.przywara@arm.com>
References: <20160809115303.17032-1-andre.przywara@arm.com>
 <20160809115303.17032-2-andre.przywara@arm.com>
Message-ID: <20160810085823.GA21702@Red>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello

Just a minor comment below

> +static int smc_mbox_probe(struct platform_device *pdev)
> +{
> +	struct device *dev = &pdev->dev;
> +	struct mbox_controller *mbox;
> +	int ret = 0;
> +	int i;
> +
> +	ret = of_property_count_elems_of_size(dev->of_node, "identifiers",
> +					      sizeof(u32));
> +	if (ret < 0)
> +		return ret;
> +
> +	mbox = devm_kzalloc(dev, sizeof(*mbox), GFP_KERNEL);
> +	if (mbox == NULL)
> +		return -ENOMEM;

checkpatch prefer !mbox

> +
> +	mbox->num_chans = ret;
> +	mbox->chans = devm_kmalloc_array(dev, mbox->num_chans,
> +					 sizeof(*mbox->chans),
> +					 GFP_KERNEL | __GFP_ZERO);

devm_kcalloc seems to do the same

Regards

LABBE Corentin
