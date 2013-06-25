From: grant.likely@secretlab.ca (Grant Likely)
Date: Tue, 25 Jun 2013 12:04:44 +0100
Subject: [PATCH v4] irqchip: Add support for ARMv7-M's NVIC
In-Reply-To: <20130625103440.GR11232@pengutronix.de>
References: <1371073835-10639-1-git-send-email-u.kleine-koenig@pengutronix.de>
 <20130625103440.GR11232@pengutronix.de>
Message-ID: <CACxGe6vBCKCnXRtvT9N6cRPa7uHTJDMw7k-46eCj7fFPko+Raw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 25, 2013 at 11:34 AM, Uwe Kleine-K?nig
<u.kleine-koenig@pengutronix.de> wrote:
> Hello Thomas, hello Grant,
>
> On Wed, Jun 12, 2013 at 11:50:35PM +0200, Uwe Kleine-K?nig wrote:
>> This interrupt controller is found on Cortex-M3 and Cortex-M4 machines.
>>
>> Support for this controller appeared in Catalin's Cortex tree based on
>> 2.6.33 but was nearly completely rewritten.
>>
>> Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
>> Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
>> ---
>>
>> Notes:
>>     Changes since v3, sent with
>>     Message-Id: <1366214540-31166-1-git-send-email-u.kleine-koenig@pengutronix.de>:
>>
>>      - use generic chip
>>      - rename nvic_do_IRQ to nvic_handle_irq
>>
>>     This depends on the stuff currently in tip/irq/for-arm
> I see that tip/irq/for-arm went into next via Grant's irqdomain tree. I
> assume that means the changes go in for 3.11?

Yes, the plan is to put that branch into v3.11. I don't know if Thomas
plans to send a separate pull request for the irq/for-arm branch, or
if he is going to let it go as part of my pull request. I'll work it
out with him when the merge window opens. It would probably be best
for your patch to be applied on the irq/for-arm branch and pushed
separately from my irqdomain branch since I don't maintain any of the
irqchip drivers.

g.
