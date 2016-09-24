From: davem@davemloft.net (David Miller)
Date: Fri, 23 Sep 2016 22:43:05 -0400 (EDT)
Subject: Alignment issues with freescale FEC driver
In-Reply-To: <0fe7a310-2d2f-4fca-d698-85d66122d91c@nelint.com>
References: <CANn89iLb+QJu+MYh859oAAjcLCsKRpBbzVf43yOdq+HJVtZDpQ@mail.gmail.com>
 <5ee28ee0-cf0c-bdab-1271-f17755365c13@nelint.com>
 <0fe7a310-2d2f-4fca-d698-85d66122d91c@nelint.com>
Message-ID: <20160923.224305.942077200829435690.davem@davemloft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Eric Nelson <eric@nelint.com>
Date: Fri, 23 Sep 2016 10:33:29 -0700

> Since the hardware requires longword alignment for its' DMA transfers,
> aligning the IP header will require a memcpy, right?

I wish hardware designers didn't do this.

There is no conflict between DMA alignment and properly offseting
the packet data by two bytes.

All hardware designers have to do is allow 2 padding bytes to be
emitted by the chip before the actual packet data.

Then the longword or whatever DMA transfer alignment is met
whilst still giving the necessary flexibility for where the
packet data lands.
