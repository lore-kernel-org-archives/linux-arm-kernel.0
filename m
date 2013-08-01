From: davidb@codeaurora.org (David Brown)
Date: Thu, 1 Aug 2013 15:41:13 -0700
Subject: [Ksummit-2013-discuss] [ARM ATTEND] Describing complex,
 non-probable system topologies
In-Reply-To: <20130801184252.GB19325@localhost.localdomain>
References: <20130801183531.GB29831@mudshark.cambridge.arm.com>
 <20130801184252.GB19325@localhost.localdomain>
Message-ID: <20130801224113.GA26984@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 01, 2013 at 07:42:52PM +0100, Dave Martin wrote:

>> Whilst Linux implements a bunch of different bus types (many of which
>> are in fact virtual), devices sitting on non-probable, memory mapped
>> buses inside SoCs typically live on either the platform_bus or the
>> amba_bus. So far, this has worked out alright; the buses haven't needed
>> to be visible to software and no additional software control is really
>> required from the OS. However, as I/O coherency and hardware
>> virtualisation capabilities start to creep into ARM-based SoCs, Linux
>> needs to know the topology of the system on which it is running.
>> ...
>
>This area of discussion has come up a couple of times before as a biggie
>looming on the horizon which we'll have to sort out before every SoC
>vendor rolls their own solution ... but it's not sorted yet.

Sadly, it seems that the Qualcomm out-of-tree code has done something
like this, at least sort of.  There is enough of this described in the
DT for the code to use it, but it isn't really done in a way that
would be generalizable.

I wonder how different what we've got is from what other SoCs are
doing.  Is point-to-point DMA being used anywhere else?

David

-- 
sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
hosted by The Linux Foundation
