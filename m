From: wangyijing@huawei.com (Yijing Wang)
Date: Mon, 16 Mar 2015 09:28:16 +0800
Subject: [PATCH v6 10/30] PCI: Introduce pci_host_bridge_list to manage
 host bridges
In-Reply-To: <CAErSpo5RgADWDPDvA-sg+MhmayPgTCfQqN1j0hYorAzZ=8_-qg@mail.gmail.com>
References: <1425868467-9667-1-git-send-email-wangyijing@huawei.com>
 <1425868467-9667-11-git-send-email-wangyijing@huawei.com>
 <20150312025537.GD10949@google.com> <55018E90.9030301@huawei.com>
 <20150312195651.GD7346@google.com> <55025955.3020000@huawei.com>
 <CAErSpo5RgADWDPDvA-sg+MhmayPgTCfQqN1j0hYorAzZ=8_-qg@mail.gmail.com>
Message-ID: <550631B0.2030709@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

>> Currently, if platform does not know the end bus number (not provide the bus resource),
>> we will update the max bus number returned by pci_scan_child_bus() to the bus resource end,
>> and I think this is reasonable. I consider to introduce a flag to identify the bus resource
>> which end bus number is undefined, then we could force all pci_scan_root_bus()  etc. callers
>> to provide the bus resource, and we could process the bus resource end according the bus resource flag.
>> Also then we could reduce the bus argument which is the same as busn_res->start.
>> I would try to provide draft patch, then we could discuss it more clearly.
> 
> Without having seen a patch, my inclination is to avoid a flag because
> flags change the behavior of the code you call, which makes that code
> harder to follow.  Maybe we could require these platforms to
> explicitly update the ending bus number after scanning the bus.

OK, agree, thanks for your suggestion :)

> 
> Bjorn
> 
> .
> 


-- 
Thanks!
Yijing
