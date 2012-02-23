From: balbi@ti.com (Felipe Balbi)
Date: Thu, 23 Feb 2012 14:30:55 +0200
Subject: [PATCH 5/6] gpio/omap: fix trigger type to unsigned
In-Reply-To: <1329999031-6914-6-git-send-email-tarun.kanti@ti.com>
References: <1329999031-6914-1-git-send-email-tarun.kanti@ti.com>
 <1329999031-6914-6-git-send-email-tarun.kanti@ti.com>
Message-ID: <20120223123052.GI18463@legolas.emea.dhcp.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Feb 23, 2012 at 05:40:30PM +0530, Tarun Kanti DebBarma wrote:
> The GPIO trigger parameter is of type unsigned.
> enum {
>         IRQ_TYPE_NONE           = 0x00000000,
>         IRQ_TYPE_EDGE_RISING    = 0x00000001,
>         IRQ_TYPE_EDGE_FALLING   = 0x00000002,
>         IRQ_TYPE_EDGE_BOTH      = (IRQ_TYPE_EDGE_FALLING | IRQ_TYPE_EDGE_RISING),
>         IRQ_TYPE_LEVEL_HIGH     = 0x00000004,
>         IRQ_TYPE_LEVEL_LOW      = 0x00000008,
>         IRQ_TYPE_LEVEL_MASK     = (IRQ_TYPE_LEVEL_LOW | IRQ_TYPE_LEVEL_HIGH),
>         IRQ_TYPE_SENSE_MASK     = 0x0000000f,
> 
>         IRQ_TYPE_PROBE          = 0x00000010,
> ...
> };
> Even though gpio_irq_type(struct irq_data *d, unsigned type) has the right type
> of parameter, the subsequent called functions set_gpio_triggering() and
> set_gpio_trigger() wrongly makes it signed integer. Fix this.
> 
> Signed-off-by: Tarun Kanti DebBarma <tarun.kanti@ti.com>

Cool, I guess sparse would also have caught that error :-)

Acked-by: Felipe Balbi <balbi@ti.com>

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120223/c58dffc7/attachment.sig>
