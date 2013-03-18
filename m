From: gerlando.falauto@keymile.com (Gerlando Falauto)
Date: Mon, 18 Mar 2013 12:05:08 +0100
Subject: [PATCH] genirq: allow an alternative setup for the mask cache
In-Reply-To: <CALF0-+WPb-WcQPaRJ_oyS44Aq9=zMemSGZnkvKY2OXfPz8uy=w@mail.gmail.com>
References: <1363277430-21325-1-git-send-email-holger.brunck@keymile.com>
 <CALF0-+WPb-WcQPaRJ_oyS44Aq9=zMemSGZnkvKY2OXfPz8uy=w@mail.gmail.com>
Message-ID: <5146F4E4.2000001@keymile.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Ezequiel,

On 03/14/2013 08:42 PM, Ezequiel Garcia wrote:
> Hi,
>
> On Thu, Mar 14, 2013 at 1:10 PM, Holger Brunck
> <holger.brunck@keymile.com> wrote:
>> The same interrupt mask cache (stored within struct irq_chip_generic)
>> is shared between all the irq_chip_type instances by default. But this
>> does not work on Orion SOCs which have separate mask registers for edge
>> and level interrupts. Therefore refactor the code that we always use a
>> pointer to access the mask register. By default it points to
>> gc->mask_cache for Orion SOCs it points to ct->mask_cache which is
>> setup in irq_setup_alt_chip().
>>
>
> When you say this does not work for Orion SoC, are you aware there
> are two GPIO drivers? One at plat-orion and *another* one at drivers/gpio?

Yes, we are now aware of that, but apparently this was new driver was 
introduced around 3.6 which we are not yet using.

> Have you tried and reproduced this regression with both of them?

No, not really. Would you be able to test this?
BTW, do you know whether all three variants of Marvell Chipsets use 
separate registers, or it's only the Orion?

Thank you,
Gerlando
