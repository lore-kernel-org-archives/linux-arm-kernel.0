From: sf84@laposte.net (Sebastian Frias)
Date: Fri, 9 Dec 2016 11:25:57 +0100
Subject: Tearing down DMA transfer setup after DMA client has finished
In-Reply-To: <20161209065955.GJ6408@localhost>
References: <20fc9020-7278-bc2f-2a8d-43aff5cabff8@free.fr>
 <20161206051222.GQ6408@localhost> <5846B237.8060409@free.fr>
 <yw1xwpfd2o9f.fsf@unicorn.mansr.com> <20161207164341.GX6408@localhost>
 <yw1xr35j1yd5.fsf@unicorn.mansr.com> <20161208103921.GC6408@localhost>
 <91b0d10c-1bc2-c3e1-4088-f4ad9adcd6c0@free.fr>
 <20161208163755.GH6408@localhost> <yw1xy3zqxt7x.fsf@unicorn.mansr.com>
 <20161209065955.GJ6408@localhost>
Message-ID: <6ce1ea97-1d68-2203-c7b4-73315e801655@laposte.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/12/16 07:59, Vinod Koul wrote:
> On Thu, Dec 08, 2016 at 04:48:18PM +0000, M?ns Rullg?rd wrote:
>> Vinod Koul <vinod.koul@intel.com> writes:
>>
>>> To make it efficient, disregarding your Sbox HW issue, the solution is
>>> virtual channels. You can delink physical channels and virtual channels. If
>>> one has SW controlled MUX then a channel can service any client. For few
>>> controllers request lines are hard wired so they cant use any channel. But
>>> if you dont have this restriction then driver can queue up many transactions
>>> from different controllers.
>>
>> Have you been paying attention at all?  This exactly what the driver
>> ALREADY DOES.
> 
> And have you read what the question was?
> 

I think many people appreciate the quick turn around time and responsiveness of
knowledgeable people making constructive remarks in this thread, but it looks we
are slowly drifting away from the main problem.

If we had to sum up the discussion, the current DMA API/framework in Linux seems
to lack a way to properly handle this HW (or if it has a way, the information got
lost somewhere).

What concrete solution do you propose?

Alternatively, one can think of the current issue (i.e.: the fact that the IRQ
arrives "too soon") in a different way.
Instead of thinking the IRQ indicates "transfer complete", it is indicating "ready
to accept another command", which in practice (and with proper API support) can
translate into efficient queuing of DMA operations.
