From: wangyijing@huawei.com (Yijing Wang)
Date: Fri, 23 Jan 2015 10:11:47 +0800
Subject: [PATCH v2 23/30] PCI/mvebu: Use pci_common_init_dev() to simplify
 code
In-Reply-To: <20150122184000.63ba06bb@free-electrons.com>
References: <1421800225-26230-1-git-send-email-wangyijing@huawei.com>
 <1421800225-26230-24-git-send-email-wangyijing@huawei.com>
 <20150122184000.63ba06bb@free-electrons.com>
Message-ID: <54C1ADE3.9060606@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2015/1/23 1:40, Thomas Petazzoni wrote:
> Dear Yijing Wang,
> 
> On Wed, 21 Jan 2015 08:30:18 +0800, Yijing Wang wrote:
>> Mvebu_pcie_scan_bus() is not necessary, we could use
>> pci_common_init_dev() instead of pci_common_init(),
>> and pass the device pointer as the parent. Then
>> pci_scan_root_bus() will be called to scan the pci busses.
>>
>> Signed-off-by: Yijing Wang <wangyijing@huawei.com>
>> CC: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
>> CC: Jason Cooper <jason@lakedaemon.net>
> 
> While I'm fine with the change to pci_common_init_dev(), I am not so
> sure about the removal of mvebu_pcie_scan_bus(). I vaguely remember
> that we intentionally did not use the default function for a specific
> reason. Of course, this was a long time ago, and I don't remember the
> reason. I would have to take a bit of time to 1/ review the archives of
> the discussion surrounding the pcie-mvebu driver, and 2/ test your
> patch to validate it works fine on HW.

Hi Thomas, Thanks for your comments and help to test :)

> 
> Thanks!
> 
> Thomas
> 


-- 
Thanks!
Yijing
