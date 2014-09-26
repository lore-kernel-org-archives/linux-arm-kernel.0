From: wangyijing@huawei.com (Yijing Wang)
Date: Fri, 26 Sep 2014 10:33:24 +0800
Subject: [PATCH v2 06/22] PCI/MSI: Introduce weak arch_find_msi_chip()
 to find MSI chip
In-Reply-To: <alpine.DEB.2.10.1409251220570.4604@nanos>
References: <1411614872-4009-1-git-send-email-wangyijing@huawei.com>
 <1411614872-4009-7-git-send-email-wangyijing@huawei.com>
 <alpine.DEB.2.10.1409251220570.4604@nanos>
Message-ID: <5424D074.60102@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2014/9/25 18:38, Thomas Gleixner wrote:
> On Thu, 25 Sep 2014, Yijing Wang wrote:
> 
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
> This is really backwards. On one hand you try to get rid of the weak
> arch functions zoo and then you invent new ones for no good
> reason. Why can't x86 store the chip in the pci bus?

Hi Thomas, I introduced this weak function , because I thought all platforms
except arm always have only one msi chip, and I hoped to provide a simplest
solution, less code changes. I consider several solutions to associate msi chip
and PCI device. In my reply to Thierry in first reply,
http://marc.info/?l=linux-pci&m=141169658208255&w=2
Could you give me some advices ?

Thanks!
Yijing.


> 
> Looking deeper, I'm questioning the whole notion of different
> msi_chips. Are this really different MSI controllers with a different
> feature set or are this defacto multiple instances of the same
> controller which just need a different data set?
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
