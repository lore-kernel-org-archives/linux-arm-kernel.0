From: bigeasy@linutronix.de (Sebastian Andrzej Siewior)
Date: Thu, 3 May 2018 14:44:10 +0200
Subject: [PATCH] tty/serial: atmel: use port->name as name in request_irq()
In-Reply-To: <4f3f6e7c-2806-1749-1523-72d5c8eb8229@sorico.fr>
References: <20180426150625.q5tqcb7fzchvkb5d@linutronix.de>
 <20180426151222.6vw67lwqmu6ffgnw@linutronix.de>
 <0dbf4a4c-71d4-6456-67b9-d4d202acffb7@sorico.fr>
 <20180502191632.tgda4g5v3rhncx7c@linutronix.de>
 <4f3f6e7c-2806-1749-1523-72d5c8eb8229@sorico.fr>
Message-ID: <20180503124410.n6ze2ngwv6ekjhdr@linutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2018-05-03 14:36:03 [+0200], Richard Genoud wrote:
> Could resend your patch with Fixes: in the commit message ?

will do shortly.

> BTW, I didn't manage to reproduce the behavior you describe, could you
> give me your .config and describe a little more how you manage to
> trigger this bug ?
.config sent offlist.
Did you not reproduce this even with the second/debug patch I've sent?

> (do you use the console on serial debug ? which board ? )
up to date debian sid booting with systemd. After boot completed I do
"cat /proc/interrupts" and check for the "gone" string.
This is
[    0.000000] OF: fdt:Machine model: SAMA5D3 Xplained
[    0.000000] Kernel command line: earlyprintk=ttyS0,115200 console=ttyS0,115200 root=/dev/mmcblk0p2 rootwait
[    0.520000] AT91: Detected SoC family: sama5d3
[    0.520000] AT91: Detected SoC: sama5d36, revision 2

at91-sama5d3_xplained.dtb

Is this enough?

> Thanks !

Sebastian
