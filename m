From: sylvester.nawrocki@gmail.com (Sylwester Nawrocki)
Date: Thu, 14 Feb 2013 23:08:54 +0100
Subject: [PATCH 0/2] Device Tree support for CMA (Contiguous Memory
 Allocator)
In-Reply-To: <20130214213013.GG1906@pengutronix.de>
References: <1360845928-8107-1-git-send-email-m.szyprowski@samsung.com>
 <20130214213013.GG1906@pengutronix.de>
Message-ID: <511D6076.9090503@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 02/14/2013 10:30 PM, Sascha Hauer wrote:
> On Thu, Feb 14, 2013 at 01:45:26PM +0100, Marek Szyprowski wrote:
...
>> Here is my initial proposal for device tree integration for Contiguous
>> Memory Allocator. The code is quite straightforward, however I expect
>> that the memory bindings require some discussion.
>>
>> The proposed bindings allows to define contiguous memory regions of
>> specified base address and size. Then, the defined regions can be
>> assigned to the given device(s) by adding a property with a phanle to
>> the defined contiguous memory region. From the device tree perspective
>> that's all. Once the bindings are added, all the memory allocations from
>> dma-mapping subsystem will be served from the defined contiguous memory
>> regions.
>>
>
> I think CMA regions should not be described in the devicetre at all. The
> devicetree is about hardware description and it should be OS agnostic,
> but CMA is only a Linux specific implementation detail. It's not even
> specific to a particular board, it's specific to a particular usecase of
> a board.

I disagree. For example, in a multiprocessor system describing the memory
regions this way allows to assign memory to each subsystem, e.g. shared
memory, so that the memory region constraints are satisfied.

CMA just happens to be an implementation of a method of assigning memory
to each device in Linux. The constraints on the memory are real hardware
constraints, resulting from a particular subsystem architecture.

---

Thanks,
Sylwester
