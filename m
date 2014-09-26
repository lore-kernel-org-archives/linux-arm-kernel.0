From: wangyijing@huawei.com (Yijing Wang)
Date: Fri, 26 Sep 2014 10:10:23 +0800
Subject: [PATCH v2 06/22] PCI/MSI: Introduce weak arch_find_msi_chip()
 to find MSI chip
In-Reply-To: <20140925072619.GI12423@ulmo>
References: <1411614872-4009-1-git-send-email-wangyijing@huawei.com>
 <1411614872-4009-7-git-send-email-wangyijing@huawei.com>
 <20140925072619.GI12423@ulmo>
Message-ID: <5424CB0F.2030406@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2014/9/25 15:26, Thierry Reding wrote:
> On Thu, Sep 25, 2014 at 11:14:16AM +0800, Yijing Wang wrote:
>> Introduce weak arch_find_msi_chip() to find the match msi_chip.
>> Currently, MSI chip associates pci bus to msi_chip. Because in
>> ARM platform, there may be more than one MSI controller in system.
>> Associate pci bus to msi_chip help pci device to find the match
>> msi_chip and setup MSI/MSI-X irq correctly. But in other platform,
>> like in x86. we only need one MSI chip, because all device use
>> the same MSI address/data and irq etc. So it's no need to associate
>> pci bus to MSI chip, just use a arch function, arch_find_msi_chip()
>> to return the MSI chip for simplicity. The default weak
>> arch_find_msi_chip() used in ARM platform, find the MSI chip
>> by pci bus.
> 
> Can't x86 simply set the bus' .msi field anyway? It would seem to be
> easy to do and unifies the code rather than driving it further apart
> using even more of the __weak functions.

As mentioned in the first reply, I will rework this one when we find a better solution.

Thanks!
Yijing.

> 
> Thierry
> 


-- 
Thanks!
Yijing
