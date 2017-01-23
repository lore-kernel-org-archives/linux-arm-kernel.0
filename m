From: sricharan@codeaurora.org (Sricharan)
Date: Mon, 23 Jan 2017 21:53:11 +0530
Subject: [PATCH V6 06/11] drivers: platform: Configure dma operations at
 probe time
References: <1484939748-31591-1-git-send-email-sricharan@codeaurora.org>
 <1484939748-31591-7-git-send-email-sricharan@codeaurora.org>
 <20170123120729.GB12593@red-moon>
Message-ID: <009701d27595$01e24a70$05a6df50$@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Lorenzo,

>>[+bjorn]
>>
>>On Sat, Jan 21, 2017 at 12:45:43AM +0530, Sricharan R wrote:
>>> Configuring DMA ops at probe time will allow deferring device probe when
>>> the IOMMU isn't available yet. The dma_configure for the device is
>>> now called from the generic device_attach callback just before the
>>> bus/driver probe is called. This way, configuring the DMA ops for the
>>> device would be called at the same place for all bus_types, hence the
>>> deferred probing mechanism should work for all buses as well.
>>>
>>> pci_bus_add_devices    (platform/amba)(_device_create/driver_register)
>>>        |                         |
>>> pci_bus_add_device     (device_add/driver_register)
>>>        |                         |
>>> device_attach           device_initial_probe
>>>        |                         |
>>> __device_attach_driver    __device_attach_driver
>>>        |
>>> driver_probe_device
>>>        |
>>> really_probe
>>>        |
>>> dma_configure
>>>
>>> Similarly on the device/driver_unregister path __device_release_driver is
>>> called which inturn calls dma_deconfigure.
>>>
>>> This patch changes the dma ops configuration time to probe time for
>>> both OF and ACPI based devices.
>>
>>For all device types, inclusive of PCI, so please you have to:
>>
>>- Update the $SUBJECT
>>- Copy linux-pci at vger.kernel.org
>>- Copy linux-acpi at vger.kernel org (on the series)
>
>Sure, i will just see till tomorrow for any further comments and
>repost with $SUBJECT modified and the lists

Infact just reposted with $SUB updated and the additional lists.

Regards,
 Sricharan
