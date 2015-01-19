From: wangyijing@huawei.com (Yijing Wang)
Date: Mon, 19 Jan 2015 11:19:15 +0800
Subject: [PATCH 27/28] PCI: Remove platform specific pci_domain_nr()
In-Reply-To: <1561857.t9qV46uRjC@wuerfel>
References: <1421372666-12288-1-git-send-email-wangyijing@huawei.com>
 <1421372666-12288-28-git-send-email-wangyijing@huawei.com>
 <1561857.t9qV46uRjC@wuerfel>
Message-ID: <54BC77B3.6080701@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2015/1/16 17:44, Arnd Bergmann wrote:
> On Friday 16 January 2015 09:44:25 Yijing Wang wrote:
>>
>> +int pci_domain_nr(struct pci_bus *bus)
>> +{
>> +       struct pci_host_bridge *host = find_pci_host_bridge(bus);
>> +
>> +       return host->domain;
>> +}
>> +EXPORT_SYMBOL_GPL(pci_domain_nr);
>> +
> 
> Since most of the existing functions are exported as EXPORT_SYMBOL
> rather than EXPORT_SYMBOL_GPL, I think the new version should do
> the same.

Good catch. Thanks!

> 
> 	Arnd
> 
> .
> 


-- 
Thanks!
Yijing
