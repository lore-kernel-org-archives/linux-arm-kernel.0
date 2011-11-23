From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Wed, 23 Nov 2011 18:44:17 +0000
Subject: [PATCH v5 4/4] regulator: map consumer regulator based on device
 tree
In-Reply-To: <1321615040-13257-5-git-send-email-rnayak@ti.com>
References: <1321615040-13257-1-git-send-email-rnayak@ti.com>
 <1321615040-13257-5-git-send-email-rnayak@ti.com>
Message-ID: <20111123184416.GA17587@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 18, 2011 at 04:47:20PM +0530, Rajendra Nayak wrote:

> +	struct device_node *regnode = NULL;
> +	char prop_name[32]; /* 32 is max size of property name */

There ought to be a #define for that though I can't see one right now -
this can't be the only place where we need to do stuff like this.

> +
> +	dev_dbg(dev, "Looking up %s-supply from device tree\n", supply);
> +
> +	snprintf(prop_name, 32, "%s-supply", supply);

sizeof().
