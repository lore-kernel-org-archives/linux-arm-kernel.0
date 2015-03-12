From: tomasz.nowicki@linaro.org (Tomasz Nowicki)
Date: Thu, 12 Mar 2015 14:42:51 +0100
Subject: [PATCH v4 7/9] x86, pci, ecam: mmconfig_64.c becomes default
 implementation for ECAM driver.
In-Reply-To: <CAMzpN2gLjuddMYKJY9z=e=oG0P-NjV-mfjtvYRAY6HXCWn5-UQ@mail.gmail.com>
References: <1426083169-8698-1-git-send-email-tomasz.nowicki@linaro.org>	<1426083169-8698-8-git-send-email-tomasz.nowicki@linaro.org>
 <CAMzpN2gLjuddMYKJY9z=e=oG0P-NjV-mfjtvYRAY6HXCWn5-UQ@mail.gmail.com>
Message-ID: <550197DB.7030900@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11.03.2015 17:30, Brian Gerst wrote:
> On Wed, Mar 11, 2015 at 10:12 AM, Tomasz Nowicki
> <tomasz.nowicki@linaro.org> wrote:
>
>> diff --git a/arch/x86/pci/Makefile b/arch/x86/pci/Makefile
>> index 5c6fc35..35c765b 100644
>> --- a/arch/x86/pci/Makefile
>> +++ b/arch/x86/pci/Makefile
>> @@ -1,7 +1,10 @@
>>   obj-y                          := i386.o init.o
>>
>>   obj-$(CONFIG_PCI_BIOS)         += pcbios.o
>> -obj-$(CONFIG_PCI_MMCONFIG)     += mmconfig_$(BITS).o direct.o mmconfig-shared.o
>> +obj-$(CONFIG_PCI_MMCONFIG)     += direct.o mmconfig-shared.o
>> +ifeq ($(BITS),32)
>> +obj-$(CONFIG_PCI_MMCONFIG)     += mmconfig_32.o
>> +endif
>>   obj-$(CONFIG_PCI_DIRECT)       += direct.o
>>   obj-$(CONFIG_PCI_OLPC)         += olpc.o
>>   obj-$(CONFIG_PCI_XEN)          += xen.o
>
> This would be better written as:
>
> mmconfig-y := direct.o mmconfig-shared.o
> mmconfig-$(CONFIG_X86_32) += mmconfig_32.o
> obj-$(CONFIG_PCI_MMCONFIG) += $(mmconfig-y)

Nice! Will update my patch.

Tomasz
