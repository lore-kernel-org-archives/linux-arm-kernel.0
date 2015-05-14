From: jiang.liu@linux.intel.com (Jiang Liu)
Date: Thu, 14 May 2015 09:09:19 +0800
Subject: [RFC v2 5/7] PCI/ACPI: Consolidate common PCI host bridge code
 into ACPI core
In-Reply-To: <555350B2.8050301@linaro.org>
References: <1430793970-11159-1-git-send-email-jiang.liu@linux.intel.com>
 <1430793970-11159-6-git-send-email-jiang.liu@linux.intel.com>
 <55531967.70507@linaro.org> <55534275.2040404@linux.intel.com>
 <555350B2.8050301@linaro.org>
Message-ID: <5553F5BF.2080802@linux.intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2015/5/13 21:25, Hanjun Guo wrote:
> On 2015?05?13? 20:24, Jiang Liu wrote:
>> On 2015/5/13 17:29, Hanjun Guo wrote:
>>> Hi Jiang,
>>>
>>> On 2015?05?05? 10:46, Jiang Liu wrote:
>>>
>>> struct pci_controller {
>>>          struct acpi_device *companion;
>>>          void *iommu;
>>>          int segment;
>>>          int node;               /* nearest node with memory or
>>> NUMA_NO_NODE for global allocation */
>>>
>>>          void *platform_data;
>>> };
>>>
>>> except void *platform_data;
>>>
>>> On ARM64, the structure is almost the same, so how about
>>> introduce
>>>
>>> struct pci_controller {
>>>          struct acpi_device *companion;  /* ACPI companion device */
>>>          void            *iommu;         /* IOMMU private data */
>>>          int             segment;        /* PCI domain */
>>>          int             node;           /* NUMA node */
>>> #ifdef CONFIG_IA64
>>>      void *platform_data;
>>> #endif
>>> };
>>>
>>> in this file, then can be used for all architectures?
>> Current mode is that architecture defines its own version of
>> struct pci_controller. It would be better to keep this pattern.
> 
> OK, thanks for the clarify :) So how about add my basic
> PCI support patch for ARM64 on top of you patch set to fix
> this problem?

Sure, please send me the patches and I will send out v3 to
cover your review comments.
Thanks!

> 
> Thanks
> Hanjun
> 
> 
