From: tn@semihalf.com (Tomasz Nowicki)
Date: Fri, 11 Dec 2015 15:17:18 +0100
Subject: [RFC PATCH 1/2] PCI/ACPI: Add ACPI support for non ECAM Host
 Bridge Controllers
In-Reply-To: <EE11001F9E5DDD47B7634E2F8A612F2E1EBE4494@lhreml503-mbs>
References: <1449155999-220955-1-git-send-email-gabriele.paoloni@huawei.com>
 <5018756.5lEEeJVMod@wuerfel> <20151204120404.GA3999@red-moon>
 <724640317.IRruPaehsN@wuerfel>
 <EE11001F9E5DDD47B7634E2F8A612F2E1EBE4494@lhreml503-mbs>
Message-ID: <566ADAEE.8020408@semihalf.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04.12.2015 17:22, Gabriele Paoloni wrote:
> Hi Lorenzo, Arnd (thanks to you both for looking at this)
>
>> -----Original Message-----
>> From: Arnd Bergmann [mailto:arnd at arndb.de]
>> Sent: 04 December 2015 13:57
>> To: Lorenzo Pieralisi
>> Cc: linux-arm-kernel at lists.infradead.org; Gabriele Paoloni; linux-
>> acpi at vger.kernel.org; linux-pci at vger.kernel.org;
>> catalin.marinas at arm.com; linaro-acpi at lists.linaro.org;
>> Liviu.Dudau at arm.com; linux-kernel at vger.kernel.org; will.deacon at arm.com;
>> Wangyijing; Wangzhou (B); hanjun.guo at linaro.org; liudongdong (C);
>> tn at semihalf.com; bhelgaas at google.com; tglx at linutronix.de; xuwei (O);
>> Liguozhu (Kenneth); jiang.liu at linux.intel.com
>> Subject: Re: [RFC PATCH 1/2] PCI/ACPI: Add ACPI support for non ECAM
>> Host Bridge Controllers
>>
>> On Friday 04 December 2015 12:04:04 Lorenzo Pieralisi wrote:
>>> On Thu, Dec 03, 2015 at 09:58:14PM +0100, Arnd Bergmann wrote:
>>
>>>> pci-host-generic.c is just for standard PCI implementations, and it
>>>> has zero code that would be shared with ACPI: Most of the
>>>> implementation deals with parsing DT properties, and all that code
>>>> is entirely differnet for ACPI and already exists in drivers/acpi.
>>>> The one thing that could be shared is the ECAM config space access,
>>>> but ACPI already needs something else here because it requires
>>>> access to the config space at early boot time, way before we even
>> load that driver, see raw_pci_read/raw_pci_write.
>>>
>>> Yes, I agree, basically ACPI has already a concept of "host generic"
>>> layer, there is not much point in "merging" it with the
>>> pci-host-generic.c driver. One thing is for certain: nothing in this
>>> and Tomasz patchsets is
>>> arm64 specific, and should not live in arch/arm64.
>
> Ok so now I guess Tomasz is aware of this and probably he is reworking
> his patchset to move his code into "drivers/acpi/pci_*",
> Tomasz can you confirm this?

Yes, working on it now and sorry for late response.

Tomasz
