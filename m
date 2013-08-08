From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 8 Aug 2013 12:09:54 +0200
Subject: [PATCH] Documentation: Add device tree binding file for MOXA ART
 SoCs interrupt controller
In-Reply-To: <CACmBeS0wbCSU+3DJwtyN5CuX8GDCNWJxeiDq8YUrfTL8DwU_1w@mail.gmail.com>
References: <1374137426-6763-1-git-send-email-jonas.jensen@gmail.com>
 <20130802093559.GB2884@e106331-lin.cambridge.arm.com>
 <CACmBeS0wbCSU+3DJwtyN5CuX8GDCNWJxeiDq8YUrfTL8DwU_1w@mail.gmail.com>
Message-ID: <201308081209.54412.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 08 August 2013, Jonas Jensen wrote:
> It's true that "interrupt-mask" is redundant, DT "interrupts" hold the
> same information. I just never found nice way to collect it from DT.
> 
> See registers written on line 111:
> http://git.kernel.org/cgit/linux/kernel/git/next/linux-next.git/tree/drivers/irqchip/irq-moxart.c#n111
> 

Can't you just update the register whenever an interrupt gets mapped?

All unused interrupts can start out as edge triggered.

	Arnd
