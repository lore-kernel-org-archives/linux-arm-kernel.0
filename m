From: lars@metafoo.de (Lars-Peter Clausen)
Date: Wed, 8 Mar 2017 21:44:17 +0100
Subject: [Question] devm_kmalloc() for DMA ?
In-Reply-To: <20170308195901.GD21222@n2100.armlinux.org.uk>
References: <CAK7LNARbD262isY7yOgQKAcbWQHV+3dsoRjtu6S+qUpPr98qSQ@mail.gmail.com>
 <b7dd01e6-ddcd-a34a-c26c-05ce6ae4015a@arm.com>
 <CAK7LNAQ3FbicgoV1Q70T2gZQS0j1Z8LffXquSM=v6DYcHP_m4Q@mail.gmail.com>
 <fd2097a1-c9b5-e6ab-f3b3-04b432bda0a3@metafoo.de>
 <20170308195901.GD21222@n2100.armlinux.org.uk>
Message-ID: <456e0515-b9d7-e1b6-fc25-a2ec5244d9db@metafoo.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/08/2017 08:59 PM, Russell King - ARM Linux wrote:
> On Wed, Mar 08, 2017 at 08:48:31PM +0100, Lars-Peter Clausen wrote:
>> When the DMA memory is mapped for reading from the device the associated
>> cachelines are invalidated without writeback. There is no guarantee that
>> the changes made to the devres_node have made it to main memory yet, or
>> is there?
> 
> That is incorrect.
> 
> Overlapping cache lines are always written back on transitions from CPU
> to device ownership of the buffer (eg, dma_map_*().)

On ARM. But my understanding is that this is not a universal requirement
according to DMA-API.txt. It says that mappings must be cache line aligned
and otherwise behavior is undefined.
