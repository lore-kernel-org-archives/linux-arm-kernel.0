From: dhdang@apm.com (Duc Dang)
Date: Sun, 23 Oct 2016 00:26:59 -0700
Subject: Question about arm64 earlycon
Message-ID: <CADaLNDnB3QBjODYNTndBsexGQfnL1rj6DAUPcf1nT9+aJaqCtw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Catalin, Marc, Mark, Arnd,

I am testing with 3.12 kernel with earlyprintk enabled and I see some
garbage characters in the console log right before the message
indicating that the real console device is initialized:

<some garbage characters here>01c020000.serial: ttyS0 at MMIO
0x1c020000 (irq = 108, base_baud = 3125000) is a U6_16550A
console [ttyS0] enabled, bootconsole disabled

I looked through early_prink.c file and printk.c file and it looks
like there is case that some early boot code can touch the UART
hardware via ealy console driver while the 'real' console driver is
setting up the same UART port? Please let me know if I missed some
important piece of code that can prevent this.

Regards,
Duc Dang.
