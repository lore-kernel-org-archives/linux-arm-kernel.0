From: mans@mansr.com (=?iso-8859-1?Q?M=E5ns_Rullg=E5rd?=)
Date: Fri, 25 Nov 2016 14:42:17 +0000
Subject: Tearing down DMA transfer setup after DMA client has finished
In-Reply-To: <da3ddae9-eca2-f67a-1933-25bc7953c201@free.fr> (Mason's message
 of "Fri, 25 Nov 2016 15:28:27 +0100")
References: <58356EA8.2010806@free.fr> <20161125045549.GC2698@localhost>
 <yw1xa8cnai0p.fsf@unicorn.mansr.com>
 <ae97a212-a91e-5e0a-c9b6-2dba3b79ddc5@free.fr>
 <yw1xd1hj8x7i.fsf@unicorn.mansr.com>
 <da3ddae9-eca2-f67a-1933-25bc7953c201@free.fr>
Message-ID: <yw1xwpfr7h9y.fsf@unicorn.mansr.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Mason <slash.tmp@free.fr> writes:

> On 25/11/2016 15:12, M?ns Rullg?rd wrote:
>
>> Mason writes:
>> 
>>> On 25/11/2016 12:57, M?ns Rullg?rd wrote:
>>>
>>>> The same DMA unit is also used for SATA, which is an off the shelf
>>>> Designware controller with an in-kernel driver.  This interrupt timing
>>>> glitch can actually explain some intermittent errors I've observed with
>>>> it.
>>>
>>> FWIW, newer chips embed an AHCI controller, with a dedicated
>>> memory channel.
>>>
>>> FWIW2, the HW dev said memory channels are "almost free", and he
>>> would have no problem giving each device their own private channel
>>> read/write pair.
>> 
>> We still need to deal with the existing hardware.
>
> Can you confirm that your MBUS driver, in its current form,
> does not support memcpy-type transfers, which generate two
> IRQs (one from send agent, one from receive agent)?

It does not.

> Do you plan to support that, or is it just too quirky?

I hadn't planned on doing that, but I'm ruling it out entirely.

-- 
M?ns Rullg?rd
