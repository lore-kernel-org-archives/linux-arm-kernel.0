From: afaerber@suse.de (=?UTF-8?Q?Andreas_F=c3=a4rber?=)
Date: Sun, 18 Jun 2017 23:45:28 +0200
Subject: [PATCH v4 09/28] tty: serial: Add Actions Semi Owl UART earlycon
In-Reply-To: <20170606005426.26446-10-afaerber@suse.de>
References: <20170606005426.26446-1-afaerber@suse.de>
 <20170606005426.26446-10-afaerber@suse.de>
Message-ID: <55059fdd-5c54-ee6c-3e63-b5a9035c1745@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Greg,

Am 06.06.2017 um 02:54 schrieb Andreas F?rber:
> This implements an earlycon for Actions Semi S500/S900 SoCs.
> 
> Based on LeMaker linux-actions tree.
> 
> Signed-off-by: Andreas F?rber <afaerber@suse.de>
> ---
>  v3 -> v4: Unchanged
>  
>  v2 -> v3:
>  * Adopted BIT() macro
>  
>  v1 -> v2:
>  * Extended Kconfig help to mention earlycon (Arnd)
>  * Spelled out Actions Semiconductor in Kconfig help
>  * Adopted "actions" vendor prefix
>  
>  drivers/tty/serial/Kconfig    |  19 ++++++
>  drivers/tty/serial/Makefile   |   1 +
>  drivers/tty/serial/owl-uart.c | 135 ++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 155 insertions(+)
>  create mode 100644 drivers/tty/serial/owl-uart.c

The DT vendor prefix is applied to my linux-actions.git tree now, and
the serial binding has been ack'ed by Rob.

Is there anything keeping you from adding this patch, the preceding DT
binding (08/28) and the following documentation patch (10/28) to your
tree for 4.13?

The full serial driver (16/28) needs another spin and may miss 4.13, but
earlycon would prove the rest is working.

Thanks,
Andreas

-- 
SUSE Linux GmbH, Maxfeldstr. 5, 90409 N?rnberg, Germany
GF: Felix Imend?rffer, Jane Smithard, Graham Norton
HRB 21284 (AG N?rnberg)
