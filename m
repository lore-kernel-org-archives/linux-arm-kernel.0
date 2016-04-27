From: tn@semihalf.com (Tomasz Nowicki)
Date: Wed, 27 Apr 2016 12:12:51 +0200
Subject: [PATCH V6 01/13] pci, acpi, x86, ia64: Move ACPI host bridge
 device companion assignment to core code.
In-Reply-To: <20160426223618.GB6789@localhost>
References: <1460740008-19489-2-git-send-email-tn@semihalf.com>
 <201604160430.P8zNe8Vl%fengguang.wu@intel.com>
 <20160426223618.GB6789@localhost>
Message-ID: <572090A3.7000503@semihalf.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 27.04.2016 00:36, Bjorn Helgaas wrote:
> On Sat, Apr 16, 2016 at 04:41:45AM +0800, kbuild test robot wrote:
>> Hi Tomasz,
>>
>> [auto build test ERROR on pci/next]
>> [also build test ERROR on v4.6-rc3 next-20160415]
>> [if your patch is applied to the wrong git tree, please drop us a note to help improving the system]
>>
>> url:    https://github.com/0day-ci/linux/commits/Tomasz-Nowicki/Support-for-generic-ACPI-based-PCI-host-controller/20160416-011935
>> base:   https://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git next
>> config: ia64-allmodconfig (attached as .config)
>> reproduce:
>>          wget https://git.kernel.org/cgit/linux/kernel/git/wfg/lkp-tests.git/plain/sbin/make.cross -O ~/bin/make.cross
>>          chmod +x ~/bin/make.cross
>>          # save the attached .config to linux build tree
>>          make.cross ARCH=ia64
>>
>> All errors (new ones prefixed by >>):
>>
>>     drivers/pci/hotplug/sgi_hotplug.c: In function 'enable_slot':
>>>> drivers/pci/hotplug/sgi_hotplug.c:412:61: error: 'struct pci_controller' has no member named 'companion'
>>        phandle = acpi_device_handle(PCI_CONTROLLER(slot->pci_bus)->companion);
>>                                                                  ^
>>     drivers/pci/hotplug/sgi_hotplug.c: In function 'disable_slot':
>>     drivers/pci/hotplug/sgi_hotplug.c:491:32: error: 'struct pci_controller' has no member named 'companion'
>>        PCI_CONTROLLER(slot->pci_bus)->companion) {
>>                                     ^
>>     drivers/pci/hotplug/sgi_hotplug.c:500:61: error: 'struct pci_controller' has no member named 'companion'
>>        phandle = acpi_device_handle(PCI_CONTROLLER(slot->pci_bus)->companion);
>>                                                                  ^
>
> I assume somebody is fixing this?

Yes, it will be fixed in next version also I will ask Hanjun to re-test 
it on IA64 as in the past.

Tomasz
