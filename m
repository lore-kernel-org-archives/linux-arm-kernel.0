From: hanjun.guo@linaro.org (Hanjun Guo)
Date: Mon, 18 Jan 2016 22:37:48 +0800
Subject: [PATCH V3 00/21] MMCONFIG refactoring and support for ARM64 PCI
 hostbridge init based on ACPI
In-Reply-To: <5698D163.6050404@linaro.org>
References: <1452691267-32240-1-git-send-email-tn@semihalf.com>
 <5698D163.6050404@linaro.org>
Message-ID: <569CF8BC.8060102@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2016/1/15 19:00, Hanjun Guo wrote:
> On 2016/1/13 21:20, Tomasz Nowicki wrote:
>>  From the functionality point of view this series might be split into the
>> following logic parts:
>> 1. Make MMCONFIG code arch-agnostic which allows all architectures to
>> collect
>>     PCI config regions and used when necessary.
>> 2. Move non-arch specific bits to the core code.
>> 3. Use MMCONFIG code and implement generic ACPI based PCI host
>> controller driver.
>> 4. Enable above driver on ARM64
>>
>> Patches has been built on top of 4.4 and can be found here:
>> git at github.com:semihalf-nowicki-tomasz/linux.git (pci-acpi-v3)
>>
>> NOTE, this patch set depends on Matthew's patches:
>> http://www.spinics.net/lists/linux-pci/msg45950.html
>> https://github.com/Vality/linux/tree/pci-fixes
>>
>> This has been tested on Cavium ThunderX server and QEMU.
>> Any help in reviewing and testing is very appreciated.
>>
>> v2 -> v3
>> - fix legacy IRQ assigning and IO ports registration
>> - remove reference to arch specific companion device for ia64
>> - move ACPI PCI host controller driver to pci_root.c
>> - drop generic domain assignment for x86 and ia64 as I am not
>>    able to run all necessary test variants
>> - drop patch which cleaned legacy IRQ assignment since it belongs to
>>    Mathew's series:
>>    https://patchwork.ozlabs.org/patch/557504/
>> - extend MCFG quirk code
>> - rebased to 4.4
>
> Tested this patch set (and Matthew's) on a HP RX2660 IA64 machine,
> with the CONFIG_ACPI_PCI_HOST_GENERIC disabled on IA64 ( it's a minor
> comment needs to be addressed in my previous email), it can boot
> the system ok with NIC working properly, with the /pro/ioports [1] and
> the boot log [2] if anyone needs refer to it.
>
> For this patch set, on IA64 machine,
>
> Tested-by: Hanjun Guo <hanjun.guo@linaro.org>

I tested this patch set on x86 server with CONFIG_ACPI_PCI_HOST_GENERIC
disabled today, also booted ok with NIC working properly.

Thanks
Hanjun
