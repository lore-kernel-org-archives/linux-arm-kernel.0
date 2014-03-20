From: ben.dooks@codethink.co.uk (Ben Dooks)
Date: Thu, 20 Mar 2014 16:04:36 +0100
Subject: DMABOUNCE in pci-rcar
In-Reply-To: <5165962.7bqj51B15Z@wuerfel>
References: <201402241200.21944.arnd@arndb.de>
 <CAErSpo5RV=w+DkgHSZZPOFGiEBBxMSraLV3TepYUZwDJuV+Jzg@mail.gmail.com>
 <5165962.7bqj51B15Z@wuerfel>
Message-ID: <532B0384.1000400@codethink.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 26/02/14 20:57, Arnd Bergmann wrote:
> On Wednesday 26 February 2014 12:48:17 Bjorn Helgaas wrote:
>> On Mon, Feb 24, 2014 at 4:00 AM, Arnd Bergmann <arnd@arndb.de> wrote:
>>> Hi Magnus,
>>>
>>> I noticed during randconfig testing that you enabled DMABOUNCE for the
>>> pci-rcar-gen2 driver as posted in this patch https://lkml.org/lkml/2014/2/5/30
>>>
>>> I didn't see the original post unfortunately, but I fear we have to
>>> revert it and come up with a better solution, ...
>>
>> Sounds like I should drop the following patches from my pci/host-rcar
>> branch for now?
>>
>>    PCI: rcar: Add DMABOUNCE support
>>    PCI: rcar: Enable BOUNCE in case of HIGHMEM
>>    PCI: rcar: Make the Kconfig dependencies more generic
>
> Sounds good to me. The last patch is actually fine, but you'll have to
> fix the context to apply it without the other two.

As a note, if we now boot a Lager with DT on 3.14-rc3 series the USB
controllers no longer work with full 2GiB RAM enabled in the device
tree.

Could we work around this by having 1GiB of memory defined in the
32bit memory and then add the rest of the 3GiB from the >32bit
area via LPAE? Will the kernel ever try to allocate DMA memory from
anything >32bit?

-- 
Ben Dooks				http://www.codethink.co.uk/
Senior Engineer				Codethink - Providing Genius
