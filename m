From: davem@davemloft.net (David Miller)
Date: Wed, 05 Sep 2012 17:31:18 -0400 (EDT)
Subject: [PATCH 08/10] net/macb: macb_get_drvinfo: add GEM/MACB suffix
 to differentiate revision
In-Reply-To: <fc701a2ed18198b7a671c55f1e65725f1709509c.1346775479.git.nicolas.ferre@atmel.com>
References: <cover.1346775479.git.nicolas.ferre@atmel.com>
 <fc701a2ed18198b7a671c55f1e65725f1709509c.1346775479.git.nicolas.ferre@atmel.com>
Message-ID: <20120905.173118.1107211725393320514.davem@davemloft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Nicolas Ferre <nicolas.ferre@atmel.com>
Date: Wed, 5 Sep 2012 11:00:53 +0200

>  	strcpy(info->driver, bp->pdev->dev.driver->name);
> +	if (macb_is_gem(bp))
> +		strcat(info->driver, " GEM");
> +	else
> +		strcat(info->driver, " MACB");

This is a driver string, which means the software driver, and has
absolutely nothing to do with the exact type of the underlying
physical hardware.

Therefore the these suffixes should be left out of the driver string.
