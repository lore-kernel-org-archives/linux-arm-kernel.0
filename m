From: davem@davemloft.net (David Miller)
Date: Tue, 29 Nov 2011 18:53:42 -0500 (EST)
Subject: [PATCH] at91_ether: use gpio_is_valid for phy IRQ line
In-Reply-To: <1322169674-4109-1-git-send-email-nicolas.ferre@atmel.com>
References: <1322128098-17724-1-git-send-email-jamie@jamieiles.com>
 <1322169674-4109-1-git-send-email-nicolas.ferre@atmel.com>
Message-ID: <20111129.185342.105454076866922618.davem@davemloft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Nicolas Ferre <nicolas.ferre@atmel.com>
Date: Thu, 24 Nov 2011 22:21:14 +0100

> Use the generic gpiolib gpio_is_valid() function to test
> if the phy IRQ line GPIO is actually provided.
> 
> For non-connected or non-existing phy IRQ lines, -EINVAL
> value is used for phy_irq_pin field of struct at91_eth_data.
> 
> Signed-off-by: Nicolas Ferre <nicolas.ferre@atmel.com>

I'm assuming this goes through the ARM tree, because in both of my networking
trees there is no ARM at91 implementation of gpio_is_valid().
