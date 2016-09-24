From: eric@nelint.com (Eric Nelson)
Date: Sat, 24 Sep 2016 05:27:15 -0700
Subject: Alignment issues with freescale FEC driver
In-Reply-To: <20160923.224305.942077200829435690.davem@davemloft.net>
References: <CANn89iLb+QJu+MYh859oAAjcLCsKRpBbzVf43yOdq+HJVtZDpQ@mail.gmail.com>
 <5ee28ee0-cf0c-bdab-1271-f17755365c13@nelint.com>
 <0fe7a310-2d2f-4fca-d698-85d66122d91c@nelint.com>
 <20160923.224305.942077200829435690.davem@davemloft.net>
Message-ID: <78d1e5e1-30dd-e434-9656-2d2bab32956f@nelint.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi David,

On 09/23/2016 07:43 PM, David Miller wrote:
> From: Eric Nelson <eric@nelint.com>
> Date: Fri, 23 Sep 2016 10:33:29 -0700
> 
>> Since the hardware requires longword alignment for its' DMA transfers,
>> aligning the IP header will require a memcpy, right?
> 
> I wish hardware designers didn't do this.
> 
> There is no conflict between DMA alignment and properly offseting
> the packet data by two bytes.
> 
> All hardware designers have to do is allow 2 padding bytes to be
> emitted by the chip before the actual packet data.
> 

Andrew Lunn pointed out that the hardware does support this,
and I just pushed a patch for the vendor kernel to the meta-freescale
mailing list:

https://lists.yoctoproject.org/pipermail/meta-freescale/2016-September/019228.html

> Then the longword or whatever DMA transfer alignment is met
> whilst still giving the necessary flexibility for where the
> packet data lands.
> 

Right. A relatively small change fixes things right up.

Many thanks to Andrew for pointing this out and Russell for providing
the basis for my patch.

I'll re-work this for the up-stream kernel when I get out from
under a couple of unrelated things.
