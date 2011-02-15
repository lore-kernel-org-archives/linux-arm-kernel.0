From: omar.ramirez@ti.com (Ramirez Luna, Omar)
Date: Tue, 15 Feb 2011 15:55:41 -0600
Subject: [PATCH v5 3/5] OMAP4: hwmod data: add mailbox data
In-Reply-To: <4D5943A9.8010205@ti.com>
References: <1296674843-12718-1-git-send-email-omar.ramirez@ti.com>
	<1296674843-12718-4-git-send-email-omar.ramirez@ti.com>
	<4D5943A9.8010205@ti.com>
Message-ID: <AANLkTinA2a60TSM7qDC1LQiRaUTs0DR3bDMv+oVsVOE0@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Benoit,

On Mon, Feb 14, 2011 at 9:00 AM, Cousson, Benoit <b-cousson@ti.com> wrote:
>> +static struct omap_hwmod_irq_info omap44xx_mailbox_irqs[] = {
>> + ? ? ? { .name = "mbox", .irq = 26 + OMAP44XX_IRQ_GIC_START, },
>
> The original entry was unnamed since it is an unique entry and thus does not
> need to be differentiate on this platform.
>
> ? ? ? ?{ .irq = 26 + OMAP44XX_IRQ_GIC_START },
>
> Do you really need to have a name here? The strategy being to provide a name
> only if more than one entry exist.
> It is perfectibility doable, I'm just trying to understand your rational.

It is this way instead of plain platform_get_irq because omap2420 has
two interrupt sources to MPU and mailbox driver uses
platform_get_irq_byname to get the irq number.

Regards,

Omar
