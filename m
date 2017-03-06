From: slash.tmp@free.fr (Mason)
Date: Mon, 6 Mar 2017 16:45:36 +0100
Subject: Panic in quirk_usb_early_handoff
In-Reply-To: <063D6719AE5E284EB5DD2968C1650D6DCFE78D44@AcuExch.aculab.com>
References: <4b2a7606-de27-c8ad-1530-958dd5d12233@free.fr>
 <45e38a07-e8da-80e4-36bb-31e471f02004@free.fr>
 <3c5bd8f5-468f-d25e-08a9-8944ee419096@free.fr>
 <38b8c9be-724b-0cfc-a941-76f2c62e1c58@arm.com>
 <491b40db-dc07-2a8e-9bc4-07b86f990600@free.fr>
 <76dea81d-c524-ad40-06bf-e549bb457f59@free.fr>
 <063D6719AE5E284EB5DD2968C1650D6DCFE78D44@AcuExch.aculab.com>
Message-ID: <7bfbe98c-0bee-a13d-0c85-508645e97c58@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/03/2017 16:27, David Laight wrote:

> Mason wrote:
>>
>>> So the kernel panics in xhci_find_next_ext_cap()
>>> ( drivers/usb/host/xhci-ext-caps.h:122 )
>>> http://lxr.free-electrons.com/source/drivers/usb/host/xhci-ext-caps.h?v=4.9#L122
>>>
>>> Any idea how this can happen?
>>>
>>> 	base = ioremap_nocache(pci_resource_start(pdev, 0), len);
>>>
>>> Could I be passing garbage to ioremap_nocache?
>>
>> Oh...
>>
>> I have just now understood what Ard wrote a few days ago.
>>
>> The issue was that, on this platform, the PCI configuration space
>> and memory space are multiplexed; in other words they reside at
>> the same physical address, with a bit in MMIO to choose one or
>> the other.
> 
> Time to shoot another hardware engineer.

He's in CC :-)

> Hopefully it isn't an SMP system - but I wouldn't put it past them.

This is a dual- and quad- Cortex A9 MP platform :-(

Regards.
