From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 2 May 2013 21:11:40 +0200
Subject: [PATCH] irqchip: add support for Marvell Orion SoCs
In-Reply-To: <20130502185322.GA29333@obsidianresearch.com>
References: <1367519104-19677-1-git-send-email-sebastian.hesselbarth@gmail.com>
 <20130502185322.GA29333@obsidianresearch.com>
Message-ID: <201305022111.41043.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 02 May 2013, Jason Gunthorpe wrote:
> > +static struct of_device_id orion_irq_dt_ids[] __initconst = {
> > +     { .compatible = "marvell,orion-mpic", .data = orion_of_init },
> > +     { }
> 
> Is there a strong reason to change the compatible string? Looks to me
> like either the new driver or the old driver will bind depending on
> what is in the machine description. No need for a new string?
> 

The compatible string should change if the binding changes in an
incomptible way, and we should try not to change it unless it's
fundamentally flawed.

	Arnd
