From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Thu, 1 Nov 2012 10:12:33 +0100
Subject: [PATCH] ARM: plat-versatile: move FPGA irq driver to
 drivers/irqchip
In-Reply-To: <CACRpkda06BbFOiX1WSqNLM-R5Es-Nd6btUNq2mMDuH7s3jA2cw@mail.gmail.com>
References: <1351719113-30880-1-git-send-email-linus.walleij@linaro.org>
 <5091CA18.7020905@gmail.com>
 <CACRpkda06BbFOiX1WSqNLM-R5Es-Nd6btUNq2mMDuH7s3jA2cw@mail.gmail.com>
Message-ID: <20121101101233.17ffcf5a@skate>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Linus,

On Thu, 1 Nov 2012 10:00:19 +0100, Linus Walleij wrote:

> Sounds like a separate patch but surely we can do this. Is Thomas'
> stuff on a branch somewhere that I can then rebase upon to get
> it upstream? I was planning to get this series as such to the
> ARM SoC maintainers soon-ish.

Not at the moment. But do you want me to put that in a branch, and
agglomerate all the related patches (posted by Rob for GIC/VIC and by
you for the FPGA IRQ controller), and then later send a pull request to
Arnd with those changes?

Also, again, the whole point of the initial infrastructure in
drivers/irqchip/ was to avoid adding per-driver header files in
include/linux/irqchip/, so there should at least be a long term plan on
how to remove those headers file, either by moving more platforms to
DT, or my extending the irqchip infrastructure to cover more features.

Best regards,

Thomas
-- 
Thomas Petazzoni, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
