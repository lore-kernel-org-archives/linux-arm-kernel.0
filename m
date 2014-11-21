From: dbaryshkov@gmail.com (Dmitry Eremin-Solenikov)
Date: Fri, 21 Nov 2014 14:51:05 +0400
Subject: IRQ #0 broken on ARM
In-Reply-To: <20141121103456.GR4042@n2100.arm.linux.org.uk>
References: <CALT56yPs-SSssff1waj81CRQfER4ZKKR=B1jOXVL-aBChicSjg@mail.gmail.com>
 <20141121103456.GR4042@n2100.arm.linux.org.uk>
Message-ID: <CALT56yOp9CNK5qGRRq=1QniFqHFjYfjx36czmdFzmDS6=yMbHw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2014-11-21 13:34 GMT+03:00 Russell King - ARM Linux <linux@arm.linux.org.uk>:
> On Fri, Nov 21, 2014 at 02:31:05PM +0400, Dmitry Eremin-Solenikov wrote:
>> Hello,
>>
>> After the commit a71b092a9c68685a270ebdde7b5986ba8787e575
>> (ARM: Convert handle_IRQ to use __handle_domain_irq) IRQ #0 is broken
>> on ARM. It is a valid IRQ and it is quite imporant (on sa1100 it's a GPIO0).
>
> No, it is not a valid IRQ.  (It was a mistake to think it was.)
> Generic code will always assume IRQ0 is not valid, and the fix is to
> fix the places in ARM where we try to use it.

Ok. SA1100, PXA, ebsa110, footbridge, rpc, orion5x, mv78xx0, ixp4xx,
lpc32xx, ks8695 and several other aging not so aging platforms are using IRQ0.

Breaking them in a very strange and silent manner doesn't look like a good
behaviour, does it? What would be a proposed fix?

-- 
With best wishes
Dmitry
