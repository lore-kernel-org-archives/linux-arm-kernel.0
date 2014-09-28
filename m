From: wangyijing@huawei.com (Yijing Wang)
Date: Sun, 28 Sep 2014 10:35:09 +0800
Subject: [PATCH v2 06/22] PCI/MSI: Introduce weak arch_find_msi_chip()
 to find MSI chip
In-Reply-To: <alpine.DEB.2.11.1409261236160.4567@nanos>
References: <1411614872-4009-1-git-send-email-wangyijing@huawei.com>
 <1411614872-4009-7-git-send-email-wangyijing@huawei.com>
 <alpine.DEB.2.10.1409251220570.4604@nanos> <5424D30A.6040900@huawei.com>
 <alpine.DEB.2.11.1409261236160.4567@nanos>
Message-ID: <542773DD.8020105@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

>> MSI chip in this series is to setup MSI irq, including IRQ allocation, Map,
>> compose MSI msg ..., in different platform, many arch specific MSI irq details in it.
>> It's difficult to extract the common data and code.
>>
>> I have a plan to rework MSI related irq_chips in kernel, PCI and Non-PCI, currently,
>> HPET, DMAR and PCI have their own irq_chip and MSI related functions, write_msi_msg(),
>> mask_msi_irq(), etc... I want to extract the common data set for that, so we can
>> remove lots of unnecessary MSI code.
> 
> That makes sense. Can you please make sure that this does not conflict
> with the ongoing work Jiang is doing in the x86 irq area with
> hierarchical irqdomains to distangle layered levels like MSI from the
> underlying vector/irqremap mechanics.

Yes, I'm reviewing Jiang hierarchical irqdomains series, I'm interested in that changes.

Thanks!
Yijing.

> 
> Thanks,
> 
> 	tglx
> 
> .
> 


-- 
Thanks!
Yijing
