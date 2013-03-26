From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 26 Mar 2013 16:54:41 +0000
Subject: [RFCv1 02/11] irqchip: move IRQ driver for Armada 370/XP
In-Reply-To: <1364316746-8702-3-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1364316746-8702-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1364316746-8702-3-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <201303261654.41873.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 26 March 2013, Thomas Petazzoni wrote:
> When the Marvell Armada 370/XP support was included in the kernel, the
> drivers/irqchip/ directory didn't exist and the minimal infrastructure
> in it also didn't exist. Now that we have those things in place, we
> move the Armada 370/XP IRQ controller driver from
> arch/arm/mach-mvebu/irq-armada-370-xp.c to
> drivers/irqchip/irq-armada-370-xp.c.
> 
> Note in order to reduce code movement and therefore ease the review of
> this patch, we intentionally introduce a forward declaration of
> armada_370_xp_handle_irq(). It is in fact not needed because this
> handler can now simply be implemented before
> armada_370_xp_mpic_of_init(). That will be done in the next commit.
> 
> Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>

Acked-by: Arnd Bergmann <arnd@arndb.de>
