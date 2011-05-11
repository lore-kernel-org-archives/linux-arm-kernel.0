From: plagnioj@jcrosoft.com (Jean-Christophe PLAGNIOL-VILLARD)
Date: Wed, 11 May 2011 05:49:01 +0200
Subject: AT91: Remove fixed mapping for AT91RM9200 ethernet
In-Reply-To: <1304884489.6089.13.camel@redbox>
References: <1304884489.6089.13.camel@redbox>
Message-ID: <20110511034901.GA22009@game.jcrosoft.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 21:54 Sun 08 May     , Andrew Victor wrote:
> The AT91RM9200 Ethernet controller still has a fixed IO mapping.
> So:
> * Remove the fixed IO mapping and AT91_VA_BASE_EMAC definition.
> * Pass the physical base-address via platform-resources to the driver.
> * Convert at91_ether.c driver to perform an ioremap().
> * Ethernet PHY detection needs to be performed during the driver
> initialization process, it can no longer be done first.
we need to pass the irq too as the hw ip does not belong to Atmel
so it can be attached to any irq

ca we split is in two file on for -net and the other one for at91 tree

Best Regards,
J.
