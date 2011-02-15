From: b-cousson@ti.com (Cousson, Benoit)
Date: Tue, 15 Feb 2011 23:05:46 +0100
Subject: [PATCH v5 3/5] OMAP4: hwmod data: add mailbox data
In-Reply-To: <AANLkTinA2a60TSM7qDC1LQiRaUTs0DR3bDMv+oVsVOE0@mail.gmail.com>
References: <1296674843-12718-1-git-send-email-omar.ramirez@ti.com>	<1296674843-12718-4-git-send-email-omar.ramirez@ti.com>	<4D5943A9.8010205@ti.com>
	<AANLkTinA2a60TSM7qDC1LQiRaUTs0DR3bDMv+oVsVOE0@mail.gmail.com>
Message-ID: <4D5AF8BA.8080403@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Omar,

On 2/15/2011 10:55 PM, Ramirez Luna, Omar wrote:
> Hi Benoit,
>
> On Mon, Feb 14, 2011 at 9:00 AM, Cousson, Benoit<b-cousson@ti.com>  wrote:
>>> +static struct omap_hwmod_irq_info omap44xx_mailbox_irqs[] = {
>>> +       { .name = "mbox", .irq = 26 + OMAP44XX_IRQ_GIC_START, },
>>
>> The original entry was unnamed since it is an unique entry and thus does not
>> need to be differentiate on this platform.
>>
>>         { .irq = 26 + OMAP44XX_IRQ_GIC_START },
>>
>> Do you really need to have a name here? The strategy being to provide a name
>> only if more than one entry exist.
>> It is perfectibility doable, I'm just trying to understand your rational.
>
> It is this way instead of plain platform_get_irq because omap2420 has
> two interrupt sources to MPU and mailbox driver uses
> platform_get_irq_byname to get the irq number.

This is what I was thinking, except that on OMAP2420 the names are:
+	{ .name = "dsp", .irq = 26, },
+	{ .name = "iva", .irq = 34, },

and on OMAP2430 and OMAP3
+	{ .name = "dsp", .irq = 26, },

so why is it named "mbox" on OMAP4?

If you have to do several platform_get_irq_byname to get this one, I'd 
prefer to get rid of that name for OMAP4. It will make mailbox irq 
consistent with the other hwmods.

Thanks,
Benoit
