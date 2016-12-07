From: mans@mansr.com (=?iso-8859-1?Q?M=E5ns_Rullg=E5rd?=)
Date: Wed, 07 Dec 2016 16:45:58 +0000
Subject: Tearing down DMA transfer setup after DMA client has finished
In-Reply-To: <20161207164341.GX6408@localhost> (Vinod Koul's message of "Wed,
 7 Dec 2016 22:13:41 +0530")
References: <58356EA8.2010806@free.fr> <20161125045549.GC2698@localhost>
 <092f44ee-4560-be17-25f7-00948dba3cfa@free.fr>
 <20fc9020-7278-bc2f-2a8d-43aff5cabff8@free.fr>
 <20161206051222.GQ6408@localhost> <5846B237.8060409@free.fr>
 <yw1xwpfd2o9f.fsf@unicorn.mansr.com> <20161207164341.GX6408@localhost>
Message-ID: <yw1xr35j1yd5.fsf@unicorn.mansr.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Vinod Koul <vinod.koul@intel.com> writes:

> On Tue, Dec 06, 2016 at 01:14:20PM +0000, M?ns Rullg?rd wrote:
>> 
>> That's not going to work very well.  Device drivers typically request
>> dma channels in their probe functions or when the device is opened.
>> This means that reserving one of the few channels there will inevitably
>> make some other device fail to operate.
>
> No that doesnt make sense at all, you should get a channel only when you
> want to use it and not in probe!

Tell that to just about every single driver ever written.

-- 
M?ns Rullg?rd
