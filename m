From: okaya@codeaurora.org (Sinan Kaya)
Date: Wed, 19 Oct 2016 10:41:11 -0700
Subject: [PATCH V5 00/10] dmaengine: qcom_hidma: add MSI interrupt support
In-Reply-To: <20161019133406.GO2467@localhost>
References: <1475817915-11976-1-git-send-email-okaya@codeaurora.org>
 <20161019133406.GO2467@localhost>
Message-ID: <3c808abb-61a6-e4b8-0ffc-f4cbf09d177a@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Vinod,

On 10/19/2016 6:34 AM, Vinod Koul wrote:
> On Fri, Oct 07, 2016 at 01:25:05AM -0400, Sinan Kaya wrote:
>> The new version of the HW supports MSI interrupts instead of wired
>> interrupts. The MSI interrupts are especially useful for the guest machine
>> execution. The wired interrupts usually trap to the hypervisor and then are
>> relayed to the actual interrupt.
>>
>> The MSI interrupts can be directly fed into the interrupt controller.
>>
>> Adding a new OF compat string (qcom,hidma-1.1) and ACPI string (QCOM8062)
>> to distinguish newer HW from the older ones.
> 
> I was only able to apply 6 patches in this series. Which tree were these
> generated against?
> 
> Please rebase rest..
> 

I'll post V6 now with the remaining 4 patches. My tree is as follows. 
I'll also repost V2 of the "dmaengine: qcom_hidma: cleanup sysfs entries during remove"
patch with your suggestion.

b8faa2a dmaengine: qcom_hidma: add MSI support for interrupts
54043eb dmaengine: qcom_hidma: break completion processing on error
31c9e2c dmaengine: qcom_hidma: protect common data structures
252ef1f dmaengine: qcom_hidma: add a common API to setup the interrupt
4e6c5ce dmaengine: qcom_hidma: bring out interrupt cause
784851a dmaengine: qcom_hidma: make pending_tre_count atomic
098685b dmaengine: qcom_hidma: configure DMA and MSI for OF
79f97f0 of: irq: make of_msi_configure accessible from modules
81e9b3a Documentation: DT: qcom_hidma: correct spelling mistakes
c55ceac Documentation: DT: qcom_hidma: update binding for MSI
7f3470c dmaengine: qcom_hidma: cleanup sysfs entries during remove
78e5299 dmaengine: qcom_hidma: remove useless debugfs file removal
96633c0 ACPI: platform: setup MSI domain for ACPI based platform device
851aadc irqchip: gicv3-its: platform-msi: scan MADT to create platform msi domain
5a8622e irqchip: gicv3-its: platform-msi: refactor its_pmsi_init() to prepare for ACPI
ca80550 ACPI: platform-msi: retrieve dev id from IORT
b631797 irqchip: gicv3-its: platform-msi: refactor its_pmsi_prepare()
1001354 Linux 4.9-rc1

Sinan


-- 
Sinan Kaya
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project.
