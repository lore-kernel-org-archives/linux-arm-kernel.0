From: shannon.zhao@linaro.org (Shannon Zhao)
Date: Wed, 18 Nov 2015 21:15:30 +0800
Subject: [Xen-devel] [PATCH 06/13] Xen: ARM: Add support for mapping amba
 device mmio
In-Reply-To: <564C6EBF.7010105@citrix.com>
References: <1447754231-7772-1-git-send-email-shannon.zhao@linaro.org>
 <1447754231-7772-7-git-send-email-shannon.zhao@linaro.org>
 <20151117144040.GI3003@char.us.oracle.com> <564C14CA.9080601@huawei.com>
 <564C6EBF.7010105@citrix.com>
Message-ID: <564C79F2.6050708@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 2015/11/18 20:27, Julien Grall wrote:
> On 18/11/15 06:03, Shannon Zhao wrote:
>>>
>>> What about the removal of a bus device? No need to handle that?
>>>
>> I have thought about removal before. I think there is little(or no)
>> chance for AMBA and platform bus devices to be removed. It's not like
>> the PCI devices which will be hot-unplug.
>> Maybe I'm not right. If so, it's fine to add a case to handle the removal.
>
> What about the platform device passthrough case?
>
No, it will add the platform passthrough device at booting step while 
it's only removed when Dom0 shutdowns unless it supports platform device 
hot-unplug.

> In anycase, if the AMBA platform provides a removal method, there is
> harmless to implement it.
>
Sure, as you said, it's harmless to add.

Thanks,
-- 
Shannon
