From: wangyijing@huawei.com (Yijing Wang)
Date: Tue, 3 Mar 2015 16:49:46 +0800
Subject: [PATCH v4 20/30] PCI/sparc: Use pci_scan_root_bridge() for
 simplicity
In-Reply-To: <20150303031059.GJ11978@google.com>
References: <1424938344-4017-1-git-send-email-wangyijing@huawei.com>
 <1424938344-4017-21-git-send-email-wangyijing@huawei.com>
 <20150303031059.GJ11978@google.com>
Message-ID: <54F575AA.6050409@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

>> -	pci_of_scan_bus(pbm, node, bus);
>> -	pci_bus_add_devices(bus);
>> -	pci_bus_register_of_sysfs(bus);
>> +	pci_bus_add_devices(host->bus);
>> +	pci_bus_register_of_sysfs(host->bus);
>>  
>> -	pci_claim_bus_resources(bus);
>> +	pci_claim_bus_resources(host->bus);
> 
> Isn't this a case where pci_claim_bus_resources() should be done before
> pci_bus_add_devices()?  You didn't introduce this problem, but since you're
> fixing similar issues, seems like we should fix this one, too.  In a patch
> of its own, of course.

OK, will fix in a another patch.

> 
>>  
>> -	return bus;
>> +	return host->bus;
>>  }
>>  
>>  void pcibios_fixup_bus(struct pci_bus *pbus)
>> -- 
>> 1.7.1
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>> the body of a message to majordomo at vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>> Please read the FAQ at  http://www.tux.org/lkml/
> 
> .
> 


-- 
Thanks!
Yijing
