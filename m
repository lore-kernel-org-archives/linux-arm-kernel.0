From: wangyijing@huawei.com (Yijing Wang)
Date: Thu, 12 Mar 2015 21:29:17 +0800
Subject: [PATCH v6 28/30] PCI: Export find_pci_host_bridge() and rename
 to pci_find_host_bridge()
In-Reply-To: <20150312034305.GJ10949@google.com>
References: <1425868467-9667-1-git-send-email-wangyijing@huawei.com>
 <1425868467-9667-29-git-send-email-wangyijing@huawei.com>
 <20150312034305.GJ10949@google.com>
Message-ID: <550194AD.6080204@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

>> diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
>> index a1dc9f2..45252dd 100644
>> --- a/drivers/pci/pci.h
>> +++ b/drivers/pci/pci.h
>> @@ -328,4 +328,6 @@ struct pci_host_bridge *pci_create_host_bridge(
>>  		void *sysdata, struct pci_host_bridge_ops *ops);
>>  
>>  void pci_free_host_bridge(struct pci_host_bridge *host);
>> +struct pci_host_bridge *pci_find_host_bridge(struct pci_bus *bus);
> 
> This is only used in drivers/pci/host-bridge.c and in drivers/pci/pci.c for
> pci_domain_nr().  Can you drop this patch and put the generic
> pci_domain_nr() implementation (next patch) in host-bridge.c instead of in
> pci.c?

Of course, thanks.

> 
>> +
>>  #endif /* DRIVERS_PCI_H */
>> -- 
>> 1.7.1
>>
> 
> .
> 


-- 
Thanks!
Yijing
