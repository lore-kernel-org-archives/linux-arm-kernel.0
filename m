From: mans@mansr.com (=?iso-8859-1?Q?M=E5ns_Rullg=E5rd?=)
Date: Thu, 08 Dec 2016 11:44:23 +0000
Subject: Tearing down DMA transfer setup after DMA client has finished
In-Reply-To: <20161208103730.GB6408@localhost> (Vinod Koul's message of "Thu,
 8 Dec 2016 16:07:30 +0530")
References: <58356EA8.2010806@free.fr> <20161125045549.GC2698@localhost>
 <092f44ee-4560-be17-25f7-00948dba3cfa@free.fr>
 <20fc9020-7278-bc2f-2a8d-43aff5cabff8@free.fr>
 <20161206051222.GQ6408@localhost> <5846B237.8060409@free.fr>
 <20161207164156.GW6408@localhost> <yw1xvauv1yew.fsf@unicorn.mansr.com>
 <20161208103730.GB6408@localhost>
Message-ID: <yw1xa8c61w88.fsf@unicorn.mansr.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Vinod Koul <vinod.koul@intel.com> writes:

> On Wed, Dec 07, 2016 at 04:44:55PM +0000, M?ns Rullg?rd wrote:
>> Vinod Koul <vinod.koul@intel.com> writes:
>> >> 
>> >> What you're proposing, Vinod, is to make a channel exclusive
>> >> to a driver, as long as the driver has not explicitly released
>> >> the channel, via dma_release_channel(), right?
>> >
>> > Precisely, but yes the downside of that is concurrent access are
>> > limited, but am not sure if driver implements virtual channels and
>> > allows that..
>> 
>> My driver implements virtual channels.  The problem is that the physical
>> dma channels signal completion slightly too soon, at least with
>> mem-to-device transfers.  Apparently we need to keep the sbox routing
>> until the peripheral indicates that it has actually received all the
>> data.
>
> So do we need concurrent accesses by all clients.

Depends on what people do with the chips.

-- 
M?ns Rullg?rd
