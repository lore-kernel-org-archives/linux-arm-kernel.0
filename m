From: wangyijing@huawei.com (Yijing Wang)
Date: Tue, 3 Mar 2015 16:08:29 +0800
Subject: [PATCH v4 12/30] PCI: Introduce pci_host_bridge_ops to support
 host specific operations
In-Reply-To: <20150303025020.GF11978@google.com>
References: <1424938344-4017-1-git-send-email-wangyijing@huawei.com>
 <1424938344-4017-13-git-send-email-wangyijing@huawei.com>
 <20150303025020.GF11978@google.com>
Message-ID: <54F56BFD.2060008@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

>> +	if (host->ops && host->ops->phb_prepare) {
>> +		error = host->ops->phb_prepare(host);
>> +		if(error) {
> 
> Whitespace error.

Will fix.

> 
>> --- a/include/linux/pci.h
>> +++ b/include/linux/pci.h
>> @@ -400,6 +400,13 @@ static inline int pci_channel_offline(struct pci_dev *pdev)
>>  	return (pdev->error_state != pci_channel_io_normal);
>>  }
>>  
>> +struct pci_host_bridge;
>> +struct pci_host_bridge_ops {
>> +	void (*phb_set_root_bus_speed)(struct pci_host_bridge *host);
>> +	int (*phb_prepare)(struct pci_host_bridge *host);
>> +	void (*phb_of_scan_bus)(struct pci_host_bridge *);
> 
> These function pointers don't need a "phb_" prefix.

Will update them.

> 
> .
> 


-- 
Thanks!
Yijing
