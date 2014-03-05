From: jgunthorpe@obsidianresearch.com (Jason Gunthorpe)
Date: Wed, 5 Mar 2014 11:42:19 -0700
Subject: [PATCH v2 6/6] PCI: designware: use new OF interrupt mapping
 when possible
In-Reply-To: <1394025951-32438-7-git-send-email-l.stach@pengutronix.de>
References: <1394025951-32438-1-git-send-email-l.stach@pengutronix.de>
 <1394025951-32438-7-git-send-email-l.stach@pengutronix.de>
Message-ID: <20140305184219.GA29903@obsidianresearch.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 05, 2014 at 02:25:51PM +0100, Lucas Stach wrote:
> -	return pp->irq;
> +	irq = of_irq_parse_and_map_pci(dev, slot, pin);
> +	if (!irq)
> +		irq = pp->irq;

In light of the two bugs that Tim found, it might be wise to throw a
'dev_warn(FW_BUG "Missing DT interrupt mapping")' in the fall back
path, so it doesn't continue to silently cover up errors on the OF/DT
side..

Regards,
Jason
