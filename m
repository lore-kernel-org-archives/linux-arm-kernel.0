From: santosh.shilimkar@oracle.com (Santosh Shilimkar)
Date: Wed, 7 Sep 2016 09:25:54 -0700
Subject: [PATCH 0/5] Use mmio-sram driver for Keystone MSMC RAM
In-Reply-To: <f6920801-554d-18e8-f140-44aeeb2f878e@ti.com>
References: <20160901225846.31058-1-s-anna@ti.com>
 <d797bb0d-41b5-45a7-6faf-95baaab0215b@oracle.com>
 <f6920801-554d-18e8-f140-44aeeb2f878e@ti.com>
Message-ID: <287b7e1d-1453-2832-515d-e7e51373a3bc@oracle.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 9/7/2016 9:22 AM, Suman Anna wrote:
> Hi Santosh,
>
> On 09/07/2016 11:11 AM, Santosh Shilimkar wrote:
>> Hi Suman,
>>
>> On 9/1/2016 3:58 PM, Suman Anna wrote:
>>> Hi,
>>>
>>> The Keystone 2 family of SoCs have an on-chip RAM called the
>>> Multicore Shared Memory (MSM) RAM. This RAM is accessible through
>>> the Multicore Shared Memory Controller (MSMC). This series represents
>>> these on-chip RAMs as sram nodes so that the memory allocations
>>> can be managed by the in-kernel mmio-sram driver.
>>>
>>> The first 4 patches adds the basic SRAM nodes on each of the SoCs,
>>> and the last patch enables the generic on-chip SRAM driver for
>>> keystone defconfig.
>>>
>> The series looks good in general but I would like to understand
>> the users of this memory in kernel. Is that going to be posted
>> as a follow up patch ? Is the Power controller going to make
>> use of this SRAM for PM code ?
>
> Yes, the users will eventually follow. Power Controller code is not
> gonna be using this SRAM, it has its own RAM. This memory is gonna be
> split between various functional features like IPC, OPTEE integration,
> we already have the Boot Monitor code using this. We will have the
> memory split by either having static child nodes or drivers requesting
> the memory using gen_pool API.
>
OK. Its good to add the code at least with one active user of it.
Since this has to anyway wait for another merge window, please post the
users of it so that I can pull the combined patchset.

Regards,
Santosh
