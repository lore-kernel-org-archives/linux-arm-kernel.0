From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 3 Jan 2013 21:36:51 +0000
Subject: [PATCH v4 01/19] irqchip: add basic infrastructure
In-Reply-To: <1357235668-9450-2-git-send-email-robherring2@gmail.com>
References: <1357235668-9450-1-git-send-email-robherring2@gmail.com>
 <1357235668-9450-2-git-send-email-robherring2@gmail.com>
Message-ID: <201301032136.51302.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 03 January 2013, Rob Herring wrote:
> So, upon the suggestion of Rob Herring and Arnd Bergmann, this commit
> introduces a small infrastructure that defines a central
> irqchip_init() function in drivers/irqchip/irqchip.c, which is meant
> to be called as the ->init_irq() callback of ARM platforms. This
> function calls of_irq_init() with an array that will progressively
> contain the compatible strings of each irq controller driver, and also
> a reference to the initialization functions of such drivers. The
> drivers/irqchip/irqchip.h header file, currently empty, is added to
> allow irq controller drivers to expose their initialization function
> to the main irqchip.c file. Note that the irq controller driver
> initialization function is responsible for setting the global
> handle_arch_irq() variable, so that ARM platforms no longer have to
> define the ->handle_irq field in their DT_MACHINE structure.

This changeset text looks like it refers to an older version of the
patch that did not have the section magic yet.

> Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
> Reviewed-by: Stephen Warren <swarren@wwwdotorg.org>
> Reviewed-by: Rob Herring <rob.herring@calxeda.com>

I actually liked the old version better because it was more obvious
to the casual reader how it fits together, but I'm not going to
stand in the way if other people like it this way.

Acked-by: Arnd Bergmann <arnd@arndb.de>
