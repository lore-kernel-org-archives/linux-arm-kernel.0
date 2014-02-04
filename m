From: ivan.khoronzhuk@ti.com (Ivan Khoronzhuk)
Date: Wed, 5 Feb 2014 00:35:59 +0200
Subject: [PATCH v4 1/3] clocksource: timer-keystone: introduce clocksource
 driver for Keystone
In-Reply-To: <52F1668B.9040507@ti.com>
References: <1391513453-21140-1-git-send-email-ivan.khoronzhuk@ti.com>
 <1391513453-21140-2-git-send-email-ivan.khoronzhuk@ti.com>
 <alpine.DEB.2.02.1402041715220.24986@ionos.tec.linutronix.de>
 <52F11B5C.40407@ti.com>
 <alpine.DEB.2.02.1402042113270.24986@ionos.tec.linutronix.de>
 <52F1668B.9040507@ti.com>
Message-ID: <52F16B4F.2010801@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Yes. I'll send with __iowmb() instead of wmb().

On 02/05/2014 12:15 AM, Santosh Shilimkar wrote:
> On Tuesday 04 February 2014 03:17 PM, Thomas Gleixner wrote:
>> On Tue, 4 Feb 2014, Ivan Khoronzhuk wrote:
>>
>> Please do not top post.
>>
>>> It was so in v1. But it was decided to use explicit memory barriers,
>>> because we're always sure the memory barriers are there and that
>>> they're properly documented. Also in this case I don't need to add
>>> keystone readl/writel relaxed function variants and to use mixed calls of
>>> writel/writel_relaxed functions.
>>>
>>> See:
>>> http://www.spinics.net/lists/arm-kernel/msg294941.html
>> Fair enough, but we want a proper explanation for explicit barriers in
>> the code and not in some random discussion of patch version X on some
>> random mailing list.
>>
>> Aside of that it should be iowmb(), but I might miss something ...
>>
> Agree. __iowmb() seems to be more appropriate.
>
> Regards,
> Santosh
>

-- 
Regards,
Ivan Khoronzhuk
