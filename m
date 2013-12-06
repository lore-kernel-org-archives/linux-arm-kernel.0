From: tomasz.nowicki@linaro.org (Tomasz Nowicki)
Date: Fri, 06 Dec 2013 16:04:52 +0100
Subject: [Linaro-acpi] [RFC part1 PATCH 1/7] ACPI: Make ACPI core running
 without PCI on ARM64
In-Reply-To: <201312052304.22302.arnd@arndb.de>
References: <1386088611-2801-1-git-send-email-hanjun.guo@linaro.org>
 <20131203164111.GA13447@srcf.ucam.org> <529F376F.8050005@linaro.org>
 <201312052304.22302.arnd@arndb.de>
Message-ID: <52A1E794.1040008@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05.12.2013 23:04, Arnd Bergmann wrote:
> On Wednesday 04 December 2013, Hanjun Guo wrote:
>> On 2013?12?04? 00:41, Matthew Garrett wrote:
>>> Given the number of #ifdefs you're adding, wouldn't it make more sense
>>> to just add stub functions to include/linux/pci.h?
>>
>> Thanks for the suggestion :)
>>
>> I can add stub functions in include/linux/pci.h for raw_pci_read()/
>> raw_pci_write(), then can remove #ifdefs for acpi_os_read/write_pci_configuration().
>
> Actually I wonder about the usefulness of this patch in either form: Since ACPI
> on ARM64 is only for servers, I would very much expect them to always come with
> PCI, either physical host bridges with attached devices, or logical PCI functions
> used to describe the on-SoC I/O devices. Even in case of virtual machines, you'd
> normally use PCI as the method to communicate data about the virtio channels.
>
> Can you name a realistic use-case where you'd want ACPI but not PCI?

Yes you can describe SoC I/O devices using logical PCI functions only if 
they are on PCI, correct me if I am wrong. Also, devices can be placed 
only on IOMEM (like for ARM SoC) and it is hard to predict which way 
vendors chose. So way don't let it be configurable? ACPI spec says 
nothing like PCI is needed for ACPI, AFAIK.

Tomasz
