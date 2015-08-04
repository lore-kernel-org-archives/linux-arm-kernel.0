From: andrew@lunn.ch (Andrew Lunn)
Date: Tue, 4 Aug 2015 17:34:39 +0200
Subject: Armadaxp GPIO interrupts
In-Reply-To: <CAG1O52Xg88OsifBzmpSdqvC8wQaOW78nC9nnfxugFv1VU1m1LQ@mail.gmail.com>
References: <CAG1O52Xg88OsifBzmpSdqvC8wQaOW78nC9nnfxugFv1VU1m1LQ@mail.gmail.com>
Message-ID: <20150804153439.GA28673@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 04, 2015 at 08:52:17PM +0530, raghu MG wrote:
> Hello,
> 
> I am working on a card which as GPIOs connected to external I/O's. The
> board consists of ARMADAXP 78460 host cpu.
> 
> Board currently runs Linux-4.1 with modified  armada-xp-gp.dtb for ArmadaXP.
> I enabled "orion-gpio" driver to initialize GPIOs as given in
> armada-xp-mv78460.

What kernel configuration are you using? Do you have the same problem
with multi_v7_defconfig and mvebu_v7_defconfig?
 
> The driver while initializing calls irq_domain_add_simple which throws up
> following warning
> "irq: Cannot allocate irq_descs @ IRQ47, assuming pre-allocated"
> The warning repeats for next set(32-63  & 64-66).
>
> Also the GPIO IRQs are not getting listed in cat /proc/interrupts

irq_domain_add_simple() returning an error is fatal for the probe. The
driver will not be loaded, so more than interrupts will be missing,
all the gpios will be missing.

    Andrew
