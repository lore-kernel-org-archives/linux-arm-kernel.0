From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Wed, 21 Jul 2010 18:59:30 +0100
Subject: [PATCH v2 10/20] omap: zoom: add fixed regulator device for wlan
In-Reply-To: <1279733634-21974-11-git-send-email-ohad@wizery.com>
References: <1279733634-21974-1-git-send-email-ohad@wizery.com>
	<1279733634-21974-11-git-send-email-ohad@wizery.com>
Message-ID: <20100721175930.GD10930@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 21, 2010 at 08:33:44PM +0300, Ohad Ben-Cohen wrote:

> +static struct regulator_consumer_supply zoom_vmmc3_supply = {
> +	.supply		= "vmmc",
> +};

This looks like a misconfiguration on the consumer - I'd strongly expect
the consumer to have a dev_name specified also with the name being in
terms of the consumer device.
