From: ben.dooks@codethink.co.uk (Ben Dooks)
Date: Thu, 20 Mar 2014 16:36:52 +0100
Subject: DMABOUNCE in pci-rcar
In-Reply-To: <20140320152640.GW7528@n2100.arm.linux.org.uk>
References: <201402241200.21944.arnd@arndb.de>
 <CAErSpo5RV=w+DkgHSZZPOFGiEBBxMSraLV3TepYUZwDJuV+Jzg@mail.gmail.com>
 <5165962.7bqj51B15Z@wuerfel> <532B0384.1000400@codethink.co.uk>
 <20140320152640.GW7528@n2100.arm.linux.org.uk>
Message-ID: <532B0B14.7040600@codethink.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 20/03/14 16:26, Russell King - ARM Linux wrote:
> On Thu, Mar 20, 2014 at 04:04:36PM +0100, Ben Dooks wrote:
>> On 26/02/14 20:57, Arnd Bergmann wrote:
>>> On Wednesday 26 February 2014 12:48:17 Bjorn Helgaas wrote:
>>>> On Mon, Feb 24, 2014 at 4:00 AM, Arnd Bergmann <arnd@arndb.de> wrote:
>>>>> Hi Magnus,
>>>>>
>>>>> I noticed during randconfig testing that you enabled DMABOUNCE for the
>>>>> pci-rcar-gen2 driver as posted in this patch https://lkml.org/lkml/2014/2/5/30
>>>>>
>>>>> I didn't see the original post unfortunately, but I fear we have to
>>>>> revert it and come up with a better solution, ...
>>>>
>>>> Sounds like I should drop the following patches from my pci/host-rcar
>>>> branch for now?
>>>>
>>>>     PCI: rcar: Add DMABOUNCE support
>>>>     PCI: rcar: Enable BOUNCE in case of HIGHMEM
>>>>     PCI: rcar: Make the Kconfig dependencies more generic
>>>
>>> Sounds good to me. The last patch is actually fine, but you'll have to
>>> fix the context to apply it without the other two.
>>
>> As a note, if we now boot a Lager with DT on 3.14-rc3 series the USB
>> controllers no longer work with full 2GiB RAM enabled in the device
>> tree.
>>
>> Could we work around this by having 1GiB of memory defined in the
>> 32bit memory and then add the rest of the 3GiB from the >32bit
>> area via LPAE? Will the kernel ever try to allocate DMA memory from
>> anything >32bit?
>
> Ignore highmem.  What is the actual hardware restriction concerning memory
> it can access?

If the window is set to 2GiB it can only access 2GiB aligned to 2GiB
boundary, however DRAM spans a 2GiB boundary (being at 1-3GiB)


-- 
Ben Dooks				http://www.codethink.co.uk/
Senior Engineer				Codethink - Providing Genius
